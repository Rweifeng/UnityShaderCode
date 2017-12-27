// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unity Shader入门精要/03基础纹理/002.法线纹理在切世界空间下的计算" {
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
					float4 Ttow0:TEXCOORD1;
					float4 Ttow1:TEXCOORD2;
					float4 Ttow2:TEXCOORD3;
				};

				v2f vert(a2v v){
					v2f o;
					o.pos=mul(UNITY_MATRIX_MVP,v.vertex);

					//存储_MainTex的纹理坐标
					o.uv.xy=v.texcoord.xy*_MainTex_ST.xy+_MainTex_ST.zw;
					//存储_BumpMap的坐标
					o.uv.zw=v.texcoord.xy*_BumpMap_ST.xy+_BumpMap_ST.zw;
					
					float3 worldPos=mul(unity_ObjectToWorld,v.vertex).xyz;
					float3 worldNormal=UnityObjectToWorldNormal(v.normal);
					fixed3 worldTangent=UnityObjectToWorldDir(v.tangent.xyz);
					fixed3 worldBinormal=cross(worldNormal,worldTangent)*v.tangent.w;

					o.Ttow0=float4(worldTangent.x,worldBinormal.x,worldNormal.x,worldPos.x);
					o.Ttow1=float4(worldTangent.y,worldBinormal.y,worldNormal.y,worldPos.y);
					o.Ttow2=float4(worldTangent.z,worldBinormal.z,worldNormal.z,worldPos.z);

					return o;
				}

				fixed4 frag(v2f i):SV_Target{
					// Get the position in world space		
					float3 worldPos = float3(i.Ttow0.w, i.Ttow1.w, i.Ttow2.w);
					// Compute the light and view dir in world space
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
					fixed3 viewDir = normalize(UnityWorldSpaceViewDir(worldPos));
				
					// Get the normal in tangent space
					fixed3 bump = UnpackNormal(tex2D(_BumpMap, i.uv.zw));
					bump.xy *= _BumpScale;
					bump.z = sqrt(1.0 - saturate(dot(bump.xy, bump.xy)));
					// Transform the narmal from tangent space to world space
					bump = normalize(half3(dot(i.Ttow0.xyz, bump), dot(i.Ttow1.xyz, bump), dot(i.Ttow2.xyz, bump)));
				
					fixed3 albedo = tex2D(_MainTex, i.uv).rgb * _Color.rgb;
				
					fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz * albedo;
				
					fixed3 diffuse = _LightColor0.rgb * albedo * max(0, dot(bump, lightDir));

					fixed3 halfDir = normalize(lightDir + viewDir);
					fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(max(0, dot(bump, halfDir)), _Gloss);
				
					return fixed4(ambient + diffuse + specular, 1.0);
				}
			ENDCG
		}
	}
	FallBack "SPECULAR"
}
