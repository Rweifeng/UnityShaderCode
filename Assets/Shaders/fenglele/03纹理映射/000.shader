// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unity Shader入门精要/03基础纹理/000.纹理映射" {
	Properties {
		_Color("Color Tint",COLOR)=(1,1,1,1)
		_MainTex("MainTex",2D)="white"{}
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

				fixed4 _Color;
				sampler2D _MainTex;
				float4 _MainTex_ST;
				fixed4 _Specular;
				float _Gloss;

				struct a2v{
					float4 vertex :POSITION;
					float3 normal :NORMAL;
					//Unity会把模型的第一组纹理坐标储存在该变量中
					float4 texcoord :TEXCOORD0;
				};

				struct v2f{
					float4 pos:SV_POSITION;
					float3 worldNormal:TEXCOORD0;
					float3 worldPos:TEXCOORD1;
					float2 uv:TEXCOORD2;
				};

				v2f vert(a2v v){
					v2f o;
					o.pos=mul(UNITY_MATRIX_MVP,v.vertex);
					//世界空间下的法线
					o.worldNormal=UnityObjectToWorldNormal(v.normal);
					o.worldPos=mul(unity_ObjectToWorld,v.vertex).xyz;
					//o.uv=v.texcoord.xy*_MainTex_ST.xy+_MainTex_ST.zw;
					//or
					o.uv=TRANSFORM_TEX(v.texcoord,_MainTex);
					return o;
				}

				fixed4 frag(v2f i):SV_Target{
					//归一化世界空间下法线
					fixed3 worldNormal=normalize(i.worldNormal);
					//世界空间下的光照方向
					fixed3 worldLightDir=normalize(UnityWorldSpaceLightDir(i.worldPos));

					fixed3 albedo=tex2D(_MainTex,i.uv).rgb*_Color.rgb;

					fixed3 ambient=UNITY_LIGHTMODEL_AMBIENT;

					fixed diffuse=_LightColor0.rgb*albedo*max(0,dot(worldNormal,worldLightDir));

					fixed3 viewDir=normalize(UnityWorldSpaceViewDir(i.worldPos));

					fixed3 halfDir=normalize(worldLightDir+viewDir);

					fixed3 specular=_LightColor0.rgb*_Specular.rgb*pow(max(0,dot(worldNormal,halfDir)),_Gloss);

					return fixed4(ambient+diffuse+specular,1.0);
				}
			ENDCG
		}
	}
	FallBack "SPECULAR"
}
