Shader "浅墨Shader编程/07.SurfaceShader+自定义光照/004.自定义卡通渐变光照模型" {
	Properties {
		_MainTex("主纹理",2D)="white"{}
		_Ramp("渐变纹理",2D)="white"{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM
		//1.光照模型声明：使用自定义的光照模型
		#pragma surface surf Ramp

		sampler2D _MainTex;
		sampler2D _Ramp;

		//2.实现自定义光照模型
		half4 LightingRamp(SurfaceOutput s,half3 lightDir,half atten){
			//点乘反射光线法线和光线方向
			half NdotL=dot(s.Normal,lightDir);

			//在兰伯特光照的基础上加上这句，增强光照
			float diff=NdotL*0.5+0.5;

			//从纹理中定义渐变效果
			half3 ramp=tex2D(_Ramp,float2(diff,diff)).rgb;

			//计算出最终结果
			half4 color;
			color.rgb=s.Albedo*_LightColor0.rgb*ramp*(atten*2);
			color.a=s.Alpha;
			return color;
		}

		struct Input{
			float2 uv_MainTex;
		};

		void surf(Input IN,inout SurfaceOutput o){
			o.Albedo=tex2D(_MainTex,IN.uv_MainTex).rgb;		}

		ENDCG
	}
	FallBack "Diffuse"
}
