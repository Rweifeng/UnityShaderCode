Shader "浅墨Shader编程/07.SurfaceShader+自定义光照/000.内置的漫反射" {
	Properties {
		_MainTex("主纹理",2D)="white"{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		#pragma surface surf Lambert

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
