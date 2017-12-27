Shader "浅墨Shader编程/06.表面着色器编写/007.细节纹理" {
	Properties {
		_MainTex ("主纹理", 2D) = "white" {}
		_Detail("细节纹理",2D)="gray"{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _Detail;

		struct Input {
			float2 uv_MainTex;
			float2 uv_Detail;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			//先获取主纹理rgb颜色值
			o.Albedo = tex2D(_MainTex,IN.uv_MainTex).rgb;
			//设置细节纹理
			o.Albedo*=tex2D(_Detail,IN.uv_Detail).rgb*2;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
