Shader "浅墨Shader编程/07.SurfaceShader+自定义光照/002.自制简单Lambert" {
	Properties {
		_MainTex("主纹理",2D)="white"{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		//1.光照模型声明：使用自定义的光照模型
		#pragma surface surf MyLambert

		//2.实现自定义光照模型
		half4 LightingMyLambert(SurfaceOutput s,half3 lightDir,half atten){
			half NdotL=max(0,dot(s.Normal,lightDir));
			half4 color;
			color.rgb=s.Albedo*_LightColor0.rgb*(NdotL*atten*2);
			color.a=s.Alpha;
			return color;
		}

		struct Input{
			float2 uv_MainTex;
		};

		sampler2D _MainTex;

		void surf(Input IN,inout SurfaceOutput o){
			o.Albedo=tex2D(_MainTex,IN.uv_MainTex).rgb;		}

		ENDCG
	}
	FallBack "Diffuse"
}
