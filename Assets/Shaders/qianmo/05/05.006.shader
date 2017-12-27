Shader "浅墨Shader编程/05.Unity三种形态Shader对比&混合/006.基于blend使用+顶点光照"{
	Properties{
		_Color("主颜色",COLOR)=(1,1,1,1)
		_MainTex("基础纹理",2D)="white"{}
	}
	SubShader{
		Tags{"Queue"="Transparent"}
		Pass{
			Material{
				DIFFUSE[_Color]
				Ambient[_Color]
			}

			Lighting On 
			Blend One OneMinusSrcColor //柔性相加
			SetTexture[_MainTex]{
				//使颜色属性进入混合器
				ConstantColor[_Color]
				//使用纹理的Alpha通道插值混合顶点颜色
				Combine constant lerp(texture)previous
			}
		}
	}
}