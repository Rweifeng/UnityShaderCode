Shader "浅墨Shader编程/03.子着色器实例/03.001.GrabPassInvert"{
	SubShader{

		//在所有不透明几何体之后绘制
		Tags{"Queue"="Transparent"}

		//捕获对象后面的纹理到_GrabPass中
		GrabPass{}

		//用前面捕获的纹理渲染对象，并反相它的颜色
		Pass{
			SetTexture[_GrabTexture]{
				//Combine one-texture
				Combine texture
			}
		}
	}
}