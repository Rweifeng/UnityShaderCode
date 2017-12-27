Shader "浅墨Shader编程/02.认识和书写实战/000.编写示例"{
	//------------------------------------属性------------------------------------
	Properties{
		//纹理
		_MainTex("基本纹理",2D)="White"{TexGen ObjectLinear}

		//水着色器的属性
		_WaveScale("Wave Scale",Range(0.02,0.15))=0.07 //滑块
		_RefDistort("Reflection distort",Range(0,1.5))=0.5 //反射
		_RefrDistort("Refraction distort",Range(0,1.5))=0.4 //折射
		_RefrColor("Refraction color",COLOR)=(.34,.85,.92,1) //颜色
		_ReflectionTex("Enviroment Reflection",2D)=""{}	//纹理
		_RefractionTex("Enviroment Refraction",2D)=""{}
		_Fresnel("Fresnel(A)",2D)=""{} //菲涅耳波
		_BumpMap("Bumpmap(RGB)",2D)=""{} //波动
	}

	//----------------------------------子着色器-----------------------------------
	SubShader{
		//---------------------通道-----------------------
		Pass{
			//----------------设置纹理为属性中选中的纹理
			SetTexture[_MainTex]{Combine texture}
		}
	}

	//----------------------------------回滚(备胎)---------------------------------
	//备胎设置为Unity中自带的普通漫反射
	FallBack "DIFFUSE"
}