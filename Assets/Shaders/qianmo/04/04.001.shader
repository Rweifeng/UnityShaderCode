Shader "浅墨Shader编程/04.剔除、深度与Alpha测试、基本雾效/001.用剔除操作渲染对象背面"{
	Properties{
		_Color("主颜色",COLOR)=(1,1,1,0)
		_SpecColor("高光颜色",COLOR)=(1,1,1,1)
		_Emission("光泽颜色",COLOR)=(0,0,0,0)
		_Shininess("光泽度",Range(0.01,1))=0.7
		_MainTex("基础纹理(RGB)-透明度(A)",2D)="white"{}
	}
	SubShader{
		pass{
			//1.设置顶点光照
			Material{
				DIFFUSE[_Color]
				Ambient[_Color]
				Shininess[_Shininess]
				SPECULAR[_SpecColor]
				Emission[_Emission]
			}

			//2.开启光照
			Lighting On

			//3.将顶点颜色混合上纹理
			SetTexture[_MainTex]{
				Combine Primary * texture
			}
		}

		//通道二：采用蓝色来渲染背面
		pass{
			COLOR(0,0,1,1)
			Cull Front 
		}
	}
}