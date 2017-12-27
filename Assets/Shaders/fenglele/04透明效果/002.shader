Shader "Unity Shader入门精要/04透明效果/002.AlphaBlend(深度写入开)" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Main Tex", 2D) = "white" {}
		_AlphaScale("Alpha Scale",Range(0,1))=1
	}
	SubShader{
		//通常使用了透明度测试的Shader都应该在SubShader中设置这三个标签
		//1.Queue=AlphaTest：Unity中透明度测试使用Alpha的队列
		//2"RenderType"="TransparentCutoff"：可以让Unity把这个Shader归入到提前定义的组中，以指明该Shader是一个使用了透明度测试的Shader。RenderType标签通常被用于着色器替换功能。
		//3."IgnoreProject"="True"：该Shader不会受投影器的影响
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		Pass{
			//深度写入开
			ZWrite On 
			//设置颜色通道的写掩码，语义 ColorMask RGB|A|0|其他R、G、B、A的组合
			//当设置为0时，意味着该Pass不写入任何颜色通道，即不会输出任何颜色
			ColorMask 0
		}

		Pass{
			Tags{"LightMode"="ForwardBase"}

			//设置混合模式
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert 
			#pragma fragment frag 

			#include "Lighting.cginc"

			fixed4 _Color;
			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed _AlphaScale;

			struct a2v{
				float4 vertex:POSITION;
				float3 normal:NORMAL;
				float4 texcoord:TEXCOORD0;
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
				o.worldNormal=UnityObjectToWorldNormal(v.normal);
				o.worldPos=mul(unity_ObjectToWorld,v.vertex).xyz;
				o.uv=TRANSFORM_TEX(v.texcoord,_MainTex);

				return o;
			}

			fixed4 frag(v2f i):SV_Target{
				fixed3 worldNormal=normalize(i.worldNormal);
				fixed3 worldLightDir=normalize(UnityWorldSpaceLightDir(i.worldPos));
				fixed4 texColor=tex2D(_MainTex,i.uv);

				fixed3 albedo=texColor.rgb*_Color.rgb;
				fixed3 ambient=UNITY_LIGHTMODEL_AMBIENT.xyz*albedo;
				fixed3 diffuse=_LightColor0.rgb*albedo*max(0,dot(worldNormal,worldLightDir));

				return fixed4(ambient+diffuse,texColor.a*_AlphaScale);
			}
			ENDCG
		}
	}
	FallBack "DIFFUSE"
}
