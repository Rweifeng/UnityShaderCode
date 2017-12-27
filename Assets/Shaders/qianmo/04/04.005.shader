
Shader "浅墨Shader编程/04.剔除、深度与Alpha测试、基本雾效/005.简单植被Shader"{
	Properties{
		_Color("主颜色",COLOR)=(0.5,0.5,0.5,0.5)
		_MainTex("主纹理",2D)="white"{}
		_Cutoff("Alpha透明度阈值",Range(0,0.9))=0.5
	}

	SubShader{
		//1.定义材质
		Material{
			DIFFUSE[_Color]
			Ambient[_Color]
		}

		//2.开启光照
		Lighting On 

		//3.关闭裁剪，渲染所有面，用于接下来渲染几何体两面
		Cull Off
		
		//通道一：渲染所有超过[_Cutoff]不透明的像素
		Pass{
			AlphaTest Greater [_Cutoff]
			SetTexture[_MainTex]{
				Combine texture * primary,texture 
			}
		}
		
		//通道二：渲染半透明细节
		Pass{
			//不写到深度缓冲中
			ZWrite Off

			//不写已经写过的像素
			ZTest Less

			//深度测试中，只渲染小于或等于的像素值
			AlphaTest LEqual[_Cutoff]

			//设置透明度混合
			Blend SrcAlpha OneMinusSrcAlpha

			//进行纹理混合
			SetTexture[_MainTex]{
				Combine texture * primary,texture 
			}
		}
	}
}