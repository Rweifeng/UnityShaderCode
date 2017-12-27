Shader "浅墨Shader编程/05.Unity三种形态Shader对比&混合/000.固定功能Shader示例" {
	Properties {
		//主颜色、高光颜色、自发光颜色、光泽度、主纹理
		_Color("主颜色",COLOR)=(1,1,1,0)
		_SpecColor("高光颜色",COLOR)=(1,1,1,1)
		_Emission("自发光颜色",COLOR)=(0,0,0,0)
		_Shininess("光泽度",Range(0.01,1))=0.7
		_MainTex("基础纹理",2D)="white"{}
	}
	SubShader{
		Pass{
			Material{
				DIFFUSE[_Color]
				Ambient[_Color]
				Shininess[_Shininess]
				SPECULAR[_SpecColor]
				Emission[_Emission]
			}

			Lighting On 

			SeparateSpecular On 

			SetTexture[_MainTex]{
				Combine texture * primary double,texture * primary
			}
		}
	}
}
