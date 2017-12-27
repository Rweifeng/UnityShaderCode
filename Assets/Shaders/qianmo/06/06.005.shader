Shader "浅墨Shader编程/06.表面着色器编写/005.凹凸纹理+边缘光照"{
	Properties{
		_MainTex("主纹理",2D)="white"{}
		_BumpMap("凹凸纹理",2D)="white"{}
		_RimColor("边缘颜色",COLOR)=(0.26,0.19,0.16,0.0)
		_RimPower("边缘颜色强度",Range(0.5,8.0))=3.0
	}
	SubShader{
		Tags{"RenderType"="Opaque"}

		CGPROGRAM
			//1.兰伯特光照+自定义颜色
			#pragma surface surf Lambert 

			//2.输入结构
			struct Input{
				//主纹理
				float2 uv_MainTex;
				//凹凸纹理
				float2 uv_BumpMap;
				//当前坐标的视角方向 WorldSpace View Direction 
				float3 viewDir;
			};

			//变量声明
			sampler2D _MainTex;
			sampler2D _BumpMap;
			float4 _RimColor;
			float _RimPower;

			//3.表面着色器函数编写
			void surf(Input IN,inout SurfaceOutput o){
				o.Albedo=tex2D(_MainTex,IN.uv_MainTex).rgb;
				
				o.Normal=UnpackNormal(tex2D(_BumpMap,IN.uv_BumpMap));
				//Normalize函数，用于获取到的viewDir坐标转成一个单位向量且方向不变
				//外面再与点的法线做点积,o.Normal就是单位向量
				//最外层再用 saturate算出[0,1]之间的最靠近的值
				//这样算出一个rim边界
				//half是一种低精度的float,但有时也会被选择成与float一样的精度
				half rim=1.0-saturate(dot(normalize(IN.viewDir),o.Normal));
				o.Emission=_RimColor.rgb * pow(rim,_RimPower);
			}
		ENDCG
	}
	FallBack "DIFFUSE"
}