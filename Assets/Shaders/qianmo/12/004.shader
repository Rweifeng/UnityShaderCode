Shader "浅墨Shader编程/12.可编程Shader/004.三色可调RGB Cube"{
	Properties{
		_ColorValueRed("Color",Range(0.0,1.0))=0.6
		_ColorValueGreen("Color",Range(0.0,1.0))=0.6
		_ColorValueBlue("Color",Range(0.0,1.0))=0.6
	}
	SubShader{
		Pass{
			CGPROGRAM
				#pragma vertex vert 
				#pragma fragment frag

				struct vertexOutput{
					float4 position:SV_POSITION;//空间位置
					float4 color:TEXTCOORD;//0级纹理坐标
				};

				uniform float _ColorValueRed;
				uniform float _ColorValueGreen;
				uniform float _ColorValueBlue;

				//顶点着色函数
				vertexOutput vert(float4 vertexPos:POSITION){
					vertexOutput output;
					output.position=mul(UNITY_MATRIX_MVP,vertexPos);
					output.color=vertexPos+float4(_ColorValueRed,_ColorValueGreen,_ColorValueBlue,1.0);

					return output;
				}

				//片段着色器
				float4 frag(vertexOutput o):COLOR{
					return o.color;
				}
			ENDCG
		}
	}
}