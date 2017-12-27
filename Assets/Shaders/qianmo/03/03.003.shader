Shader "浅墨Shader编程/03.子着色器实例/03.003.纹理的Alpha通道与自发光混合"{
	Properties{
		_MainTex("基础纹理(RGB)-自发光(A)",2D)="red"{}
	}

	SubShader{
		Pass{
			//1.设置白色的顶点光照
			Material{
				DIFFUSE(1,1,1,1)
				Ambient(1,1,1,1)
			}

			//2.开光照
			Lighting On

			//3.使用纹理的Alpha通道来差值混合颜色(1,1,1,1)
			SetTexture[_MainTex]{
				ConstantColor(1,1,1,1)
				Combine constant lerp(texture) previous
			}

			//4.和纹理相乘
			SetTexture[_MainTex]{
				Combine previous * texture
			}
		}
	}
}