Shader "浅墨Shader编程/13.单色透明与标准镜面高光/001.可调色单色透明Shader" {
	Properties{
		_ColorWithAlpha("ColorWithAlpha",COLOR)=(0.9,0.1,0.1,0.5)
	}
	SubShader {
		Tags{"Queue"="Transparent"}

		Pass{
			ZWrite Off

			Blend SrcAlpha SrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag 

			uniform float4 _ColorWithAlpha;

			float4 vert(float4 vertexPos:POSITION):SV_POSITION{
				return mul(UNITY_MATRIX_MVP,vertexPos);
			}

			float4 frag(void):COLOR{
				return _ColorWithAlpha;
			}
			ENDCG
		}
	}
}
