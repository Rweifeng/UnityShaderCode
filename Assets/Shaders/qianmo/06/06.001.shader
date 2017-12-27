Shader "浅墨Shader编程/06.表面着色器编写/001.颜色可调的SurfaceShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		CGPROGRAM
		//1.使用兰伯特光照模式
		#pragma surface surf Lambert

		//2.变量声明
		float4 _Color;

		//3.输入结构体
		struct Input{
			float4 color:COLOR;
		};

		//4.表面着色函数的编写
		void surf(Input IN,inout SurfaceOutput o){
			//反射率
			o.Albedo=_Color.rgb;
			//透明值
			o.Alpha=_Color.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
