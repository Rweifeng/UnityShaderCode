Shader "浅墨Shader编程/06.表面着色器编写/006.凹凸纹理+颜色可调+边缘光照"{
	Properties{
		_MainTex("Main",2D)="white"{}
		_BumpMap("Bump",2D)="bump"{}
		_Color("Main Color",COLOR)=(0.6,0.3,0.6,0.3)
		_RimColor("Rim Color",COLOR)=(0.26,0.19,0.16,0.0)
		_RimPower("Rim Power",Range(0.5,8.0))=3.0
	}
	SubShader{
		Tags{"RenderType"="Opaque"}

		CGPROGRAM
		#pragma surface surf Lambert finalcolor:setcolor

		struct Input{
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir;
		};

		sampler2D _MainTex;
		sampler2D _BumpMap;
		fixed4 _Color;
		fixed4 _RimColor;
		float _RimPower;

		void setcolor(Input IN,SurfaceOutput o,inout fixed4 color){
			color*=_Color;
		}

		void surf(Input IN,inout SurfaceOutput o){
			o.Albedo=tex2D(_MainTex,IN.uv_MainTex).rgb;
			o.Normal=UnpackNormal(tex2D(_BumpMap,IN.uv_BumpMap));
			half rim=1.0-saturate(dot(normalize(IN.viewDir),o.Normal));
			o.Emission=_RimColor.rgb*pow(rim,_RimPower);
		}
		ENDCG
	}
	FallBack "DIFFUSE"
}