Shader "浅墨Shader编程/03.子着色器实例/03.004.纹理Alpha与自发光混合可调色版"
{
	Properties{
		_IlluminCol("自发光(RGB)",COLOR)=(1,1,1,1)
		_MainTex("基础纹理(RGB)-自发光(A)",2D)="white"{}
	}

	SubShader{
		pass{
			//1.设置白色的顶点光照
			Material{
				DIFFUSE(1,1,1,1)
				Ambient(1,1,1,1)
			}
		
			//2.开启光照
			Lighting On 

			//3.将自发光颜色混合上纹理
			SetTexture[_MainTex]{
				//使颜色属性进入混合器
				constantColor[_IlluminCol]

				//使用纹理的Alpha通道混合顶点颜色
				Combine constant lerp(texture) previous
			} 

			//4.乘以纹理
			SetTexture[_MainTex]{
				Combine texture * previous
			}
		}
		
	}
}