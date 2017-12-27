Shader "浅墨Shader编程/06.表面着色器编写/002.基本纹理载入" {
	Properties {
		_MainTex ("主纹理", 2D) = "white"{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		CGPROGRAM
		//1.使用兰伯特光照模式
		#pragma surface surf Lambert

		//2.变量声明
		sampler2D _MainTex;

		//3.输入结构体
		struct Input{
			float2 uv_MainTex;
		};

		//4.表面着色函数的编写
		void surf(Input IN,inout SurfaceOutput o){
			//从纹理获取rgb颜色值
			o.Albedo=tex2D(_MainTex,IN.uv_MainTex).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
