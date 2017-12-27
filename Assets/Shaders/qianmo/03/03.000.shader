Shader "浅墨Shader编程/03.子着色器实例/03.000.Tags使用示例"{
	SubShader{
		//在Unity实现中每一个队列都被一个整数的索引值所代表。后台为1000，几何体为2000，透明为3000，叠加层为4000. 
		//着色器可以自定义一个队列，如：Tags { "Queue" ="Geometry+1" }

		Tags{"Queue"="Transparent"}
		Pass{
			
		}
	}
}