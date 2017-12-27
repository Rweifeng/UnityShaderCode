Shader "浅墨Shader编程/02.认识和书写实战/004.光照材质完整beta版Shader"{
	Properties{
		_MainColor("主颜色",COLOR)=(1,1,1,1)
		_SpecColor("反射高光颜色",COLOR)=(1,1,1,1)
		_Emission("自发光颜色",COLOR)=(0,0,0,0)
		_Shininess("光泽度",Range(0.01,1))=0.7
	}

	SubShader{
		pass{
			Material{
				//可调节漫反射和环境光
				DIFFUSE[_MainColor]
				Ambient[_MainColor]
				//光泽度
				Shininess[_Shininess]
				//高光颜色
				SPECULAR[_SpecColor]
				//自发光颜色
				Emission[_Emission]
			}
			//开启光照
			Lighting On
		}
	}
}