Shader "浅墨Shader编程/13.单色透明与标准镜面高光/002.可调色双面双色透明Shader" {
	Properties{
		_ColorWithAlpha_Front("Front",COLOR)=(0.9,0.1,0.1,0.5)
		_ColorWithAlpha_Back("Back",COLOR)=(0.1,0.3,0.9,0.5)
	}
	SubShader {
		Tags{"Queue"="Transparent"}

		Pass{
			Cull Back
			
			ZWrite Off

			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag 

			uniform float4 _ColorWithAlpha_Front;

			float4 vert(float4 vertexPos:POSITION):SV_POSITION{
				return mul(UNITY_MATRIX_MVP,vertexPos);
			}

			float4 frag(void):COLOR{
				return _ColorWithAlpha_Front;
			}
			ENDCG
		}

		Pass{
			Cull Front

			ZWrite Off

			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert 
			#pragma fragment frag

			uniform float4 _ColorWithAlpha_Back;

			float4 vert(float4 vertexPos:POSITION):SV_POSITION{
				return mul(UNITY_MATRIX_MVP,vertexPos);
			}

			float4 frag(void):COLOR{
				return _ColorWithAlpha_Back;
			}

			ENDCG
		}
	}
}
