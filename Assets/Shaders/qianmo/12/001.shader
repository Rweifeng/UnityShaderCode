Shader "浅墨Shader编程/12.可编程Shader/000.单色可调Shader"{
	Properties{
		_Color("主颜色",COLOR)=(1,1,1,1)
	}
	SubShader{
		Pass{
			CGPROGRAM
				#pragma vertex vert 
				#pragma fragment frag

				//顶点着色函数
				float4 vert(float4 vertexPos:POSITION):SV_POSITION{
					return mul(UNITY_MATRIX_MVP,vertexPos); 
				}

				uniform float4 _Color;
				//片段着色器
				float4 frag(void):COLOR{
					return _Color;
				}
			ENDCG
		}
	}
}