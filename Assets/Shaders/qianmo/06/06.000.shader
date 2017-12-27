//1.输出结构为编写表面着色器的第一要素
	//struct SurfaceOutput   
	//{  
	//    half3 Albedo;            //反射率，也就是纹理颜色值（r,g,b)   
	//    half3 Normal;            //法线，法向量(x, y, z)   
	//    half3 Emission;          //自发光颜色值(r, g,b)   
	//    half Specular;           //镜面反射度   
	//    half Gloss;              //光泽度  
	//    half Alpha;              //透明度  
	//}; 
//2.表面着色器的编译指令为编写表面着色器的第二个要素
	//CGPROGRAM .. ENDCG块 代替pass通道
	//#pragma surface...指令
//3.指明表面输入结构是表面着色器书写的第三个要素
	//struct Input {
	//	float2 uv_MainTex;
	//};
Shader "浅墨Shader编程/06.表面着色器编写/000.最基本的SurfaceShader" {

	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		//1.光照模型声明：使用兰伯特光照模式
		#pragma surface surf Lambert

		//2.输入结构
		struct Input{
			//四元素的颜色值(RGBA)
			float4 color:COLOR;
		};

		//3.表面着色器函数的编写
		void surf(Input IN,inout SurfaceOutput o){
			//反射率
			o.Albedo=float3(0.5,0.8,0.3);//分别对应RGB分量
			//o.Albedo=0.6;等效于o.Albedo=float3(0.6,0.6,0.6)
		}
		ENDCG
	}
	FallBack "Diffuse"
}
