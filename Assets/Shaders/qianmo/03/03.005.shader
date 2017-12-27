Shader "浅墨Shader编程/03.子着色器实例/03.005.顶点光照+纹理Alpha自发光混合"{
	Properties{
		_IlluminCol("自发光色",COLOR)=(1,1,1,1)
		_Color("主颜色",COLOR)=(1,1,1,0)
		_SpecColor("高光颜色",COLOR)=(1,1,1,1)
		_Emission("光泽颜色",COLOR)=(0,0,0,0)
		_Shininess("光泽度",Range(0.01,1))=0.7
		_MainTex("基础纹理",2D)="white"{}
	}

	SubShader{
		Pass{
			//1.设置顶点光照值
			Material{
				DIFFUSE[_Color]
				Ambient[_Color]
				Shininess[_Shininess]
				SPECULAR[_SpecColor]
				Emission[_Emission]
			}

			//2.开启光照
			Lighting On
			
			//3.开启独立镜面反射
			SeparateSpecular On 

			//4.将自发光颜色混合上纹理
			SetTexture[_MainTex]{
				constantColor[_IlluminCol]
				Combine constant lerp(texture) previous
			}
			
			//5.乘上纹理
			SetTexture[_MainTex]{
				Combine texture * previous
			}

			//6.乘以顶点纹理
			SetTexture[_MainTex]{
				Combine previous * primary double,previous * primary
			}
		}
	}
}