Shader "浅墨Shader编程/04.剔除、深度与Alpha测试、基本雾效/004.顶点光照+可调透明度"{
	Properties{
		_Color("主颜色",COLOR)=(1,1,1,0)
		_SpecColor("高光颜色",COLOR)=(1,1,1,1)
		_Emission("光泽颜色",COLOR)=(0,0,0,0)
		_Shininess("光泽度",Range(0.01,1))=0.7
		_MainTex("基础纹理(RGB)-透明度(A)",2D)="white"{}
		_Cutoff("Alpha透明度阈值",Range(0,1))=0.5
	}
	SubShader{
		pass{
			//1.使用_Cutoff参数定义能被渲染的透明度阈值
			AlphaTest Greater [_Cutoff]

			//2.设置顶点光照参数值
			Material{
				DIFFUSE[_Color]
				Ambient[_Color]
				Shininess[_Shininess]
				SPECULAR[_SpecColor]
				Emission[_Emission]
			}

			//3.开启光照
			Lighting On

			//4.进行纹理混合
			SetTexture[_MainTex]{
				Combine texture * primary
			}
		}
	}
}