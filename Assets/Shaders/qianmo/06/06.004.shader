Shader "浅墨Shader编程/06.表面着色器编写/004.纹理+颜色修改"{
	Properties {
		_Color ("色泽",COLOR) = (1,1,1,1)
		_MainTex ("主纹理", 2D)="white"{}
	}

	SubShader{
		//子着色器标签
		Tags { "RenderType" = "Opaque" }

		CGPROGRAM
		//1.使用兰伯特光照+自定义颜色
		#pragma surface surf Lambert finalcolor:setcolor

		//2.输入结构
		struct Input{
			//纹理的uv值
			float2 uv_MainTex;
		};

		//3.变量声明
		fixed4 _Color;
		sampler2D _MainTex;

		//4.自定义颜色函数setcolor的编写
		void setcolor(Input IN,SurfaceOutput o,inout fixed4 color){
			//将自选的颜色乘给color 
			color *=_Color;
		}

		//5.表面着色函数的编写
		void surf(Input IN,inout SurfaceOutput o){
			//从主纹理获取rgb颜色值
			o.Albedo=tex2D(_MainTex,IN.uv_MainTex).rgb;
		}
		ENDCG
	}

	FallBack "DIFFUSE"
}
