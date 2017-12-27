Shader "浅墨Shader编程/05.Unity三种形态Shader对比&混合/005.基于blend使用+颜色可调" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags{"Queue"="Transparent"}//子着色器的标签设为透明
		Pass{
			Blend One OneMinusSrcColor //柔性相加
			SetTexture[_MainTex]{
				//使颜色进入混合器
				constantColor[_Color]
				//使用纹理的Alpha通道插值混合顶点颜色
				combine constant lerp(texture)previous
			}
		}
	}
}
