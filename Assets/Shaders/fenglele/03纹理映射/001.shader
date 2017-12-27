// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unity Shader入门精要/03基础纹理/001.法线纹理在切线空间下的计算" {
	Properties {
		_Color("Color Tint",COLOR)=(1,1,1,1)
		_MainTex("MainTex",2D)="white"{}
		_BumpMap("Normal Map",2D)="bump"{}
		_BumpScale("Bump Scale",float)=1
		_Specular("Specular",COLOR)=(1,1,1,1)
		_Gloss("Gloss",Range(8.0,256))=20
	}
	SubShader {
		Pass{
			Tags{"LightMode"="ForwardBase"}

			CGPROGRAM
				#pragma vertex vert 
				#pragma fragment frag 

				#include "Lighting.cginc"
				#include "UnityCG.cginc"

				fixed4 _Color;
				sampler2D _MainTex;
				float4 _MainTex_ST;

				sampler2D _BumpMap;
				float4 _BumpMap_ST;
				float _BumpScale;

				fixed4 _Specular;
				float _Gloss;

				struct a2v{
					float4 vertex :POSITION;
					float3 normal :NORMAL;
					//使用TANGENT语义，告诉Unity把顶点的切线方向填充到tangent变量中
					float4 tangent:TANGENT;
					//Unity会把模型的第一组纹理坐标储存在该变量中
					float4 texcoord :TEXCOORD0;
				};

				struct v2f{
					float4 pos:SV_POSITION;
					float4 uv:TEXCOORD0;
					float3 lightDir:TEXCOORD1;
					float3 viewDir:TEXCOORD2;
				};

				v2f vert(a2v v){
					v2f o;
					o.pos=mul(UNITY_MATRIX_MVP,v.vertex);

					//存储_MainTex的纹理坐标
					o.uv.xy=v.texcoord.xy*_MainTex_ST.xy+_MainTex_ST.zw;
					//存储_BumpMap的坐标
					o.uv.zw=v.texcoord.xy*_BumpMap_ST.xy+_BumpMap_ST.zw;
					//计算副切线
					float3 binormal=cross(normalize(v.normal),normalize(v.tangent.xyz))*v.tangent.w;
					//排列得到从模型空间到切线空间的变换矩阵rotation
					float3x3 rotation=float3x3(v.tangent.xyz,binormal,v.normal);
					//TANGENT_SPACE_ROTATION;

					//1.把光照方向由模型空间转为切线空间中
					o.lightDir=mul(rotation,ObjSpaceLightDir(v.vertex)).xyz;
					o.viewDir=mul(rotation,ObjSpaceViewDir(v.vertex)).xyz;

					return o;
				}

				fixed4 frag(v2f i):SV_Target{
					//切线空间下的光照方向
					fixed3 tangentLightDir=normalize(i.lightDir);
					//切线空间下的视角方向
					fixed3 tangentViewDir=normalize(i.viewDir);

					//2.计算切线空间下的法线

					//对法线纹理进行采样
					fixed4 packedNormal=tex2D(_BumpMap,i.uv.zw);
					fixed3 tangentNormal;
					tangentNormal=UnpackNormal(packedNormal);
					tangentNormal.xy*=_BumpScale;
					tangentNormal.z=sqrt(1.0-saturate(dot(tangentNormal.xy,tangentNormal.xy)));

					//切线空间下的光照计算
					fixed3 albedo=tex2D(_MainTex,i.uv).rgb*_Color.rgb;
					fixed3 ambient=UNITY_LIGHTMODEL_AMBIENT.xyz*albedo;

					fixed3 diffuse=_LightColor0.rgb*albedo*max(0,dot(tangentNormal,tangentLightDir));

					fixed3 halfDir=normalize(tangentLightDir+tangentViewDir);

					fixed3 specular=_LightColor0.rgb*_Specular.rgb*pow(max(0,dot(tangentNormal,halfDir)),_Gloss);

					return fixed4(ambient+diffuse+specular,1.0);
				}
			ENDCG
		}
	}
	FallBack "SPECULAR"
}
