Shader "浅墨Shader编程/05.Unity三种形态Shader对比&混合/001.表面Shader示例"{
	Properties{
		_MainTex("纹理",2D)="white"{}
		_BumpMap("凹凸纹理",2D)="white"{}
		_RimColor("边缘颜色",COLOR)=(0.17,0.36,0.81,0)
		_RimPower("边缘颜色亮度",Range(0.6,9.0))=1.0
	}

	SubShader{
		//渲染类型为Opaque，不透明
		Tags{"RenderType"="Opaque"}
		//--------------开始CG着色器编程语言段-------------------
		CGPROGRAM

		//使用兰伯特光照模式
		#pragma surface surf Lambert

		//输入结构
		struct Input{
			float2 uv_Maintex;//纹理贴图
			float2 uv_BumpMap;//法线贴图
			float3 viewDir;//观察方向
		};

		//变量声明
		sampler2D _MainTex;//主纹理
		sampler2D _BumpMap;//凹凸贴图
		float4 _RimColor;//边缘颜色
		float _RimPower;//边缘颜色强度

		//表面着色函数的编写
		void surf(Input IN,inout SurfaceOutput o){
			//表面反射颜色为纹理颜色
			o.Albedo=tex2D(_MainTex,IN.uv_Maintex).rgb;
			//表面法线为凹凸纹理的颜色
			o.Normal=UnpackNormal(tex2D(_BumpMap,IN.uv_BumpMap));
			//边缘颜色
			half rim=1.0-saturate(dot(normalize(IN.viewDir),o.Normal));
			//边缘颜色强度
			o.Emission=_RimColor.rgb*pow(rim,_RimPower);
		}
		//----------------结束CG着色器编程语言段-------------------
		ENDCG
	}

	//备胎为普通漫反射
	FallBack "DIFFUSE"
}