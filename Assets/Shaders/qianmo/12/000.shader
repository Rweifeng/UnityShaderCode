Shader "浅墨Shader编程/12.可编程Shader/000.单色Shader"{
	SubShader{
		Pass{
			CGPROGRAM
				#pragma vertex vert 
				#pragma fragment frag

				//顶点着色函数
				float4 vert(float4 vertexPos:POSITION):SV_POSITION{
					return mul(UNITY_MATRIX_MVP,vertexPos); 
				}

				//片段着色器
				float4 frag(void):COLOR{
					return float4(0.0,0.6,0.8,1.0);
				}
			ENDCG
		}
	}
}