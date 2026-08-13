// Made with Amplify Shader Editor v1.9.2.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HA_Custom/Sd_All"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[Enum(ADD,1,ADP,10)]_BlendMode("Blend Mode", Float) = 10
		[Enum(LessOrEqual,4,Always,8)]_ZTestMode("ZTestMode", Float) = 4
		[Enum(Back,1,Front,2,Off,0)]_CullMode("Cull Mode", Float) = 0
		[Header(_________________________________________________________________________________________)]_HighColor("HighColor", Color) = (1,1,1,1)
		_HighColorHDR("HighColorHDR", Float) = 0
		_HighColorPower("HighColorPower", Float) = 0
		_MainColor("MainColor", Color) = (1,1,1,1)
		_MainColorHDR("MainColorHDR", Float) = 0
		_SubColor("SubColor", Color) = (0,0,0,1)
		_SubColorHDR("SubColorHDR", Float) = 1
		[Toggle(_1_RGB_OR_ALPHA_ON)] _1_RGB_or_Alpha("1_RGB_or_Alpha", Float) = 0
		_DepthFadeValue("DepthFadeValue", Float) = 0
		_1_RGBA_Value("1_RGBA_Value", Vector) = (1,0,0,0)
		_MainTex("MainTex", 2D) = "white" {}
		_1_PannerX("1_PannerX", Float) = 0
		_1_PannerY("1_PannerY", Float) = 0
		_1_Rotion("1_Rotion", Float) = 0
		_1_RotionSpeed("1_RotionSpeed", Float) = 0
		[Toggle(_1_CENTERPIVOT_ON)] _1_CenterPivot("1_CenterPivot", Float) = 0
		[Toggle(_1_CLAMPX_ON)] _1_ClampX("1_ClampX", Float) = 0
		[Toggle(_1_CLAMPY_ON)] _1_ClampY("1_ClampY", Float) = 0
		[Toggle(_1_USEPOLAR_ON)] _1_UsePolar("1_UsePolar", Float) = 0
		_1_Smooth_Step("1_Smooth_Step", Range( 0 , 1)) = 1
		[Toggle(_1_FOLLOWOFFSETMAIN_ON)] _1_FollowOffsetMain("1_FollowOffsetMain", Float) = 1
		_2_RGBA_Value("2_RGBA_Value", Vector) = (1,0,0,1)
		_MaskTex("MaskTex", 2D) = "white" {}
		_2_PannerX("2_PannerX", Float) = 0
		_2_PannerY("2_PannerY", Float) = 0
		_2_Rotion("2_Rotion", Float) = 0
		_2_RotionSpeed("2_RotionSpeed", Float) = 0
		[Toggle(_2_CENTERPIVOT_ON)] _2_CenterPivot("2_CenterPivot", Float) = 0
		[Toggle(_2_CLAMPX_ON)] _2_ClampX("2_ClampX", Float) = 0
		[Toggle(_2_CLAMPY_ON)] _2_ClampY("2_ClampY", Float) = 0
		[Toggle(_2_USEPOLAR_ON)] _2_UsePolar("2_UsePolar", Float) = 0
		_2_Smooth_Step("2_Smooth_Step", Range( 0 , 1)) = 1
		[Toggle(_2_FOLLOWOFFSETMAIN_ON)] _2_FollowOffsetMain("2_FollowOffsetMain", Float) = 0
		_3_RGBA_Value("3_RGBA_Value", Vector) = (1,0,0,1)
		_DissolveTex("DissolveTex", 2D) = "white" {}
		_3_PannerX("3_PannerX", Float) = 0
		_3_PannerY("3_PannerY", Float) = 0
		_3_Rotion("3_Rotion", Float) = 0
		_3_RotionSpeed("3_RotionSpeed", Float) = 0
		[Toggle(_3_CENTERPIVOT_ON)] _3_CenterPivot("3_CenterPivot", Float) = 0
		[Toggle(_3_USEPOLAR_ON)] _3_UsePolar("3_UsePolar", Float) = 0
		_3_Smooth_Step("3_Smooth_Step", Range( 0 , 1)) = 1
		[Toggle(_3_FOLLOWOFFSETMAIN_ON)] _3_FollowOffsetMain("3_FollowOffsetMain", Float) = 0
		_4_RGBA_Value("4_RGBA_Value", Vector) = (1,0,0,1)
		_DissolveMasksTex("DissolveMasksTex", 2D) = "white" {}
		_4_PannerX("4_PannerX", Float) = 0
		_4_PannerY("4_PannerY", Float) = 0
		_4_Rotion("4_Rotion", Float) = 0
		_4_RotionSpeed("4_RotionSpeed", Float) = 0
		[Toggle(_4_CENTERPIVOT_ON)] _4_CenterPivot("4_CenterPivot", Float) = 0
		[Toggle(_4_USEPOLAR_ON)] _4_UsePolar("4_UsePolar", Float) = 0
		_4_Smooth_Step("4_Smooth_Step", Range( 0 , 1)) = 1
		[Toggle(_4_FOLLOWOFFSETMAIN_ON)] _4_FollowOffsetMain("4_FollowOffsetMain", Float) = 0
		_DissolveValue("DissolveValue", Range( 0 , 2)) = 0
		[Toggle(_ALPHAFORDISSOLVE_ON)] _AlphaforDissolve("Alpha for Dissolve?", Float) = 0
		_SmoothStepValue1("SmoothStepValue1", Range( 0 , 1)) = 0
		_SmoothStepValue2("SmoothStepValue2", Range( 0 , 1)) = 0.2
		_LineThickness("Line Thickness", Range( 0 , 1)) = 0
		_LineMainColor1("LineMainColor1", Color) = (0,0,0,1)
		_LineMainHDR("LineMainHDR", Float) = 1
		_LineSubColor1("LineSubColor1", Color) = (0,0,0,1)
		_LineSubHDR("LineSubHDR", Float) = 0
		[Toggle(_USE_CUSTOM1_ON)] _Use_Custom1("Use_Custom1", Float) = 0
		[Toggle(_USE_CUSTOM2_ON)] _Use_Custom2("Use_Custom2", Float) = 0
		[KeywordEnum(X,Y)] _TillingOffsetXorY("Tilling Offset X or Y", Float) = 0
		[Header(_________________________________________________________________________________________)]_5_Opacity("5_Opacity", Float) = 0
		_5_PowerValue("5_PowerValue", Float) = 1
		_5_Rotion("5_Rotion", Float) = 0
		_5_Tilling("5_Tilling", Float) = 0
		[Toggle(_5_FLIP_ON)] _5_Flip("5_Flip", Float) = 0
		[Toggle(_5_USEPOLAR_ON)] _5_UsePolar("5_UsePolar", Float) = 0
		[Header(_________________________________________________________________________________________)]_1_Distort_MainTex("1_Distort_MainTex", Float) = 0
		_2_Distort_MaskTex("2_Distort_MaskTex", Float) = 0
		_3_Distort_DissolveTex("3_Distort_DissolveTex", Float) = 0
		_4_Distort_MaskDTex("4_Distort_MaskDTex", Float) = 0
		_DistortTex("DistortTex", 2D) = "white" {}
		_6_PannerX("6_PannerX", Float) = 0
		_6_PannerY("6_PannerY", Float) = 0
		_6_Rotion("6_Rotion", Float) = 0
		[Toggle(_6_USEPOLAR_ON)] _6_UsePolar("6_UsePolar", Float) = 0


		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector][ToggleOff] _ReceiveShadows("Receive Shadows", Float) = 1.0
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Transparent" "Queue"="Transparent" }

		Cull [_CullMode]
		AlphaToMask Off

		

		HLSLINCLUDE
		#pragma target 4.5
		#pragma prefer_hlslcc gles
		// ensure rendering platforms toggle list is visible

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }

			Blend SrcAlpha [_BlendMode], SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			ZTest [_ZTestMode]
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM

			#pragma multi_compile_instancing
			#define shader_feature_local _RECEIVE_SHADOWS_OFF
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_SRP_VERSION 101000
			#define REQUIRE_DEPTH_TEXTURE 1


			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local _USE_CUSTOM1_ON
			#pragma shader_feature_local _USE_CUSTOM2_ON
			#pragma shader_feature_local _6_USEPOLAR_ON
			#pragma shader_feature_local _1_CENTERPIVOT_ON
			#pragma shader_feature_local _1_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _TILLINGOFFSETXORY_X _TILLINGOFFSETXORY_Y
			#pragma shader_feature_local _1_USEPOLAR_ON
			#pragma shader_feature_local _1_CLAMPX_ON
			#pragma shader_feature_local _1_CLAMPY_ON
			#pragma shader_feature_local _1_RGB_OR_ALPHA_ON
			#pragma shader_feature_local _2_CENTERPIVOT_ON
			#pragma shader_feature_local _2_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _2_USEPOLAR_ON
			#pragma shader_feature_local _2_CLAMPX_ON
			#pragma shader_feature_local _2_CLAMPY_ON
			#pragma shader_feature_local _3_CENTERPIVOT_ON
			#pragma shader_feature_local _3_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _3_USEPOLAR_ON
			#pragma shader_feature_local _ALPHAFORDISSOLVE_ON
			#pragma shader_feature_local _4_CENTERPIVOT_ON
			#pragma shader_feature_local _4_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _4_USEPOLAR_ON
			#pragma shader_feature_local _5_USEPOLAR_ON
			#pragma shader_feature_local _5_FLIP_ON


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD1;
				#endif
				#ifdef ASE_FOG
					float fogFactor : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_color : COLOR;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _LineMainColor1;
			float4 _1_RGBA_Value;
			float4 _LineSubColor1;
			float4 _MaskTex_ST;
			float4 _MainTex_ST;
			float4 _DissolveMasksTex_ST;
			float4 _4_RGBA_Value;
			float4 _3_RGBA_Value;
			float4 _DistortTex_ST;
			float4 _HighColor;
			float4 _DissolveTex_ST;
			float4 _MainColor;
			float4 _SubColor;
			float4 _2_RGBA_Value;
			half _3_PannerX;
			half _3_PannerY;
			half _3_RotionSpeed;
			half _3_Rotion;
			half _3_Distort_DissolveTex;
			half _DissolveValue;
			half _4_Rotion;
			half _4_Distort_MaskDTex;
			half _4_RotionSpeed;
			half _4_PannerX;
			half _4_PannerY;
			half _5_Tilling;
			half _5_Rotion;
			half _5_PowerValue;
			float _5_Opacity;
			half _SmoothStepValue1;
			float _LineThickness;
			float _4_Smooth_Step;
			float _3_Smooth_Step;
			half _ZTestMode;
			half _LineSubHDR;
			half _CullMode;
			half _BlendMode;
			half _SubColorHDR;
			half _MainColorHDR;
			half _1_Distort_MainTex;
			half _6_Rotion;
			half _6_PannerX;
			half _6_PannerY;
			float _1_Rotion;
			half _1_RotionSpeed;
			half _SmoothStepValue2;
			half _1_PannerX;
			float _1_Smooth_Step;
			half _2_Distort_MaskTex;
			float _2_Rotion;
			half _2_RotionSpeed;
			half _2_PannerX;
			half _2_PannerY;
			half _HighColorHDR;
			half _HighColorPower;
			float _2_Smooth_Step;
			half _LineMainHDR;
			half _1_PannerY;
			float _DepthFadeValue;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			sampler2D _DistortTex;
			sampler2D _MaskTex;
			sampler2D _DissolveTex;
			sampler2D _DissolveMasksTex;
			uniform float4 _CameraDepthTexture_TexelSize;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float4 ase_clipPos = TransformObjectToHClip((v.vertex).xyz);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord6 = screenPos;
				
				o.ase_texcoord3 = v.ase_texcoord1;
				o.ase_texcoord4 = v.ase_texcoord2;
				o.ase_texcoord5.xy = v.ase_texcoord.xy;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord5.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.worldPos = positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				#ifdef ASE_FOG
					o.fogFactor = ComputeFogFactor( positionCS.z );
				#endif

				o.clipPos = positionCS;

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = IN.worldPos;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float4 temp_cast_2 = (0.0).xxxx;
				#ifdef _USE_CUSTOM1_ON
				float4 staticSwitch480 = IN.ase_texcoord3;
				#else
				float4 staticSwitch480 = temp_cast_2;
				#endif
				float4 break481 = staticSwitch480;
				float UV1_Y486 = break481.y;
				float clampResult1131 = clamp( ( _MainColorHDR + UV1_Y486 ) , 1.0 , 999.0 );
				float4 temp_cast_3 = (0.0).xxxx;
				#ifdef _USE_CUSTOM2_ON
				float4 staticSwitch986 = IN.ase_texcoord4;
				#else
				float4 staticSwitch986 = temp_cast_3;
				#endif
				float4 break984 = staticSwitch986;
				float UV2_Z990 = break984.z;
				float temp_output_1134_0 = ( _1_Distort_MainTex + UV2_Z990 );
				float2 temp_output_68_0_g258 = IN.ase_texcoord5.xy;
				float temp_output_33_0_g258 = ( ( _6_Rotion * PI ) / -180.0 );
				float temp_output_72_0_g258 = 0.0;
				float cos41_g258 = cos( ( temp_output_33_0_g258 + temp_output_72_0_g258 ) );
				float sin41_g258 = sin( ( temp_output_33_0_g258 + temp_output_72_0_g258 ) );
				float2 rotator41_g258 = mul( temp_output_68_0_g258 - float2( 0.5,0.5 ) , float2x2( cos41_g258 , -sin41_g258 , sin41_g258 , cos41_g258 )) + float2( 0.5,0.5 );
				float clampResult46_g258 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult29_g258 = lerp( 0.0 , 0.5 , clampResult46_g258);
				float2 temp_cast_4 = (lerpResult29_g258).xx;
				float2 break648 = _DistortTex_ST.xy;
				float2 break650 = _DistortTex_ST.zw;
				float4 appendResult649 = (float4(break648.x , break648.y , break650.x , break650.y));
				float4 break63_g258 = appendResult649;
				float2 appendResult60_g258 = (float2(break63_g258.x , break63_g258.y));
				float2 CenteredUV15_g259 = ( temp_output_68_0_g258 - float2( 0.5,0.5 ) );
				float2 break37_g258 = appendResult60_g258;
				float2 break17_g259 = CenteredUV15_g259;
				float2 appendResult23_g259 = (float2(( length( CenteredUV15_g259 ) * break37_g258.x * 2.0 ) , ( atan2( break17_g259.x , break17_g259.y ) * ( 1.0 / TWO_PI ) * break37_g258.y )));
				float cos44_g258 = cos( ( temp_output_33_0_g258 + temp_output_72_0_g258 ) );
				float sin44_g258 = sin( ( temp_output_33_0_g258 + temp_output_72_0_g258 ) );
				float2 rotator44_g258 = mul( appendResult23_g259 - float2( 0.5,0.5 ) , float2x2( cos44_g258 , -sin44_g258 , sin44_g258 , cos44_g258 )) + float2( 0.5,0.5 );
				float2 temp_cast_5 = (lerpResult29_g258).xx;
				#ifdef _6_USEPOLAR_ON
				float staticSwitch647 = 1.0;
				#else
				float staticSwitch647 = 0.0;
				#endif
				float clampResult49_g258 = clamp( staticSwitch647 , 0.0 , 1.0 );
				float2 lerpResult38_g258 = lerp( ( ( rotator41_g258 - temp_cast_4 ) * appendResult60_g258 ) , ( rotator44_g258 - temp_cast_5 ) , clampResult49_g258);
				float2 appendResult61_g258 = (float2(break63_g258.z , break63_g258.w));
				float2 appendResult1291 = (float2(_6_PannerX , _6_PannerY));
				float2 break1289 = ( _TimeParameters.x * appendResult1291 );
				float2 appendResult17_g258 = (float2(break1289.x , break1289.y));
				float2 break20_g258 = ( ( ( lerpResult38_g258 + appendResult61_g258 ) + lerpResult29_g258 ) + appendResult17_g258 );
				float clampResult55_g258 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult25_g258 = lerp( break20_g258.x , saturate( break20_g258.x ) , clampResult55_g258);
				float clampResult58_g258 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult23_g258 = lerp( break20_g258.y , saturate( break20_g258.y ) , clampResult58_g258);
				float2 appendResult21_g258 = (float2(lerpResult25_g258 , lerpResult23_g258));
				float4 tex2DNode639 = tex2D( _DistortTex, appendResult21_g258 );
				float TextureDistort655 = ( tex2DNode639.r * tex2DNode639.a );
				float2 temp_output_68_0_g238 = ( ( ( temp_output_1134_0 * TextureDistort655 ) + IN.ase_texcoord5.xy ) + ( temp_output_1134_0 * -0.3 ) );
				float temp_output_33_0_g238 = ( ( _1_Rotion * PI ) / -180.0 );
				float temp_output_72_0_g238 = ( _1_RotionSpeed * _TimeParameters.x );
				float cos41_g238 = cos( ( temp_output_33_0_g238 + temp_output_72_0_g238 ) );
				float sin41_g238 = sin( ( temp_output_33_0_g238 + temp_output_72_0_g238 ) );
				float2 rotator41_g238 = mul( temp_output_68_0_g238 - float2( 0.5,0.5 ) , float2x2( cos41_g238 , -sin41_g238 , sin41_g238 , cos41_g238 )) + float2( 0.5,0.5 );
				#ifdef _1_CENTERPIVOT_ON
				float staticSwitch87 = 1.0;
				#else
				float staticSwitch87 = 0.0;
				#endif
				float clampResult46_g238 = clamp( staticSwitch87 , 0.0 , 1.0 );
				float lerpResult29_g238 = lerp( 0.0 , 0.5 , clampResult46_g238);
				float2 temp_cast_6 = (lerpResult29_g238).xx;
				float UV2_X988 = break984.x;
				float2 appendResult1149 = (float2(0.0 , UV2_X988));
				float2 appendResult1019 = (float2(UV2_X988 , 0.0));
				#if defined(_TILLINGOFFSETXORY_X)
				float2 staticSwitch1151 = appendResult1149;
				#elif defined(_TILLINGOFFSETXORY_Y)
				float2 staticSwitch1151 = appendResult1019;
				#else
				float2 staticSwitch1151 = appendResult1149;
				#endif
				float2 break1157 = staticSwitch1151;
				float2 appendResult1155 = (float2(break1157.y , break1157.x));
				float2 TillingMain1152 = appendResult1155;
				float UV2_Y989 = break984.y;
				float2 appendResult1015 = (float2(UV2_Y989 , 0.0));
				float2 appendResult1147 = (float2(0.0 , UV2_Y989));
				#if defined(_TILLINGOFFSETXORY_X)
				float2 staticSwitch1150 = appendResult1015;
				#elif defined(_TILLINGOFFSETXORY_Y)
				float2 staticSwitch1150 = appendResult1147;
				#else
				float2 staticSwitch1150 = appendResult1015;
				#endif
				float2 break1156 = staticSwitch1150;
				float2 appendResult1167 = (float2(break1156.x , break1156.y));
				float2 OffsetMain1166 = appendResult1167;
				float4 appendResult1486 = (float4(TillingMain1152 , OffsetMain1166));
				#ifdef _1_FOLLOWOFFSETMAIN_ON
				float4 staticSwitch1491 = appendResult1486;
				#else
				float4 staticSwitch1491 = float4( 0,0,0,0 );
				#endif
				float4 break1484 = staticSwitch1491;
				float2 appendResult1489 = (float2(break1484.x , break1484.y));
				float2 break1481 = ( _MainTex_ST.xy + appendResult1489 );
				float2 appendResult1490 = (float2(break1484.z , break1484.w));
				float2 break1482 = ( _MainTex_ST.zw + appendResult1490 );
				float4 appendResult1480 = (float4(break1481.x , break1481.y , break1482.x , break1482.y));
				float4 break63_g238 = appendResult1480;
				float2 appendResult60_g238 = (float2(break63_g238.x , break63_g238.y));
				float2 CenteredUV15_g239 = ( temp_output_68_0_g238 - float2( 0.5,0.5 ) );
				float2 break37_g238 = appendResult60_g238;
				float2 break17_g239 = CenteredUV15_g239;
				float2 appendResult23_g239 = (float2(( length( CenteredUV15_g239 ) * break37_g238.x * 2.0 ) , ( atan2( break17_g239.x , break17_g239.y ) * ( 1.0 / TWO_PI ) * break37_g238.y )));
				float cos44_g238 = cos( ( temp_output_33_0_g238 + temp_output_72_0_g238 ) );
				float sin44_g238 = sin( ( temp_output_33_0_g238 + temp_output_72_0_g238 ) );
				float2 rotator44_g238 = mul( appendResult23_g239 - float2( 0.5,0.5 ) , float2x2( cos44_g238 , -sin44_g238 , sin44_g238 , cos44_g238 )) + float2( 0.5,0.5 );
				float2 temp_cast_7 = (lerpResult29_g238).xx;
				#ifdef _1_USEPOLAR_ON
				float staticSwitch90 = 1.0;
				#else
				float staticSwitch90 = 0.0;
				#endif
				float clampResult49_g238 = clamp( staticSwitch90 , 0.0 , 1.0 );
				float2 lerpResult38_g238 = lerp( ( ( rotator41_g238 - temp_cast_6 ) * appendResult60_g238 ) , ( rotator44_g238 - temp_cast_7 ) , clampResult49_g238);
				float2 appendResult61_g238 = (float2(break63_g238.z , break63_g238.w));
				float2 appendResult1282 = (float2(_1_PannerX , _1_PannerY));
				float2 break1280 = ( _TimeParameters.x * appendResult1282 );
				float2 appendResult17_g238 = (float2(break1280.x , break1280.y));
				float2 break20_g238 = ( ( ( lerpResult38_g238 + appendResult61_g238 ) + lerpResult29_g238 ) + appendResult17_g238 );
				#ifdef _1_CLAMPX_ON
				float staticSwitch91 = 1.0;
				#else
				float staticSwitch91 = 0.0;
				#endif
				float clampResult55_g238 = clamp( staticSwitch91 , 0.0 , 1.0 );
				float lerpResult25_g238 = lerp( break20_g238.x , saturate( break20_g238.x ) , clampResult55_g238);
				#ifdef _1_CLAMPY_ON
				float staticSwitch92 = 1.0;
				#else
				float staticSwitch92 = 0.0;
				#endif
				float clampResult58_g238 = clamp( staticSwitch92 , 0.0 , 1.0 );
				float lerpResult23_g238 = lerp( break20_g238.y , saturate( break20_g238.y ) , clampResult58_g238);
				float2 appendResult21_g238 = (float2(lerpResult25_g238 , lerpResult23_g238));
				float4 temp_output_19_0_g256 = tex2D( _MainTex, appendResult21_g238 );
				float4 break5_g256 = temp_output_19_0_g256;
				float4 break18_g256 = _1_RGBA_Value;
				float temp_output_26_0_g256 = saturate( ( ( break5_g256.x * break18_g256.x ) + ( break5_g256.y * break18_g256.y ) + ( break5_g256.z * break18_g256.z ) ) );
				float3 temp_cast_9 = (temp_output_26_0_g256).xxx;
				#ifdef _1_RGB_OR_ALPHA_ON
				float staticSwitch133 = 1.0;
				#else
				float staticSwitch133 = 0.0;
				#endif
				float clampResult21_g256 = clamp( staticSwitch133 , 0.0 , 1.0 );
				float3 lerpResult16_g256 = lerp( (temp_output_19_0_g256).xyz , temp_cast_9 , clampResult21_g256);
				float3 temp_output_1607_25 = saturate( lerpResult16_g256 );
				float temp_output_23_0_g256 = _1_Smooth_Step;
				float lerpResult2_g256 = lerp( break5_g256.w , ( temp_output_26_0_g256 * break5_g256.w ) , break18_g256.w);
				float smoothstepResult13_g256 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g256 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g256);
				float lerpResult30_g256 = lerp( smoothstepResult13_g256 , lerpResult2_g256 , saturate( (0.0 + (temp_output_23_0_g256 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				float temp_output_1607_0 = saturate( lerpResult30_g256 );
				float3 lerpResult1071 = lerp( temp_output_1607_25 , ( temp_output_1607_25 * temp_output_1607_0 ) , staticSwitch133);
				float temp_output_1461_0 = ( _2_Distort_MaskTex + UV2_Z990 );
				float2 temp_output_68_0_g240 = ( ( ( temp_output_1461_0 * TextureDistort655 ) + IN.ase_texcoord5.xy ) + ( temp_output_1461_0 * -0.3 ) );
				float temp_output_33_0_g240 = ( ( _2_Rotion * PI ) / -180.0 );
				float temp_output_72_0_g240 = ( _2_RotionSpeed * _TimeParameters.x );
				float cos41_g240 = cos( ( temp_output_33_0_g240 + temp_output_72_0_g240 ) );
				float sin41_g240 = sin( ( temp_output_33_0_g240 + temp_output_72_0_g240 ) );
				float2 rotator41_g240 = mul( temp_output_68_0_g240 - float2( 0.5,0.5 ) , float2x2( cos41_g240 , -sin41_g240 , sin41_g240 , cos41_g240 )) + float2( 0.5,0.5 );
				#ifdef _2_CENTERPIVOT_ON
				float staticSwitch1450 = 1.0;
				#else
				float staticSwitch1450 = 0.0;
				#endif
				float clampResult46_g240 = clamp( staticSwitch1450 , 0.0 , 1.0 );
				float lerpResult29_g240 = lerp( 0.0 , 0.5 , clampResult46_g240);
				float2 temp_cast_10 = (lerpResult29_g240).xx;
				float4 appendResult1469 = (float4(TillingMain1152 , OffsetMain1166));
				#ifdef _2_FOLLOWOFFSETMAIN_ON
				float4 staticSwitch1467 = appendResult1469;
				#else
				float4 staticSwitch1467 = float4( 0,0,0,0 );
				#endif
				float4 break1470 = staticSwitch1467;
				float2 appendResult1471 = (float2(break1470.x , break1470.y));
				float2 break1436 = ( _MaskTex_ST.xy + appendResult1471 );
				float2 appendResult1472 = (float2(break1470.z , break1470.w));
				float2 break1437 = ( _MaskTex_ST.zw + appendResult1472 );
				float4 appendResult1435 = (float4(break1436.x , break1436.y , break1437.x , break1437.y));
				float4 break63_g240 = appendResult1435;
				float2 appendResult60_g240 = (float2(break63_g240.x , break63_g240.y));
				float2 CenteredUV15_g241 = ( temp_output_68_0_g240 - float2( 0.5,0.5 ) );
				float2 break37_g240 = appendResult60_g240;
				float2 break17_g241 = CenteredUV15_g241;
				float2 appendResult23_g241 = (float2(( length( CenteredUV15_g241 ) * break37_g240.x * 2.0 ) , ( atan2( break17_g241.x , break17_g241.y ) * ( 1.0 / TWO_PI ) * break37_g240.y )));
				float cos44_g240 = cos( ( temp_output_33_0_g240 + temp_output_72_0_g240 ) );
				float sin44_g240 = sin( ( temp_output_33_0_g240 + temp_output_72_0_g240 ) );
				float2 rotator44_g240 = mul( appendResult23_g241 - float2( 0.5,0.5 ) , float2x2( cos44_g240 , -sin44_g240 , sin44_g240 , cos44_g240 )) + float2( 0.5,0.5 );
				float2 temp_cast_11 = (lerpResult29_g240).xx;
				#ifdef _2_USEPOLAR_ON
				float staticSwitch1449 = 1.0;
				#else
				float staticSwitch1449 = 0.0;
				#endif
				float clampResult49_g240 = clamp( staticSwitch1449 , 0.0 , 1.0 );
				float2 lerpResult38_g240 = lerp( ( ( rotator41_g240 - temp_cast_10 ) * appendResult60_g240 ) , ( rotator44_g240 - temp_cast_11 ) , clampResult49_g240);
				float2 appendResult61_g240 = (float2(break63_g240.z , break63_g240.w));
				float2 appendResult1454 = (float2(_2_PannerX , _2_PannerY));
				float2 break1466 = ( _TimeParameters.x * appendResult1454 );
				float2 appendResult17_g240 = (float2(break1466.x , break1466.y));
				float2 break20_g240 = ( ( ( lerpResult38_g240 + appendResult61_g240 ) + lerpResult29_g240 ) + appendResult17_g240 );
				#ifdef _2_CLAMPX_ON
				float staticSwitch1447 = 1.0;
				#else
				float staticSwitch1447 = 0.0;
				#endif
				float clampResult55_g240 = clamp( staticSwitch1447 , 0.0 , 1.0 );
				float lerpResult25_g240 = lerp( break20_g240.x , saturate( break20_g240.x ) , clampResult55_g240);
				#ifdef _2_CLAMPY_ON
				float staticSwitch1448 = 1.0;
				#else
				float staticSwitch1448 = 0.0;
				#endif
				float clampResult58_g240 = clamp( staticSwitch1448 , 0.0 , 1.0 );
				float lerpResult23_g240 = lerp( break20_g240.y , saturate( break20_g240.y ) , clampResult58_g240);
				float2 appendResult21_g240 = (float2(lerpResult25_g240 , lerpResult23_g240));
				float4 temp_output_19_0_g257 = tex2D( _MaskTex, appendResult21_g240 );
				float4 break5_g257 = temp_output_19_0_g257;
				float4 break18_g257 = _2_RGBA_Value;
				float temp_output_26_0_g257 = saturate( ( ( break5_g257.x * break18_g257.x ) + ( break5_g257.y * break18_g257.y ) + ( break5_g257.z * break18_g257.z ) ) );
				float3 temp_cast_13 = (temp_output_26_0_g257).xxx;
				float clampResult21_g257 = clamp( 0.0 , 0.0 , 1.0 );
				float3 lerpResult16_g257 = lerp( (temp_output_19_0_g257).xyz , temp_cast_13 , clampResult21_g257);
				float3 temp_output_5_0_g264 = ( ( lerpResult1071 * saturate( lerpResult16_g257 ) ) + float3( 0,0,0 ) );
				float3 lerpResult1_g264 = lerp( ( _SubColor.rgb * _SubColorHDR ) , ( _MainColor.rgb * clampResult1131 ) , temp_output_5_0_g264);
				float3 saferPower34_g264 = abs( temp_output_5_0_g264 );
				float3 temp_cast_15 = (_HighColorPower).xxx;
				float3 lerpResult35_g264 = lerp( lerpResult1_g264 , ( _HighColor.rgb * _HighColorHDR ) , saturate( abs( pow( saferPower34_g264 , temp_cast_15 ) ) ));
				float clampResult1625 = clamp( _HighColorHDR , 0.0 , 1.0 );
				float clampResult41_g264 = clamp( clampResult1625 , 0.0 , 1.0 );
				float3 lerpResult40_g264 = lerp( lerpResult1_g264 , lerpResult35_g264 , clampResult41_g264);
				float3 temp_output_1624_0 = abs( lerpResult40_g264 );
				float4 temp_output_721_0 = ( _LineMainColor1 * _LineMainHDR );
				float clampResult1584 = clamp( _LineSubHDR , 0.0 , 1.0 );
				float4 lerpResult1585 = lerp( temp_output_721_0 , ( _LineSubColor1 * _LineSubHDR ) , clampResult1584);
				float UV1_Z487 = break481.z;
				float clampResult1579 = clamp( ( _SmoothStepValue2 + UV1_Z487 ) , 0.001 , 1.0 );
				float temp_output_23_0_g263 = _3_Smooth_Step;
				float UV2_W991 = break984.w;
				float temp_output_1307_0 = ( _3_Distort_DissolveTex + UV2_W991 );
				float2 temp_output_68_0_g243 = ( ( ( temp_output_1307_0 * TextureDistort655 ) + IN.ase_texcoord5.xy ) + ( temp_output_1307_0 * -0.3 ) );
				float temp_output_33_0_g243 = ( ( _3_Rotion * PI ) / -180.0 );
				float temp_output_72_0_g243 = ( _3_RotionSpeed * _TimeParameters.x );
				float cos41_g243 = cos( ( temp_output_33_0_g243 + temp_output_72_0_g243 ) );
				float sin41_g243 = sin( ( temp_output_33_0_g243 + temp_output_72_0_g243 ) );
				float2 rotator41_g243 = mul( temp_output_68_0_g243 - float2( 0.5,0.5 ) , float2x2( cos41_g243 , -sin41_g243 , sin41_g243 , cos41_g243 )) + float2( 0.5,0.5 );
				#ifdef _3_CENTERPIVOT_ON
				float staticSwitch158 = 1.0;
				#else
				float staticSwitch158 = 0.0;
				#endif
				float clampResult46_g243 = clamp( staticSwitch158 , 0.0 , 1.0 );
				float lerpResult29_g243 = lerp( 0.0 , 0.5 , clampResult46_g243);
				float2 temp_cast_17 = (lerpResult29_g243).xx;
				float2 break163 = _DissolveTex_ST.xy;
				float2 break162 = _DissolveTex_ST.zw;
				float4 appendResult160 = (float4(break163.x , break163.y , break162.x , break162.y));
				float2 break1176 = ( _DissolveTex_ST.xy + TillingMain1152 );
				float2 break1175 = ( _DissolveTex_ST.zw + OffsetMain1166 );
				float4 appendResult1177 = (float4(break1176.x , break1176.y , break1175.x , break1175.y));
				#ifdef _3_FOLLOWOFFSETMAIN_ON
				float4 staticSwitch1180 = appendResult1177;
				#else
				float4 staticSwitch1180 = appendResult160;
				#endif
				float4 break63_g243 = staticSwitch1180;
				float2 appendResult60_g243 = (float2(break63_g243.x , break63_g243.y));
				float2 CenteredUV15_g244 = ( temp_output_68_0_g243 - float2( 0.5,0.5 ) );
				float2 break37_g243 = appendResult60_g243;
				float2 break17_g244 = CenteredUV15_g244;
				float2 appendResult23_g244 = (float2(( length( CenteredUV15_g244 ) * break37_g243.x * 2.0 ) , ( atan2( break17_g244.x , break17_g244.y ) * ( 1.0 / TWO_PI ) * break37_g243.y )));
				float cos44_g243 = cos( ( temp_output_33_0_g243 + temp_output_72_0_g243 ) );
				float sin44_g243 = sin( ( temp_output_33_0_g243 + temp_output_72_0_g243 ) );
				float2 rotator44_g243 = mul( appendResult23_g244 - float2( 0.5,0.5 ) , float2x2( cos44_g243 , -sin44_g243 , sin44_g243 , cos44_g243 )) + float2( 0.5,0.5 );
				float2 temp_cast_18 = (lerpResult29_g243).xx;
				#ifdef _3_USEPOLAR_ON
				float staticSwitch152 = 1.0;
				#else
				float staticSwitch152 = 0.0;
				#endif
				float clampResult49_g243 = clamp( staticSwitch152 , 0.0 , 1.0 );
				float2 lerpResult38_g243 = lerp( ( ( rotator41_g243 - temp_cast_17 ) * appendResult60_g243 ) , ( rotator44_g243 - temp_cast_18 ) , clampResult49_g243);
				float2 appendResult61_g243 = (float2(break63_g243.z , break63_g243.w));
				float2 appendResult1276 = (float2(_3_PannerX , _3_PannerY));
				float2 break1279 = ( _TimeParameters.x * appendResult1276 );
				float2 appendResult17_g243 = (float2(break1279.x , break1279.y));
				float2 break20_g243 = ( ( ( lerpResult38_g243 + appendResult61_g243 ) + lerpResult29_g243 ) + appendResult17_g243 );
				float clampResult55_g243 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult25_g243 = lerp( break20_g243.x , saturate( break20_g243.x ) , clampResult55_g243);
				float clampResult58_g243 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult23_g243 = lerp( break20_g243.y , saturate( break20_g243.y ) , clampResult58_g243);
				float2 appendResult21_g243 = (float2(lerpResult25_g243 , lerpResult23_g243));
				float4 temp_output_19_0_g263 = tex2D( _DissolveTex, appendResult21_g243 );
				float4 break5_g263 = temp_output_19_0_g263;
				float4 break18_g263 = _3_RGBA_Value;
				float temp_output_26_0_g263 = saturate( ( ( break5_g263.x * break18_g263.x ) + ( break5_g263.y * break18_g263.y ) + ( break5_g263.z * break18_g263.z ) ) );
				float lerpResult2_g263 = lerp( break5_g263.w , ( temp_output_26_0_g263 * break5_g263.w ) , break18_g263.w);
				float smoothstepResult13_g263 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g263 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g263);
				float lerpResult30_g263 = lerp( smoothstepResult13_g263 , lerpResult2_g263 , saturate( (0.0 + (temp_output_23_0_g263 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				#ifdef _ALPHAFORDISSOLVE_ON
				float staticSwitch709 = (0.0 + (( 1.0 - IN.ase_color.a ) - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				#else
				float staticSwitch709 = 0.0;
				#endif
				float UV1_X485 = break481.x;
				float clampResult1569 = clamp( ( _DissolveValue + staticSwitch709 + UV1_X485 ) , 0.0 , 2.0 );
				float temp_output_23_0_g262 = _4_Smooth_Step;
				float temp_output_1534_0 = ( _4_Distort_MaskDTex + UV2_W991 );
				float2 temp_output_68_0_g246 = ( ( ( temp_output_1534_0 * TextureDistort655 ) + IN.ase_texcoord5.xy ) + ( temp_output_1534_0 * -0.3 ) );
				float temp_output_33_0_g246 = ( ( _4_Rotion * PI ) / -180.0 );
				float temp_output_72_0_g246 = ( _4_RotionSpeed * _TimeParameters.x );
				float cos41_g246 = cos( ( temp_output_33_0_g246 + temp_output_72_0_g246 ) );
				float sin41_g246 = sin( ( temp_output_33_0_g246 + temp_output_72_0_g246 ) );
				float2 rotator41_g246 = mul( temp_output_68_0_g246 - float2( 0.5,0.5 ) , float2x2( cos41_g246 , -sin41_g246 , sin41_g246 , cos41_g246 )) + float2( 0.5,0.5 );
				#ifdef _4_CENTERPIVOT_ON
				float staticSwitch1511 = 1.0;
				#else
				float staticSwitch1511 = 0.0;
				#endif
				float clampResult46_g246 = clamp( staticSwitch1511 , 0.0 , 1.0 );
				float lerpResult29_g246 = lerp( 0.0 , 0.5 , clampResult46_g246);
				float2 temp_cast_20 = (lerpResult29_g246).xx;
				float2 break1527 = _DissolveMasksTex_ST.xy;
				float2 break1520 = _DissolveMasksTex_ST.zw;
				float4 appendResult1514 = (float4(break1527.x , break1527.y , break1520.x , break1520.y));
				float2 break1516 = ( _DissolveMasksTex_ST.xy + TillingMain1152 );
				float2 break1513 = ( _DissolveMasksTex_ST.zw + OffsetMain1166 );
				float4 appendResult1512 = (float4(break1516.x , break1516.y , break1513.x , break1513.y));
				#ifdef _4_FOLLOWOFFSETMAIN_ON
				float4 staticSwitch1515 = appendResult1512;
				#else
				float4 staticSwitch1515 = appendResult1514;
				#endif
				float4 break63_g246 = staticSwitch1515;
				float2 appendResult60_g246 = (float2(break63_g246.x , break63_g246.y));
				float2 CenteredUV15_g247 = ( temp_output_68_0_g246 - float2( 0.5,0.5 ) );
				float2 break37_g246 = appendResult60_g246;
				float2 break17_g247 = CenteredUV15_g247;
				float2 appendResult23_g247 = (float2(( length( CenteredUV15_g247 ) * break37_g246.x * 2.0 ) , ( atan2( break17_g247.x , break17_g247.y ) * ( 1.0 / TWO_PI ) * break37_g246.y )));
				float cos44_g246 = cos( ( temp_output_33_0_g246 + temp_output_72_0_g246 ) );
				float sin44_g246 = sin( ( temp_output_33_0_g246 + temp_output_72_0_g246 ) );
				float2 rotator44_g246 = mul( appendResult23_g247 - float2( 0.5,0.5 ) , float2x2( cos44_g246 , -sin44_g246 , sin44_g246 , cos44_g246 )) + float2( 0.5,0.5 );
				float2 temp_cast_21 = (lerpResult29_g246).xx;
				#ifdef _4_USEPOLAR_ON
				float staticSwitch1510 = 1.0;
				#else
				float staticSwitch1510 = 0.0;
				#endif
				float clampResult49_g246 = clamp( staticSwitch1510 , 0.0 , 1.0 );
				float2 lerpResult38_g246 = lerp( ( ( rotator41_g246 - temp_cast_20 ) * appendResult60_g246 ) , ( rotator44_g246 - temp_cast_21 ) , clampResult49_g246);
				float2 appendResult61_g246 = (float2(break63_g246.z , break63_g246.w));
				float2 appendResult1525 = (float2(_4_PannerX , _4_PannerY));
				float2 break1523 = ( _TimeParameters.x * appendResult1525 );
				float2 appendResult17_g246 = (float2(break1523.x , break1523.y));
				float2 break20_g246 = ( ( ( lerpResult38_g246 + appendResult61_g246 ) + lerpResult29_g246 ) + appendResult17_g246 );
				float clampResult55_g246 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult25_g246 = lerp( break20_g246.x , saturate( break20_g246.x ) , clampResult55_g246);
				float clampResult58_g246 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult23_g246 = lerp( break20_g246.y , saturate( break20_g246.y ) , clampResult58_g246);
				float2 appendResult21_g246 = (float2(lerpResult25_g246 , lerpResult23_g246));
				float4 temp_output_19_0_g262 = tex2D( _DissolveMasksTex, appendResult21_g246 );
				float4 break5_g262 = temp_output_19_0_g262;
				float4 break18_g262 = _4_RGBA_Value;
				float temp_output_26_0_g262 = saturate( ( ( break5_g262.x * break18_g262.x ) + ( break5_g262.y * break18_g262.y ) + ( break5_g262.z * break18_g262.z ) ) );
				float lerpResult2_g262 = lerp( break5_g262.w , ( temp_output_26_0_g262 * break5_g262.w ) , break18_g262.w);
				float smoothstepResult13_g262 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g262 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g262);
				float lerpResult30_g262 = lerp( smoothstepResult13_g262 , lerpResult2_g262 , saturate( (0.0 + (temp_output_23_0_g262 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				float clampResult33_g248 = clamp( _5_Tilling , 1.0 , 999.0 );
				float2 temp_cast_23 = (0.5).xx;
				float cos5_g248 = cos( ( ( _5_Rotion * PI ) / -180.0 ) );
				float sin5_g248 = sin( ( ( _5_Rotion * PI ) / -180.0 ) );
				float2 rotator5_g248 = mul( frac( ( IN.ase_texcoord5.xy * clampResult33_g248 ) ) - temp_cast_23 , float2x2( cos5_g248 , -sin5_g248 , sin5_g248 , cos5_g248 )) + temp_cast_23;
				float2 CenteredUV15_g249 = ( rotator5_g248 - float2( 0.5,0.5 ) );
				float2 break17_g249 = CenteredUV15_g249;
				float2 appendResult23_g249 = (float2(( length( CenteredUV15_g249 ) * 1.0 * 2.0 ) , ( atan2( break17_g249.x , break17_g249.y ) * ( 1.0 / TWO_PI ) * 1.0 )));
				#ifdef _5_USEPOLAR_ON
				float staticSwitch298 = 1.0;
				#else
				float staticSwitch298 = 0.0;
				#endif
				float clampResult23_g248 = clamp( staticSwitch298 , 0.0 , 1.0 );
				float2 lerpResult12_g248 = lerp( saturate( rotator5_g248 ) , ( 1.0 - saturate( appendResult23_g249 ) ) , clampResult23_g248);
				float temp_output_53_0_g248 = saturate( lerpResult12_g248.x );
				#ifdef _5_FLIP_ON
				float staticSwitch303 = 1.0;
				#else
				float staticSwitch303 = 0.0;
				#endif
				float clampResult21_g248 = clamp( staticSwitch303 , 0.0 , 1.0 );
				float lerpResult14_g248 = lerp( temp_output_53_0_g248 , ( 1.0 - temp_output_53_0_g248 ) , clampResult21_g248);
				float saferPower13_g248 = abs( lerpResult14_g248 );
				float lerpResult1562 = lerp( 0.0 , ( ( saturate( ( saturate( abs( pow( saferPower13_g248 , _5_PowerValue ) ) ) * _5_Opacity ) ) + 1.0 ) - clampResult1569 ) , _5_Opacity);
				float temp_output_1587_0 = saturate( ( ( ( saturate( lerpResult30_g263 ) + 1.0 ) - clampResult1569 ) + ( ( 1.0 + saturate( lerpResult30_g262 ) ) - clampResult1569 ) + lerpResult1562 ) );
				float smoothstepResult1388 = smoothstep( 0.0 , clampResult1579 , temp_output_1587_0);
				float clampResult1128 = clamp( _SmoothStepValue1 , 0.001 , 1.0 );
				float smoothstepResult1384 = smoothstep( 0.0 , clampResult1128 , saturate( ( temp_output_1587_0 - _LineThickness ) ));
				float4 lerpResult1404 = lerp( lerpResult1585 , temp_output_721_0 , ( smoothstepResult1388 - smoothstepResult1384 ));
				float4 lerpResult1391 = lerp( lerpResult1404 , float4( temp_output_1624_0 , 0.0 ) , saturate( smoothstepResult1384 ));
				half Line1390 = _LineThickness;
				float4 lerpResult1407 = lerp( float4( temp_output_1624_0 , 0.0 ) , lerpResult1391 , saturate( (0.0 + (Line1390 - 0.0) * (1.0 - 0.0) / (0.01 - 0.0)) ));
				
				float temp_output_23_0_g257 = _2_Smooth_Step;
				float lerpResult2_g257 = lerp( break5_g257.w , ( temp_output_26_0_g257 * break5_g257.w ) , break18_g257.w);
				float smoothstepResult13_g257 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g257 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g257);
				float lerpResult30_g257 = lerp( smoothstepResult13_g257 , lerpResult2_g257 , saturate( (0.0 + (temp_output_23_0_g257 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				float4 screenPos = IN.ase_texcoord6;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth1622 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth1622 = saturate( abs( ( screenDepth1622 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _DepthFadeValue ) ) );
				float temp_output_828_0 = ( saturate( ( ( temp_output_1607_0 * saturate( lerpResult30_g257 ) ) * smoothstepResult1388 ) ) * distanceDepth1622 );
				#ifdef _ALPHAFORDISSOLVE_ON
				float staticSwitch712 = temp_output_828_0;
				#else
				float staticSwitch712 = ( IN.ase_color.a * temp_output_828_0 );
				#endif
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = ( lerpResult1407 * IN.ase_color ).rgb;
				float Alpha = saturate( staticSwitch712 );
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;

				#ifdef _ALPHATEST_ON
					clip( Alpha - AlphaClipThreshold );
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#ifdef ASE_FOG
					Color = MixFog( Color, IN.fogFactor );
				#endif

				return half4( Color, Alpha );
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM

			#pragma multi_compile_instancing
			#define shader_feature_local _RECEIVE_SHADOWS_OFF
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_SRP_VERSION 101000
			#define REQUIRE_DEPTH_TEXTURE 1


			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define ASE_NEEDS_FRAG_COLOR
			#pragma shader_feature_local _ALPHAFORDISSOLVE_ON
			#pragma shader_feature_local _USE_CUSTOM2_ON
			#pragma shader_feature_local _6_USEPOLAR_ON
			#pragma shader_feature_local _1_CENTERPIVOT_ON
			#pragma shader_feature_local _1_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _TILLINGOFFSETXORY_X _TILLINGOFFSETXORY_Y
			#pragma shader_feature_local _1_USEPOLAR_ON
			#pragma shader_feature_local _1_CLAMPX_ON
			#pragma shader_feature_local _1_CLAMPY_ON
			#pragma shader_feature_local _2_CENTERPIVOT_ON
			#pragma shader_feature_local _2_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _2_USEPOLAR_ON
			#pragma shader_feature_local _2_CLAMPX_ON
			#pragma shader_feature_local _2_CLAMPY_ON
			#pragma shader_feature_local _USE_CUSTOM1_ON
			#pragma shader_feature_local _3_CENTERPIVOT_ON
			#pragma shader_feature_local _3_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _3_USEPOLAR_ON
			#pragma shader_feature_local _4_CENTERPIVOT_ON
			#pragma shader_feature_local _4_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _4_USEPOLAR_ON
			#pragma shader_feature_local _5_USEPOLAR_ON
			#pragma shader_feature_local _5_FLIP_ON


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _LineMainColor1;
			float4 _1_RGBA_Value;
			float4 _LineSubColor1;
			float4 _MaskTex_ST;
			float4 _MainTex_ST;
			float4 _DissolveMasksTex_ST;
			float4 _4_RGBA_Value;
			float4 _3_RGBA_Value;
			float4 _DistortTex_ST;
			float4 _HighColor;
			float4 _DissolveTex_ST;
			float4 _MainColor;
			float4 _SubColor;
			float4 _2_RGBA_Value;
			half _3_PannerX;
			half _3_PannerY;
			half _3_RotionSpeed;
			half _3_Rotion;
			half _3_Distort_DissolveTex;
			half _DissolveValue;
			half _4_Rotion;
			half _4_Distort_MaskDTex;
			half _4_RotionSpeed;
			half _4_PannerX;
			half _4_PannerY;
			half _5_Tilling;
			half _5_Rotion;
			half _5_PowerValue;
			float _5_Opacity;
			half _SmoothStepValue1;
			float _LineThickness;
			float _4_Smooth_Step;
			float _3_Smooth_Step;
			half _ZTestMode;
			half _LineSubHDR;
			half _CullMode;
			half _BlendMode;
			half _SubColorHDR;
			half _MainColorHDR;
			half _1_Distort_MainTex;
			half _6_Rotion;
			half _6_PannerX;
			half _6_PannerY;
			float _1_Rotion;
			half _1_RotionSpeed;
			half _SmoothStepValue2;
			half _1_PannerX;
			float _1_Smooth_Step;
			half _2_Distort_MaskTex;
			float _2_Rotion;
			half _2_RotionSpeed;
			half _2_PannerX;
			half _2_PannerY;
			half _HighColorHDR;
			half _HighColorPower;
			float _2_Smooth_Step;
			half _LineMainHDR;
			half _1_PannerY;
			float _DepthFadeValue;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			sampler2D _MainTex;
			sampler2D _DistortTex;
			sampler2D _MaskTex;
			sampler2D _DissolveTex;
			sampler2D _DissolveMasksTex;
			uniform float4 _CameraDepthTexture_TexelSize;


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float4 ase_clipPos = TransformObjectToHClip((v.vertex).xyz);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord5 = screenPos;
				
				o.ase_color = v.ase_color;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord3.xy = v.ase_texcoord.xy;
				o.ase_texcoord4 = v.ase_texcoord1;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = defaultVertexValue;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					o.worldPos = positionWS;
				#endif

				o.clipPos = TransformWorldToHClip( positionWS );
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = o.clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_color = v.ase_color;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN  ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float temp_output_23_0_g256 = _1_Smooth_Step;
				float4 temp_cast_0 = (0.0).xxxx;
				#ifdef _USE_CUSTOM2_ON
				float4 staticSwitch986 = IN.ase_texcoord2;
				#else
				float4 staticSwitch986 = temp_cast_0;
				#endif
				float4 break984 = staticSwitch986;
				float UV2_Z990 = break984.z;
				float temp_output_1134_0 = ( _1_Distort_MainTex + UV2_Z990 );
				float2 temp_output_68_0_g258 = IN.ase_texcoord3.xy;
				float temp_output_33_0_g258 = ( ( _6_Rotion * PI ) / -180.0 );
				float temp_output_72_0_g258 = 0.0;
				float cos41_g258 = cos( ( temp_output_33_0_g258 + temp_output_72_0_g258 ) );
				float sin41_g258 = sin( ( temp_output_33_0_g258 + temp_output_72_0_g258 ) );
				float2 rotator41_g258 = mul( temp_output_68_0_g258 - float2( 0.5,0.5 ) , float2x2( cos41_g258 , -sin41_g258 , sin41_g258 , cos41_g258 )) + float2( 0.5,0.5 );
				float clampResult46_g258 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult29_g258 = lerp( 0.0 , 0.5 , clampResult46_g258);
				float2 temp_cast_1 = (lerpResult29_g258).xx;
				float2 break648 = _DistortTex_ST.xy;
				float2 break650 = _DistortTex_ST.zw;
				float4 appendResult649 = (float4(break648.x , break648.y , break650.x , break650.y));
				float4 break63_g258 = appendResult649;
				float2 appendResult60_g258 = (float2(break63_g258.x , break63_g258.y));
				float2 CenteredUV15_g259 = ( temp_output_68_0_g258 - float2( 0.5,0.5 ) );
				float2 break37_g258 = appendResult60_g258;
				float2 break17_g259 = CenteredUV15_g259;
				float2 appendResult23_g259 = (float2(( length( CenteredUV15_g259 ) * break37_g258.x * 2.0 ) , ( atan2( break17_g259.x , break17_g259.y ) * ( 1.0 / TWO_PI ) * break37_g258.y )));
				float cos44_g258 = cos( ( temp_output_33_0_g258 + temp_output_72_0_g258 ) );
				float sin44_g258 = sin( ( temp_output_33_0_g258 + temp_output_72_0_g258 ) );
				float2 rotator44_g258 = mul( appendResult23_g259 - float2( 0.5,0.5 ) , float2x2( cos44_g258 , -sin44_g258 , sin44_g258 , cos44_g258 )) + float2( 0.5,0.5 );
				float2 temp_cast_2 = (lerpResult29_g258).xx;
				#ifdef _6_USEPOLAR_ON
				float staticSwitch647 = 1.0;
				#else
				float staticSwitch647 = 0.0;
				#endif
				float clampResult49_g258 = clamp( staticSwitch647 , 0.0 , 1.0 );
				float2 lerpResult38_g258 = lerp( ( ( rotator41_g258 - temp_cast_1 ) * appendResult60_g258 ) , ( rotator44_g258 - temp_cast_2 ) , clampResult49_g258);
				float2 appendResult61_g258 = (float2(break63_g258.z , break63_g258.w));
				float2 appendResult1291 = (float2(_6_PannerX , _6_PannerY));
				float2 break1289 = ( _TimeParameters.x * appendResult1291 );
				float2 appendResult17_g258 = (float2(break1289.x , break1289.y));
				float2 break20_g258 = ( ( ( lerpResult38_g258 + appendResult61_g258 ) + lerpResult29_g258 ) + appendResult17_g258 );
				float clampResult55_g258 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult25_g258 = lerp( break20_g258.x , saturate( break20_g258.x ) , clampResult55_g258);
				float clampResult58_g258 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult23_g258 = lerp( break20_g258.y , saturate( break20_g258.y ) , clampResult58_g258);
				float2 appendResult21_g258 = (float2(lerpResult25_g258 , lerpResult23_g258));
				float4 tex2DNode639 = tex2D( _DistortTex, appendResult21_g258 );
				float TextureDistort655 = ( tex2DNode639.r * tex2DNode639.a );
				float2 temp_output_68_0_g238 = ( ( ( temp_output_1134_0 * TextureDistort655 ) + IN.ase_texcoord3.xy ) + ( temp_output_1134_0 * -0.3 ) );
				float temp_output_33_0_g238 = ( ( _1_Rotion * PI ) / -180.0 );
				float temp_output_72_0_g238 = ( _1_RotionSpeed * _TimeParameters.x );
				float cos41_g238 = cos( ( temp_output_33_0_g238 + temp_output_72_0_g238 ) );
				float sin41_g238 = sin( ( temp_output_33_0_g238 + temp_output_72_0_g238 ) );
				float2 rotator41_g238 = mul( temp_output_68_0_g238 - float2( 0.5,0.5 ) , float2x2( cos41_g238 , -sin41_g238 , sin41_g238 , cos41_g238 )) + float2( 0.5,0.5 );
				#ifdef _1_CENTERPIVOT_ON
				float staticSwitch87 = 1.0;
				#else
				float staticSwitch87 = 0.0;
				#endif
				float clampResult46_g238 = clamp( staticSwitch87 , 0.0 , 1.0 );
				float lerpResult29_g238 = lerp( 0.0 , 0.5 , clampResult46_g238);
				float2 temp_cast_3 = (lerpResult29_g238).xx;
				float UV2_X988 = break984.x;
				float2 appendResult1149 = (float2(0.0 , UV2_X988));
				float2 appendResult1019 = (float2(UV2_X988 , 0.0));
				#if defined(_TILLINGOFFSETXORY_X)
				float2 staticSwitch1151 = appendResult1149;
				#elif defined(_TILLINGOFFSETXORY_Y)
				float2 staticSwitch1151 = appendResult1019;
				#else
				float2 staticSwitch1151 = appendResult1149;
				#endif
				float2 break1157 = staticSwitch1151;
				float2 appendResult1155 = (float2(break1157.y , break1157.x));
				float2 TillingMain1152 = appendResult1155;
				float UV2_Y989 = break984.y;
				float2 appendResult1015 = (float2(UV2_Y989 , 0.0));
				float2 appendResult1147 = (float2(0.0 , UV2_Y989));
				#if defined(_TILLINGOFFSETXORY_X)
				float2 staticSwitch1150 = appendResult1015;
				#elif defined(_TILLINGOFFSETXORY_Y)
				float2 staticSwitch1150 = appendResult1147;
				#else
				float2 staticSwitch1150 = appendResult1015;
				#endif
				float2 break1156 = staticSwitch1150;
				float2 appendResult1167 = (float2(break1156.x , break1156.y));
				float2 OffsetMain1166 = appendResult1167;
				float4 appendResult1486 = (float4(TillingMain1152 , OffsetMain1166));
				#ifdef _1_FOLLOWOFFSETMAIN_ON
				float4 staticSwitch1491 = appendResult1486;
				#else
				float4 staticSwitch1491 = float4( 0,0,0,0 );
				#endif
				float4 break1484 = staticSwitch1491;
				float2 appendResult1489 = (float2(break1484.x , break1484.y));
				float2 break1481 = ( _MainTex_ST.xy + appendResult1489 );
				float2 appendResult1490 = (float2(break1484.z , break1484.w));
				float2 break1482 = ( _MainTex_ST.zw + appendResult1490 );
				float4 appendResult1480 = (float4(break1481.x , break1481.y , break1482.x , break1482.y));
				float4 break63_g238 = appendResult1480;
				float2 appendResult60_g238 = (float2(break63_g238.x , break63_g238.y));
				float2 CenteredUV15_g239 = ( temp_output_68_0_g238 - float2( 0.5,0.5 ) );
				float2 break37_g238 = appendResult60_g238;
				float2 break17_g239 = CenteredUV15_g239;
				float2 appendResult23_g239 = (float2(( length( CenteredUV15_g239 ) * break37_g238.x * 2.0 ) , ( atan2( break17_g239.x , break17_g239.y ) * ( 1.0 / TWO_PI ) * break37_g238.y )));
				float cos44_g238 = cos( ( temp_output_33_0_g238 + temp_output_72_0_g238 ) );
				float sin44_g238 = sin( ( temp_output_33_0_g238 + temp_output_72_0_g238 ) );
				float2 rotator44_g238 = mul( appendResult23_g239 - float2( 0.5,0.5 ) , float2x2( cos44_g238 , -sin44_g238 , sin44_g238 , cos44_g238 )) + float2( 0.5,0.5 );
				float2 temp_cast_4 = (lerpResult29_g238).xx;
				#ifdef _1_USEPOLAR_ON
				float staticSwitch90 = 1.0;
				#else
				float staticSwitch90 = 0.0;
				#endif
				float clampResult49_g238 = clamp( staticSwitch90 , 0.0 , 1.0 );
				float2 lerpResult38_g238 = lerp( ( ( rotator41_g238 - temp_cast_3 ) * appendResult60_g238 ) , ( rotator44_g238 - temp_cast_4 ) , clampResult49_g238);
				float2 appendResult61_g238 = (float2(break63_g238.z , break63_g238.w));
				float2 appendResult1282 = (float2(_1_PannerX , _1_PannerY));
				float2 break1280 = ( _TimeParameters.x * appendResult1282 );
				float2 appendResult17_g238 = (float2(break1280.x , break1280.y));
				float2 break20_g238 = ( ( ( lerpResult38_g238 + appendResult61_g238 ) + lerpResult29_g238 ) + appendResult17_g238 );
				#ifdef _1_CLAMPX_ON
				float staticSwitch91 = 1.0;
				#else
				float staticSwitch91 = 0.0;
				#endif
				float clampResult55_g238 = clamp( staticSwitch91 , 0.0 , 1.0 );
				float lerpResult25_g238 = lerp( break20_g238.x , saturate( break20_g238.x ) , clampResult55_g238);
				#ifdef _1_CLAMPY_ON
				float staticSwitch92 = 1.0;
				#else
				float staticSwitch92 = 0.0;
				#endif
				float clampResult58_g238 = clamp( staticSwitch92 , 0.0 , 1.0 );
				float lerpResult23_g238 = lerp( break20_g238.y , saturate( break20_g238.y ) , clampResult58_g238);
				float2 appendResult21_g238 = (float2(lerpResult25_g238 , lerpResult23_g238));
				float4 temp_output_19_0_g256 = tex2D( _MainTex, appendResult21_g238 );
				float4 break5_g256 = temp_output_19_0_g256;
				float4 break18_g256 = _1_RGBA_Value;
				float temp_output_26_0_g256 = saturate( ( ( break5_g256.x * break18_g256.x ) + ( break5_g256.y * break18_g256.y ) + ( break5_g256.z * break18_g256.z ) ) );
				float lerpResult2_g256 = lerp( break5_g256.w , ( temp_output_26_0_g256 * break5_g256.w ) , break18_g256.w);
				float smoothstepResult13_g256 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g256 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g256);
				float lerpResult30_g256 = lerp( smoothstepResult13_g256 , lerpResult2_g256 , saturate( (0.0 + (temp_output_23_0_g256 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				float temp_output_1607_0 = saturate( lerpResult30_g256 );
				float temp_output_23_0_g257 = _2_Smooth_Step;
				float temp_output_1461_0 = ( _2_Distort_MaskTex + UV2_Z990 );
				float2 temp_output_68_0_g240 = ( ( ( temp_output_1461_0 * TextureDistort655 ) + IN.ase_texcoord3.xy ) + ( temp_output_1461_0 * -0.3 ) );
				float temp_output_33_0_g240 = ( ( _2_Rotion * PI ) / -180.0 );
				float temp_output_72_0_g240 = ( _2_RotionSpeed * _TimeParameters.x );
				float cos41_g240 = cos( ( temp_output_33_0_g240 + temp_output_72_0_g240 ) );
				float sin41_g240 = sin( ( temp_output_33_0_g240 + temp_output_72_0_g240 ) );
				float2 rotator41_g240 = mul( temp_output_68_0_g240 - float2( 0.5,0.5 ) , float2x2( cos41_g240 , -sin41_g240 , sin41_g240 , cos41_g240 )) + float2( 0.5,0.5 );
				#ifdef _2_CENTERPIVOT_ON
				float staticSwitch1450 = 1.0;
				#else
				float staticSwitch1450 = 0.0;
				#endif
				float clampResult46_g240 = clamp( staticSwitch1450 , 0.0 , 1.0 );
				float lerpResult29_g240 = lerp( 0.0 , 0.5 , clampResult46_g240);
				float2 temp_cast_6 = (lerpResult29_g240).xx;
				float4 appendResult1469 = (float4(TillingMain1152 , OffsetMain1166));
				#ifdef _2_FOLLOWOFFSETMAIN_ON
				float4 staticSwitch1467 = appendResult1469;
				#else
				float4 staticSwitch1467 = float4( 0,0,0,0 );
				#endif
				float4 break1470 = staticSwitch1467;
				float2 appendResult1471 = (float2(break1470.x , break1470.y));
				float2 break1436 = ( _MaskTex_ST.xy + appendResult1471 );
				float2 appendResult1472 = (float2(break1470.z , break1470.w));
				float2 break1437 = ( _MaskTex_ST.zw + appendResult1472 );
				float4 appendResult1435 = (float4(break1436.x , break1436.y , break1437.x , break1437.y));
				float4 break63_g240 = appendResult1435;
				float2 appendResult60_g240 = (float2(break63_g240.x , break63_g240.y));
				float2 CenteredUV15_g241 = ( temp_output_68_0_g240 - float2( 0.5,0.5 ) );
				float2 break37_g240 = appendResult60_g240;
				float2 break17_g241 = CenteredUV15_g241;
				float2 appendResult23_g241 = (float2(( length( CenteredUV15_g241 ) * break37_g240.x * 2.0 ) , ( atan2( break17_g241.x , break17_g241.y ) * ( 1.0 / TWO_PI ) * break37_g240.y )));
				float cos44_g240 = cos( ( temp_output_33_0_g240 + temp_output_72_0_g240 ) );
				float sin44_g240 = sin( ( temp_output_33_0_g240 + temp_output_72_0_g240 ) );
				float2 rotator44_g240 = mul( appendResult23_g241 - float2( 0.5,0.5 ) , float2x2( cos44_g240 , -sin44_g240 , sin44_g240 , cos44_g240 )) + float2( 0.5,0.5 );
				float2 temp_cast_7 = (lerpResult29_g240).xx;
				#ifdef _2_USEPOLAR_ON
				float staticSwitch1449 = 1.0;
				#else
				float staticSwitch1449 = 0.0;
				#endif
				float clampResult49_g240 = clamp( staticSwitch1449 , 0.0 , 1.0 );
				float2 lerpResult38_g240 = lerp( ( ( rotator41_g240 - temp_cast_6 ) * appendResult60_g240 ) , ( rotator44_g240 - temp_cast_7 ) , clampResult49_g240);
				float2 appendResult61_g240 = (float2(break63_g240.z , break63_g240.w));
				float2 appendResult1454 = (float2(_2_PannerX , _2_PannerY));
				float2 break1466 = ( _TimeParameters.x * appendResult1454 );
				float2 appendResult17_g240 = (float2(break1466.x , break1466.y));
				float2 break20_g240 = ( ( ( lerpResult38_g240 + appendResult61_g240 ) + lerpResult29_g240 ) + appendResult17_g240 );
				#ifdef _2_CLAMPX_ON
				float staticSwitch1447 = 1.0;
				#else
				float staticSwitch1447 = 0.0;
				#endif
				float clampResult55_g240 = clamp( staticSwitch1447 , 0.0 , 1.0 );
				float lerpResult25_g240 = lerp( break20_g240.x , saturate( break20_g240.x ) , clampResult55_g240);
				#ifdef _2_CLAMPY_ON
				float staticSwitch1448 = 1.0;
				#else
				float staticSwitch1448 = 0.0;
				#endif
				float clampResult58_g240 = clamp( staticSwitch1448 , 0.0 , 1.0 );
				float lerpResult23_g240 = lerp( break20_g240.y , saturate( break20_g240.y ) , clampResult58_g240);
				float2 appendResult21_g240 = (float2(lerpResult25_g240 , lerpResult23_g240));
				float4 temp_output_19_0_g257 = tex2D( _MaskTex, appendResult21_g240 );
				float4 break5_g257 = temp_output_19_0_g257;
				float4 break18_g257 = _2_RGBA_Value;
				float temp_output_26_0_g257 = saturate( ( ( break5_g257.x * break18_g257.x ) + ( break5_g257.y * break18_g257.y ) + ( break5_g257.z * break18_g257.z ) ) );
				float lerpResult2_g257 = lerp( break5_g257.w , ( temp_output_26_0_g257 * break5_g257.w ) , break18_g257.w);
				float smoothstepResult13_g257 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g257 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g257);
				float lerpResult30_g257 = lerp( smoothstepResult13_g257 , lerpResult2_g257 , saturate( (0.0 + (temp_output_23_0_g257 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				float4 temp_cast_9 = (0.0).xxxx;
				#ifdef _USE_CUSTOM1_ON
				float4 staticSwitch480 = IN.ase_texcoord4;
				#else
				float4 staticSwitch480 = temp_cast_9;
				#endif
				float4 break481 = staticSwitch480;
				float UV1_Z487 = break481.z;
				float clampResult1579 = clamp( ( _SmoothStepValue2 + UV1_Z487 ) , 0.001 , 1.0 );
				float temp_output_23_0_g263 = _3_Smooth_Step;
				float UV2_W991 = break984.w;
				float temp_output_1307_0 = ( _3_Distort_DissolveTex + UV2_W991 );
				float2 temp_output_68_0_g243 = ( ( ( temp_output_1307_0 * TextureDistort655 ) + IN.ase_texcoord3.xy ) + ( temp_output_1307_0 * -0.3 ) );
				float temp_output_33_0_g243 = ( ( _3_Rotion * PI ) / -180.0 );
				float temp_output_72_0_g243 = ( _3_RotionSpeed * _TimeParameters.x );
				float cos41_g243 = cos( ( temp_output_33_0_g243 + temp_output_72_0_g243 ) );
				float sin41_g243 = sin( ( temp_output_33_0_g243 + temp_output_72_0_g243 ) );
				float2 rotator41_g243 = mul( temp_output_68_0_g243 - float2( 0.5,0.5 ) , float2x2( cos41_g243 , -sin41_g243 , sin41_g243 , cos41_g243 )) + float2( 0.5,0.5 );
				#ifdef _3_CENTERPIVOT_ON
				float staticSwitch158 = 1.0;
				#else
				float staticSwitch158 = 0.0;
				#endif
				float clampResult46_g243 = clamp( staticSwitch158 , 0.0 , 1.0 );
				float lerpResult29_g243 = lerp( 0.0 , 0.5 , clampResult46_g243);
				float2 temp_cast_10 = (lerpResult29_g243).xx;
				float2 break163 = _DissolveTex_ST.xy;
				float2 break162 = _DissolveTex_ST.zw;
				float4 appendResult160 = (float4(break163.x , break163.y , break162.x , break162.y));
				float2 break1176 = ( _DissolveTex_ST.xy + TillingMain1152 );
				float2 break1175 = ( _DissolveTex_ST.zw + OffsetMain1166 );
				float4 appendResult1177 = (float4(break1176.x , break1176.y , break1175.x , break1175.y));
				#ifdef _3_FOLLOWOFFSETMAIN_ON
				float4 staticSwitch1180 = appendResult1177;
				#else
				float4 staticSwitch1180 = appendResult160;
				#endif
				float4 break63_g243 = staticSwitch1180;
				float2 appendResult60_g243 = (float2(break63_g243.x , break63_g243.y));
				float2 CenteredUV15_g244 = ( temp_output_68_0_g243 - float2( 0.5,0.5 ) );
				float2 break37_g243 = appendResult60_g243;
				float2 break17_g244 = CenteredUV15_g244;
				float2 appendResult23_g244 = (float2(( length( CenteredUV15_g244 ) * break37_g243.x * 2.0 ) , ( atan2( break17_g244.x , break17_g244.y ) * ( 1.0 / TWO_PI ) * break37_g243.y )));
				float cos44_g243 = cos( ( temp_output_33_0_g243 + temp_output_72_0_g243 ) );
				float sin44_g243 = sin( ( temp_output_33_0_g243 + temp_output_72_0_g243 ) );
				float2 rotator44_g243 = mul( appendResult23_g244 - float2( 0.5,0.5 ) , float2x2( cos44_g243 , -sin44_g243 , sin44_g243 , cos44_g243 )) + float2( 0.5,0.5 );
				float2 temp_cast_11 = (lerpResult29_g243).xx;
				#ifdef _3_USEPOLAR_ON
				float staticSwitch152 = 1.0;
				#else
				float staticSwitch152 = 0.0;
				#endif
				float clampResult49_g243 = clamp( staticSwitch152 , 0.0 , 1.0 );
				float2 lerpResult38_g243 = lerp( ( ( rotator41_g243 - temp_cast_10 ) * appendResult60_g243 ) , ( rotator44_g243 - temp_cast_11 ) , clampResult49_g243);
				float2 appendResult61_g243 = (float2(break63_g243.z , break63_g243.w));
				float2 appendResult1276 = (float2(_3_PannerX , _3_PannerY));
				float2 break1279 = ( _TimeParameters.x * appendResult1276 );
				float2 appendResult17_g243 = (float2(break1279.x , break1279.y));
				float2 break20_g243 = ( ( ( lerpResult38_g243 + appendResult61_g243 ) + lerpResult29_g243 ) + appendResult17_g243 );
				float clampResult55_g243 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult25_g243 = lerp( break20_g243.x , saturate( break20_g243.x ) , clampResult55_g243);
				float clampResult58_g243 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult23_g243 = lerp( break20_g243.y , saturate( break20_g243.y ) , clampResult58_g243);
				float2 appendResult21_g243 = (float2(lerpResult25_g243 , lerpResult23_g243));
				float4 temp_output_19_0_g263 = tex2D( _DissolveTex, appendResult21_g243 );
				float4 break5_g263 = temp_output_19_0_g263;
				float4 break18_g263 = _3_RGBA_Value;
				float temp_output_26_0_g263 = saturate( ( ( break5_g263.x * break18_g263.x ) + ( break5_g263.y * break18_g263.y ) + ( break5_g263.z * break18_g263.z ) ) );
				float lerpResult2_g263 = lerp( break5_g263.w , ( temp_output_26_0_g263 * break5_g263.w ) , break18_g263.w);
				float smoothstepResult13_g263 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g263 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g263);
				float lerpResult30_g263 = lerp( smoothstepResult13_g263 , lerpResult2_g263 , saturate( (0.0 + (temp_output_23_0_g263 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				#ifdef _ALPHAFORDISSOLVE_ON
				float staticSwitch709 = (0.0 + (( 1.0 - IN.ase_color.a ) - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				#else
				float staticSwitch709 = 0.0;
				#endif
				float UV1_X485 = break481.x;
				float clampResult1569 = clamp( ( _DissolveValue + staticSwitch709 + UV1_X485 ) , 0.0 , 2.0 );
				float temp_output_23_0_g262 = _4_Smooth_Step;
				float temp_output_1534_0 = ( _4_Distort_MaskDTex + UV2_W991 );
				float2 temp_output_68_0_g246 = ( ( ( temp_output_1534_0 * TextureDistort655 ) + IN.ase_texcoord3.xy ) + ( temp_output_1534_0 * -0.3 ) );
				float temp_output_33_0_g246 = ( ( _4_Rotion * PI ) / -180.0 );
				float temp_output_72_0_g246 = ( _4_RotionSpeed * _TimeParameters.x );
				float cos41_g246 = cos( ( temp_output_33_0_g246 + temp_output_72_0_g246 ) );
				float sin41_g246 = sin( ( temp_output_33_0_g246 + temp_output_72_0_g246 ) );
				float2 rotator41_g246 = mul( temp_output_68_0_g246 - float2( 0.5,0.5 ) , float2x2( cos41_g246 , -sin41_g246 , sin41_g246 , cos41_g246 )) + float2( 0.5,0.5 );
				#ifdef _4_CENTERPIVOT_ON
				float staticSwitch1511 = 1.0;
				#else
				float staticSwitch1511 = 0.0;
				#endif
				float clampResult46_g246 = clamp( staticSwitch1511 , 0.0 , 1.0 );
				float lerpResult29_g246 = lerp( 0.0 , 0.5 , clampResult46_g246);
				float2 temp_cast_13 = (lerpResult29_g246).xx;
				float2 break1527 = _DissolveMasksTex_ST.xy;
				float2 break1520 = _DissolveMasksTex_ST.zw;
				float4 appendResult1514 = (float4(break1527.x , break1527.y , break1520.x , break1520.y));
				float2 break1516 = ( _DissolveMasksTex_ST.xy + TillingMain1152 );
				float2 break1513 = ( _DissolveMasksTex_ST.zw + OffsetMain1166 );
				float4 appendResult1512 = (float4(break1516.x , break1516.y , break1513.x , break1513.y));
				#ifdef _4_FOLLOWOFFSETMAIN_ON
				float4 staticSwitch1515 = appendResult1512;
				#else
				float4 staticSwitch1515 = appendResult1514;
				#endif
				float4 break63_g246 = staticSwitch1515;
				float2 appendResult60_g246 = (float2(break63_g246.x , break63_g246.y));
				float2 CenteredUV15_g247 = ( temp_output_68_0_g246 - float2( 0.5,0.5 ) );
				float2 break37_g246 = appendResult60_g246;
				float2 break17_g247 = CenteredUV15_g247;
				float2 appendResult23_g247 = (float2(( length( CenteredUV15_g247 ) * break37_g246.x * 2.0 ) , ( atan2( break17_g247.x , break17_g247.y ) * ( 1.0 / TWO_PI ) * break37_g246.y )));
				float cos44_g246 = cos( ( temp_output_33_0_g246 + temp_output_72_0_g246 ) );
				float sin44_g246 = sin( ( temp_output_33_0_g246 + temp_output_72_0_g246 ) );
				float2 rotator44_g246 = mul( appendResult23_g247 - float2( 0.5,0.5 ) , float2x2( cos44_g246 , -sin44_g246 , sin44_g246 , cos44_g246 )) + float2( 0.5,0.5 );
				float2 temp_cast_14 = (lerpResult29_g246).xx;
				#ifdef _4_USEPOLAR_ON
				float staticSwitch1510 = 1.0;
				#else
				float staticSwitch1510 = 0.0;
				#endif
				float clampResult49_g246 = clamp( staticSwitch1510 , 0.0 , 1.0 );
				float2 lerpResult38_g246 = lerp( ( ( rotator41_g246 - temp_cast_13 ) * appendResult60_g246 ) , ( rotator44_g246 - temp_cast_14 ) , clampResult49_g246);
				float2 appendResult61_g246 = (float2(break63_g246.z , break63_g246.w));
				float2 appendResult1525 = (float2(_4_PannerX , _4_PannerY));
				float2 break1523 = ( _TimeParameters.x * appendResult1525 );
				float2 appendResult17_g246 = (float2(break1523.x , break1523.y));
				float2 break20_g246 = ( ( ( lerpResult38_g246 + appendResult61_g246 ) + lerpResult29_g246 ) + appendResult17_g246 );
				float clampResult55_g246 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult25_g246 = lerp( break20_g246.x , saturate( break20_g246.x ) , clampResult55_g246);
				float clampResult58_g246 = clamp( 0.0 , 0.0 , 1.0 );
				float lerpResult23_g246 = lerp( break20_g246.y , saturate( break20_g246.y ) , clampResult58_g246);
				float2 appendResult21_g246 = (float2(lerpResult25_g246 , lerpResult23_g246));
				float4 temp_output_19_0_g262 = tex2D( _DissolveMasksTex, appendResult21_g246 );
				float4 break5_g262 = temp_output_19_0_g262;
				float4 break18_g262 = _4_RGBA_Value;
				float temp_output_26_0_g262 = saturate( ( ( break5_g262.x * break18_g262.x ) + ( break5_g262.y * break18_g262.y ) + ( break5_g262.z * break18_g262.z ) ) );
				float lerpResult2_g262 = lerp( break5_g262.w , ( temp_output_26_0_g262 * break5_g262.w ) , break18_g262.w);
				float smoothstepResult13_g262 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g262 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g262);
				float lerpResult30_g262 = lerp( smoothstepResult13_g262 , lerpResult2_g262 , saturate( (0.0 + (temp_output_23_0_g262 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				float clampResult33_g248 = clamp( _5_Tilling , 1.0 , 999.0 );
				float2 temp_cast_16 = (0.5).xx;
				float cos5_g248 = cos( ( ( _5_Rotion * PI ) / -180.0 ) );
				float sin5_g248 = sin( ( ( _5_Rotion * PI ) / -180.0 ) );
				float2 rotator5_g248 = mul( frac( ( IN.ase_texcoord3.xy * clampResult33_g248 ) ) - temp_cast_16 , float2x2( cos5_g248 , -sin5_g248 , sin5_g248 , cos5_g248 )) + temp_cast_16;
				float2 CenteredUV15_g249 = ( rotator5_g248 - float2( 0.5,0.5 ) );
				float2 break17_g249 = CenteredUV15_g249;
				float2 appendResult23_g249 = (float2(( length( CenteredUV15_g249 ) * 1.0 * 2.0 ) , ( atan2( break17_g249.x , break17_g249.y ) * ( 1.0 / TWO_PI ) * 1.0 )));
				#ifdef _5_USEPOLAR_ON
				float staticSwitch298 = 1.0;
				#else
				float staticSwitch298 = 0.0;
				#endif
				float clampResult23_g248 = clamp( staticSwitch298 , 0.0 , 1.0 );
				float2 lerpResult12_g248 = lerp( saturate( rotator5_g248 ) , ( 1.0 - saturate( appendResult23_g249 ) ) , clampResult23_g248);
				float temp_output_53_0_g248 = saturate( lerpResult12_g248.x );
				#ifdef _5_FLIP_ON
				float staticSwitch303 = 1.0;
				#else
				float staticSwitch303 = 0.0;
				#endif
				float clampResult21_g248 = clamp( staticSwitch303 , 0.0 , 1.0 );
				float lerpResult14_g248 = lerp( temp_output_53_0_g248 , ( 1.0 - temp_output_53_0_g248 ) , clampResult21_g248);
				float saferPower13_g248 = abs( lerpResult14_g248 );
				float lerpResult1562 = lerp( 0.0 , ( ( saturate( ( saturate( abs( pow( saferPower13_g248 , _5_PowerValue ) ) ) * _5_Opacity ) ) + 1.0 ) - clampResult1569 ) , _5_Opacity);
				float temp_output_1587_0 = saturate( ( ( ( saturate( lerpResult30_g263 ) + 1.0 ) - clampResult1569 ) + ( ( 1.0 + saturate( lerpResult30_g262 ) ) - clampResult1569 ) + lerpResult1562 ) );
				float smoothstepResult1388 = smoothstep( 0.0 , clampResult1579 , temp_output_1587_0);
				float4 screenPos = IN.ase_texcoord5;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth1622 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm.xy ),_ZBufferParams);
				float distanceDepth1622 = saturate( abs( ( screenDepth1622 - LinearEyeDepth( ase_screenPosNorm.z,_ZBufferParams ) ) / ( _DepthFadeValue ) ) );
				float temp_output_828_0 = ( saturate( ( ( temp_output_1607_0 * saturate( lerpResult30_g257 ) ) * smoothstepResult1388 ) ) * distanceDepth1622 );
				#ifdef _ALPHAFORDISSOLVE_ON
				float staticSwitch712 = temp_output_828_0;
				#else
				float staticSwitch712 = ( IN.ase_color.a * temp_output_828_0 );
				#endif
				

				float Alpha = saturate( staticSwitch712 );
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}
			ENDHLSL
		}

	
	}
	
	CustomEditor "ASEMaterialInspector"
	Fallback Off
	
}
/*ASEBEGIN
Version=19201
Node;AmplifyShaderEditor.CommentaryNode;1415;-9209.613,-1241.09;Inherit;False;2373.625;1266.605;;21;648;649;650;652;653;642;644;645;646;647;639;853;640;1289;1290;1291;1292;641;643;1287;655;DistortTex;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1220;-8187.843,-4652.205;Inherit;False;1475.795;981.5369;;14;1156;1147;1013;1015;1166;1167;1157;1155;1019;1149;1014;1152;1151;1150;Custom Offset X or Y;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1219;-9092.897,-2942.774;Inherit;False;1438.79;1109.777;;16;985;986;984;989;990;991;725;480;481;485;486;487;724;479;987;988;Custom Data;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;423;7324.596,1003.933;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;788;7046.859,1670.881;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;838;8066.022,1784.949;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;175;2228.071,-2585.739;Inherit;False;Property;_MainColor;MainColor;6;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1027;2212.697,-2988.13;Half;False;Property;_HighColorHDR;HighColorHDR;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1029;2293.486,-2766.179;Half;False;Property;_HighColorPower;HighColorPower;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;683;2321.729,-2166.52;Inherit;False;Property;_SubColor;SubColor;8;0;Create;True;0;0;0;False;0;False;0,0,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;717;2351.561,-1993.53;Half;False;Property;_SubColorHDR;SubColorHDR;9;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1025;2269.398,-3221.012;Inherit;False;Property;_HighColor;HighColor;3;1;[Header];Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;985;-8869.248,-2302.456;Inherit;False;Constant;_Float24;Float 20;64;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;725;-8890.081,-2870.63;Inherit;False;Constant;_Float20;Float 20;64;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;479;-9042.897,-2734.016;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;1019;-7906.364,-4405.585;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1149;-7913.369,-4569.391;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1229;9498.361,1752.677;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1231;9498.361,1752.677;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1232;9498.361,1752.677;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1233;9498.361,1752.677;Float;False;False;-1;2;UnityEditor.ShaderGraphUnlitGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;987;-9022.063,-2165.843;Inherit;False;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;986;-8604.064,-2196.843;Inherit;False;Property;_Use_Custom2;Use_Custom2;66;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;480;-8624.898,-2765.016;Inherit;False;Property;_Use_Custom1;Use_Custom1;65;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1156;-7266.7,-3805.668;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;1167;-7075.459,-3844.484;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1157;-7400.416,-4530.134;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;984;-8302.064,-2195.843;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;481;-8316.897,-2763.016;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;989;-7912.106,-2148.995;Inherit;False;UV2_Y;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;990;-7923.106,-2061.996;Inherit;False;UV2_Z;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;991;-7918.106,-1948.996;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;988;-7878.107,-2232.995;Inherit;False;UV2_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1166;-6936.048,-3869.023;Inherit;False;OffsetMain;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;1407;6697.446,-1183.881;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1389;2306.733,3323.873;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1386;2917.644,3306.727;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1071;1627.364,-528.572;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;1151;-7699.885,-4602.205;Inherit;False;Property;_Keyword1;Keyword 0;67;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;1150;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1014;-8137.843,-4583.648;Inherit;False;988;UV2_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;721;5431.939,-10.69003;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1372;-1647.689,-1393.346;Inherit;True;Property;_TextureSample3;Texture Sample 3;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;140;-1889.821,-1982.644;Inherit;True;Property;_MainTex;MainTex;13;0;Create;True;1;Main____________________________________________________________________________________________;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;93;-3274.788,-1925.601;Inherit;False;Property;_1_Rotion;1_Rotion;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1281;-3252.071,-2100.259;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;658;-3711.292,-2869.483;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;587;-4210.522,-2813.207;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;88;-3608.394,-1426.856;Inherit;False;Constant;_Float4;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-3608.115,-1344.807;Inherit;False;Constant;_Float5;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;91;-3336.189,-1412.641;Inherit;False;Property;_1_ClampX;1_ClampX;19;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;92;-3323.189,-1266.641;Inherit;False;Property;_1_ClampY;1_ClampY;20;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;90;-3341.189,-1130.641;Inherit;False;Property;_1_UsePolar;1_UsePolar;21;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;87;-3356.089,-1546.741;Inherit;False;Property;_1_CenterPivot;1_CenterPivot;18;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1349;-3195.196,-1743.999;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1350;-3613.482,-1638.556;Half;False;Property;_1_RotionSpeed;1_RotionSpeed;17;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1348;-3624.196,-1783;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1282;-3484.993,-2060.638;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-3659.326,-1959.21;Half;False;Property;_1_PannerY;1_PannerY;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-3682.326,-2110.209;Half;False;Property;_1_PannerX;1_PannerX;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1286;-2864.279,-2072.313;Inherit;True;MF_UV_TX;-1;;238;8fdb8293e8d00da44843ff33d5199a52;0;10;68;FLOAT2;1,1;False;67;FLOAT4;1,1,0,0;False;52;FLOAT;0;False;53;FLOAT;0;False;48;FLOAT;0;False;72;FLOAT;0;False;45;FLOAT;0;False;56;FLOAT;0;False;57;FLOAT;0;False;50;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1097;-4026.334,-3029.549;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1096;-3436.187,-2997.884;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1134;-4476.639,-3207.349;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;660;-4819.873,-3220.219;Half;False;Property;_1_Distort_MainTex;1_Distort_MainTex;74;1;[Header];Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1213;-4796.038,-3094.451;Inherit;False;990;UV2_Z;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1094;-4225.052,-2949.356;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;657;-4539.273,-3012.367;Inherit;False;655;TextureDistort;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1280;-3061.371,-2069.959;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1442;-3100.915,144.2721;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1446;-3456.958,899.724;Inherit;False;Constant;_Float10;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1451;-3044.04,500.5321;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1453;-3473.04,461.5311;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1454;-3333.836,183.8932;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1457;-2713.123,172.2182;Inherit;True;MF_UV_TX;-1;;240;8fdb8293e8d00da44843ff33d5199a52;0;10;68;FLOAT2;1,1;False;67;FLOAT4;1,1,0,0;False;52;FLOAT;0;False;53;FLOAT;0;False;48;FLOAT;0;False;72;FLOAT;0;False;45;FLOAT;0;False;56;FLOAT;0;False;57;FLOAT;0;False;50;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1459;-3875.179,-785.0181;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1460;-3285.031,-753.3533;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1461;-4325.485,-962.8182;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1463;-4644.884,-849.9203;Inherit;False;990;UV2_Z;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1464;-4073.898,-704.8251;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1466;-2910.215,174.5722;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;1465;-4387.023,-767.8362;Inherit;False;655;TextureDistort;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1444;-4103.935,-571.2987;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1443;-3707.129,-600.7634;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1432;-1633.376,-415.8578;Inherit;True;Property;_TextureSample4;Texture Sample 3;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;1433;-1966.024,-626.4944;Inherit;True;Property;_MaskTex;MaskTex;25;0;Create;True;1;Main____________________________________________________________________________________________;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;135;378.2448,-707.5173;Inherit;False;Constant;_Float6;Float 6;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;381.9556,-626.1992;Inherit;False;Constant;_Float2;Float 2;11;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;133;529.7465,-684.3385;Inherit;False;Property;_1_RGB_or_Alpha;1_RGB_or_Alpha;10;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1456;-3531.17,134.3222;Half;False;Property;_2_PannerX;2_PannerX;26;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1455;-3508.17,285.3212;Half;False;Property;_2_PannerY;2_PannerY;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1434;-3123.632,318.9302;Inherit;False;Property;_2_Rotion;2_Rotion;28;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1452;-3462.326,605.9751;Half;False;Property;_2_RotionSpeed;2_RotionSpeed;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1445;-3457.238,817.675;Inherit;False;Constant;_Float9;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1450;-3204.933,697.79;Inherit;False;Property;_2_CenterPivot;2_CenterPivot;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1447;-3185.033,831.89;Inherit;False;Property;_2_ClampX;2_ClampX;31;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1448;-3172.033,977.89;Inherit;False;Property;_2_ClampY;2_ClampY;32;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1449;-3190.033,1113.89;Inherit;False;Property;_2_UsePolar;2_UsePolar;33;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;136;543.6154,-516.2017;Inherit;False;Property;_1_RGBA_Value;1_RGBA_Value;12;0;Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;1,0,0,0;1,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1475;1988.497,-308.968;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1477;1981.438,443.5569;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1480;-3179.848,-2348.205;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1481;-3474.7,-2453.655;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;1482;-3471.634,-2317.197;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;1483;-3693.708,-2457.217;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1484;-4270.056,-2426.457;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;1485;-5019.772,-2519.953;Inherit;False;1152;TillingMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1486;-4762.668,-2459.751;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;1487;-5017.46,-2408.527;Inherit;False;1166;OffsetMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1488;-3701.707,-2282.217;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1489;-3995.165,-2544.668;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1490;-4009.165,-2192.668;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1435;-3210.415,-148.0019;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1436;-3505.267,-253.452;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;1437;-3502.201,-116.9938;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;1440;-3724.275,-257.0139;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1470;-4300.623,-226.2531;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;1441;-5050.339,-319.75;Inherit;False;1152;TillingMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1469;-4793.235,-259.5478;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;1458;-5048.027,-208.3239;Inherit;False;1166;OffsetMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1439;-3732.274,-82.0138;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1471;-4025.732,-344.4649;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1472;-4039.732,7.535095;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1394;-8052.224,2186.507;Inherit;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;166;-8811.567,1917.531;Inherit;True;Property;_DissolveTex;DissolveTex;37;0;Create;True;1;Dissolve______________________________________________________________________________________________;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;155;-10020.79,2750.926;Inherit;False;Constant;_Float8;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;154;-10027.99,2657.525;Inherit;False;Constant;_Float7;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;152;-9744.202,2908.222;Inherit;False;Property;_3_UsePolar;3_UsePolar;43;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;158;-9758.102,2753.122;Inherit;False;Property;_3_CenterPivot;3_CenterPivot;42;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1177;-10132.14,2177.968;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1175;-10385.36,2270.891;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;160;-10121.47,1841.27;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;1180;-9920.316,1991.69;Inherit;False;Property;_3_FollowOffsetMain;3_FollowOffsetMain;45;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1176;-10371.62,2091.731;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;1178;-10543.71,2016.53;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1179;-10543.71,2159.53;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;162;-10354.69,1868.193;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;156;-9920.117,2339.933;Half;False;Property;_3_PannerX;3_PannerX;38;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;157;-9924.117,2419.933;Half;False;Property;_3_PannerY;3_PannerY;39;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1279;-9373.96,2334.161;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1277;-9526.961,2266.161;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1276;-9676.961,2312.161;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;1278;-9743.961,2187.161;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;163;-10371.95,1724.033;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;153;-9707.502,2451.162;Half;False;Property;_3_Rotion;3_Rotion;40;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1285;-9931.372,2557.975;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1284;-9484.372,2549.975;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1275;-9767.958,2581.018;Half;False;Property;_3_RotionSpeed;3_RotionSpeed;41;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1306;-10235.15,1222.935;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1324;-10549.37,1189.878;Inherit;False;655;TextureDistort;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1307;-10547.55,995.7657;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1310;-11061.95,1106.664;Inherit;False;991;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1425;-10068.49,1061.244;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1426;-9508.491,1342.244;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1304;-9818.392,1355.808;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1323;-10242.07,1428.974;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1288;-9172.567,2315.263;Inherit;True;MF_UV_TX;-1;;243;8fdb8293e8d00da44843ff33d5199a52;0;10;68;FLOAT2;1,1;False;67;FLOAT4;1,1,0,0;False;52;FLOAT;0;False;53;FLOAT;0;False;48;FLOAT;0;False;72;FLOAT;0;False;45;FLOAT;0;False;56;FLOAT;0;False;57;FLOAT;0;False;50;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1173;-10869.13,2071.628;Inherit;False;1152;TillingMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1174;-10866.28,2248.431;Inherit;False;1166;OffsetMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;673;-11171.88,969.1127;Half;False;Property;_3_Distort_DissolveTex;3_Distort_DissolveTex;76;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1479;516.5003,392.9673;Inherit;False;Property;_2_Smooth_Step;2_Smooth_Step;34;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1508;-10201.28,5308.152;Inherit;False;Constant;_Float14;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1509;-10208.48,5214.75;Inherit;False;Constant;_Float18;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1512;-10312.63,4735.193;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1513;-10565.85,4828.117;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;1514;-10301.96,4398.498;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1516;-10552.11,4648.957;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;1518;-10724.2,4573.756;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1519;-10724.2,4716.755;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1520;-10535.18,4425.42;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;1523;-9554.45,4891.387;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1524;-9707.451,4823.387;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1525;-9857.451,4869.388;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;1526;-9924.451,4744.386;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1527;-10552.44,4281.261;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1530;-9664.862,5107.201;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1532;-10415.64,3780.164;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1533;-10729.86,3747.108;Inherit;False;655;TextureDistort;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1534;-10728.04,3552.995;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1535;-11242.44,3663.893;Inherit;False;991;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1536;-10248.98,3618.473;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1537;-9688.981,3899.472;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1538;-9998.882,3913.036;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1539;-10422.56,3986.202;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1540;-9353.058,4872.49;Inherit;True;MF_UV_TX;-1;;246;8fdb8293e8d00da44843ff33d5199a52;0;10;68;FLOAT2;1,1;False;67;FLOAT4;1,1,0,0;False;52;FLOAT;0;False;53;FLOAT;0;False;48;FLOAT;0;False;72;FLOAT;0;False;45;FLOAT;0;False;56;FLOAT;0;False;57;FLOAT;0;False;50;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1541;-11049.62,4628.854;Inherit;False;1152;TillingMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1542;-11046.77,4805.657;Inherit;False;1166;OffsetMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1521;-10100.61,4897.159;Half;False;Property;_4_PannerX;4_PannerX;48;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1522;-10104.61,4977.159;Half;False;Property;_4_PannerY;4_PannerY;49;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1528;-9887.992,5008.388;Half;False;Property;_4_Rotion;4_Rotion;50;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1531;-9948.448,5138.244;Half;False;Property;_4_RotionSpeed;4_RotionSpeed;51;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1529;-10183.86,5105.201;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1506;-8440.943,4331.949;Inherit;True;Property;_TextureSample5;Texture Sample 2;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;1511;-9938.592,5310.348;Inherit;False;Property;_4_CenterPivot;4_CenterPivot;52;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1510;-9924.692,5465.448;Inherit;False;Property;_4_UsePolar;4_UsePolar;53;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1380;-4700.139,2640.206;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1401;-4638.274,5650.269;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;303;-6869.851,5827.715;Inherit;False;Property;_5_Flip;5_Flip;72;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;312;-5375.895,5794.915;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;302;-7154.857,5873.114;Inherit;False;Constant;_Float17;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;309;-5666.851,5770.14;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;297;-6790.539,5933.198;Half;False;Property;_5_Rotion;5_Rotion;70;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;520;-6764.177,6024.888;Half;False;Property;_5_Tilling;5_Tilling;71;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;301;-7156.857,5791.112;Inherit;False;Constant;_Float16;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1195;-6309.926,5803.748;Inherit;True;MF_Gradient_Alpha;-1;;248;2615dfd5ebdde4f42b1224bd2e1e9e42;0;7;54;FLOAT2;1,1;False;19;FLOAT;1;False;20;FLOAT;0;False;24;FLOAT;0;False;30;FLOAT;0;False;62;FLOAT2;0,0;False;22;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1379;-4914.982,5861.75;Inherit;False;Constant;_Float25;Float 21;63;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;310;-5963.29,5509.514;Inherit;False;Property;_5_Opacity;5_Opacity;68;1;[Header];Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;304;-6875.17,5712.065;Half;False;Property;_5_PowerValue;5_PowerValue;69;0;Create;True;1;Gradient Alpha____________________________________________________________________________________________;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1344;-6797.691,5479.704;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;300;-6919.323,6339.355;Inherit;False;Constant;_Float15;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;298;-6634.318,6293.957;Inherit;False;Property;_5_UsePolar;5_UsePolar;73;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;299;-6921.323,6269.354;Inherit;False;Constant;_Float12;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1424;-6649.254,6117.744;Inherit;False;1166;OffsetMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;707;-6223.082,4473.714;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;710;-6029.801,4347.814;Inherit;False;Constant;_Float3;Float 3;59;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;709;-5838.472,4481.979;Inherit;False;Property;_AlphaforDissolve;Alpha for Dissolve?;57;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;688;-5768.453,4710.175;Inherit;False;485;UV1_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;708;-6050.561,4466.757;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;687;-5437.626,4554.938;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;706;-6567.522,4320.75;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1559;-4926.236,3508.957;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1371;-5224.684,2976.427;Inherit;False;Constant;_Float22;Float 18;60;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1560;-3587.257,3737.466;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1399;-3580.477,4277.585;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;183;-1733.899,3012.091;Half;False;Property;_SmoothStepValue1;SmoothStepValue1;58;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1384;-1347.181,3409.207;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1569;-4969.008,4347.16;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1558;-3625.545,2993.671;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1412;-754.0117,3435.365;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1567;-1808.209,3439.084;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1575;-2102.851,3383.452;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1515;-10100.81,4548.917;Inherit;False;Property;_4_FollowOffsetMain;4_FollowOffsetMain;55;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1583;5417.917,-325.956;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;1584;5409.559,-212.0507;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1585;5633.579,-255.9958;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1404;5765.429,8.612378;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1580;5126.275,-411.1915;Inherit;False;Property;_LineSubColor1;LineSubColor1;63;0;Create;True;0;0;0;False;0;False;0,0,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;1397;2450.86,749.6577;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;180;-5843.527,4367.647;Half;False;Property;_DissolveValue;DissolveValue;56;0;Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1561;-2807.552,3576.764;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1376;-2455.098,3310.829;Inherit;False;Property;_LineThickness;Line Thickness;60;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1388;-1317.625,3718.957;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1129;-1815.016,4233.687;Inherit;False;487;UV1_Z;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1587;-2548.59,3605.643;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1128;-1511.329,3176.137;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.001;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1543;-11352.37,3525.342;Half;False;Property;_4_Distort_MaskDTex;4_Distort_MaskDTex;77;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1072;1342.56,-191.3168;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;720;5126.605,117.261;Half;False;Property;_LineMainHDR;LineMainHDR;62;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;422;6779.539,1147.233;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1230;9119.699,1527.597;Float;False;True;-1;2;ASEMaterialInspector;0;13;HA_Custom/Sd_All;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;1;Forward;8;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;2;True;_CullMode;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;5;True;12;all;0;True;True;2;5;False;;10;True;_BlendMode;2;5;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;True;True;2;False;;True;3;True;_ZTestMode;True;True;0;False;;0;False;;True;1;LightMode=UniversalForward;False;False;0;;0;0;Standard;22;Surface;1;638313483686247703;  Blend;0;0;Two Sided;0;638313483672647531;Cast Shadows;0;638313483655181423;  Use Shadow Threshold;0;0;Receive Shadows;0;638313483637566884;GPU Instancing;1;0;LOD CrossFade;0;0;Built-in Fog;0;0;DOTS Instancing;0;0;Meta Pass;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Vertex Position,InvertActionOnDeselection;1;0;0;5;False;True;False;True;False;False;;False;0
Node;AmplifyShaderEditor.RangedFloatNode;130;563.6705,-84.54344;Inherit;False;Property;_1_Smooth_Step;1_Smooth_Step;22;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1607;836.4301,-172.4892;Inherit;False;MF_RGB_Alpha;-1;;256;81c413b5668b2004e8bc7cdf85fe8515;0;4;22;FLOAT;0;False;17;FLOAT4;1,1,1,0;False;19;FLOAT4;0,0,0,0;False;23;FLOAT;1;False;2;FLOAT3;25;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1478;604.1426,127.6373;Inherit;False;Property;_2_RGBA_Value;2_RGBA_Value;24;0;Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;1,0,0,1;1,0,0,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1608;855.044,291.654;Inherit;False;MF_RGB_Alpha;-1;;257;81c413b5668b2004e8bc7cdf85fe8515;0;4;22;FLOAT;0;False;17;FLOAT4;1,1,1,0;False;19;FLOAT4;0,0,0,0;False;23;FLOAT;1;False;2;FLOAT3;25;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;648;-8872.182,-916.1116;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;649;-8680.898,-878.5744;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;650;-8886.114,-783.6525;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TextureTransformNode;652;-9159.613,-840.3428;Inherit;False;640;False;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.TexCoordVertexDataNode;653;-8724.444,-1191.09;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;642;-8691.627,-411.546;Half;False;Property;_6_Rotion;6_Rotion;81;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;644;-9014.419,-397.2804;Inherit;False;Constant;_Float11;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;645;-9012.419,-327.2803;Inherit;False;Constant;_Float13;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;646;-8743.228,-266.5839;Inherit;False;Property;_6_CenterPivot;6_CenterPivot;82;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;647;-8729.327,-111.4852;Inherit;False;Property;_6_UsePolar;6_UsePolar;83;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;639;-7642.363,-988.2825;Inherit;True;Property;_TextureSample0;Texture Sample 0;47;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;853;-7274.94,-779.4796;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;640;-7987.849,-1024.807;Inherit;True;Property;_DistortTex;DistortTex;78;0;Create;True;1;Dissolve______________________________________________________________________________________________;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.BreakToComponentsNode;1289;-8278.723,-526.2811;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1290;-8431.723,-594.2811;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1291;-8581.723,-548.281;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;1292;-8648.723,-673.2811;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;641;-8886.243,-543.7755;Half;False;Property;_6_PannerY;6_PannerY;80;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;643;-8881.243,-631.7755;Half;False;Property;_6_PannerX;6_PannerX;79;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;655;-7077.99,-741.6318;Inherit;False;TextureDistort;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1287;-8085.087,-570.3273;Inherit;True;MF_UV_TX;-1;;258;8fdb8293e8d00da44843ff33d5199a52;0;10;68;FLOAT2;1,1;False;67;FLOAT4;1,1,0,0;False;52;FLOAT;0;False;53;FLOAT;0;False;48;FLOAT;0;False;72;FLOAT;0;False;45;FLOAT;0;False;56;FLOAT;0;False;57;FLOAT;0;False;50;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;1562;-3289.54,4385.484;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1127;-1559.806,4036.441;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;834;-1923.492,4031.88;Half;False;Property;_SmoothStepValue2;SmoothStepValue2;59;0;Create;True;0;0;0;False;0;False;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1579;-1392.755,3967.068;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.001;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;176;5131.931,-137.2419;Inherit;False;Property;_LineMainColor1;LineMainColor1;61;0;Create;True;0;0;0;False;0;False;0,0,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1581;5160.238,-225.3518;Half;False;Property;_LineSubHDR;LineSubHDR;64;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1132;2341.693,-2277.931;Inherit;False;486;UV1_Y;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1391;6149.977,-930.0786;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1414;6247.466,-633.986;Inherit;False;1390;Line;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1462;-4668.719,-975.688;Half;False;Property;_2_Distort_MaskTex;2_Distort_MaskTex;75;0;Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1392;6684.103,-736.5789;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1408;6508.404,-750.4738;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.01;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-7947.877,-2673.773;Inherit;False;UV1_Z;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;724;-7949.964,-2573.88;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;485;-7964.877,-2890.773;Inherit;False;UV1_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-7952.877,-2783.772;Inherit;False;UV1_Y;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1155;-7221.312,-4539.341;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1152;-7066.91,-4562.999;Inherit;False;TillingMain;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1147;-7761.586,-3901.467;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1015;-7760.062,-4031.723;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;1150;-7542.348,-3916.701;Inherit;False;Property;_TillingOffsetXorY;Tilling Offset X or Y;67;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;X;Y;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1013;-7995.061,-3943.724;Inherit;False;989;UV2_Y;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;1507;-8812.494,4362.116;Inherit;True;Property;_DissolveMasksTex;DissolveMasksTex;47;0;Create;True;1;Dissolve______________________________________________________________________________________________;0;0;True;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.Vector4Node;1616;-7593.801,1931.678;Inherit;False;Property;_3_RGBA_Value;3_RGBA_Value;36;0;Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;1,0,0,1;1,0,0,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;1618;-7904.99,3527.186;Inherit;False;Property;_4_RGBA_Value;4_RGBA_Value;46;0;Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;1,0,0,1;1,0,0,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1615;-7572.305,2324.674;Inherit;False;Property;_3_Smooth_Step;3_Smooth_Step;44;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1620;-7797.649,4088.474;Inherit;False;Property;_4_Smooth_Step;4_Smooth_Step;54;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1623;6206.207,2142.245;Inherit;False;Property;_DepthFadeValue;DepthFadeValue;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;828;5938.891,1883.477;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;1622;6585.143,2114.266;Inherit;False;True;True;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1621;9862.172,1579.278;Half;False;Property;_ZTestMode;ZTestMode;1;1;[Enum];Create;True;0;2;LessOrEqual;4;Always;8;0;True;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1210;9641.549,1459.697;Half;False;Property;_CullMode;Cull Mode;2;1;[Enum];Create;True;0;3;Back;1;Front;2;Off;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1212;9596.932,1640.221;Half;False;Property;_BlendMode;Blend Mode;0;1;[Enum];Create;True;0;2;ADD;1;ADP;10;0;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureTransformNode;161;-10872.18,1864.501;Inherit;False;166;False;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.TextureTransformNode;1517;-11051.67,4421.729;Inherit;False;1507;False;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.StaticSwitch;1467;-4612.958,-234.1985;Inherit;False;Property;_2_FollowOffsetMain;2_FollowOffsetMain;35;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureTransformNode;1438;-4094.569,-183.7362;Inherit;False;1433;False;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.FunctionNode;1619;-7615.949,3717.869;Inherit;False;MF_RGB_Alpha;-1;;262;81c413b5668b2004e8bc7cdf85fe8515;0;4;22;FLOAT;1;False;17;FLOAT4;1,1,1,0;False;19;FLOAT4;0,0,0,0;False;23;FLOAT;1;False;2;FLOAT3;25;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1614;-7304.76,2122.361;Inherit;False;MF_RGB_Alpha;-1;;263;81c413b5668b2004e8bc7cdf85fe8515;0;4;22;FLOAT;1;False;17;FLOAT4;1,1,1,0;False;19;FLOAT4;0,0,0,0;False;23;FLOAT;1;False;2;FLOAT3;25;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;712;7414.799,1889.773;Inherit;False;Property;_1111;1111;57;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;709;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1390;-2087.816,3189.352;Half;False;Line;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1491;-4582.391,-2432.402;Inherit;False;Property;_1_FollowOffsetMain;1_FollowOffsetMain;23;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureTransformNode;1492;-4064.002,-2384.939;Inherit;False;140;False;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.ClampOpNode;1131;2747.094,-2248.131;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;999;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1624;3511.677,-2198.469;Inherit;False;MF_Fill_3_Color;-1;;264;93b9e1825a3927840a67e57099e75cc1;0;9;54;FLOAT;1;False;33;FLOAT3;1,1,1;False;51;FLOAT;1;False;39;FLOAT;1;False;20;FLOAT3;1,1,1;False;42;FLOAT;1;False;19;FLOAT3;1,1,1;False;44;FLOAT;1;False;22;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;1625;2523.481,-2947.547;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1626;2608.141,-2306.887;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;715;2348.69,-2389.381;Half;False;Property;_MainColorHDR;MainColorHDR;7;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
WireConnection;423;0;1407;0
WireConnection;423;1;422;0
WireConnection;788;0;422;4
WireConnection;788;1;828;0
WireConnection;838;0;712;0
WireConnection;1019;0;1014;0
WireConnection;1149;1;1014;0
WireConnection;986;1;985;0
WireConnection;986;0;987;0
WireConnection;480;1;725;0
WireConnection;480;0;479;0
WireConnection;1156;0;1150;0
WireConnection;1167;0;1156;0
WireConnection;1167;1;1156;1
WireConnection;1157;0;1151;0
WireConnection;984;0;986;0
WireConnection;481;0;480;0
WireConnection;989;0;984;1
WireConnection;990;0;984;2
WireConnection;991;0;984;3
WireConnection;988;0;984;0
WireConnection;1166;0;1167;0
WireConnection;1407;0;1624;0
WireConnection;1407;1;1391;0
WireConnection;1407;2;1392;0
WireConnection;1389;0;1477;0
WireConnection;1389;1;1388;0
WireConnection;1386;0;1389;0
WireConnection;1071;0;1607;25
WireConnection;1071;1;1072;0
WireConnection;1071;2;133;0
WireConnection;1151;1;1149;0
WireConnection;1151;0;1019;0
WireConnection;721;0;176;0
WireConnection;721;1;720;0
WireConnection;1372;0;140;0
WireConnection;1372;1;1286;0
WireConnection;1281;0;1348;0
WireConnection;1281;1;1282;0
WireConnection;658;0;1094;0
WireConnection;658;1;587;0
WireConnection;91;1;88;0
WireConnection;91;0;89;0
WireConnection;92;1;88;0
WireConnection;92;0;89;0
WireConnection;90;1;88;0
WireConnection;90;0;89;0
WireConnection;87;1;88;0
WireConnection;87;0;89;0
WireConnection;1349;0;1350;0
WireConnection;1349;1;1348;0
WireConnection;1282;0;94;0
WireConnection;1282;1;95;0
WireConnection;1286;68;1096;0
WireConnection;1286;67;1480;0
WireConnection;1286;52;1280;0
WireConnection;1286;53;1280;1
WireConnection;1286;48;93;0
WireConnection;1286;72;1349;0
WireConnection;1286;45;87;0
WireConnection;1286;56;91;0
WireConnection;1286;57;92;0
WireConnection;1286;50;90;0
WireConnection;1097;0;1134;0
WireConnection;1096;0;658;0
WireConnection;1096;1;1097;0
WireConnection;1134;0;660;0
WireConnection;1134;1;1213;0
WireConnection;1094;0;1134;0
WireConnection;1094;1;657;0
WireConnection;1280;0;1281;0
WireConnection;1442;0;1453;0
WireConnection;1442;1;1454;0
WireConnection;1451;0;1452;0
WireConnection;1451;1;1453;0
WireConnection;1454;0;1456;0
WireConnection;1454;1;1455;0
WireConnection;1457;68;1460;0
WireConnection;1457;67;1435;0
WireConnection;1457;52;1466;0
WireConnection;1457;53;1466;1
WireConnection;1457;48;1434;0
WireConnection;1457;72;1451;0
WireConnection;1457;45;1450;0
WireConnection;1457;56;1447;0
WireConnection;1457;57;1448;0
WireConnection;1457;50;1449;0
WireConnection;1459;0;1461;0
WireConnection;1460;0;1443;0
WireConnection;1460;1;1459;0
WireConnection;1461;0;1462;0
WireConnection;1461;1;1463;0
WireConnection;1464;0;1461;0
WireConnection;1464;1;1465;0
WireConnection;1466;0;1442;0
WireConnection;1443;0;1464;0
WireConnection;1443;1;1444;0
WireConnection;1432;0;1433;0
WireConnection;1432;1;1457;0
WireConnection;133;1;135;0
WireConnection;133;0;134;0
WireConnection;1450;1;1445;0
WireConnection;1450;0;1446;0
WireConnection;1447;1;1445;0
WireConnection;1447;0;1446;0
WireConnection;1448;1;1445;0
WireConnection;1448;0;1446;0
WireConnection;1449;1;1445;0
WireConnection;1449;0;1446;0
WireConnection;1475;0;1071;0
WireConnection;1475;1;1608;25
WireConnection;1477;0;1607;0
WireConnection;1477;1;1608;0
WireConnection;1480;0;1481;0
WireConnection;1480;1;1481;1
WireConnection;1480;2;1482;0
WireConnection;1480;3;1482;1
WireConnection;1481;0;1483;0
WireConnection;1482;0;1488;0
WireConnection;1483;0;1492;0
WireConnection;1483;1;1489;0
WireConnection;1484;0;1491;0
WireConnection;1486;0;1485;0
WireConnection;1486;2;1487;0
WireConnection;1488;0;1492;1
WireConnection;1488;1;1490;0
WireConnection;1489;0;1484;0
WireConnection;1489;1;1484;1
WireConnection;1490;0;1484;2
WireConnection;1490;1;1484;3
WireConnection;1435;0;1436;0
WireConnection;1435;1;1436;1
WireConnection;1435;2;1437;0
WireConnection;1435;3;1437;1
WireConnection;1436;0;1440;0
WireConnection;1437;0;1439;0
WireConnection;1440;0;1438;0
WireConnection;1440;1;1471;0
WireConnection;1470;0;1467;0
WireConnection;1469;0;1441;0
WireConnection;1469;2;1458;0
WireConnection;1439;0;1438;1
WireConnection;1439;1;1472;0
WireConnection;1471;0;1470;0
WireConnection;1471;1;1470;1
WireConnection;1472;0;1470;2
WireConnection;1472;1;1470;3
WireConnection;1394;0;166;0
WireConnection;1394;1;1288;0
WireConnection;152;1;154;0
WireConnection;152;0;155;0
WireConnection;158;1;154;0
WireConnection;158;0;155;0
WireConnection;1177;0;1176;0
WireConnection;1177;1;1176;1
WireConnection;1177;2;1175;0
WireConnection;1177;3;1175;1
WireConnection;1175;0;1179;0
WireConnection;160;0;163;0
WireConnection;160;1;163;1
WireConnection;160;2;162;0
WireConnection;160;3;162;1
WireConnection;1180;1;160;0
WireConnection;1180;0;1177;0
WireConnection;1176;0;1178;0
WireConnection;1178;0;161;0
WireConnection;1178;1;1173;0
WireConnection;1179;0;161;1
WireConnection;1179;1;1174;0
WireConnection;162;0;161;1
WireConnection;1279;0;1277;0
WireConnection;1277;0;1278;0
WireConnection;1277;1;1276;0
WireConnection;1276;0;156;0
WireConnection;1276;1;157;0
WireConnection;163;0;161;0
WireConnection;1284;0;1275;0
WireConnection;1284;1;1285;0
WireConnection;1306;0;1307;0
WireConnection;1306;1;1324;0
WireConnection;1307;0;673;0
WireConnection;1307;1;1310;0
WireConnection;1425;0;1307;0
WireConnection;1426;0;1304;0
WireConnection;1426;1;1425;0
WireConnection;1304;0;1306;0
WireConnection;1304;1;1323;0
WireConnection;1288;68;1426;0
WireConnection;1288;67;1180;0
WireConnection;1288;52;1279;0
WireConnection;1288;53;1279;1
WireConnection;1288;48;153;0
WireConnection;1288;72;1284;0
WireConnection;1288;45;158;0
WireConnection;1288;50;152;0
WireConnection;1512;0;1516;0
WireConnection;1512;1;1516;1
WireConnection;1512;2;1513;0
WireConnection;1512;3;1513;1
WireConnection;1513;0;1519;0
WireConnection;1514;0;1527;0
WireConnection;1514;1;1527;1
WireConnection;1514;2;1520;0
WireConnection;1514;3;1520;1
WireConnection;1516;0;1518;0
WireConnection;1518;0;1517;0
WireConnection;1518;1;1541;0
WireConnection;1519;0;1517;1
WireConnection;1519;1;1542;0
WireConnection;1520;0;1517;1
WireConnection;1523;0;1524;0
WireConnection;1524;0;1526;0
WireConnection;1524;1;1525;0
WireConnection;1525;0;1521;0
WireConnection;1525;1;1522;0
WireConnection;1527;0;1517;0
WireConnection;1530;0;1531;0
WireConnection;1530;1;1529;0
WireConnection;1532;0;1534;0
WireConnection;1532;1;1533;0
WireConnection;1534;0;1543;0
WireConnection;1534;1;1535;0
WireConnection;1536;0;1534;0
WireConnection;1537;0;1538;0
WireConnection;1537;1;1536;0
WireConnection;1538;0;1532;0
WireConnection;1538;1;1539;0
WireConnection;1540;68;1537;0
WireConnection;1540;67;1515;0
WireConnection;1540;52;1523;0
WireConnection;1540;53;1523;1
WireConnection;1540;48;1528;0
WireConnection;1540;72;1530;0
WireConnection;1540;45;1511;0
WireConnection;1540;50;1510;0
WireConnection;1506;0;1507;0
WireConnection;1506;1;1540;0
WireConnection;1511;1;1509;0
WireConnection;1511;0;1508;0
WireConnection;1510;1;1509;0
WireConnection;1510;0;1508;0
WireConnection;1380;0;1614;0
WireConnection;1380;1;1371;0
WireConnection;1401;0;312;0
WireConnection;1401;1;1379;0
WireConnection;303;1;301;0
WireConnection;303;0;302;0
WireConnection;312;0;309;0
WireConnection;309;0;1195;0
WireConnection;309;1;310;0
WireConnection;1195;54;1344;0
WireConnection;1195;19;304;0
WireConnection;1195;20;303;0
WireConnection;1195;24;297;0
WireConnection;1195;30;520;0
WireConnection;1195;22;298;0
WireConnection;298;1;299;0
WireConnection;298;0;300;0
WireConnection;707;0;706;4
WireConnection;709;1;710;0
WireConnection;709;0;708;0
WireConnection;708;0;707;0
WireConnection;687;0;180;0
WireConnection;687;1;709;0
WireConnection;687;2;688;0
WireConnection;1559;0;1371;0
WireConnection;1559;1;1619;0
WireConnection;1560;0;1559;0
WireConnection;1560;1;1569;0
WireConnection;1399;0;1401;0
WireConnection;1399;1;1569;0
WireConnection;1384;0;1567;0
WireConnection;1384;2;1128;0
WireConnection;1569;0;687;0
WireConnection;1558;0;1380;0
WireConnection;1558;1;1569;0
WireConnection;1412;0;1388;0
WireConnection;1412;1;1384;0
WireConnection;1567;0;1575;0
WireConnection;1575;0;1587;0
WireConnection;1575;1;1376;0
WireConnection;1515;1;1514;0
WireConnection;1515;0;1512;0
WireConnection;1583;0;1580;0
WireConnection;1583;1;1581;0
WireConnection;1584;0;1581;0
WireConnection;1585;0;721;0
WireConnection;1585;1;1583;0
WireConnection;1585;2;1584;0
WireConnection;1404;0;1585;0
WireConnection;1404;1;721;0
WireConnection;1404;2;1412;0
WireConnection;1397;0;1384;0
WireConnection;1561;0;1558;0
WireConnection;1561;1;1560;0
WireConnection;1561;2;1562;0
WireConnection;1388;0;1587;0
WireConnection;1388;2;1579;0
WireConnection;1587;0;1561;0
WireConnection;1128;0;183;0
WireConnection;1072;0;1607;25
WireConnection;1072;1;1607;0
WireConnection;1230;2;423;0
WireConnection;1230;3;838;0
WireConnection;1607;22;133;0
WireConnection;1607;17;136;0
WireConnection;1607;19;1372;0
WireConnection;1607;23;130;0
WireConnection;1608;17;1478;0
WireConnection;1608;19;1432;0
WireConnection;1608;23;1479;0
WireConnection;648;0;652;0
WireConnection;649;0;648;0
WireConnection;649;1;648;1
WireConnection;649;2;650;0
WireConnection;649;3;650;1
WireConnection;650;0;652;1
WireConnection;646;1;644;0
WireConnection;646;0;645;0
WireConnection;647;1;644;0
WireConnection;647;0;645;0
WireConnection;639;0;640;0
WireConnection;639;1;1287;0
WireConnection;853;0;639;1
WireConnection;853;1;639;4
WireConnection;1289;0;1290;0
WireConnection;1290;0;1292;0
WireConnection;1290;1;1291;0
WireConnection;1291;0;643;0
WireConnection;1291;1;641;0
WireConnection;655;0;853;0
WireConnection;1287;68;653;0
WireConnection;1287;67;649;0
WireConnection;1287;52;1289;0
WireConnection;1287;53;1289;1
WireConnection;1287;48;642;0
WireConnection;1287;50;647;0
WireConnection;1562;1;1399;0
WireConnection;1562;2;310;0
WireConnection;1127;0;834;0
WireConnection;1127;1;1129;0
WireConnection;1579;0;1127;0
WireConnection;1391;0;1404;0
WireConnection;1391;1;1624;0
WireConnection;1391;2;1397;0
WireConnection;1392;0;1408;0
WireConnection;1408;0;1414;0
WireConnection;487;0;481;2
WireConnection;724;0;481;3
WireConnection;485;0;481;0
WireConnection;486;0;481;1
WireConnection;1155;0;1157;1
WireConnection;1155;1;1157;0
WireConnection;1152;0;1155;0
WireConnection;1147;1;1013;0
WireConnection;1015;0;1013;0
WireConnection;1150;1;1015;0
WireConnection;1150;0;1147;0
WireConnection;828;0;1386;0
WireConnection;828;1;1622;0
WireConnection;1622;0;1623;0
WireConnection;1467;0;1469;0
WireConnection;1619;17;1618;0
WireConnection;1619;19;1506;0
WireConnection;1619;23;1620;0
WireConnection;1614;17;1616;0
WireConnection;1614;19;1394;0
WireConnection;1614;23;1615;0
WireConnection;712;1;788;0
WireConnection;712;0;828;0
WireConnection;1390;0;1376;0
WireConnection;1491;0;1486;0
WireConnection;1131;0;1626;0
WireConnection;1624;54;1625;0
WireConnection;1624;33;1025;0
WireConnection;1624;51;1027;0
WireConnection;1624;39;1029;0
WireConnection;1624;20;175;0
WireConnection;1624;42;1131;0
WireConnection;1624;19;683;0
WireConnection;1624;44;717;0
WireConnection;1624;22;1475;0
WireConnection;1625;0;1027;0
WireConnection;1626;0;715;0
WireConnection;1626;1;1132;0
ASEEND*/
//CHKSM=9AFD906DF2D02ED9DDD762702E4DD3B02592EE90