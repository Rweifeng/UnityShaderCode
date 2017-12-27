Shader "浅墨Shader编程/05.Unity三种形态Shader对比&混合/007.玻璃效果1"{
	Properties{
		_Color("Main Color",COLOR)=(1,1,1,1)
		_MainTex("Base(RGB)Transparency(A)",2D)="white"{}
		_Reflenctions("Base(RGB)Gloss(A)",Cube)="skyBox"{TexGen CubeReflect}
	}
	SubShader{
		Tags{"Queue"="Transparent"}

		Pass{
			//进行纹理混合
			Blend One One

			Material{
				DIFFUSE[_Color]
			}

			Lighting On

			//和纹理相乘
			SetTexture[_Reflenctions]{
				Combine texture 
				matrix[_Reflenctions]
			}
		}
	}
}