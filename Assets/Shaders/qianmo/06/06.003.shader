Shader "浅墨Shader编程/06.表面着色器编写/003.凹凸纹理载入" {
	Properties {
		_MainTex ("主纹理", 2D) = "white" {}
		_BumpMap("凹凸纹理",2D)="bump"{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		CGPROGRAM
		//1.使用兰伯特光照模式
		#pragma surface surf Lambert

		//2.变量声明
		sampler2D _MainTex;
		sampler2D _BumpMap;

		//3.输入结构体
		struct Input{
			//主纹理uv值
			float2 uv_MainTex;
			//凹凸纹理的uv值
			float2 uv_BumpMap;
		};

		//4.表面着色函数的编写
		void surf(Input IN,inout SurfaceOutput o){
			//从纹理获取rgb颜色值
			o.Albedo=tex2D(_MainTex,IN.uv_MainTex).rgb;
			//从凹凸纹理获取法线值
			o.Normal=UnpackNormal(tex2D(_BumpMap,IN.uv_BumpMap));
		}
		ENDCG
	}
	FallBack "Diffuse"
}
