Shader "浅墨Shader编程/02.认识和书写实战/005.简单的纹理载入Shader"{
	Properties{
		_MainTex("基本纹理",2D)="White"{TexGen SphereMap}
	}

	SubShader{
		Pass{
			//设置纹理为属性中选中的纹理
			SetTexture[_MainTex]{Combine texture}
		}
	}

	FallBack "DIFFUSE"
}