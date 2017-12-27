Shader "浅墨Shader编程/13.单色透明与标准镜面高光/000.单色透明Shader" {
	SubShader {
		Tags{"Queue"="Transparent"}

		Pass{
			ZWrite Off

			Blend SrcAlpha SrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag 

			float4 vert(float4 vertexPos:POSITION):SV_POSITION{
				return mul(UNITY_MATRIX_MVP,vertexPos);
			}

			float4 frag(void):COLOR{
				return float4(0.3,1.0,0.1,0.6);
			}
			ENDCG
		}
	}
}
