Shader "浅墨Shader编程/02.认识和书写实战/003.简单的可调漫反射光照"{
	Properties{
		_MainColor("主颜色",COLOR)=(1,1,.5,1)
	}
	SubShader{
		Pass{
			Material{
				DIFFUSE[_MainColor]
				Ambient[_MainColor]
			}
			Lighting On
		}
	}
}