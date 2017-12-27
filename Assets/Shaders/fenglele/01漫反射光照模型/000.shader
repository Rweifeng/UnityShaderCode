// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Unity Shader入门精要/01漫反射光照模型/000.逐顶点光照"{
	Properties{
		//用来控制材质的漫反射颜色
		_Diffuse("Diffuse",COLOR)=(1,1,1,1)
	}
	SubShader{
		Pass{
			//LightMode标签是Pass标签中的一种，用于定义该Pass在Unity的光照流水线中的角色
			//只有定义了正确的LightMode，才能得到一些Unity的内置光照变量，如_WorldSpaceLightPos0
			Tags{"LightMode"="ForwardBase"}

			//CGPROGRAM和ENDCG用来包围CG代码片
			CGPROGRAM
			//告诉Unity定义的顶点着色器和片元着色器的名字
			#pragma vertex vert 
			#pragma fragment frag 

			//包含Unity的内置文件，用来使用Unity内置的一些变量
			#include "Lighting.cginc"

			//为了使用在Properties声明的属性，需要定义一个和该属性类型相匹配的变量
			fixed4 _Diffuse;

			//定义顶点着色器的输入结构体
			struct a2v{
				//POSITION语义告诉Unity，用模型空间的顶点坐标填充vertex变量
				float4 vertex:POSITION;
				//NORMAL语义告诉Unity，用模型空间的法线方向填充normal变量
				float3 normal:NORMAL;
			};

			//定义顶点着色器的输出结构体，！！！同时也是片元着色器的输入结构体
			//这也是顶点着色器和片元着色器之间的通信
			struct v2f{
				float4 pos:SV_POSITION;//储存顶点着色器转换后的顶点信息
				fixed3 color:COLOR;//储存顶点着色器中计算得到的光照颜色，然后传递给片元着色器
			};

			//顶点着色器
			//a2v是顶点着色器的输入结构，由Unity自动为我们准备需要的模型数据
			v2f vert(a2v v){
				//定义一个顶点着色器输出结构的变量，用于存储顶点着色器计算后的输出结果，并且传递给片元着色器
				v2f o;

				//把顶点位置从模型空间转换到裁剪空间
				//UNITY_MATRIX_MVP是Unity内置的模型*世界*投影矩阵
				//使用v.vertex来访问模型空间的顶点坐标
				//mul函数实现矩阵乘法
				o.pos=mul(UNITY_MATRIX_MVP,v.vertex);

				//得到环境光
				//UNITY_LIGHTMODEL_AMBIENT是Unity内置变量，用来获取环境光
				fixed3 ambient=UNITY_LIGHTMODEL_AMBIENT.xyz;

				//把法线从模型空间转为世界空间
				//normalize为归一化方法，得到单位向量
				//unity_WorldToObject是unity_ObjectToWorld的逆矩阵，用于将顶点/方向矢量从世界空间变换到模型空间
				fixed3 worldNormal=normalize(mul(v.normal,(float3x3)unity_WorldToObject));

				//在世界空间中得到光照方向
				//_WorldSpaceLightPos0是Unity内置用来得到光源方向的
				fixed3 worldLightDir=normalize(_WorldSpaceLightPos0.xyz);

				//计算漫反射值
				//计算漫反射需要4个值：漫反射颜色、顶点法线、光源颜色和强度、光源方向
				//_LightColor0是Unity内置变量，用来访问该Pass处理的光源颜色和强度信息
				//saturate函数用来截取[0,1]
				//dot得到标量
				//兰伯特光照模型：C(diffuse)=(C(light)*m(diffuse))max(0,n.I)
				fixed3 diffuse=_LightColor0.rgb*_Diffuse.rgb*saturate(dot(worldNormal,worldLightDir));

				o.color=ambient+diffuse;
				return o;
			}

			fixed4 frag(v2f i):SV_Target{
				return fixed4(i.color,1.0);
			}
			ENDCG	
		}
	}

	FallBack "Diffuse"
}