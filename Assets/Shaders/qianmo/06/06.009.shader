Shader "浅墨Shader编程/06.表面着色器编写/008.凹凸纹理+颜色可调+边缘光照+细节纹理" {
	Properties {
		_MainTex("MainTex",2D)="white"{}
		_BumpMap("BumpMap",2D)="bump"{}
		_Detail("Detail",2D)="gray"{}
		_Color("Main Color",COLOR)=(1,1,1,1)
		_RimColor("Rim Color",COLOR)=(0,0,0,0)
		_RimPower("Rim Power",Range(0.5,8.0))=3.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		CGPROGRAM
		#pragma surface surf Lambert finalcolor:setcolor

		struct Input{
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float2 uv_Detail;

			//当前坐标的视角方向  
            float3 viewDir;
		};

		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _Detail;
		fixed4 _Color;
		fixed4 _RimColor;
		float _RimPower;

		void setcolor(Input IN,SurfaceOutput o,inout fixed4 color){
			color*=_Color;
		}

		void surf (Input IN, inout SurfaceOutput o) {
			//先获取主纹理rgb颜色值
			o.Albedo = tex2D(_MainTex,IN.uv_MainTex).rgb;
			//设置细节纹理
			o.Albedo*=tex2D(_Detail,IN.uv_Detail).rgb*2;
			o.Normal=UnpackNormal(tex2D(_BumpMap,IN.uv_BumpMap));
			half rim=1.0-saturate(dot(normalize(IN.viewDir),o.Normal));
			o.Emission=_RimColor.rgb*pow(rim,_RimPower);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
