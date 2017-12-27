Shader "浅墨Shader编程/05.Unity三种形态Shader对比&混合/004.基于blend使用" {
	Properties{
		_MainTex("将要混合的基本纹理",2D)="black"{}
	}
	SubShader{
		Tags{"Queue"="Geometry"}
		Pass{
			//进行混合
			//One	值为1，使用此因子来让帧缓冲区源颜色或是目标颜色完全的通过。
			//Zero	值为0，使用此因子来删除帧缓冲区源颜色或目标颜色的值。
			//SrcColor	使用此因子为将当前值乘以帧缓冲区源颜色的值
			//SrcAlpha	使用此因子为将当前值乘以帧缓冲区源颜色Alpha的值。
			//DstColor	使用此因子为将当前值乘以帧缓冲区源颜色的值。
			//DstAlpha	使用此因子为将当前值乘以帧缓冲区源颜色Alpha分量的值。
			//OneMinusSrcColor	使用此因子为将当前值乘以(1 -帧缓冲区源颜色值)
			//OneMinusSrcAlpha	使用此因子为将当前值乘以(1 -帧缓冲区源颜色Alpha分量的值)
			//OneMinusDstColor	使用此因子为将当前值乘以(1 –目标颜色值)
			//OneMinusDstAlpha	使用此因子为将当前值乘以(1 –目标Alpha分量的值)
			Blend DstColor Zero //乘法

			SetTexture[_MainTex]{
				Combine texture
			}
		}
	}
}