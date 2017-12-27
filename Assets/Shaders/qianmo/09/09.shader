Shader "浅墨Shader编程/09.水屏幕特效"
{
	Properties
	{
		//主纹理
		_MainTex ("Texture", 2D) = "white" {}
		//屏幕水滴素材图
		_ScreenWaterDropTex("水纹理",2D)="white"{}
		//当前时间
		//_CurTime("Time",float)=1.0
		_CurTime("Time",Range(0.0,1.0))=1.0
		//x坐标上的水滴尺寸
		_SizeX("SizeX",Range(0.0,1.0))=1.0
		//Y坐标上的水滴尺寸
		_SizeY("SixeY",Range(0.0,1.0))=1.0
		//水流速度
		_DropSpeed("Speed",Range(0.0,10.0))=1.0
		//溶解度
		_Distortion("_Distortion",Range(0.0,1.0))=0.87
	}
	SubShader
	{
		ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			//外部变量的声明
			uniform sampler2D _MainTex;
			uniform sampler2D _ScreenWaterDropTex;
			float _CurTime;
			float _DropSpeed;
			float _SizeX;
			float _SizeY;
			float _Distortion;
			float2 _MainTex_TexelSize;

			//顶点输入结构
			struct appdata
			{
				float4 vertex : POSITION;//顶点位置
				float4 color : COLOR;//颜色值
				float2 uv : TEXCOORD0;//一级纹理坐标
			};

			//顶点输出结构
			struct v2f
			{
				float2 uv : TEXCOORD0; //一级纹理坐标
				float4 vertex : SV_POSITION;//像素位置
				fixed4 color : COLOR;//颜色值
			};

			//顶点着色函数
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				o.color=v.color;
				return o;
			}
			
			//片段着色函数
			fixed4 frag (v2f i) : COLOR
			{
			    //获取顶点的坐标值
				float2 uv=i.uv.xy;

				//解决平台差异问题，校正方向，若与规定方向相反，则将速度反向并加1
				#if UNITY_UV_STARTS_AT_TOP
				if(_MainTex_TexelSize.y<0)
					_DropSpeed=1-_DropSpeed;
				#endif

				//设置三层水流效果，按照一定的规律在水滴纹理上分别进行取样
				float3 rainTex1 = tex2D(_ScreenWaterDropTex, float2(uv.x * 1.15* _SizeX, (uv.y* _SizeY *1.1) + _CurTime* _DropSpeed *0.15)).rgb/_Distortion;
				float3 rainTex2 = tex2D(_ScreenWaterDropTex, float2(uv.x * 1.25* _SizeX - 0.1, (uv.y *_SizeY * 1.2) + _CurTime *_DropSpeed * 0.2)).rgb/_Distortion;
				float3 rainTex3 = tex2D(_ScreenWaterDropTex, float2(uv.x* _SizeX *0.9, (uv.y *_SizeY * 1.25) + _CurTime * _DropSpeed* 0.032)).rgb/_Distortion;

				//整合三层水流效果的颜色值，存于finalRainTex中
				float2 finalRainTex = uv.xy - (rainTex1.xy - rainTex2.xy - rainTex3.xy) / 3;
				//按照finalRainTex的坐标信息，在主纹理中进行采样
				float3 finalColor = tex2D(_MainTex, float2(finalRainTex.x, finalRainTex.y)).rgb;
				//返回加上Alpha分量的最终颜色值
				return fixed4(finalColor, 1.0);
			}
			ENDCG
		}
	}
}
