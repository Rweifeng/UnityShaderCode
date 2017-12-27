Shader "浅墨Shader编程/02.认识和书写实战/006.光照材质完整正式版Shader"{
	Properties{
		_Color("主颜色",COLOR)=(1,1,1,0)
		_SpecColor("高光颜色",COLOR)=(1,1,1,1)
		_Emission("自发光颜色",COLOR)=(0,0,0,0)
		_Shineness("光泽度",Range(0.01,1))=0.7
		_MainTex("基本纹理",2D)="white"{}
	}

	SubShader{
		pass{
			Material{
				DIFFUSE[_Color]
				Ambient[_Color]

				Shininess[_Shineness]

				SPECULAR[_SpecColor]

				Emission[_Emission]
			}

			Lighting On
			//开启独立镜面反射
			SeparateSpecular On
			//设置纹理并进行纹理混合
			SetTexture[_MainTex]{
				Combine texture * primary double,texture * primary
			}
		}
	}
}