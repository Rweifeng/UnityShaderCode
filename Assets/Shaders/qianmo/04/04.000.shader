Shader "浅墨Shader编程/04.剔除、深度与Alpha测试、基本雾效/000.剔除正面"{
	Properties{
		
	}

	SubShader{
		pass{
			//1.设置顶点光照
			Material{
				DIFFUSE(1,1,1,1)
				Emission(0.3,0.3,0.3,0.3)
			}

			//2.开启光照
			Lighting On 

			//3.剔除正面(不绘制面向观察者的几何体)
			Cull Front 
		}
	}
}