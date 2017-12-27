Shader "浅墨Shader编程/05.Unity三种形态Shader对比&混合/007.玻璃效果2"{
	Properties{
		_Color("Main Color",COLOR)=(1,1,1,1)
		_MainTex("Base(RGB)Transparency(A)",2D)="white"{}
		_Reflecions("Base(RGB)Gloss(A)",Cube)="skybox"{TexGen CubeReflect}
	}
	SubShader{
		Tags{"Queue"="Transparent"}
		Pass{
			Blend SrcAlpha OneMinusSrcAlpha

			Material{
				DIFFUSE[_Color]
			}

			Lighting On 

			SetTexture[_MainTex]{
				Combine texture * primary double,texture * primary
			}
		}
		pass{
			Blend One One
			Material{
				DIFFUSE[_Color]
			}
			Lighting On 
			SetTexture[_Reflecions]{
				Combine texture 
				matrix[_Reflecions]
			}
		}
	}
}