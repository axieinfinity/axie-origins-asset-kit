// Made with Amplify Shader Editor v1.9.2.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HA_Custom/Sd_All_Mini_Dissolve"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[Enum(ADD,1,ADP,10)]_BlendMode("Blend Mode", Float) = 10
		[Enum(Back,1,Front,2,Off,0)]_CullMode("Cull Mode", Float) = 0
		[Header(_________________________________________________________________________________________)]_HighColor("HighColor", Color) = (1,1,1,1)
		_HighColorHDR("HighColorHDR", Float) = 0
		_HighColorPower("HighColorPower", Float) = 0
		_MainColor("MainColor", Color) = (1,1,1,1)
		_MainColorHDR("MainColorHDR", Float) = 0
		_SubColor("SubColor", Color) = (0,0,0,1)
		_SubColorHDR("SubColorHDR", Float) = 1
		[Toggle(_1_RGB_OR_ALPHA_ON)] _1_RGB_or_Alpha("1_RGB_or_Alpha", Float) = 0
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
		#pragma target 3.5
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
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM

			#define shader_feature_local _RECEIVE_SHADOWS_OFF
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_SRP_VERSION 101000


			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_FRAG_COLOR
			#pragma multi_compile_instancing
			#pragma shader_feature_local _USE_CUSTOM1_ON
			#pragma shader_feature_local _1_CENTERPIVOT_ON
			#pragma shader_feature_local _1_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _TILLINGOFFSETXORY_X _TILLINGOFFSETXORY_Y
			#pragma shader_feature_local _USE_CUSTOM2_ON
			#pragma shader_feature_local _1_USEPOLAR_ON
			#pragma shader_feature_local _1_CLAMPX_ON
			#pragma shader_feature_local _1_CLAMPY_ON
			#pragma shader_feature_local _1_RGB_OR_ALPHA_ON
			#pragma shader_feature_local _3_CENTERPIVOT_ON
			#pragma shader_feature_local _3_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _3_USEPOLAR_ON
			#pragma shader_feature_local _ALPHAFORDISSOLVE_ON
			#pragma shader_feature_local _5_USEPOLAR_ON
			#pragma shader_feature_local _5_FLIP_ON


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				half4 ase_color : COLOR;
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
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _SubColor;
			half4 _3_RGBA_Value;
			half4 _DissolveTex_ST;
			half4 _LineMainColor1;
			half4 _HighColor;
			half4 _1_RGBA_Value;
			half4 _LineSubColor1;
			half4 _MainColor;
			half4 _MainTex_ST;
			half _1_PannerX;
			half _5_PowerValue;
			half _5_Rotion;
			half _5_Tilling;
			half _LineThickness;
			half _DissolveValue;
			half _SubColorHDR;
			half _3_PannerY;
			half _3_PannerX;
			half _3_RotionSpeed;
			half _3_Rotion;
			half _3_Smooth_Step;
			half _LineSubHDR;
			half _5_Opacity;
			half _LineMainHDR;
			half _MainColorHDR;
			half _HighColorPower;
			half _HighColorHDR;
			half _1_Rotion;
			half _1_Smooth_Step;
			half _1_RotionSpeed;
			half _1_PannerY;
			half _SmoothStepValue2;
			half _SmoothStepValue1;
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
			sampler2D _DissolveTex;
			UNITY_INSTANCING_BUFFER_START(HA_CustomSd_All_Mini_Dissolve)
				UNITY_DEFINE_INSTANCED_PROP(half, _CullMode)
				UNITY_DEFINE_INSTANCED_PROP(half, _BlendMode)
			UNITY_INSTANCING_BUFFER_END(HA_CustomSd_All_Mini_Dissolve)


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.ase_texcoord3 = v.ase_texcoord1;
				o.ase_texcoord4.xy = v.ase_texcoord.xy;
				o.ase_texcoord5 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord4.zw = 0;

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
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
				half4 ase_color : COLOR;

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
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord2;
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
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
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

				half _CullMode_Instance = UNITY_ACCESS_INSTANCED_PROP(HA_CustomSd_All_Mini_Dissolve,_CullMode);
				half _BlendMode_Instance = UNITY_ACCESS_INSTANCED_PROP(HA_CustomSd_All_Mini_Dissolve,_BlendMode);
				half4 temp_cast_2 = (0.0).xxxx;
				#ifdef _USE_CUSTOM1_ON
				half4 staticSwitch480 = IN.ase_texcoord3;
				#else
				half4 staticSwitch480 = temp_cast_2;
				#endif
				half4 break481 = staticSwitch480;
				half UV1_Y486 = break481.y;
				half clampResult1131 = clamp( ( _MainColorHDR + UV1_Y486 ) , 1.0 , 999.0 );
				half2 temp_output_68_0_g228 = IN.ase_texcoord4.xy;
				half temp_output_33_0_g228 = ( ( _1_Rotion * PI ) / -180.0 );
				half temp_output_72_0_g228 = ( _1_RotionSpeed * _TimeParameters.x );
				float cos41_g228 = cos( ( temp_output_33_0_g228 + temp_output_72_0_g228 ) );
				float sin41_g228 = sin( ( temp_output_33_0_g228 + temp_output_72_0_g228 ) );
				half2 rotator41_g228 = mul( temp_output_68_0_g228 - float2( 0.5,0.5 ) , float2x2( cos41_g228 , -sin41_g228 , sin41_g228 , cos41_g228 )) + float2( 0.5,0.5 );
				#ifdef _1_CENTERPIVOT_ON
				half staticSwitch87 = 1.0;
				#else
				half staticSwitch87 = 0.0;
				#endif
				half clampResult46_g228 = clamp( staticSwitch87 , 0.0 , 1.0 );
				half lerpResult29_g228 = lerp( 0.0 , 0.5 , clampResult46_g228);
				half2 temp_cast_3 = (lerpResult29_g228).xx;
				half4 temp_cast_4 = (0.0).xxxx;
				#ifdef _USE_CUSTOM2_ON
				half4 staticSwitch986 = IN.ase_texcoord5;
				#else
				half4 staticSwitch986 = temp_cast_4;
				#endif
				half4 break984 = staticSwitch986;
				half UV2_X988 = break984.x;
				half2 appendResult1149 = (half2(0.0 , UV2_X988));
				half2 appendResult1019 = (half2(UV2_X988 , 0.0));
				#if defined(_TILLINGOFFSETXORY_X)
				half2 staticSwitch1151 = appendResult1149;
				#elif defined(_TILLINGOFFSETXORY_Y)
				half2 staticSwitch1151 = appendResult1019;
				#else
				half2 staticSwitch1151 = appendResult1149;
				#endif
				half2 break1157 = staticSwitch1151;
				half2 appendResult1155 = (half2(break1157.y , break1157.x));
				half2 TillingMain1152 = appendResult1155;
				half UV2_Y989 = break984.y;
				half2 appendResult1015 = (half2(UV2_Y989 , 0.0));
				half2 appendResult1147 = (half2(0.0 , UV2_Y989));
				#if defined(_TILLINGOFFSETXORY_X)
				half2 staticSwitch1150 = appendResult1015;
				#elif defined(_TILLINGOFFSETXORY_Y)
				half2 staticSwitch1150 = appendResult1147;
				#else
				half2 staticSwitch1150 = appendResult1015;
				#endif
				half2 break1156 = staticSwitch1150;
				half2 appendResult1167 = (half2(break1156.x , break1156.y));
				half2 OffsetMain1166 = appendResult1167;
				half4 appendResult1493 = (half4(TillingMain1152 , OffsetMain1166));
				#ifdef _1_FOLLOWOFFSETMAIN_ON
				half4 staticSwitch1495 = appendResult1493;
				#else
				half4 staticSwitch1495 = float4( 0,0,0,0 );
				#endif
				half4 break1491 = staticSwitch1495;
				half2 appendResult1488 = (half2(break1491.x , break1491.y));
				half2 break146 = ( _MainTex_ST.xy + appendResult1488 );
				half2 appendResult1489 = (half2(break1491.z , break1491.w));
				half2 break147 = ( _MainTex_ST.zw + appendResult1489 );
				half4 appendResult149 = (half4(break146.x , break146.y , break147.x , break147.y));
				half4 break63_g228 = appendResult149;
				half2 appendResult60_g228 = (half2(break63_g228.x , break63_g228.y));
				half2 CenteredUV15_g229 = ( temp_output_68_0_g228 - float2( 0.5,0.5 ) );
				half2 break37_g228 = appendResult60_g228;
				half2 break17_g229 = CenteredUV15_g229;
				half2 appendResult23_g229 = (half2(( length( CenteredUV15_g229 ) * break37_g228.x * 2.0 ) , ( atan2( break17_g229.x , break17_g229.y ) * ( 1.0 / TWO_PI ) * break37_g228.y )));
				float cos44_g228 = cos( ( temp_output_33_0_g228 + temp_output_72_0_g228 ) );
				float sin44_g228 = sin( ( temp_output_33_0_g228 + temp_output_72_0_g228 ) );
				half2 rotator44_g228 = mul( appendResult23_g229 - float2( 0.5,0.5 ) , float2x2( cos44_g228 , -sin44_g228 , sin44_g228 , cos44_g228 )) + float2( 0.5,0.5 );
				half2 temp_cast_5 = (lerpResult29_g228).xx;
				#ifdef _1_USEPOLAR_ON
				half staticSwitch90 = 1.0;
				#else
				half staticSwitch90 = 0.0;
				#endif
				half clampResult49_g228 = clamp( staticSwitch90 , 0.0 , 1.0 );
				half2 lerpResult38_g228 = lerp( ( ( rotator41_g228 - temp_cast_3 ) * appendResult60_g228 ) , ( rotator44_g228 - temp_cast_5 ) , clampResult49_g228);
				half2 appendResult61_g228 = (half2(break63_g228.z , break63_g228.w));
				half2 appendResult1282 = (half2(_1_PannerX , _1_PannerY));
				half2 break1280 = ( _TimeParameters.x * appendResult1282 );
				half2 appendResult17_g228 = (half2(break1280.x , break1280.y));
				half2 break20_g228 = ( ( ( lerpResult38_g228 + appendResult61_g228 ) + lerpResult29_g228 ) + appendResult17_g228 );
				#ifdef _1_CLAMPX_ON
				half staticSwitch91 = 1.0;
				#else
				half staticSwitch91 = 0.0;
				#endif
				half clampResult55_g228 = clamp( staticSwitch91 , 0.0 , 1.0 );
				half lerpResult25_g228 = lerp( break20_g228.x , saturate( break20_g228.x ) , clampResult55_g228);
				#ifdef _1_CLAMPY_ON
				half staticSwitch92 = 1.0;
				#else
				half staticSwitch92 = 0.0;
				#endif
				half clampResult58_g228 = clamp( staticSwitch92 , 0.0 , 1.0 );
				half lerpResult23_g228 = lerp( break20_g228.y , saturate( break20_g228.y ) , clampResult58_g228);
				half2 appendResult21_g228 = (half2(lerpResult25_g228 , lerpResult23_g228));
				half4 temp_output_19_0_g251 = tex2D( _MainTex, appendResult21_g228 );
				half4 break5_g251 = temp_output_19_0_g251;
				half UV1_W724 = break481.w;
				half4 appendResult1450 = (half4(_1_RGBA_Value.x , _1_RGBA_Value.y , _1_RGBA_Value.z , ( _1_RGBA_Value.w + UV1_W724 )));
				half4 break18_g251 = appendResult1450;
				half temp_output_26_0_g251 = saturate( ( ( break5_g251.x * break18_g251.x ) + ( break5_g251.y * break18_g251.y ) + ( break5_g251.z * break18_g251.z ) ) );
				half3 temp_cast_7 = (temp_output_26_0_g251).xxx;
				#ifdef _1_RGB_OR_ALPHA_ON
				half staticSwitch133 = 1.0;
				#else
				half staticSwitch133 = 0.0;
				#endif
				half clampResult21_g251 = clamp( staticSwitch133 , 0.0 , 1.0 );
				half3 lerpResult16_g251 = lerp( (temp_output_19_0_g251).xyz , temp_cast_7 , clampResult21_g251);
				half3 temp_output_1443_25 = saturate( lerpResult16_g251 );
				half temp_output_23_0_g251 = _1_Smooth_Step;
				half lerpResult2_g251 = lerp( break5_g251.w , ( temp_output_26_0_g251 * break5_g251.w ) , break18_g251.w);
				half smoothstepResult13_g251 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g251 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g251);
				half lerpResult30_g251 = lerp( smoothstepResult13_g251 , lerpResult2_g251 , saturate( (0.0 + (temp_output_23_0_g251 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				half temp_output_1443_0 = saturate( lerpResult30_g251 );
				half3 lerpResult1071 = lerp( temp_output_1443_25 , ( temp_output_1443_25 * temp_output_1443_0 ) , staticSwitch133);
				half3 temp_output_5_0_g248 = ( lerpResult1071 + float3( 0,0,0 ) );
				half3 lerpResult1_g248 = lerp( ( _SubColor.rgb * _SubColorHDR ) , ( _MainColor.rgb * clampResult1131 ) , temp_output_5_0_g248);
				half3 saferPower34_g248 = abs( temp_output_5_0_g248 );
				half3 temp_cast_9 = (_HighColorPower).xxx;
				half3 lerpResult35_g248 = lerp( lerpResult1_g248 , ( _HighColor.rgb * _HighColorHDR ) , saturate( abs( pow( saferPower34_g248 , temp_cast_9 ) ) ));
				half clampResult1066 = clamp( _HighColorHDR , 0.0 , 1.0 );
				half clampResult41_g248 = clamp( clampResult1066 , 0.0 , 1.0 );
				half3 lerpResult40_g248 = lerp( lerpResult1_g248 , lerpResult35_g248 , clampResult41_g248);
				half3 temp_output_1456_0 = ( abs( lerpResult40_g248 ) + float3( 0,0,0 ) );
				half4 temp_output_721_0 = ( _LineMainColor1 * _LineMainHDR );
				half clampResult1466 = clamp( _LineSubHDR , 0.0 , 1.0 );
				half4 lerpResult1465 = lerp( temp_output_721_0 , ( _LineSubColor1 * _LineSubHDR ) , clampResult1466);
				half UV1_Z487 = break481.z;
				half2 temp_output_68_0_g252 = IN.ase_texcoord4.xy;
				half temp_output_33_0_g252 = ( ( _3_Rotion * PI ) / -180.0 );
				half temp_output_72_0_g252 = ( _3_RotionSpeed * _TimeParameters.x );
				float cos41_g252 = cos( ( temp_output_33_0_g252 + temp_output_72_0_g252 ) );
				float sin41_g252 = sin( ( temp_output_33_0_g252 + temp_output_72_0_g252 ) );
				half2 rotator41_g252 = mul( temp_output_68_0_g252 - float2( 0.5,0.5 ) , float2x2( cos41_g252 , -sin41_g252 , sin41_g252 , cos41_g252 )) + float2( 0.5,0.5 );
				#ifdef _3_CENTERPIVOT_ON
				half staticSwitch158 = 1.0;
				#else
				half staticSwitch158 = 0.0;
				#endif
				half clampResult46_g252 = clamp( staticSwitch158 , 0.0 , 1.0 );
				half lerpResult29_g252 = lerp( 0.0 , 0.5 , clampResult46_g252);
				half2 temp_cast_11 = (lerpResult29_g252).xx;
				half2 break163 = _DissolveTex_ST.xy;
				half2 break162 = _DissolveTex_ST.zw;
				half UV2_Z990 = break984.z;
				half4 appendResult160 = (half4(break163.x , break163.y , ( break162.x + UV2_Z990 ) , ( break162.y + UV2_Z990 )));
				half2 break1176 = ( _DissolveTex_ST.xy + TillingMain1152 );
				half2 break1175 = ( _DissolveTex_ST.zw + OffsetMain1166 );
				half4 appendResult1177 = (half4(break1176.x , break1176.y , break1175.x , break1175.y));
				#ifdef _3_FOLLOWOFFSETMAIN_ON
				half4 staticSwitch1180 = appendResult1177;
				#else
				half4 staticSwitch1180 = appendResult160;
				#endif
				half4 break63_g252 = staticSwitch1180;
				half2 appendResult60_g252 = (half2(break63_g252.x , break63_g252.y));
				half2 CenteredUV15_g253 = ( temp_output_68_0_g252 - float2( 0.5,0.5 ) );
				half2 break37_g252 = appendResult60_g252;
				half2 break17_g253 = CenteredUV15_g253;
				half2 appendResult23_g253 = (half2(( length( CenteredUV15_g253 ) * break37_g252.x * 2.0 ) , ( atan2( break17_g253.x , break17_g253.y ) * ( 1.0 / TWO_PI ) * break37_g252.y )));
				float cos44_g252 = cos( ( temp_output_33_0_g252 + temp_output_72_0_g252 ) );
				float sin44_g252 = sin( ( temp_output_33_0_g252 + temp_output_72_0_g252 ) );
				half2 rotator44_g252 = mul( appendResult23_g253 - float2( 0.5,0.5 ) , float2x2( cos44_g252 , -sin44_g252 , sin44_g252 , cos44_g252 )) + float2( 0.5,0.5 );
				half2 temp_cast_12 = (lerpResult29_g252).xx;
				#ifdef _3_USEPOLAR_ON
				half staticSwitch152 = 1.0;
				#else
				half staticSwitch152 = 0.0;
				#endif
				half clampResult49_g252 = clamp( staticSwitch152 , 0.0 , 1.0 );
				half2 lerpResult38_g252 = lerp( ( ( rotator41_g252 - temp_cast_11 ) * appendResult60_g252 ) , ( rotator44_g252 - temp_cast_12 ) , clampResult49_g252);
				half2 appendResult61_g252 = (half2(break63_g252.z , break63_g252.w));
				half2 appendResult1276 = (half2(_3_PannerX , _3_PannerY));
				half2 break1279 = ( _TimeParameters.x * appendResult1276 );
				half2 appendResult17_g252 = (half2(break1279.x , break1279.y));
				half2 break20_g252 = ( ( ( lerpResult38_g252 + appendResult61_g252 ) + lerpResult29_g252 ) + appendResult17_g252 );
				half clampResult55_g252 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult25_g252 = lerp( break20_g252.x , saturate( break20_g252.x ) , clampResult55_g252);
				half clampResult58_g252 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult23_g252 = lerp( break20_g252.y , saturate( break20_g252.y ) , clampResult58_g252);
				half2 appendResult21_g252 = (half2(lerpResult25_g252 , lerpResult23_g252));
				half4 tex2DNode1394 = tex2D( _DissolveTex, appendResult21_g252 );
				half2 texCoord1476 = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				half4 tex2DNode1467 = tex2D( _DissolveTex, texCoord1476 );
				half temp_output_1474_0 = ( ( tex2DNode1394.r * _3_RGBA_Value.x * tex2DNode1394.a ) + ( tex2DNode1467.g * _3_RGBA_Value.y * tex2DNode1467.a ) );
				half smoothstepResult1483 = smoothstep( 0.0 , (0.0 + (_3_Smooth_Step - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , temp_output_1474_0);
				half lerpResult1480 = lerp( smoothstepResult1483 , temp_output_1474_0 , saturate( (0.0 + (_3_Smooth_Step - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				half temp_output_1380_0 = ( saturate( lerpResult1480 ) + 1.0 );
				#ifdef _ALPHAFORDISSOLVE_ON
				half staticSwitch709 = (0.0 + (( 1.0 - IN.ase_color.a ) - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				#else
				half staticSwitch709 = 0.0;
				#endif
				half UV1_X485 = break481.x;
				half temp_output_1378_0 = (0.0 + (( _DissolveValue + staticSwitch709 + UV1_X485 ) - 0.0) * (( 2.0 + _LineThickness ) - 0.0) / (2.0 - 0.0));
				half clampResult33_g249 = clamp( _5_Tilling , 1.0 , 999.0 );
				half2 temp_cast_13 = (0.5).xx;
				float cos5_g249 = cos( ( ( _5_Rotion * PI ) / -180.0 ) );
				float sin5_g249 = sin( ( ( _5_Rotion * PI ) / -180.0 ) );
				half2 rotator5_g249 = mul( frac( ( IN.ase_texcoord4.xy * clampResult33_g249 ) ) - temp_cast_13 , float2x2( cos5_g249 , -sin5_g249 , sin5_g249 , cos5_g249 )) + temp_cast_13;
				half2 CenteredUV15_g250 = ( rotator5_g249 - float2( 0.5,0.5 ) );
				half2 break17_g250 = CenteredUV15_g250;
				half2 appendResult23_g250 = (half2(( length( CenteredUV15_g250 ) * 1.0 * 2.0 ) , ( atan2( break17_g250.x , break17_g250.y ) * ( 1.0 / TWO_PI ) * 1.0 )));
				#ifdef _5_USEPOLAR_ON
				half staticSwitch298 = 1.0;
				#else
				half staticSwitch298 = 0.0;
				#endif
				half clampResult23_g249 = clamp( staticSwitch298 , 0.0 , 1.0 );
				half2 lerpResult12_g249 = lerp( saturate( rotator5_g249 ) , ( 1.0 - saturate( appendResult23_g250 ) ) , clampResult23_g249);
				half temp_output_53_0_g249 = saturate( lerpResult12_g249.x );
				#ifdef _5_FLIP_ON
				half staticSwitch303 = 1.0;
				#else
				half staticSwitch303 = 0.0;
				#endif
				half clampResult21_g249 = clamp( staticSwitch303 , 0.0 , 1.0 );
				half lerpResult14_g249 = lerp( temp_output_53_0_g249 , ( 1.0 - temp_output_53_0_g249 ) , clampResult21_g249);
				half saferPower13_g249 = abs( lerpResult14_g249 );
				half temp_output_1399_0 = ( ( saturate( ( saturate( abs( pow( saferPower13_g249 , _5_PowerValue ) ) ) * _5_Opacity ) ) + 1.0 ) - temp_output_1378_0 );
				half clampResult1421 = clamp( _5_Opacity , 0.0 , 1.0 );
				half lerpResult1423 = lerp( 0.0 , temp_output_1399_0 , clampResult1421);
				half smoothstepResult1388 = smoothstep( 0.0 , ( _SmoothStepValue2 + UV1_Z487 ) , ( ( temp_output_1380_0 - ( temp_output_1378_0 - _LineThickness ) ) + lerpResult1423 ));
				half clampResult1128 = clamp( _SmoothStepValue1 , 0.001 , 1.0 );
				half lerpResult1422 = lerp( 0.0 , temp_output_1399_0 , clampResult1421);
				half smoothstepResult1384 = smoothstep( 0.0 , clampResult1128 , ( ( temp_output_1380_0 - temp_output_1378_0 ) + lerpResult1422 ));
				half4 lerpResult1404 = lerp( lerpResult1465 , temp_output_721_0 , ( smoothstepResult1388 - smoothstepResult1384 ));
				half4 lerpResult1391 = lerp( lerpResult1404 , half4( temp_output_1456_0 , 0.0 ) , saturate( smoothstepResult1384 ));
				half Line1390 = _LineThickness;
				half4 lerpResult1407 = lerp( half4( temp_output_1456_0 , 0.0 ) , lerpResult1391 , saturate( (0.0 + (Line1390 - 0.0) * (1.0 - 0.0) / (0.01 - 0.0)) ));
				
				half temp_output_1386_0 = saturate( ( temp_output_1443_0 * smoothstepResult1388 ) );
				#ifdef _ALPHAFORDISSOLVE_ON
				half staticSwitch712 = temp_output_1386_0;
				#else
				half staticSwitch712 = ( IN.ase_color.a * temp_output_1386_0 );
				#endif
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = ( lerpResult1407 * IN.ase_color ).rgb;
				float Alpha = staticSwitch712;
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

			#define shader_feature_local _RECEIVE_SHADOWS_OFF
			#define _SURFACE_TYPE_TRANSPARENT 1
			#define ASE_SRP_VERSION 101000


			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define ASE_NEEDS_FRAG_COLOR
			#pragma multi_compile_instancing
			#pragma shader_feature_local _ALPHAFORDISSOLVE_ON
			#pragma shader_feature_local _1_CENTERPIVOT_ON
			#pragma shader_feature_local _1_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _TILLINGOFFSETXORY_X _TILLINGOFFSETXORY_Y
			#pragma shader_feature_local _USE_CUSTOM2_ON
			#pragma shader_feature_local _1_USEPOLAR_ON
			#pragma shader_feature_local _1_CLAMPX_ON
			#pragma shader_feature_local _1_CLAMPY_ON
			#pragma shader_feature_local _USE_CUSTOM1_ON
			#pragma shader_feature_local _3_CENTERPIVOT_ON
			#pragma shader_feature_local _3_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _3_USEPOLAR_ON
			#pragma shader_feature_local _5_USEPOLAR_ON
			#pragma shader_feature_local _5_FLIP_ON


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				half4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
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
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _SubColor;
			half4 _3_RGBA_Value;
			half4 _DissolveTex_ST;
			half4 _LineMainColor1;
			half4 _HighColor;
			half4 _1_RGBA_Value;
			half4 _LineSubColor1;
			half4 _MainColor;
			half4 _MainTex_ST;
			half _1_PannerX;
			half _5_PowerValue;
			half _5_Rotion;
			half _5_Tilling;
			half _LineThickness;
			half _DissolveValue;
			half _SubColorHDR;
			half _3_PannerY;
			half _3_PannerX;
			half _3_RotionSpeed;
			half _3_Rotion;
			half _3_Smooth_Step;
			half _LineSubHDR;
			half _5_Opacity;
			half _LineMainHDR;
			half _MainColorHDR;
			half _HighColorPower;
			half _HighColorHDR;
			half _1_Rotion;
			half _1_Smooth_Step;
			half _1_RotionSpeed;
			half _1_PannerY;
			half _SmoothStepValue2;
			half _SmoothStepValue1;
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
			sampler2D _DissolveTex;
			UNITY_INSTANCING_BUFFER_START(HA_CustomSd_All_Mini_Dissolve)
				UNITY_DEFINE_INSTANCED_PROP(half, _CullMode)
				UNITY_DEFINE_INSTANCED_PROP(half, _BlendMode)
			UNITY_INSTANCING_BUFFER_END(HA_CustomSd_All_Mini_Dissolve)


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.ase_color = v.ase_color;
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				o.ase_texcoord3 = v.ase_texcoord2;
				o.ase_texcoord4 = v.ase_texcoord1;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.zw = 0;

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
				half4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord2 : TEXCOORD2;
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
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord2 = v.ase_texcoord2;
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
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
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

				half _CullMode_Instance = UNITY_ACCESS_INSTANCED_PROP(HA_CustomSd_All_Mini_Dissolve,_CullMode);
				half _BlendMode_Instance = UNITY_ACCESS_INSTANCED_PROP(HA_CustomSd_All_Mini_Dissolve,_BlendMode);
				half temp_output_23_0_g251 = _1_Smooth_Step;
				half2 temp_output_68_0_g228 = IN.ase_texcoord2.xy;
				half temp_output_33_0_g228 = ( ( _1_Rotion * PI ) / -180.0 );
				half temp_output_72_0_g228 = ( _1_RotionSpeed * _TimeParameters.x );
				float cos41_g228 = cos( ( temp_output_33_0_g228 + temp_output_72_0_g228 ) );
				float sin41_g228 = sin( ( temp_output_33_0_g228 + temp_output_72_0_g228 ) );
				half2 rotator41_g228 = mul( temp_output_68_0_g228 - float2( 0.5,0.5 ) , float2x2( cos41_g228 , -sin41_g228 , sin41_g228 , cos41_g228 )) + float2( 0.5,0.5 );
				#ifdef _1_CENTERPIVOT_ON
				half staticSwitch87 = 1.0;
				#else
				half staticSwitch87 = 0.0;
				#endif
				half clampResult46_g228 = clamp( staticSwitch87 , 0.0 , 1.0 );
				half lerpResult29_g228 = lerp( 0.0 , 0.5 , clampResult46_g228);
				half2 temp_cast_0 = (lerpResult29_g228).xx;
				half4 temp_cast_1 = (0.0).xxxx;
				#ifdef _USE_CUSTOM2_ON
				half4 staticSwitch986 = IN.ase_texcoord3;
				#else
				half4 staticSwitch986 = temp_cast_1;
				#endif
				half4 break984 = staticSwitch986;
				half UV2_X988 = break984.x;
				half2 appendResult1149 = (half2(0.0 , UV2_X988));
				half2 appendResult1019 = (half2(UV2_X988 , 0.0));
				#if defined(_TILLINGOFFSETXORY_X)
				half2 staticSwitch1151 = appendResult1149;
				#elif defined(_TILLINGOFFSETXORY_Y)
				half2 staticSwitch1151 = appendResult1019;
				#else
				half2 staticSwitch1151 = appendResult1149;
				#endif
				half2 break1157 = staticSwitch1151;
				half2 appendResult1155 = (half2(break1157.y , break1157.x));
				half2 TillingMain1152 = appendResult1155;
				half UV2_Y989 = break984.y;
				half2 appendResult1015 = (half2(UV2_Y989 , 0.0));
				half2 appendResult1147 = (half2(0.0 , UV2_Y989));
				#if defined(_TILLINGOFFSETXORY_X)
				half2 staticSwitch1150 = appendResult1015;
				#elif defined(_TILLINGOFFSETXORY_Y)
				half2 staticSwitch1150 = appendResult1147;
				#else
				half2 staticSwitch1150 = appendResult1015;
				#endif
				half2 break1156 = staticSwitch1150;
				half2 appendResult1167 = (half2(break1156.x , break1156.y));
				half2 OffsetMain1166 = appendResult1167;
				half4 appendResult1493 = (half4(TillingMain1152 , OffsetMain1166));
				#ifdef _1_FOLLOWOFFSETMAIN_ON
				half4 staticSwitch1495 = appendResult1493;
				#else
				half4 staticSwitch1495 = float4( 0,0,0,0 );
				#endif
				half4 break1491 = staticSwitch1495;
				half2 appendResult1488 = (half2(break1491.x , break1491.y));
				half2 break146 = ( _MainTex_ST.xy + appendResult1488 );
				half2 appendResult1489 = (half2(break1491.z , break1491.w));
				half2 break147 = ( _MainTex_ST.zw + appendResult1489 );
				half4 appendResult149 = (half4(break146.x , break146.y , break147.x , break147.y));
				half4 break63_g228 = appendResult149;
				half2 appendResult60_g228 = (half2(break63_g228.x , break63_g228.y));
				half2 CenteredUV15_g229 = ( temp_output_68_0_g228 - float2( 0.5,0.5 ) );
				half2 break37_g228 = appendResult60_g228;
				half2 break17_g229 = CenteredUV15_g229;
				half2 appendResult23_g229 = (half2(( length( CenteredUV15_g229 ) * break37_g228.x * 2.0 ) , ( atan2( break17_g229.x , break17_g229.y ) * ( 1.0 / TWO_PI ) * break37_g228.y )));
				float cos44_g228 = cos( ( temp_output_33_0_g228 + temp_output_72_0_g228 ) );
				float sin44_g228 = sin( ( temp_output_33_0_g228 + temp_output_72_0_g228 ) );
				half2 rotator44_g228 = mul( appendResult23_g229 - float2( 0.5,0.5 ) , float2x2( cos44_g228 , -sin44_g228 , sin44_g228 , cos44_g228 )) + float2( 0.5,0.5 );
				half2 temp_cast_2 = (lerpResult29_g228).xx;
				#ifdef _1_USEPOLAR_ON
				half staticSwitch90 = 1.0;
				#else
				half staticSwitch90 = 0.0;
				#endif
				half clampResult49_g228 = clamp( staticSwitch90 , 0.0 , 1.0 );
				half2 lerpResult38_g228 = lerp( ( ( rotator41_g228 - temp_cast_0 ) * appendResult60_g228 ) , ( rotator44_g228 - temp_cast_2 ) , clampResult49_g228);
				half2 appendResult61_g228 = (half2(break63_g228.z , break63_g228.w));
				half2 appendResult1282 = (half2(_1_PannerX , _1_PannerY));
				half2 break1280 = ( _TimeParameters.x * appendResult1282 );
				half2 appendResult17_g228 = (half2(break1280.x , break1280.y));
				half2 break20_g228 = ( ( ( lerpResult38_g228 + appendResult61_g228 ) + lerpResult29_g228 ) + appendResult17_g228 );
				#ifdef _1_CLAMPX_ON
				half staticSwitch91 = 1.0;
				#else
				half staticSwitch91 = 0.0;
				#endif
				half clampResult55_g228 = clamp( staticSwitch91 , 0.0 , 1.0 );
				half lerpResult25_g228 = lerp( break20_g228.x , saturate( break20_g228.x ) , clampResult55_g228);
				#ifdef _1_CLAMPY_ON
				half staticSwitch92 = 1.0;
				#else
				half staticSwitch92 = 0.0;
				#endif
				half clampResult58_g228 = clamp( staticSwitch92 , 0.0 , 1.0 );
				half lerpResult23_g228 = lerp( break20_g228.y , saturate( break20_g228.y ) , clampResult58_g228);
				half2 appendResult21_g228 = (half2(lerpResult25_g228 , lerpResult23_g228));
				half4 temp_output_19_0_g251 = tex2D( _MainTex, appendResult21_g228 );
				half4 break5_g251 = temp_output_19_0_g251;
				half4 temp_cast_4 = (0.0).xxxx;
				#ifdef _USE_CUSTOM1_ON
				half4 staticSwitch480 = IN.ase_texcoord4;
				#else
				half4 staticSwitch480 = temp_cast_4;
				#endif
				half4 break481 = staticSwitch480;
				half UV1_W724 = break481.w;
				half4 appendResult1450 = (half4(_1_RGBA_Value.x , _1_RGBA_Value.y , _1_RGBA_Value.z , ( _1_RGBA_Value.w + UV1_W724 )));
				half4 break18_g251 = appendResult1450;
				half temp_output_26_0_g251 = saturate( ( ( break5_g251.x * break18_g251.x ) + ( break5_g251.y * break18_g251.y ) + ( break5_g251.z * break18_g251.z ) ) );
				half lerpResult2_g251 = lerp( break5_g251.w , ( temp_output_26_0_g251 * break5_g251.w ) , break18_g251.w);
				half smoothstepResult13_g251 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g251 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g251);
				half lerpResult30_g251 = lerp( smoothstepResult13_g251 , lerpResult2_g251 , saturate( (0.0 + (temp_output_23_0_g251 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				half temp_output_1443_0 = saturate( lerpResult30_g251 );
				half UV1_Z487 = break481.z;
				half2 temp_output_68_0_g252 = IN.ase_texcoord2.xy;
				half temp_output_33_0_g252 = ( ( _3_Rotion * PI ) / -180.0 );
				half temp_output_72_0_g252 = ( _3_RotionSpeed * _TimeParameters.x );
				float cos41_g252 = cos( ( temp_output_33_0_g252 + temp_output_72_0_g252 ) );
				float sin41_g252 = sin( ( temp_output_33_0_g252 + temp_output_72_0_g252 ) );
				half2 rotator41_g252 = mul( temp_output_68_0_g252 - float2( 0.5,0.5 ) , float2x2( cos41_g252 , -sin41_g252 , sin41_g252 , cos41_g252 )) + float2( 0.5,0.5 );
				#ifdef _3_CENTERPIVOT_ON
				half staticSwitch158 = 1.0;
				#else
				half staticSwitch158 = 0.0;
				#endif
				half clampResult46_g252 = clamp( staticSwitch158 , 0.0 , 1.0 );
				half lerpResult29_g252 = lerp( 0.0 , 0.5 , clampResult46_g252);
				half2 temp_cast_5 = (lerpResult29_g252).xx;
				half2 break163 = _DissolveTex_ST.xy;
				half2 break162 = _DissolveTex_ST.zw;
				half UV2_Z990 = break984.z;
				half4 appendResult160 = (half4(break163.x , break163.y , ( break162.x + UV2_Z990 ) , ( break162.y + UV2_Z990 )));
				half2 break1176 = ( _DissolveTex_ST.xy + TillingMain1152 );
				half2 break1175 = ( _DissolveTex_ST.zw + OffsetMain1166 );
				half4 appendResult1177 = (half4(break1176.x , break1176.y , break1175.x , break1175.y));
				#ifdef _3_FOLLOWOFFSETMAIN_ON
				half4 staticSwitch1180 = appendResult1177;
				#else
				half4 staticSwitch1180 = appendResult160;
				#endif
				half4 break63_g252 = staticSwitch1180;
				half2 appendResult60_g252 = (half2(break63_g252.x , break63_g252.y));
				half2 CenteredUV15_g253 = ( temp_output_68_0_g252 - float2( 0.5,0.5 ) );
				half2 break37_g252 = appendResult60_g252;
				half2 break17_g253 = CenteredUV15_g253;
				half2 appendResult23_g253 = (half2(( length( CenteredUV15_g253 ) * break37_g252.x * 2.0 ) , ( atan2( break17_g253.x , break17_g253.y ) * ( 1.0 / TWO_PI ) * break37_g252.y )));
				float cos44_g252 = cos( ( temp_output_33_0_g252 + temp_output_72_0_g252 ) );
				float sin44_g252 = sin( ( temp_output_33_0_g252 + temp_output_72_0_g252 ) );
				half2 rotator44_g252 = mul( appendResult23_g253 - float2( 0.5,0.5 ) , float2x2( cos44_g252 , -sin44_g252 , sin44_g252 , cos44_g252 )) + float2( 0.5,0.5 );
				half2 temp_cast_6 = (lerpResult29_g252).xx;
				#ifdef _3_USEPOLAR_ON
				half staticSwitch152 = 1.0;
				#else
				half staticSwitch152 = 0.0;
				#endif
				half clampResult49_g252 = clamp( staticSwitch152 , 0.0 , 1.0 );
				half2 lerpResult38_g252 = lerp( ( ( rotator41_g252 - temp_cast_5 ) * appendResult60_g252 ) , ( rotator44_g252 - temp_cast_6 ) , clampResult49_g252);
				half2 appendResult61_g252 = (half2(break63_g252.z , break63_g252.w));
				half2 appendResult1276 = (half2(_3_PannerX , _3_PannerY));
				half2 break1279 = ( _TimeParameters.x * appendResult1276 );
				half2 appendResult17_g252 = (half2(break1279.x , break1279.y));
				half2 break20_g252 = ( ( ( lerpResult38_g252 + appendResult61_g252 ) + lerpResult29_g252 ) + appendResult17_g252 );
				half clampResult55_g252 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult25_g252 = lerp( break20_g252.x , saturate( break20_g252.x ) , clampResult55_g252);
				half clampResult58_g252 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult23_g252 = lerp( break20_g252.y , saturate( break20_g252.y ) , clampResult58_g252);
				half2 appendResult21_g252 = (half2(lerpResult25_g252 , lerpResult23_g252));
				half4 tex2DNode1394 = tex2D( _DissolveTex, appendResult21_g252 );
				half2 texCoord1476 = IN.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				half4 tex2DNode1467 = tex2D( _DissolveTex, texCoord1476 );
				half temp_output_1474_0 = ( ( tex2DNode1394.r * _3_RGBA_Value.x * tex2DNode1394.a ) + ( tex2DNode1467.g * _3_RGBA_Value.y * tex2DNode1467.a ) );
				half smoothstepResult1483 = smoothstep( 0.0 , (0.0 + (_3_Smooth_Step - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , temp_output_1474_0);
				half lerpResult1480 = lerp( smoothstepResult1483 , temp_output_1474_0 , saturate( (0.0 + (_3_Smooth_Step - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				half temp_output_1380_0 = ( saturate( lerpResult1480 ) + 1.0 );
				#ifdef _ALPHAFORDISSOLVE_ON
				half staticSwitch709 = (0.0 + (( 1.0 - IN.ase_color.a ) - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				#else
				half staticSwitch709 = 0.0;
				#endif
				half UV1_X485 = break481.x;
				half temp_output_1378_0 = (0.0 + (( _DissolveValue + staticSwitch709 + UV1_X485 ) - 0.0) * (( 2.0 + _LineThickness ) - 0.0) / (2.0 - 0.0));
				half clampResult33_g249 = clamp( _5_Tilling , 1.0 , 999.0 );
				half2 temp_cast_7 = (0.5).xx;
				float cos5_g249 = cos( ( ( _5_Rotion * PI ) / -180.0 ) );
				float sin5_g249 = sin( ( ( _5_Rotion * PI ) / -180.0 ) );
				half2 rotator5_g249 = mul( frac( ( IN.ase_texcoord2.xy * clampResult33_g249 ) ) - temp_cast_7 , float2x2( cos5_g249 , -sin5_g249 , sin5_g249 , cos5_g249 )) + temp_cast_7;
				half2 CenteredUV15_g250 = ( rotator5_g249 - float2( 0.5,0.5 ) );
				half2 break17_g250 = CenteredUV15_g250;
				half2 appendResult23_g250 = (half2(( length( CenteredUV15_g250 ) * 1.0 * 2.0 ) , ( atan2( break17_g250.x , break17_g250.y ) * ( 1.0 / TWO_PI ) * 1.0 )));
				#ifdef _5_USEPOLAR_ON
				half staticSwitch298 = 1.0;
				#else
				half staticSwitch298 = 0.0;
				#endif
				half clampResult23_g249 = clamp( staticSwitch298 , 0.0 , 1.0 );
				half2 lerpResult12_g249 = lerp( saturate( rotator5_g249 ) , ( 1.0 - saturate( appendResult23_g250 ) ) , clampResult23_g249);
				half temp_output_53_0_g249 = saturate( lerpResult12_g249.x );
				#ifdef _5_FLIP_ON
				half staticSwitch303 = 1.0;
				#else
				half staticSwitch303 = 0.0;
				#endif
				half clampResult21_g249 = clamp( staticSwitch303 , 0.0 , 1.0 );
				half lerpResult14_g249 = lerp( temp_output_53_0_g249 , ( 1.0 - temp_output_53_0_g249 ) , clampResult21_g249);
				half saferPower13_g249 = abs( lerpResult14_g249 );
				half temp_output_1399_0 = ( ( saturate( ( saturate( abs( pow( saferPower13_g249 , _5_PowerValue ) ) ) * _5_Opacity ) ) + 1.0 ) - temp_output_1378_0 );
				half clampResult1421 = clamp( _5_Opacity , 0.0 , 1.0 );
				half lerpResult1423 = lerp( 0.0 , temp_output_1399_0 , clampResult1421);
				half smoothstepResult1388 = smoothstep( 0.0 , ( _SmoothStepValue2 + UV1_Z487 ) , ( ( temp_output_1380_0 - ( temp_output_1378_0 - _LineThickness ) ) + lerpResult1423 ));
				half temp_output_1386_0 = saturate( ( temp_output_1443_0 * smoothstepResult1388 ) );
				#ifdef _ALPHAFORDISSOLVE_ON
				half staticSwitch712 = temp_output_1386_0;
				#else
				half staticSwitch712 = ( IN.ase_color.a * temp_output_1386_0 );
				#endif
				

				float Alpha = staticSwitch712;
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
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=19201
Node;AmplifyShaderEditor.CommentaryNode;1220;-8187.843,-4652.205;Inherit;False;1475.795;981.5369;;14;1156;1147;1013;1015;1166;1167;1157;1155;1019;1149;1014;1152;1151;1150;Custom Offset X or Y;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1219;-9092.897,-2942.774;Inherit;False;1438.79;1109.777;;16;985;986;984;989;990;991;725;480;481;485;486;487;724;479;987;988;Custom Data;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1074;2086.225,-3302.749;Inherit;False;1784.468;2171.969;;12;1131;717;683;1132;715;1029;1027;1025;1066;175;1427;1487;Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;788;7046.859,1670.881;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1210;9986.549,1727.697;Half;False;InstancedProperty;_CullMode;Cull Mode;1;1;[Enum];Create;True;0;3;Back;1;Front;2;Off;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1212;9941.932,1908.221;Half;False;InstancedProperty;_BlendMode;Blend Mode;0;1;[Enum];Create;True;0;2;ADD;1;ADP;10;0;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1229;9498.361,1752.677;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1231;9498.361,1752.677;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1232;9498.361,1752.677;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1233;9498.361,1752.677;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;13;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1382;-2463.201,3787.892;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1377;-3014.44,3593.328;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1378;-3689.363,3413.776;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;2;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1387;-2459.498,3416.826;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1388;-2165.916,3740.698;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1384;-2175.472,3452.948;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1397;-1431.814,1193.735;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;93;-2883.54,124.9828;Inherit;False;Property;_1_Rotion;1_Rotion;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;149;-2970.323,-341.9498;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;146;-3265.175,-447.4006;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;147;-3262.109,-310.942;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TextureTransformNode;97;-3751.502,-326.1973;Inherit;False;140;False;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.SimpleAddOpNode;1170;-3414.182,-294.9622;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1172;-3484.183,-450.9626;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1280;-2707.823,18.32436;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1281;-2860.823,-49.67567;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-3217.146,623.7272;Inherit;False;Constant;_Float4;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-3216.867,705.7766;Inherit;False;Constant;_Float5;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1349;-2803.948,306.5841;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;183;-2645.922,3096.726;Half;False;Property;_SmoothStepValue1;SmoothStepValue1;34;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1128;-2330.619,3194.878;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.001;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1407;6697.446,-1183.881;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1375;-3785.363,3696.776;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1389;2306.733,3323.873;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;127.6104,-560.1815;Inherit;False;Constant;_Float6;Float 6;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;131.3212,-478.8634;Inherit;False;Constant;_Float2;Float 2;11;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1072;1216.56,-183.3168;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1071;1627.364,-528.572;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1372;-1569.552,25.71282;Inherit;True;Property;_TextureSample3;Texture Sample 3;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1350;-3222.234,412.0271;Half;False;Property;_1_RotionSpeed;1_RotionSpeed;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1348;-3232.948,267.5841;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1282;-3093.745,-10.05421;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-3268.078,91.37404;Half;False;Property;_1_PannerY;1_PannerY;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-3291.078,-59.62598;Half;False;Property;_1_PannerX;1_PannerX;12;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1286;-2473.031,-21.72963;Inherit;True;MF_UV_TX;-1;;228;8fdb8293e8d00da44843ff33d5199a52;0;10;68;FLOAT2;1,1;False;67;FLOAT4;1,1,0,0;False;52;FLOAT;0;False;53;FLOAT;0;False;48;FLOAT;0;False;72;FLOAT;0;False;45;FLOAT;0;False;56;FLOAT;0;False;57;FLOAT;0;False;50;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1401;-4429.375,4794.457;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1127;-2320.521,4107.505;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;707;-5224.573,3587.138;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;710;-5031.292,3461.238;Inherit;False;Constant;_Float3;Float 3;59;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;180;-4838.632,3300.805;Half;False;Property;_DissolveValue;DissolveValue;32;0;Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;709;-4839.963,3595.402;Inherit;False;Property;_AlphaforDissolve;Alpha for Dissolve?;33;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;688;-4769.944,3823.598;Inherit;False;485;UV1_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;708;-5052.052,3580.181;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;687;-4439.117,3668.361;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1374;-4013.26,3640.148;Inherit;False;Constant;_Float23;Float 10;63;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1385;-3293.184,3656.328;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;312;-5166.996,4939.103;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;309;-5457.952,4914.328;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1379;-4706.083,5005.938;Inherit;False;Constant;_Float25;Float 21;63;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1371;-4750.184,2811.328;Inherit;False;Constant;_Float22;Float 18;60;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1380;-4581.184,2685.328;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1381;-3007.499,3273.358;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1376;-4084.184,3883.805;Inherit;False;Property;_LineThickness;Line Thickness;36;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1129;-2549.413,4254.073;Inherit;False;487;UV1_Z;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;310;-5754.391,4653.702;Inherit;False;Property;_5_Opacity;5_Opacity;44;1;[Header];Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1422;-2977.026,4118.971;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;834;-2649.665,4114.392;Half;False;Property;_SmoothStepValue2;SmoothStepValue2;35;0;Create;True;0;0;0;False;0;False;0.2;0.667;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1391;6149.977,-930.0786;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1423;-2971.788,4318.165;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1399;-3293.925,4466.525;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1421;-3699.572,4395.651;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;140;-1914.049,-237.1413;Inherit;True;Property;_MainTex;MainTex;11;0;Create;True;1;Main____________________________________________________________________________________________;0;0;True;0;False;None;1b57bd331f9e9d741b8912917617c109;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;130;271.3468,152.7783;Inherit;False;Property;_1_Smooth_Step;1_Smooth_Step;20;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;587;-2910.365,-559.4572;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;133;279.1121,-537.0026;Inherit;False;Property;_1_RGB_or_Alpha;1_RGB_or_Alpha;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1412;-1307.197,3202.635;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1230;9498.361,1752.677;Half;False;True;-1;2;ASEMaterialInspector;0;13;HA_Custom/Sd_All_Mini_Dissolve;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;1;Forward;8;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;2;True;_CullMode;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;3;True;12;all;0;True;True;2;5;False;;10;True;_BlendMode;2;5;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalForward;False;False;0;Hidden/InternalErrorShader;0;0;Standard;22;Surface;1;638313483686247703;  Blend;0;0;Two Sided;0;638313483672647531;Cast Shadows;0;638313483655181423;  Use Shadow Threshold;0;0;Receive Shadows;0;638313483637566884;GPU Instancing;1;0;LOD CrossFade;0;0;Built-in Fog;0;0;DOTS Instancing;0;0;Meta Pass;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Vertex Position,InvertActionOnDeselection;1;0;0;5;False;True;False;True;False;False;;False;0
Node;AmplifyShaderEditor.SaturateNode;1386;6522.604,1919.495;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;422;6906.018,1337.809;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;712;7414.799,1889.773;Inherit;False;Property;_1111;1111;33;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;709;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;423;7297.596,1053.933;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1390;-3730.608,3961.02;Half;False;Line;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;706;-5496.482,3467.3;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;136;180.622,-394.7955;Inherit;False;Property;_1_RGBA_Value;1_RGBA_Value;10;0;Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;1,0,0,0;1,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1452;170.2842,-188.7957;Inherit;False;724;UV1_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1451;413.0945,-221.8076;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1456;4657.113,-2159.982;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;1147;-7754.586,-4082.467;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1015;-7753.062,-4212.723;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1019;-7906.364,-4405.585;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1149;-7913.369,-4569.391;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1156;-7266.7,-3805.668;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;1167;-7075.459,-3844.484;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1157;-7400.416,-4530.134;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;1155;-7227.2,-4491.056;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1166;-6936.048,-3869.023;Inherit;False;OffsetMain;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1152;-7066.91,-4562.999;Inherit;False;TillingMain;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;1150;-7535.348,-4097.701;Inherit;False;Property;_TillingOffsetXorY;Tilling Offset X or Y;43;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;X;Y;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;1151;-7699.885,-4602.205;Inherit;False;Property;_Keyword1;Keyword 0;43;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;1150;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1013;-7988.061,-4124.724;Inherit;False;989;UV2_Y;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1014;-8137.843,-4583.648;Inherit;False;988;UV2_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;985;-8869.248,-2302.456;Inherit;False;Constant;_Float24;Float 20;64;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;725;-8890.081,-2870.63;Inherit;False;Constant;_Float20;Float 20;64;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;479;-9042.897,-2734.016;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;987;-9022.063,-2165.843;Inherit;False;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;986;-8604.064,-2196.843;Inherit;False;Property;_Use_Custom2;Use_Custom2;42;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;480;-8624.898,-2765.016;Inherit;False;Property;_Use_Custom1;Use_Custom1;41;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;984;-8302.064,-2195.843;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;481;-8316.897,-2763.016;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;989;-7912.106,-2148.995;Inherit;False;UV2_Y;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;990;-7923.106,-2061.996;Inherit;False;UV2_Z;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;988;-7878.107,-2232.995;Inherit;False;UV2_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-7952.877,-2783.772;Inherit;False;UV1_Y;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-7947.877,-2673.773;Inherit;False;UV1_Z;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;485;-7964.877,-2890.773;Inherit;False;UV1_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;724;-7949.964,-2573.88;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;176;5032.099,-371.8475;Inherit;False;Property;_LineMainColor1;LineMainColor1;37;0;Create;True;0;0;0;False;0;False;0,0,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;720;5026.772,-117.3446;Half;False;Property;_LineMainHDR;LineMainHDR;38;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;721;5411.972,-240.3041;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1404;5852.546,52.56168;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;91;-2944.941,637.9421;Inherit;False;Property;_1_ClampX;1_ClampX;17;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;92;-2931.941,783.9421;Inherit;False;Property;_1_ClampY;1_ClampY;18;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;90;-2949.941,919.9426;Inherit;False;Property;_1_UsePolar;1_UsePolar;19;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;87;-2964.841,503.8428;Inherit;False;Property;_1_CenterPivot;1_CenterPivot;16;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1392;6346.807,-1208.479;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1414;5918.668,-1152.186;Inherit;False;1390;Line;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1408;6113.908,-1150.874;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.01;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1462;4885.622,56.1426;Inherit;False;Property;_LineSubColor1;LineSubColor1;39;0;Create;True;0;0;0;False;0;False;0,0,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1464;5183.965,182.6944;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;1466;5251.73,416.1026;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1465;5574.688,48.25124;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1463;4880.295,310.6455;Half;False;Property;_LineSubHDR;LineSubHDR;40;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;166;-8205.962,2042.486;Inherit;True;Property;_DissolveTex;DissolveTex;23;0;Create;True;1;Dissolve______________________________________________________________________________________________;0;0;True;0;False;None;c9218beef487f6449be6af235f88d0f9;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;1394;-7796.439,2400.48;Inherit;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;0;False;0;False;-1;49455d8fcd4975c4e934746ffb764262;49455d8fcd4975c4e934746ffb764262;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;1429;-7676.73,2043.328;Inherit;False;Property;_3_RGBA_Value;3_RGBA_Value;22;0;Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;1,0,0,1;0.6,0,0,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1471;-7395.757,2401.321;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1472;-7416.125,2700.272;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1467;-7797.499,2659.911;Inherit;True;Property;_TextureSample4;Texture Sample 2;2;0;Create;True;0;0;0;False;0;False;-1;49455d8fcd4975c4e934746ffb764262;49455d8fcd4975c4e934746ffb764262;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1474;-7158.279,2482.829;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;315;-5194.501,2696.842;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1481;-6690.403,3094.361;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.999;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1479;-6121.613,3111.279;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1480;-5843.402,2810.198;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1483;-6307.417,2890.243;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1430;-7272.132,3144.158;Inherit;False;Property;_3_Smooth_Step;3_Smooth_Step;30;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1482;-6687.513,2904.823;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.999;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1027;2391.193,-3022.343;Half;False;Property;_HighColorHDR;HighColorHDR;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1066;2602.978,-3114.298;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1029;2368.92,-2926.559;Half;False;Property;_HighColorPower;HighColorPower;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1025;2363.081,-3245.371;Inherit;False;Property;_HighColor;HighColor;2;1;[Header];Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1132;2114.425,-2393.874;Inherit;False;486;UV1_Y;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1427;2392.885,-2503.719;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1131;2552.426,-2521.258;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;999;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;717;2224.553,-2100.587;Half;False;Property;_SubColorHDR;SubColorHDR;8;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;683;2194.721,-2273.578;Inherit;False;Property;_SubColor;SubColor;7;0;Create;True;0;0;0;False;0;False;0,0,0,1;0.3490196,0.05490196,0.05490196,0.6941177;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1487;3151.137,-2862.802;Inherit;False;MF_Fill_3_Color;-1;;248;93b9e1825a3927840a67e57099e75cc1;0;9;54;FLOAT;0;False;33;FLOAT3;1,1,1;False;51;FLOAT;1;False;39;FLOAT;1;False;20;FLOAT3;1,1,1;False;42;FLOAT;1;False;19;FLOAT3;1,1,1;False;44;FLOAT;1;False;22;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;715;2121.422,-2505.323;Half;False;Property;_MainColorHDR;MainColorHDR;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;175;2444.084,-2806.279;Inherit;False;Property;_MainColor;MainColor;5;0;Create;True;0;0;0;False;0;False;1,1,1,1;0.3490196,0.05490196,0.05490196,0.6941177;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;991;-7918.106,-1948.996;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1486;-6101.027,4947.936;Inherit;True;MF_Gradient_Alpha;-1;;249;2615dfd5ebdde4f42b1224bd2e1e9e42;0;7;54;FLOAT2;1,1;False;19;FLOAT;1;False;20;FLOAT;0;False;24;FLOAT;0;False;30;FLOAT;0;False;62;FLOAT2;0,0;False;22;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;300;-7355.985,5592.039;Inherit;False;Constant;_Float15;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;298;-7070.98,5546.641;Inherit;False;Property;_5_UsePolar;5_UsePolar;49;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;303;-7248.513,4952.399;Inherit;False;Property;_5_Flip;5_Flip;48;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;302;-7533.519,4997.798;Inherit;False;Constant;_Float17;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;297;-7169.201,5057.882;Half;False;Property;_5_Rotion;5_Rotion;46;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;520;-7142.839,5149.572;Half;False;Property;_5_Tilling;5_Tilling;47;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;299;-7357.985,5522.038;Inherit;False;Constant;_Float12;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;301;-7535.519,4915.796;Inherit;False;Constant;_Float16;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;304;-7253.832,4836.749;Half;False;Property;_5_PowerValue;5_PowerValue;45;0;Create;True;1;Gradient Alpha____________________________________________________________________________________________;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1344;-7176.353,4604.388;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1424;-7027.916,5242.428;Inherit;False;1166;OffsetMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1443;836.4301,-174.7365;Inherit;False;MF_RGB_Alpha;-1;;251;81c413b5668b2004e8bc7cdf85fe8515;0;4;22;FLOAT;0;False;17;FLOAT4;1,1,1,0;False;19;FLOAT4;0,0,0,0;False;23;FLOAT;1;False;2;FLOAT3;25;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1450;510.1904,-299.1021;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;155;-11961.43,2862.409;Inherit;False;Constant;_Float8;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;154;-11968.63,2769.008;Inherit;False;Constant;_Float7;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;152;-11684.83,3019.705;Inherit;False;Property;_3_UsePolar;3_UsePolar;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;158;-11698.73,2864.605;Inherit;False;Property;_3_CenterPivot;3_CenterPivot;28;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;156;-11860.75,2451.416;Half;False;Property;_3_PannerX;3_PannerX;24;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;157;-11864.75,2531.416;Half;False;Property;_3_PannerY;3_PannerY;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1279;-11314.59,2445.644;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1277;-11467.59,2377.644;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1276;-11617.59,2423.644;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;1278;-11684.59,2298.644;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;153;-11648.13,2562.645;Half;False;Property;_3_Rotion;3_Rotion;26;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1285;-11872,2669.458;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1284;-11425,2661.458;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1323;-12182.7,1540.457;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1275;-11715.59,2766.501;Half;False;Property;_3_RotionSpeed;3_RotionSpeed;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1180;-11860.95,2103.173;Inherit;False;Property;_3_FollowOffsetMain;3_FollowOffsetMain;31;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;1177;-12329.15,2305.475;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;160;-12318.48,1968.777;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;163;-12715.86,1854.211;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;162;-12846.53,1998.371;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;1485;-12519.45,2124.379;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1484;-12518.28,1990.429;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1458;-12790.41,2290.141;Inherit;False;990;UV2_Z;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1174;-13163.56,2662.044;Inherit;False;1166;OffsetMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1175;-12799.33,2561.508;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;1179;-12936.21,2552.184;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1178;-12918.37,2417.626;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1176;-12786.07,2421.483;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;1173;-13207.18,2384.858;Inherit;False;1152;TillingMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureTransformNode;161;-13324.35,2059.686;Inherit;False;166;False;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.FunctionNode;1288;-11113.2,2426.746;Inherit;True;MF_UV_TX;-1;;252;8fdb8293e8d00da44843ff33d5199a52;0;10;68;FLOAT2;1,1;False;67;FLOAT4;1,1,0,0;False;52;FLOAT;0;False;53;FLOAT;0;False;48;FLOAT;0;False;72;FLOAT;0;False;45;FLOAT;0;False;56;FLOAT;0;False;57;FLOAT;0;False;50;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1476;-8084.835,2702.064;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1169;-3712.432,-485.1892;Inherit;False;1166;OffsetMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1488;-3931.589,-452.5531;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1489;-3945.589,-100.5529;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1491;-4206.48,-334.3421;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StaticSwitch;1495;-4518.815,-340.2872;Inherit;False;Property;_1_FollowOffsetMain;1_FollowOffsetMain;21;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;1493;-4702.092,-349.6361;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;1494;-4956.884,-298.4122;Inherit;False;1166;OffsetMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1492;-4959.196,-409.838;Inherit;False;1152;TillingMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1168;-3692.275,-560.9927;Inherit;False;1152;TillingMain;1;0;OBJECT;;False;1;FLOAT2;0
WireConnection;788;0;422;4
WireConnection;788;1;1386;0
WireConnection;1382;0;1377;0
WireConnection;1382;1;1423;0
WireConnection;1377;0;1380;0
WireConnection;1377;1;1385;0
WireConnection;1378;0;687;0
WireConnection;1378;2;1374;0
WireConnection;1378;4;1375;0
WireConnection;1387;0;1381;0
WireConnection;1387;1;1422;0
WireConnection;1388;0;1382;0
WireConnection;1388;2;1127;0
WireConnection;1384;0;1387;0
WireConnection;1384;2;1128;0
WireConnection;1397;0;1384;0
WireConnection;149;0;146;0
WireConnection;149;1;146;1
WireConnection;149;2;147;0
WireConnection;149;3;147;1
WireConnection;146;0;1172;0
WireConnection;147;0;1170;0
WireConnection;1170;0;97;1
WireConnection;1170;1;1489;0
WireConnection;1172;0;97;0
WireConnection;1172;1;1488;0
WireConnection;1280;0;1281;0
WireConnection;1281;0;1348;0
WireConnection;1281;1;1282;0
WireConnection;1349;0;1350;0
WireConnection;1349;1;1348;0
WireConnection;1128;0;183;0
WireConnection;1407;0;1456;0
WireConnection;1407;1;1391;0
WireConnection;1407;2;1392;0
WireConnection;1375;0;1374;0
WireConnection;1375;1;1376;0
WireConnection;1389;0;1443;0
WireConnection;1389;1;1388;0
WireConnection;1072;0;1443;25
WireConnection;1072;1;1443;0
WireConnection;1071;0;1443;25
WireConnection;1071;1;1072;0
WireConnection;1071;2;133;0
WireConnection;1372;0;140;0
WireConnection;1372;1;1286;0
WireConnection;1282;0;94;0
WireConnection;1282;1;95;0
WireConnection;1286;68;587;0
WireConnection;1286;67;149;0
WireConnection;1286;52;1280;0
WireConnection;1286;53;1280;1
WireConnection;1286;48;93;0
WireConnection;1286;72;1349;0
WireConnection;1286;45;87;0
WireConnection;1286;56;91;0
WireConnection;1286;57;92;0
WireConnection;1286;50;90;0
WireConnection;1401;0;312;0
WireConnection;1401;1;1379;0
WireConnection;1127;0;834;0
WireConnection;1127;1;1129;0
WireConnection;707;0;706;4
WireConnection;709;1;710;0
WireConnection;709;0;708;0
WireConnection;708;0;707;0
WireConnection;687;0;180;0
WireConnection;687;1;709;0
WireConnection;687;2;688;0
WireConnection;1385;0;1378;0
WireConnection;1385;1;1376;0
WireConnection;312;0;309;0
WireConnection;309;0;1486;0
WireConnection;309;1;310;0
WireConnection;1380;0;315;0
WireConnection;1380;1;1371;0
WireConnection;1381;0;1380;0
WireConnection;1381;1;1378;0
WireConnection;1422;1;1399;0
WireConnection;1422;2;1421;0
WireConnection;1391;0;1404;0
WireConnection;1391;1;1456;0
WireConnection;1391;2;1397;0
WireConnection;1423;1;1399;0
WireConnection;1423;2;1421;0
WireConnection;1399;0;1401;0
WireConnection;1399;1;1378;0
WireConnection;1421;0;310;0
WireConnection;133;1;135;0
WireConnection;133;0;134;0
WireConnection;1412;0;1388;0
WireConnection;1412;1;1384;0
WireConnection;1230;2;423;0
WireConnection;1230;3;712;0
WireConnection;1386;0;1389;0
WireConnection;712;1;788;0
WireConnection;712;0;1386;0
WireConnection;423;0;1407;0
WireConnection;423;1;422;0
WireConnection;1390;0;1376;0
WireConnection;1451;0;136;4
WireConnection;1451;1;1452;0
WireConnection;1456;0;1487;0
WireConnection;1147;1;1013;0
WireConnection;1015;0;1013;0
WireConnection;1019;0;1014;0
WireConnection;1149;1;1014;0
WireConnection;1156;0;1150;0
WireConnection;1167;0;1156;0
WireConnection;1167;1;1156;1
WireConnection;1157;0;1151;0
WireConnection;1155;0;1157;1
WireConnection;1155;1;1157;0
WireConnection;1166;0;1167;0
WireConnection;1152;0;1155;0
WireConnection;1150;1;1015;0
WireConnection;1150;0;1147;0
WireConnection;1151;1;1149;0
WireConnection;1151;0;1019;0
WireConnection;986;1;985;0
WireConnection;986;0;987;0
WireConnection;480;1;725;0
WireConnection;480;0;479;0
WireConnection;984;0;986;0
WireConnection;481;0;480;0
WireConnection;989;0;984;1
WireConnection;990;0;984;2
WireConnection;988;0;984;0
WireConnection;486;0;481;1
WireConnection;487;0;481;2
WireConnection;485;0;481;0
WireConnection;724;0;481;3
WireConnection;721;0;176;0
WireConnection;721;1;720;0
WireConnection;1404;0;1465;0
WireConnection;1404;1;721;0
WireConnection;1404;2;1412;0
WireConnection;91;1;88;0
WireConnection;91;0;89;0
WireConnection;92;1;88;0
WireConnection;92;0;89;0
WireConnection;90;1;88;0
WireConnection;90;0;89;0
WireConnection;87;1;88;0
WireConnection;87;0;89;0
WireConnection;1392;0;1408;0
WireConnection;1408;0;1414;0
WireConnection;1464;0;1462;0
WireConnection;1464;1;1463;0
WireConnection;1466;0;1463;0
WireConnection;1465;0;721;0
WireConnection;1465;1;1464;0
WireConnection;1465;2;1466;0
WireConnection;1394;0;166;0
WireConnection;1394;1;1288;0
WireConnection;1471;0;1394;1
WireConnection;1471;1;1429;1
WireConnection;1471;2;1394;4
WireConnection;1472;0;1467;2
WireConnection;1472;1;1429;2
WireConnection;1472;2;1467;4
WireConnection;1467;0;166;0
WireConnection;1467;1;1476;0
WireConnection;1474;0;1471;0
WireConnection;1474;1;1472;0
WireConnection;315;0;1480;0
WireConnection;1481;0;1430;0
WireConnection;1479;0;1481;0
WireConnection;1480;0;1483;0
WireConnection;1480;1;1474;0
WireConnection;1480;2;1479;0
WireConnection;1483;0;1474;0
WireConnection;1483;2;1482;0
WireConnection;1482;0;1430;0
WireConnection;1066;0;1027;0
WireConnection;1427;0;715;0
WireConnection;1427;1;1132;0
WireConnection;1131;0;1427;0
WireConnection;1487;54;1066;0
WireConnection;1487;33;1025;0
WireConnection;1487;51;1027;0
WireConnection;1487;39;1029;0
WireConnection;1487;20;175;0
WireConnection;1487;42;1131;0
WireConnection;1487;19;683;0
WireConnection;1487;44;717;0
WireConnection;1487;22;1071;0
WireConnection;991;0;984;3
WireConnection;1486;54;1344;0
WireConnection;1486;19;304;0
WireConnection;1486;20;303;0
WireConnection;1486;24;297;0
WireConnection;1486;30;520;0
WireConnection;1486;22;298;0
WireConnection;298;1;299;0
WireConnection;298;0;300;0
WireConnection;303;1;301;0
WireConnection;303;0;302;0
WireConnection;1443;22;133;0
WireConnection;1443;17;1450;0
WireConnection;1443;19;1372;0
WireConnection;1443;23;130;0
WireConnection;1450;0;136;1
WireConnection;1450;1;136;2
WireConnection;1450;2;136;3
WireConnection;1450;3;1451;0
WireConnection;152;1;154;0
WireConnection;152;0;155;0
WireConnection;158;1;154;0
WireConnection;158;0;155;0
WireConnection;1279;0;1277;0
WireConnection;1277;0;1278;0
WireConnection;1277;1;1276;0
WireConnection;1276;0;156;0
WireConnection;1276;1;157;0
WireConnection;1284;0;1275;0
WireConnection;1284;1;1285;0
WireConnection;1180;1;160;0
WireConnection;1180;0;1177;0
WireConnection;1177;0;1176;0
WireConnection;1177;1;1176;1
WireConnection;1177;2;1175;0
WireConnection;1177;3;1175;1
WireConnection;160;0;163;0
WireConnection;160;1;163;1
WireConnection;160;2;1484;0
WireConnection;160;3;1485;0
WireConnection;163;0;161;0
WireConnection;162;0;161;1
WireConnection;1485;0;162;1
WireConnection;1485;1;1458;0
WireConnection;1484;0;162;0
WireConnection;1484;1;1458;0
WireConnection;1175;0;1179;0
WireConnection;1179;0;161;1
WireConnection;1179;1;1174;0
WireConnection;1178;0;161;0
WireConnection;1178;1;1173;0
WireConnection;1176;0;1178;0
WireConnection;1288;68;1323;0
WireConnection;1288;67;1180;0
WireConnection;1288;52;1279;0
WireConnection;1288;53;1279;1
WireConnection;1288;48;153;0
WireConnection;1288;72;1284;0
WireConnection;1288;45;158;0
WireConnection;1288;50;152;0
WireConnection;1488;0;1491;0
WireConnection;1488;1;1491;1
WireConnection;1489;0;1491;2
WireConnection;1489;1;1491;3
WireConnection;1491;0;1495;0
WireConnection;1495;0;1493;0
WireConnection;1493;0;1492;0
WireConnection;1493;2;1494;0
ASEEND*/
//CHKSM=11E4CB6FB63FB9A1DB876A93A03E5E91D8BEDE08