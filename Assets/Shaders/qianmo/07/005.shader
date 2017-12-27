Shader "浅墨Shader编程/07.SurfaceShader+自定义光照/004.自定义卡通渐变光照模型v2" {
	Properties {
		_MainTex("主纹理",2D)="white"{}
		_Ramp("渐变纹理",2D)="white"{}
		_BumpMap("凹凸纹理",2D)="bump"{}
		_Detail("细节纹理",2D)="gray"{}
		_RimColor("边缘颜色",COLOR)=(0.26,0.19,0.16,0.0)
		_RimPower("边缘颜色强度",Range(0.5,8.0))=3.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		//1.光照模型声明：使用自定义的光照模型
		#pragma surface surf MyCartoonShader

		sampler2D _MainTex;
		sampler2D _Ramp;
		sampler2D _BumpMap;
		sampler2D _Detail;
		float4 _RimColor;
		float _RimPower;

		//2.实现自定义光照模型
		inline float4 LightingMyCartoonShader(SurfaceOutput s,fixed3 lightDir,fixed atten){
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
			float2 uv_BumpMap;
			float2 uv_Detail;
			//当前坐标的视角方向
			float3 viewDir;
		};

		void surf(Input IN,inout SurfaceOutput o){
			//获取主纹理
			o.Albedo=tex2D(_MainTex,IN.uv_MainTex).rgb;	
			//获取叠加细节纹理
			o.Albedo*=tex2D(_Detail,IN.uv_Detail).rgb*2;
			//取得凹凸法线值
			o.Normal=UnpackNormal(tex2D(_BumpMap,IN.uv_BumpMap));
			//计算边缘颜色
			half rim=1.0-saturate(dot(normalize(IN.viewDir),o.Normal));
			o.Emission=_RimColor.rgb*pow(rim,_RimPower);
		}

		ENDCG
	}
	FallBack "Diffuse"
}
