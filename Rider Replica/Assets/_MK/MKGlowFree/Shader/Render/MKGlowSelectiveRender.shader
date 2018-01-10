//////////////////////////////////////////////////////
// MK Glow Free Selective Render Shader    			//
//					                                //
// Created by Michael Kremmel                       //
// www.michaelkremmel.de | www.michaelkremmel.store //
// Copyright © 2017 All rights reserved.            //
//////////////////////////////////////////////////////
Shader "Hidden/MK/Glow/SelectiveRender"
{
	SubShader 
	{
		Tags { "RenderType"="MKGlow" "Queue"="Transparent"}
		Blend SrcAlpha OneMinusSrcAlpha
		Pass 
		{
			ZTest LEqual  
			Fog { Mode Off }
			Cull Back
			Lighting Off
			ZWrite On

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma target 2.0
			#pragma multi_compile_instancing

			#include "UnityCG.cginc"
			
			uniform sampler2D _MKGlowTex;
			uniform float4 _MKGlowTex_ST;
			uniform fixed4 _MKGlowColor;
			uniform half _MKGlowPower;
			uniform half _MKGlowTexPower;
			uniform fixed4 _Color;
			
			struct Input
			{
				float2 texcoord : TEXCOORD0;
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct Output 
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			
			Output vert (Input i)
			{
				UNITY_SETUP_INSTANCE_ID(i);
				Output o;
				UNITY_INITIALIZE_OUTPUT(Output,o);
				UNITY_TRANSFER_INSTANCE_ID(i,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.pos = UnityObjectToClipPos (i.vertex);
				o.uv = i.texcoord.xy;
				return o;
			}

			fixed4 frag (Output i) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(i);
				fixed4 glow = tex2D(_MKGlowTex, UnityStereoScreenSpaceUVAdjust(i.uv.xy, _MKGlowTex_ST));
				glow.rgb *= (_MKGlowColor * _MKGlowPower);
				glow.a = _Color.a;
				return glow;
			}
			ENDCG
		}
	}
	SubShader 
	{
		Tags { "RenderType"="MKGlowSprite" "Queue"="Transparent"}
		Blend SrcAlpha OneMinusSrcAlpha
		Pass 
		{
			ZTest LEqual  
			Fog { Mode Off }
			Cull Off
			Lighting Off
			ZWrite On

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma target 2.0
			#pragma multi_compile_instancing

			#include "UnityCG.cginc"
			
			uniform sampler2D _MKGlowTex;
			uniform float4 _MKGlowTex_ST;
			uniform fixed4 _MKGlowColor;
			uniform half _MKGlowPower;
			uniform half _MKGlowTexPower;
			uniform fixed4 _Color;
			
			struct Input
			{
				float2 texcoord : TEXCOORD0;
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct Output 
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			
			Output vert (Input i)
			{
				UNITY_SETUP_INSTANCE_ID(i);
				Output o;
				UNITY_INITIALIZE_OUTPUT(Output,o);
				UNITY_TRANSFER_INSTANCE_ID(i,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.pos = UnityObjectToClipPos (i.vertex);
				o.uv = i.texcoord.xy;
				return o;
			}

			fixed4 frag (Output i) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(i);
				fixed4 glow = tex2D(_MKGlowTex, UnityStereoScreenSpaceUVAdjust(i.uv.xy, _MKGlowTex_ST));
				glow.rgb *= (_MKGlowColor * _MKGlowPower);
				glow.a = _Color.a;
				return glow;
			}
			ENDCG
		}
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		Pass 
		{
			Fog { Mode Off }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma target 2.0
			#pragma multi_compile_instancing
			
			#include "UnityCG.cginc"

			struct Input
			{
				float2 texcoord : TEXCOORD0;
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct Output 
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			
			Output vert (Input i)
			{
				UNITY_SETUP_INSTANCE_ID(i);
				Output o;
				UNITY_INITIALIZE_OUTPUT(Output,o);
				UNITY_TRANSFER_INSTANCE_ID(i,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.pos = UnityObjectToClipPos (i.vertex);
				o.uv = i.texcoord;
				return o;
			}

			fixed4 frag (Output i) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(i);
				return fixed4(0,0,0,0);
			}
			
			ENDCG
		}
	}
	SubShader 
	{
		Tags { "RenderType"="Transparent" }
		Pass 
		{
			Fog { Mode Off }
			ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma target 2.0
			#pragma multi_compile_instancing
			
			uniform fixed4 _Color;

			#include "UnityCG.cginc"

			struct Input
			{
				float2 texcoord : TEXCOORD0;
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct Output 
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				fixed4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			
			Output vert (Input i)
			{
				UNITY_SETUP_INSTANCE_ID(i);
				Output o;
				UNITY_INITIALIZE_OUTPUT(Output,o);
				UNITY_TRANSFER_INSTANCE_ID(i,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.pos = UnityObjectToClipPos (i.vertex);
				o.uv = i.texcoord;
				o.color = _Color;
				return o;
			}

			fixed4 frag (Output i) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(i);
				return fixed4(0,0,0,i.color.a);
			}
			
			ENDCG
		}
	} 
	
	SubShader 
	{
		Tags { "RenderType"="TransparentCutout" }
		Pass 
		{
			Fog { Mode Off }
			Blend SrcAlpha OneMinusSrcAlpha
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma target 2.0
			#pragma multi_compile_instancing
			
			uniform fixed4 _Color;

			#include "UnityCG.cginc"

			struct Input
			{
				float2 texcoord : TEXCOORD0;
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct Output 
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				fixed4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			
			Output vert (Input i)
			{
				UNITY_SETUP_INSTANCE_ID(i);
				Output o;
				UNITY_INITIALIZE_OUTPUT(Output,o);
				UNITY_TRANSFER_INSTANCE_ID(i,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.pos = UnityObjectToClipPos (i.vertex);
				o.uv = i.texcoord;
				return o;
			}

			fixed4 frag (Output i) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(i);
				return fixed4(0,0,0,i.color.a);
			}
			
			ENDCG
		}
	} 
} 

