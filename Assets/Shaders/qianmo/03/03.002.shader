Shader "浅墨Shader编程/03.子着色器实例/03.002.Alpha纹理混合" {

	Properties{
		_MainTex("基础纹理(RGB)",2D)="white"{}
		_BlendTex("混合纹理(RGBA)",2D)="white"{}
	}

	SubShader{
		pass{
			//应用主纹理
			SetTexture[_MainTex]{Combine texture}
			//使用相乘操作进行Alpha纹理混合
			SetTexture[_BlendTex]{Combine texture * previous}
		}
	}
}