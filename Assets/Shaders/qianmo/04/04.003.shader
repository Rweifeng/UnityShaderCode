Shader "浅墨Shader编程/04.剔除、深度与Alpha测试、基本雾效/003.基于Alpha测试"{
	Properties{
		_MainTex("基础纹理(RGB)-透明度(A)",2D)="white"{}
	}
	SubShader{
	//进行Alpha测试操作，且只渲染透明度大于60%的像素
		pass{
			AlphaTest Greater 0.6  
			SetTexture [_MainTex] { 
				combine texture 
			} 
		}
	}
}