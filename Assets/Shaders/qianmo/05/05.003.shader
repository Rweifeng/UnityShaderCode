Shader "浅墨Shader编程/05.Unity三种形态Shader对比&混合/003.基本纹理载入" {
	Properties{
		_MainTex("基本纹理",2D)="white"{}
	}

	SubShader{
		Tags{"Queue"="Geometry"}//子着色器标签设为几何体
		pass{
			SetTexture[_MainTex]{
				Combine texture
			}
		}
	}
}