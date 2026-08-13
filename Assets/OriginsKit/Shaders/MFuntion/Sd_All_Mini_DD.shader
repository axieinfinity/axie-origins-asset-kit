// Made with Amplify Shader Editor v1.9.2.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "HA_Custom/Sd_All_Mini_DD"
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
		[Header(_________________________________________________________________________________________)]_3_Opacity("3_Opacity", Float) = 1
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
		[Header(_________________________________________________________________________________________)]_1_Distort_MainTex("1_Distort_MainTex", Float) = 0
		_3_Distort_DissolveTex("3_Distort_DissolveTex", Float) = 0
		_DistortTex("DistortTex", 2D) = "white" {}
		_6_PannerX("6_PannerX", Float) = 0
		_6_PannerY("6_PannerY", Float) = 0
		_6_Rotion("6_Rotion", Float) = 0
		[Toggle(_6_USEPOLAR_ON)] _6_UsePolar("6_UsePolar", Float) = 0
		_Distort_all("Distort_all", Range( 0 , 1)) = 0


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
			#pragma shader_feature_local _USE_CUSTOM2_ON
			#pragma shader_feature_local _6_USEPOLAR_ON
			#pragma shader_feature_local _1_CENTERPIVOT_ON
			#pragma shader_feature_local _1_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _TILLINGOFFSETXORY_X _TILLINGOFFSETXORY_Y
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
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
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
			half4 _LineSubColor1;
			half4 _HighColor;
			half4 _1_RGBA_Value;
			half4 _MainTex_ST;
			half4 _LineMainColor1;
			half4 _DistortTex_ST;
			half4 _MainColor;
			half _6_PannerY;
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
			half _3_Distort_DissolveTex;
			half _3_Smooth_Step;
			half _3_Opacity;
			half _SmoothStepValue2;
			half _LineSubHDR;
			half _MainColorHDR;
			half _LineMainHDR;
			half _5_Opacity;
			half _HighColorPower;
			half _HighColorHDR;
			half _1_Distort_MainTex;
			half _1_Smooth_Step;
			half _6_Rotion;
			half _1_PannerY;
			half _1_PannerX;
			half _1_RotionSpeed;
			half _1_Rotion;
			half _Distort_all;
			half _6_PannerX;
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
			sampler2D _DistortTex;
			sampler2D _DissolveTex;
			UNITY_INSTANCING_BUFFER_START(HA_CustomSd_All_Mini_DD)
				UNITY_DEFINE_INSTANCED_PROP(half, _CullMode)
				UNITY_DEFINE_INSTANCED_PROP(half, _BlendMode)
			UNITY_INSTANCING_BUFFER_END(HA_CustomSd_All_Mini_DD)


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

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

				half _CullMode_Instance = UNITY_ACCESS_INSTANCED_PROP(HA_CustomSd_All_Mini_DD,_CullMode);
				half _BlendMode_Instance = UNITY_ACCESS_INSTANCED_PROP(HA_CustomSd_All_Mini_DD,_BlendMode);
				half4 temp_cast_2 = (0.0).xxxx;
				#ifdef _USE_CUSTOM1_ON
				half4 staticSwitch480 = IN.ase_texcoord3;
				#else
				half4 staticSwitch480 = temp_cast_2;
				#endif
				half4 break481 = staticSwitch480;
				half UV1_Y486 = break481.y;
				half clampResult1131 = clamp( ( _MainColorHDR + UV1_Y486 ) , 1.0 , 999.0 );
				half4 temp_cast_3 = (0.0).xxxx;
				#ifdef _USE_CUSTOM2_ON
				half4 staticSwitch986 = IN.ase_texcoord4;
				#else
				half4 staticSwitch986 = temp_cast_3;
				#endif
				half4 break984 = staticSwitch986;
				half UV2_Z990 = break984.z;
				half temp_output_1134_0 = ( _1_Distort_MainTex + UV2_Z990 );
				half2 temp_output_68_0_g236 = IN.ase_texcoord5.xy;
				half temp_output_33_0_g236 = ( ( _6_Rotion * PI ) / -180.0 );
				half temp_output_72_0_g236 = 0.0;
				float cos41_g236 = cos( ( temp_output_33_0_g236 + temp_output_72_0_g236 ) );
				float sin41_g236 = sin( ( temp_output_33_0_g236 + temp_output_72_0_g236 ) );
				half2 rotator41_g236 = mul( temp_output_68_0_g236 - float2( 0.5,0.5 ) , float2x2( cos41_g236 , -sin41_g236 , sin41_g236 , cos41_g236 )) + float2( 0.5,0.5 );
				half clampResult46_g236 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult29_g236 = lerp( 0.0 , 0.5 , clampResult46_g236);
				half2 temp_cast_4 = (lerpResult29_g236).xx;
				half2 break648 = _DistortTex_ST.xy;
				half2 break650 = _DistortTex_ST.zw;
				half4 appendResult649 = (half4(break648.x , break648.y , break650.x , break650.y));
				half4 break63_g236 = appendResult649;
				half2 appendResult60_g236 = (half2(break63_g236.x , break63_g236.y));
				half2 CenteredUV15_g237 = ( temp_output_68_0_g236 - float2( 0.5,0.5 ) );
				half2 break37_g236 = appendResult60_g236;
				half2 break17_g237 = CenteredUV15_g237;
				half2 appendResult23_g237 = (half2(( length( CenteredUV15_g237 ) * break37_g236.x * 2.0 ) , ( atan2( break17_g237.x , break17_g237.y ) * ( 1.0 / TWO_PI ) * break37_g236.y )));
				float cos44_g236 = cos( ( temp_output_33_0_g236 + temp_output_72_0_g236 ) );
				float sin44_g236 = sin( ( temp_output_33_0_g236 + temp_output_72_0_g236 ) );
				half2 rotator44_g236 = mul( appendResult23_g237 - float2( 0.5,0.5 ) , float2x2( cos44_g236 , -sin44_g236 , sin44_g236 , cos44_g236 )) + float2( 0.5,0.5 );
				half2 temp_cast_5 = (lerpResult29_g236).xx;
				#ifdef _6_USEPOLAR_ON
				half staticSwitch647 = 1.0;
				#else
				half staticSwitch647 = 0.0;
				#endif
				half clampResult49_g236 = clamp( staticSwitch647 , 0.0 , 1.0 );
				half2 lerpResult38_g236 = lerp( ( ( rotator41_g236 - temp_cast_4 ) * appendResult60_g236 ) , ( rotator44_g236 - temp_cast_5 ) , clampResult49_g236);
				half2 appendResult61_g236 = (half2(break63_g236.z , break63_g236.w));
				half2 appendResult1291 = (half2(_6_PannerX , _6_PannerY));
				half2 break1289 = ( _TimeParameters.x * appendResult1291 );
				half2 appendResult17_g236 = (half2(break1289.x , break1289.y));
				half2 break20_g236 = ( ( ( lerpResult38_g236 + appendResult61_g236 ) + lerpResult29_g236 ) + appendResult17_g236 );
				half clampResult55_g236 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult25_g236 = lerp( break20_g236.x , saturate( break20_g236.x ) , clampResult55_g236);
				half clampResult58_g236 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult23_g236 = lerp( break20_g236.y , saturate( break20_g236.y ) , clampResult58_g236);
				half2 appendResult21_g236 = (half2(lerpResult25_g236 , lerpResult23_g236));
				half4 tex2DNode639 = tex2D( _DistortTex, appendResult21_g236 );
				half TextureDistort655 = ( tex2DNode639.r * tex2DNode639.a );
				half2 temp_cast_6 = (0.5).xx;
				half2 break1252 = ( IN.ase_texcoord5.xy - temp_cast_6 );
				half2 appendResult1255 = (half2(( temp_output_1134_0 * break1252.x ) , ( break1252.y * temp_output_1134_0 )));
				half2 lerpResult1258 = lerp( ( ( ( temp_output_1134_0 * TextureDistort655 ) + IN.ase_texcoord5.xy ) + ( temp_output_1134_0 * -0.3 ) ) , ( IN.ase_texcoord5.xy + ( appendResult1255 * TextureDistort655 ) ) , _Distort_all);
				half2 temp_output_68_0_g228 = lerpResult1258;
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
				half2 temp_cast_7 = (lerpResult29_g228).xx;
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
				half4 appendResult1439 = (half4(TillingMain1152 , OffsetMain1166));
				#ifdef _1_FOLLOWOFFSETMAIN_ON
				half4 staticSwitch1442 = appendResult1439;
				#else
				half4 staticSwitch1442 = float4( 0,0,0,0 );
				#endif
				half4 break1438 = staticSwitch1442;
				half2 appendResult1436 = (half2(break1438.x , break1438.y));
				half2 break146 = ( _MainTex_ST.xy + appendResult1436 );
				half2 appendResult1437 = (half2(break1438.z , break1438.w));
				half2 break147 = ( _MainTex_ST.zw + appendResult1437 );
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
				half2 temp_cast_8 = (lerpResult29_g228).xx;
				#ifdef _1_USEPOLAR_ON
				half staticSwitch90 = 1.0;
				#else
				half staticSwitch90 = 0.0;
				#endif
				half clampResult49_g228 = clamp( staticSwitch90 , 0.0 , 1.0 );
				half2 lerpResult38_g228 = lerp( ( ( rotator41_g228 - temp_cast_7 ) * appendResult60_g228 ) , ( rotator44_g228 - temp_cast_8 ) , clampResult49_g228);
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
				half4 temp_output_19_0_g238 = tex2D( _MainTex, appendResult21_g228 );
				half4 break5_g238 = temp_output_19_0_g238;
				half4 break18_g238 = _1_RGBA_Value;
				half temp_output_26_0_g238 = saturate( ( ( break5_g238.x * break18_g238.x ) + ( break5_g238.y * break18_g238.y ) + ( break5_g238.z * break18_g238.z ) ) );
				half3 temp_cast_10 = (temp_output_26_0_g238).xxx;
				#ifdef _1_RGB_OR_ALPHA_ON
				half staticSwitch133 = 1.0;
				#else
				half staticSwitch133 = 0.0;
				#endif
				half clampResult21_g238 = clamp( staticSwitch133 , 0.0 , 1.0 );
				half3 lerpResult16_g238 = lerp( (temp_output_19_0_g238).xyz , temp_cast_10 , clampResult21_g238);
				half3 temp_output_1042_25 = saturate( lerpResult16_g238 );
				half temp_output_23_0_g238 = _1_Smooth_Step;
				half lerpResult2_g238 = lerp( break5_g238.w , ( temp_output_26_0_g238 * break5_g238.w ) , break18_g238.w);
				half smoothstepResult13_g238 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g238 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g238);
				half lerpResult30_g238 = lerp( smoothstepResult13_g238 , lerpResult2_g238 , saturate( (0.0 + (temp_output_23_0_g238 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				half temp_output_1042_0 = saturate( lerpResult30_g238 );
				half3 lerpResult1071 = lerp( temp_output_1042_25 , ( temp_output_1042_25 * temp_output_1042_0 ) , staticSwitch133);
				half3 temp_output_5_0_g240 = ( lerpResult1071 + float3( 0,0,0 ) );
				half3 lerpResult1_g240 = lerp( ( _SubColor.rgb * _SubColorHDR ) , ( _MainColor.rgb * clampResult1131 ) , temp_output_5_0_g240);
				half clampResult1065 = clamp( _HighColorHDR , 1.0 , 999.0 );
				half3 saferPower34_g240 = abs( temp_output_5_0_g240 );
				half3 temp_cast_12 = (_HighColorPower).xxx;
				half3 lerpResult35_g240 = lerp( lerpResult1_g240 , ( _HighColor.rgb * clampResult1065 ) , saturate( abs( pow( saferPower34_g240 , temp_cast_12 ) ) ));
				half clampResult1066 = clamp( _HighColorHDR , 0.0 , 1.0 );
				half clampResult41_g240 = clamp( clampResult1066 , 0.0 , 1.0 );
				half3 lerpResult40_g240 = lerp( lerpResult1_g240 , lerpResult35_g240 , clampResult41_g240);
				half3 temp_output_1070_0 = abs( lerpResult40_g240 );
				half4 temp_output_721_0 = ( _LineMainColor1 * _LineMainHDR );
				half clampResult1433 = clamp( _LineSubHDR , 0.0 , 1.0 );
				half4 lerpResult1434 = lerp( temp_output_721_0 , ( _LineSubColor1 * _LineSubHDR ) , clampResult1433);
				half UV1_Z487 = break481.z;
				half temp_output_23_0_g239 = _3_Smooth_Step;
				half UV2_W991 = break984.w;
				half temp_output_1307_0 = ( _3_Distort_DissolveTex + UV2_W991 );
				half2 temp_output_68_0_g234 = ( ( ( temp_output_1307_0 * TextureDistort655 ) + IN.ase_texcoord5.xy ) + ( temp_output_1307_0 * -0.3 ) );
				half temp_output_33_0_g234 = ( ( _3_Rotion * PI ) / -180.0 );
				half temp_output_72_0_g234 = ( _3_RotionSpeed * _TimeParameters.x );
				float cos41_g234 = cos( ( temp_output_33_0_g234 + temp_output_72_0_g234 ) );
				float sin41_g234 = sin( ( temp_output_33_0_g234 + temp_output_72_0_g234 ) );
				half2 rotator41_g234 = mul( temp_output_68_0_g234 - float2( 0.5,0.5 ) , float2x2( cos41_g234 , -sin41_g234 , sin41_g234 , cos41_g234 )) + float2( 0.5,0.5 );
				#ifdef _3_CENTERPIVOT_ON
				half staticSwitch158 = 1.0;
				#else
				half staticSwitch158 = 0.0;
				#endif
				half clampResult46_g234 = clamp( staticSwitch158 , 0.0 , 1.0 );
				half lerpResult29_g234 = lerp( 0.0 , 0.5 , clampResult46_g234);
				half2 temp_cast_14 = (lerpResult29_g234).xx;
				half2 break163 = _DissolveTex_ST.xy;
				half2 break162 = _DissolveTex_ST.zw;
				half4 appendResult160 = (half4(break163.x , break163.y , break162.x , break162.y));
				half2 break1176 = ( _DissolveTex_ST.xy + TillingMain1152 );
				half2 break1175 = ( _DissolveTex_ST.zw + OffsetMain1166 );
				half4 appendResult1177 = (half4(break1176.x , break1176.y , break1175.x , break1175.y));
				#ifdef _3_FOLLOWOFFSETMAIN_ON
				half4 staticSwitch1180 = appendResult1177;
				#else
				half4 staticSwitch1180 = appendResult160;
				#endif
				half4 break63_g234 = staticSwitch1180;
				half2 appendResult60_g234 = (half2(break63_g234.x , break63_g234.y));
				half2 CenteredUV15_g235 = ( temp_output_68_0_g234 - float2( 0.5,0.5 ) );
				half2 break37_g234 = appendResult60_g234;
				half2 break17_g235 = CenteredUV15_g235;
				half2 appendResult23_g235 = (half2(( length( CenteredUV15_g235 ) * break37_g234.x * 2.0 ) , ( atan2( break17_g235.x , break17_g235.y ) * ( 1.0 / TWO_PI ) * break37_g234.y )));
				float cos44_g234 = cos( ( temp_output_33_0_g234 + temp_output_72_0_g234 ) );
				float sin44_g234 = sin( ( temp_output_33_0_g234 + temp_output_72_0_g234 ) );
				half2 rotator44_g234 = mul( appendResult23_g235 - float2( 0.5,0.5 ) , float2x2( cos44_g234 , -sin44_g234 , sin44_g234 , cos44_g234 )) + float2( 0.5,0.5 );
				half2 temp_cast_15 = (lerpResult29_g234).xx;
				#ifdef _3_USEPOLAR_ON
				half staticSwitch152 = 1.0;
				#else
				half staticSwitch152 = 0.0;
				#endif
				half clampResult49_g234 = clamp( staticSwitch152 , 0.0 , 1.0 );
				half2 lerpResult38_g234 = lerp( ( ( rotator41_g234 - temp_cast_14 ) * appendResult60_g234 ) , ( rotator44_g234 - temp_cast_15 ) , clampResult49_g234);
				half2 appendResult61_g234 = (half2(break63_g234.z , break63_g234.w));
				half2 appendResult1276 = (half2(_3_PannerX , _3_PannerY));
				half2 break1279 = ( _TimeParameters.x * appendResult1276 );
				half2 appendResult17_g234 = (half2(break1279.x , break1279.y));
				half2 break20_g234 = ( ( ( lerpResult38_g234 + appendResult61_g234 ) + lerpResult29_g234 ) + appendResult17_g234 );
				half clampResult55_g234 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult25_g234 = lerp( break20_g234.x , saturate( break20_g234.x ) , clampResult55_g234);
				half clampResult58_g234 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult23_g234 = lerp( break20_g234.y , saturate( break20_g234.y ) , clampResult58_g234);
				half2 appendResult21_g234 = (half2(lerpResult25_g234 , lerpResult23_g234));
				half4 temp_output_19_0_g239 = tex2D( _DissolveTex, appendResult21_g234 );
				half4 break5_g239 = temp_output_19_0_g239;
				half4 break18_g239 = _3_RGBA_Value;
				half temp_output_26_0_g239 = saturate( ( ( break5_g239.x * break18_g239.x ) + ( break5_g239.y * break18_g239.y ) + ( break5_g239.z * break18_g239.z ) ) );
				half lerpResult2_g239 = lerp( break5_g239.w , ( temp_output_26_0_g239 * break5_g239.w ) , break18_g239.w);
				half smoothstepResult13_g239 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g239 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g239);
				half lerpResult30_g239 = lerp( smoothstepResult13_g239 , lerpResult2_g239 , saturate( (0.0 + (temp_output_23_0_g239 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				half temp_output_1380_0 = ( saturate( ( _3_Opacity * saturate( lerpResult30_g239 ) ) ) + 1.0 );
				#ifdef _ALPHAFORDISSOLVE_ON
				half staticSwitch709 = (0.0 + (( 1.0 - IN.ase_color.a ) - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				#else
				half staticSwitch709 = 0.0;
				#endif
				half UV1_X485 = break481.x;
				half temp_output_1378_0 = (0.0 + (( _DissolveValue + staticSwitch709 + UV1_X485 ) - 0.0) * (( 2.0 + _LineThickness ) - 0.0) / (2.0 - 0.0));
				half clampResult33_g232 = clamp( _5_Tilling , 1.0 , 999.0 );
				half2 temp_cast_17 = (0.5).xx;
				float cos5_g232 = cos( ( ( _5_Rotion * PI ) / -180.0 ) );
				float sin5_g232 = sin( ( ( _5_Rotion * PI ) / -180.0 ) );
				half2 rotator5_g232 = mul( frac( ( IN.ase_texcoord5.xy * clampResult33_g232 ) ) - temp_cast_17 , float2x2( cos5_g232 , -sin5_g232 , sin5_g232 , cos5_g232 )) + temp_cast_17;
				half2 CenteredUV15_g233 = ( rotator5_g232 - float2( 0.5,0.5 ) );
				half2 break17_g233 = CenteredUV15_g233;
				half2 appendResult23_g233 = (half2(( length( CenteredUV15_g233 ) * 1.0 * 2.0 ) , ( atan2( break17_g233.x , break17_g233.y ) * ( 1.0 / TWO_PI ) * 1.0 )));
				#ifdef _5_USEPOLAR_ON
				half staticSwitch298 = 1.0;
				#else
				half staticSwitch298 = 0.0;
				#endif
				half clampResult23_g232 = clamp( staticSwitch298 , 0.0 , 1.0 );
				half2 lerpResult12_g232 = lerp( saturate( rotator5_g232 ) , ( 1.0 - saturate( appendResult23_g233 ) ) , clampResult23_g232);
				half temp_output_53_0_g232 = saturate( lerpResult12_g232.x );
				#ifdef _5_FLIP_ON
				half staticSwitch303 = 1.0;
				#else
				half staticSwitch303 = 0.0;
				#endif
				half clampResult21_g232 = clamp( staticSwitch303 , 0.0 , 1.0 );
				half lerpResult14_g232 = lerp( temp_output_53_0_g232 , ( 1.0 - temp_output_53_0_g232 ) , clampResult21_g232);
				half saferPower13_g232 = abs( lerpResult14_g232 );
				half temp_output_1399_0 = ( ( saturate( ( saturate( abs( pow( saferPower13_g232 , _5_PowerValue ) ) ) * _5_Opacity ) ) + 1.0 ) - temp_output_1378_0 );
				half clampResult1421 = clamp( _5_Opacity , 0.0 , 1.0 );
				half lerpResult1423 = lerp( 0.0 , temp_output_1399_0 , clampResult1421);
				half smoothstepResult1388 = smoothstep( 0.0 , ( _SmoothStepValue2 + UV1_Z487 ) , ( ( temp_output_1380_0 - ( temp_output_1378_0 - _LineThickness ) ) + lerpResult1423 ));
				half clampResult1128 = clamp( _SmoothStepValue1 , 0.001 , 1.0 );
				half lerpResult1422 = lerp( 0.0 , temp_output_1399_0 , clampResult1421);
				half smoothstepResult1384 = smoothstep( 0.0 , clampResult1128 , ( ( temp_output_1380_0 - temp_output_1378_0 ) + lerpResult1422 ));
				half4 lerpResult1404 = lerp( lerpResult1434 , temp_output_721_0 , ( smoothstepResult1388 - smoothstepResult1384 ));
				half4 lerpResult1391 = lerp( lerpResult1404 , half4( temp_output_1070_0 , 0.0 ) , saturate( smoothstepResult1384 ));
				half Line1390 = _LineThickness;
				half4 lerpResult1407 = lerp( half4( temp_output_1070_0 , 0.0 ) , lerpResult1391 , saturate( (0.0 + (Line1390 - 0.0) * (1.0 - 0.0) / (0.01 - 0.0)) ));
				
				half temp_output_828_0 = ( saturate( ( temp_output_1042_0 * smoothstepResult1388 ) ) * 1.0 );
				#ifdef _ALPHAFORDISSOLVE_ON
				half staticSwitch712 = temp_output_828_0;
				#else
				half staticSwitch712 = ( IN.ase_color.a * temp_output_828_0 );
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
			#pragma shader_feature_local _USE_CUSTOM2_ON
			#pragma shader_feature_local _6_USEPOLAR_ON
			#pragma shader_feature_local _1_CENTERPIVOT_ON
			#pragma shader_feature_local _1_FOLLOWOFFSETMAIN_ON
			#pragma shader_feature_local _TILLINGOFFSETXORY_X _TILLINGOFFSETXORY_Y
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
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			half4 _SubColor;
			half4 _3_RGBA_Value;
			half4 _DissolveTex_ST;
			half4 _LineSubColor1;
			half4 _HighColor;
			half4 _1_RGBA_Value;
			half4 _MainTex_ST;
			half4 _LineMainColor1;
			half4 _DistortTex_ST;
			half4 _MainColor;
			half _6_PannerY;
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
			half _3_Distort_DissolveTex;
			half _3_Smooth_Step;
			half _3_Opacity;
			half _SmoothStepValue2;
			half _LineSubHDR;
			half _MainColorHDR;
			half _LineMainHDR;
			half _5_Opacity;
			half _HighColorPower;
			half _HighColorHDR;
			half _1_Distort_MainTex;
			half _1_Smooth_Step;
			half _6_Rotion;
			half _1_PannerY;
			half _1_PannerX;
			half _1_RotionSpeed;
			half _1_Rotion;
			half _Distort_all;
			half _6_PannerX;
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
			sampler2D _DistortTex;
			sampler2D _DissolveTex;
			UNITY_INSTANCING_BUFFER_START(HA_CustomSd_All_Mini_DD)
				UNITY_DEFINE_INSTANCED_PROP(half, _CullMode)
				UNITY_DEFINE_INSTANCED_PROP(half, _BlendMode)
			UNITY_INSTANCING_BUFFER_END(HA_CustomSd_All_Mini_DD)


			
			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

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
				half4 ase_color : COLOR;
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

				half _CullMode_Instance = UNITY_ACCESS_INSTANCED_PROP(HA_CustomSd_All_Mini_DD,_CullMode);
				half _BlendMode_Instance = UNITY_ACCESS_INSTANCED_PROP(HA_CustomSd_All_Mini_DD,_BlendMode);
				half temp_output_23_0_g238 = _1_Smooth_Step;
				half4 temp_cast_0 = (0.0).xxxx;
				#ifdef _USE_CUSTOM2_ON
				half4 staticSwitch986 = IN.ase_texcoord2;
				#else
				half4 staticSwitch986 = temp_cast_0;
				#endif
				half4 break984 = staticSwitch986;
				half UV2_Z990 = break984.z;
				half temp_output_1134_0 = ( _1_Distort_MainTex + UV2_Z990 );
				half2 temp_output_68_0_g236 = IN.ase_texcoord3.xy;
				half temp_output_33_0_g236 = ( ( _6_Rotion * PI ) / -180.0 );
				half temp_output_72_0_g236 = 0.0;
				float cos41_g236 = cos( ( temp_output_33_0_g236 + temp_output_72_0_g236 ) );
				float sin41_g236 = sin( ( temp_output_33_0_g236 + temp_output_72_0_g236 ) );
				half2 rotator41_g236 = mul( temp_output_68_0_g236 - float2( 0.5,0.5 ) , float2x2( cos41_g236 , -sin41_g236 , sin41_g236 , cos41_g236 )) + float2( 0.5,0.5 );
				half clampResult46_g236 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult29_g236 = lerp( 0.0 , 0.5 , clampResult46_g236);
				half2 temp_cast_1 = (lerpResult29_g236).xx;
				half2 break648 = _DistortTex_ST.xy;
				half2 break650 = _DistortTex_ST.zw;
				half4 appendResult649 = (half4(break648.x , break648.y , break650.x , break650.y));
				half4 break63_g236 = appendResult649;
				half2 appendResult60_g236 = (half2(break63_g236.x , break63_g236.y));
				half2 CenteredUV15_g237 = ( temp_output_68_0_g236 - float2( 0.5,0.5 ) );
				half2 break37_g236 = appendResult60_g236;
				half2 break17_g237 = CenteredUV15_g237;
				half2 appendResult23_g237 = (half2(( length( CenteredUV15_g237 ) * break37_g236.x * 2.0 ) , ( atan2( break17_g237.x , break17_g237.y ) * ( 1.0 / TWO_PI ) * break37_g236.y )));
				float cos44_g236 = cos( ( temp_output_33_0_g236 + temp_output_72_0_g236 ) );
				float sin44_g236 = sin( ( temp_output_33_0_g236 + temp_output_72_0_g236 ) );
				half2 rotator44_g236 = mul( appendResult23_g237 - float2( 0.5,0.5 ) , float2x2( cos44_g236 , -sin44_g236 , sin44_g236 , cos44_g236 )) + float2( 0.5,0.5 );
				half2 temp_cast_2 = (lerpResult29_g236).xx;
				#ifdef _6_USEPOLAR_ON
				half staticSwitch647 = 1.0;
				#else
				half staticSwitch647 = 0.0;
				#endif
				half clampResult49_g236 = clamp( staticSwitch647 , 0.0 , 1.0 );
				half2 lerpResult38_g236 = lerp( ( ( rotator41_g236 - temp_cast_1 ) * appendResult60_g236 ) , ( rotator44_g236 - temp_cast_2 ) , clampResult49_g236);
				half2 appendResult61_g236 = (half2(break63_g236.z , break63_g236.w));
				half2 appendResult1291 = (half2(_6_PannerX , _6_PannerY));
				half2 break1289 = ( _TimeParameters.x * appendResult1291 );
				half2 appendResult17_g236 = (half2(break1289.x , break1289.y));
				half2 break20_g236 = ( ( ( lerpResult38_g236 + appendResult61_g236 ) + lerpResult29_g236 ) + appendResult17_g236 );
				half clampResult55_g236 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult25_g236 = lerp( break20_g236.x , saturate( break20_g236.x ) , clampResult55_g236);
				half clampResult58_g236 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult23_g236 = lerp( break20_g236.y , saturate( break20_g236.y ) , clampResult58_g236);
				half2 appendResult21_g236 = (half2(lerpResult25_g236 , lerpResult23_g236));
				half4 tex2DNode639 = tex2D( _DistortTex, appendResult21_g236 );
				half TextureDistort655 = ( tex2DNode639.r * tex2DNode639.a );
				half2 temp_cast_3 = (0.5).xx;
				half2 break1252 = ( IN.ase_texcoord3.xy - temp_cast_3 );
				half2 appendResult1255 = (half2(( temp_output_1134_0 * break1252.x ) , ( break1252.y * temp_output_1134_0 )));
				half2 lerpResult1258 = lerp( ( ( ( temp_output_1134_0 * TextureDistort655 ) + IN.ase_texcoord3.xy ) + ( temp_output_1134_0 * -0.3 ) ) , ( IN.ase_texcoord3.xy + ( appendResult1255 * TextureDistort655 ) ) , _Distort_all);
				half2 temp_output_68_0_g228 = lerpResult1258;
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
				half2 temp_cast_4 = (lerpResult29_g228).xx;
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
				half4 appendResult1439 = (half4(TillingMain1152 , OffsetMain1166));
				#ifdef _1_FOLLOWOFFSETMAIN_ON
				half4 staticSwitch1442 = appendResult1439;
				#else
				half4 staticSwitch1442 = float4( 0,0,0,0 );
				#endif
				half4 break1438 = staticSwitch1442;
				half2 appendResult1436 = (half2(break1438.x , break1438.y));
				half2 break146 = ( _MainTex_ST.xy + appendResult1436 );
				half2 appendResult1437 = (half2(break1438.z , break1438.w));
				half2 break147 = ( _MainTex_ST.zw + appendResult1437 );
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
				half2 lerpResult38_g228 = lerp( ( ( rotator41_g228 - temp_cast_4 ) * appendResult60_g228 ) , ( rotator44_g228 - temp_cast_5 ) , clampResult49_g228);
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
				half4 temp_output_19_0_g238 = tex2D( _MainTex, appendResult21_g228 );
				half4 break5_g238 = temp_output_19_0_g238;
				half4 break18_g238 = _1_RGBA_Value;
				half temp_output_26_0_g238 = saturate( ( ( break5_g238.x * break18_g238.x ) + ( break5_g238.y * break18_g238.y ) + ( break5_g238.z * break18_g238.z ) ) );
				half lerpResult2_g238 = lerp( break5_g238.w , ( temp_output_26_0_g238 * break5_g238.w ) , break18_g238.w);
				half smoothstepResult13_g238 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g238 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g238);
				half lerpResult30_g238 = lerp( smoothstepResult13_g238 , lerpResult2_g238 , saturate( (0.0 + (temp_output_23_0_g238 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				half temp_output_1042_0 = saturate( lerpResult30_g238 );
				half4 temp_cast_7 = (0.0).xxxx;
				#ifdef _USE_CUSTOM1_ON
				half4 staticSwitch480 = IN.ase_texcoord4;
				#else
				half4 staticSwitch480 = temp_cast_7;
				#endif
				half4 break481 = staticSwitch480;
				half UV1_Z487 = break481.z;
				half temp_output_23_0_g239 = _3_Smooth_Step;
				half UV2_W991 = break984.w;
				half temp_output_1307_0 = ( _3_Distort_DissolveTex + UV2_W991 );
				half2 temp_output_68_0_g234 = ( ( ( temp_output_1307_0 * TextureDistort655 ) + IN.ase_texcoord3.xy ) + ( temp_output_1307_0 * -0.3 ) );
				half temp_output_33_0_g234 = ( ( _3_Rotion * PI ) / -180.0 );
				half temp_output_72_0_g234 = ( _3_RotionSpeed * _TimeParameters.x );
				float cos41_g234 = cos( ( temp_output_33_0_g234 + temp_output_72_0_g234 ) );
				float sin41_g234 = sin( ( temp_output_33_0_g234 + temp_output_72_0_g234 ) );
				half2 rotator41_g234 = mul( temp_output_68_0_g234 - float2( 0.5,0.5 ) , float2x2( cos41_g234 , -sin41_g234 , sin41_g234 , cos41_g234 )) + float2( 0.5,0.5 );
				#ifdef _3_CENTERPIVOT_ON
				half staticSwitch158 = 1.0;
				#else
				half staticSwitch158 = 0.0;
				#endif
				half clampResult46_g234 = clamp( staticSwitch158 , 0.0 , 1.0 );
				half lerpResult29_g234 = lerp( 0.0 , 0.5 , clampResult46_g234);
				half2 temp_cast_8 = (lerpResult29_g234).xx;
				half2 break163 = _DissolveTex_ST.xy;
				half2 break162 = _DissolveTex_ST.zw;
				half4 appendResult160 = (half4(break163.x , break163.y , break162.x , break162.y));
				half2 break1176 = ( _DissolveTex_ST.xy + TillingMain1152 );
				half2 break1175 = ( _DissolveTex_ST.zw + OffsetMain1166 );
				half4 appendResult1177 = (half4(break1176.x , break1176.y , break1175.x , break1175.y));
				#ifdef _3_FOLLOWOFFSETMAIN_ON
				half4 staticSwitch1180 = appendResult1177;
				#else
				half4 staticSwitch1180 = appendResult160;
				#endif
				half4 break63_g234 = staticSwitch1180;
				half2 appendResult60_g234 = (half2(break63_g234.x , break63_g234.y));
				half2 CenteredUV15_g235 = ( temp_output_68_0_g234 - float2( 0.5,0.5 ) );
				half2 break37_g234 = appendResult60_g234;
				half2 break17_g235 = CenteredUV15_g235;
				half2 appendResult23_g235 = (half2(( length( CenteredUV15_g235 ) * break37_g234.x * 2.0 ) , ( atan2( break17_g235.x , break17_g235.y ) * ( 1.0 / TWO_PI ) * break37_g234.y )));
				float cos44_g234 = cos( ( temp_output_33_0_g234 + temp_output_72_0_g234 ) );
				float sin44_g234 = sin( ( temp_output_33_0_g234 + temp_output_72_0_g234 ) );
				half2 rotator44_g234 = mul( appendResult23_g235 - float2( 0.5,0.5 ) , float2x2( cos44_g234 , -sin44_g234 , sin44_g234 , cos44_g234 )) + float2( 0.5,0.5 );
				half2 temp_cast_9 = (lerpResult29_g234).xx;
				#ifdef _3_USEPOLAR_ON
				half staticSwitch152 = 1.0;
				#else
				half staticSwitch152 = 0.0;
				#endif
				half clampResult49_g234 = clamp( staticSwitch152 , 0.0 , 1.0 );
				half2 lerpResult38_g234 = lerp( ( ( rotator41_g234 - temp_cast_8 ) * appendResult60_g234 ) , ( rotator44_g234 - temp_cast_9 ) , clampResult49_g234);
				half2 appendResult61_g234 = (half2(break63_g234.z , break63_g234.w));
				half2 appendResult1276 = (half2(_3_PannerX , _3_PannerY));
				half2 break1279 = ( _TimeParameters.x * appendResult1276 );
				half2 appendResult17_g234 = (half2(break1279.x , break1279.y));
				half2 break20_g234 = ( ( ( lerpResult38_g234 + appendResult61_g234 ) + lerpResult29_g234 ) + appendResult17_g234 );
				half clampResult55_g234 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult25_g234 = lerp( break20_g234.x , saturate( break20_g234.x ) , clampResult55_g234);
				half clampResult58_g234 = clamp( 0.0 , 0.0 , 1.0 );
				half lerpResult23_g234 = lerp( break20_g234.y , saturate( break20_g234.y ) , clampResult58_g234);
				half2 appendResult21_g234 = (half2(lerpResult25_g234 , lerpResult23_g234));
				half4 temp_output_19_0_g239 = tex2D( _DissolveTex, appendResult21_g234 );
				half4 break5_g239 = temp_output_19_0_g239;
				half4 break18_g239 = _3_RGBA_Value;
				half temp_output_26_0_g239 = saturate( ( ( break5_g239.x * break18_g239.x ) + ( break5_g239.y * break18_g239.y ) + ( break5_g239.z * break18_g239.z ) ) );
				half lerpResult2_g239 = lerp( break5_g239.w , ( temp_output_26_0_g239 * break5_g239.w ) , break18_g239.w);
				half smoothstepResult13_g239 = smoothstep( 0.0 , (0.0 + (temp_output_23_0_g239 - 0.0) * (0.999 - 0.0) / (1.0 - 0.0)) , lerpResult2_g239);
				half lerpResult30_g239 = lerp( smoothstepResult13_g239 , lerpResult2_g239 , saturate( (0.0 + (temp_output_23_0_g239 - 0.999) * (1.0 - 0.0) / (1.0 - 0.999)) ));
				half temp_output_1380_0 = ( saturate( ( _3_Opacity * saturate( lerpResult30_g239 ) ) ) + 1.0 );
				#ifdef _ALPHAFORDISSOLVE_ON
				half staticSwitch709 = (0.0 + (( 1.0 - IN.ase_color.a ) - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				#else
				half staticSwitch709 = 0.0;
				#endif
				half UV1_X485 = break481.x;
				half temp_output_1378_0 = (0.0 + (( _DissolveValue + staticSwitch709 + UV1_X485 ) - 0.0) * (( 2.0 + _LineThickness ) - 0.0) / (2.0 - 0.0));
				half clampResult33_g232 = clamp( _5_Tilling , 1.0 , 999.0 );
				half2 temp_cast_11 = (0.5).xx;
				float cos5_g232 = cos( ( ( _5_Rotion * PI ) / -180.0 ) );
				float sin5_g232 = sin( ( ( _5_Rotion * PI ) / -180.0 ) );
				half2 rotator5_g232 = mul( frac( ( IN.ase_texcoord3.xy * clampResult33_g232 ) ) - temp_cast_11 , float2x2( cos5_g232 , -sin5_g232 , sin5_g232 , cos5_g232 )) + temp_cast_11;
				half2 CenteredUV15_g233 = ( rotator5_g232 - float2( 0.5,0.5 ) );
				half2 break17_g233 = CenteredUV15_g233;
				half2 appendResult23_g233 = (half2(( length( CenteredUV15_g233 ) * 1.0 * 2.0 ) , ( atan2( break17_g233.x , break17_g233.y ) * ( 1.0 / TWO_PI ) * 1.0 )));
				#ifdef _5_USEPOLAR_ON
				half staticSwitch298 = 1.0;
				#else
				half staticSwitch298 = 0.0;
				#endif
				half clampResult23_g232 = clamp( staticSwitch298 , 0.0 , 1.0 );
				half2 lerpResult12_g232 = lerp( saturate( rotator5_g232 ) , ( 1.0 - saturate( appendResult23_g233 ) ) , clampResult23_g232);
				half temp_output_53_0_g232 = saturate( lerpResult12_g232.x );
				#ifdef _5_FLIP_ON
				half staticSwitch303 = 1.0;
				#else
				half staticSwitch303 = 0.0;
				#endif
				half clampResult21_g232 = clamp( staticSwitch303 , 0.0 , 1.0 );
				half lerpResult14_g232 = lerp( temp_output_53_0_g232 , ( 1.0 - temp_output_53_0_g232 ) , clampResult21_g232);
				half saferPower13_g232 = abs( lerpResult14_g232 );
				half temp_output_1399_0 = ( ( saturate( ( saturate( abs( pow( saferPower13_g232 , _5_PowerValue ) ) ) * _5_Opacity ) ) + 1.0 ) - temp_output_1378_0 );
				half clampResult1421 = clamp( _5_Opacity , 0.0 , 1.0 );
				half lerpResult1423 = lerp( 0.0 , temp_output_1399_0 , clampResult1421);
				half smoothstepResult1388 = smoothstep( 0.0 , ( _SmoothStepValue2 + UV1_Z487 ) , ( ( temp_output_1380_0 - ( temp_output_1378_0 - _LineThickness ) ) + lerpResult1423 ));
				half temp_output_828_0 = ( saturate( ( temp_output_1042_0 * smoothstepResult1388 ) ) * 1.0 );
				#ifdef _ALPHAFORDISSOLVE_ON
				half staticSwitch712 = temp_output_828_0;
				#else
				half staticSwitch712 = ( IN.ase_color.a * temp_output_828_0 );
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
Node;AmplifyShaderEditor.CommentaryNode;1074;2086.225,-3302.749;Inherit;False;1784.468;2171.969;;13;1131;717;683;1132;715;1029;1027;1025;1070;1065;1066;175;1427;Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;423;7324.596,1003.933;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;712;7414.799,1889.773;Inherit;False;Property;_1111;1111;34;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;709;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;422;6779.539,1160.4;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;788;7046.859,1670.881;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;838;8066.022,1784.949;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1210;9986.549,1727.697;Half;False;InstancedProperty;_CullMode;Cull Mode;1;1;[Enum];Create;True;0;3;Back;1;Front;2;Off;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1212;9941.932,1908.221;Half;False;InstancedProperty;_BlendMode;Blend Mode;0;1;[Enum];Create;True;0;2;ADD;1;ADP;10;0;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;985;-8869.248,-2302.456;Inherit;False;Constant;_Float24;Float 20;64;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;725;-8890.081,-2870.63;Inherit;False;Constant;_Float20;Float 20;64;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;479;-9042.897,-2734.016;Inherit;False;1;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;1147;-7754.586,-4082.467;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1015;-7753.062,-4212.723;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1019;-7906.364,-4405.585;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1149;-7913.369,-4569.391;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;166;-6897.884,1951.827;Inherit;True;Property;_DissolveTex;DissolveTex;24;0;Create;True;1;Dissolve______________________________________________________________________________________________;0;0;True;0;False;None;49455d8fcd4975c4e934746ffb764262;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.DynamicAppendNode;1177;-8218.453,2212.264;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1175;-8471.671,2305.187;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;160;-8207.783,1875.566;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;1180;-8006.632,2025.986;Inherit;False;Property;_3_FollowOffsetMain;3_FollowOffsetMain;32;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;1173;-8955.442,2105.924;Inherit;False;1152;TillingMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1176;-8457.937,2126.027;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TextureTransformNode;161;-8958.498,1898.797;Inherit;False;166;False;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.SimpleAddOpNode;1178;-8630.021,2050.826;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1179;-8630.021,2193.826;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;162;-8441.001,1902.489;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1229;9498.361,1752.677;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1231;9498.361,1752.677;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1232;9498.361,1752.677;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1233;9498.361,1752.677;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;3;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1230;9498.361,1752.677;Half;False;True;-1;2;ASEMaterialInspector;0;13;HA_Custom/Sd_All_Mini_DD;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;1;Forward;8;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;True;True;2;True;_CullMode;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;3;True;12;all;0;True;True;2;5;False;;10;True;_BlendMode;2;5;False;;10;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalForward;False;False;0;;0;0;Standard;22;Surface;1;638313483686247703;  Blend;0;0;Two Sided;0;638313483672647531;Cast Shadows;0;638313483655181423;  Use Shadow Threshold;0;0;Receive Shadows;0;638313483637566884;GPU Instancing;1;0;LOD CrossFade;0;0;Built-in Fog;0;0;DOTS Instancing;0;0;Meta Pass;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Vertex Position,InvertActionOnDeselection;1;0;0;5;False;True;False;True;False;False;;False;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;987;-9022.063,-2165.843;Inherit;False;2;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;155;-8107.109,2785.222;Inherit;False;Constant;_Float8;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;154;-8114.31,2691.821;Inherit;False;Constant;_Float7;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;152;-7830.518,2942.518;Inherit;False;Property;_3_UsePolar;3_UsePolar;30;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;158;-7844.418,2787.418;Inherit;False;Property;_3_CenterPivot;3_CenterPivot;29;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;156;-8006.433,2374.229;Half;False;Property;_3_PannerX;3_PannerX;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;157;-8010.433,2454.229;Half;False;Property;_3_PannerY;3_PannerY;26;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1279;-7460.277,2368.457;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1277;-7613.277,2300.457;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1276;-7763.277,2346.457;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;1278;-7830.277,2221.457;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;163;-8458.267,1758.329;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;153;-7793.818,2485.458;Half;False;Property;_3_Rotion;3_Rotion;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1285;-8017.688,2592.271;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1284;-7570.688,2584.271;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1275;-7854.274,2615.314;Half;False;Property;_3_RotionSpeed;3_RotionSpeed;28;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1174;-8952.599,2282.727;Inherit;False;1166;OffsetMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1382;-2463.201,3787.892;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1377;-3014.44,3593.328;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1378;-3689.363,3413.776;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;2;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1387;-2459.498,3416.826;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1388;-2165.916,3740.698;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1384;-2175.472,3452.948;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1397;-1431.814,1193.735;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;986;-8604.064,-2196.843;Inherit;False;Property;_Use_Custom2;Use_Custom2;43;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;480;-8624.898,-2765.016;Inherit;False;Property;_Use_Custom1;Use_Custom1;42;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1156;-7266.7,-3805.668;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;1167;-7075.459,-3844.484;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1157;-7400.416,-4530.134;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;1155;-7227.2,-4491.056;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;984;-8302.064,-2195.843;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;481;-8316.897,-2763.016;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;989;-7912.106,-2148.995;Inherit;False;UV2_Y;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;988;-7878.107,-2232.995;Inherit;False;UV2_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1166;-6936.048,-3869.023;Inherit;False;OffsetMain;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1152;-7066.91,-4562.999;Inherit;False;TillingMain;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-7952.877,-2783.772;Inherit;False;UV1_Y;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-7947.877,-2673.773;Inherit;False;UV1_Z;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;485;-7964.877,-2890.773;Inherit;False;UV1_X;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;93;-2883.54,124.9828;Inherit;False;Property;_1_Rotion;1_Rotion;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;149;-2970.323,-341.9498;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;146;-3265.175,-447.4006;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;147;-3262.109,-310.942;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;1170;-3414.182,-294.9622;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1172;-3484.183,-450.9626;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1280;-2707.823,18.32436;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1281;-2860.823,-49.67567;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;658;-3320.044,-818.9005;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1134;-4085.39,-1156.767;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1259;-3093.851,-1149.778;Inherit;False;Property;_Distort_all;Distort_all;59;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1258;-2644.015,-1258.777;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1257;-3014.638,-1313.945;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1256;-3211.635,-1446.964;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;-0.3;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1255;-3376.649,-1685.648;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1251;-4342.648,-1543.648;Inherit;False;Constant;_Float9;Float 9;60;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1250;-4190.649,-1667.648;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1252;-4010.65,-1761.648;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1254;-3686.649,-1539.648;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1253;-3685.649,-1797.648;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;587;-3819.274,-762.6246;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;88;-3217.146,623.7272;Inherit;False;Constant;_Float4;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-3216.867,705.7766;Inherit;False;Constant;_Float5;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;91;-2944.941,637.9421;Inherit;False;Property;_1_ClampX;1_ClampX;17;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;92;-2931.941,783.9421;Inherit;False;Property;_1_ClampY;1_ClampY;18;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;90;-2949.941,919.9426;Inherit;False;Property;_1_UsePolar;1_UsePolar;19;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;87;-2964.841,503.8428;Inherit;False;Property;_1_CenterPivot;1_CenterPivot;16;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1349;-2803.948,306.5841;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;660;-4428.624,-1169.636;Half;False;Property;_1_Distort_MainTex;1_Distort_MainTex;51;1;[Header];Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;0;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1213;-4404.789,-1043.868;Inherit;False;990;UV2_Z;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1249;-4534.648,-1676.648;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;183;-2645.922,3096.726;Half;False;Property;_SmoothStepValue1;SmoothStepValue1;35;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1128;-2330.619,3194.878;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.001;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;828;5938.891,1883.477;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1407;6697.446,-1183.881;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1392;6684.103,-736.5789;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1375;-3785.363,3696.776;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1408;6508.404,-750.4738;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.01;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1412;-1252.815,3091.399;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1389;2306.733,3323.873;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1386;2917.644,3306.727;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;127.6104,-560.1815;Inherit;False;Constant;_Float6;Float 6;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;131.3212,-478.8634;Inherit;False;Constant;_Float2;Float 2;11;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1072;1216.56,-183.3168;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;133;279.1121,-537.0026;Inherit;False;Property;_1_RGB_or_Alpha;1_RGB_or_Alpha;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1071;1627.364,-528.572;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1372;-1569.552,25.71282;Inherit;True;Property;_TextureSample3;Texture Sample 3;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1350;-3222.234,412.0271;Half;False;Property;_1_RotionSpeed;1_RotionSpeed;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1348;-3232.948,267.5841;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1282;-3093.745,-10.05421;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-3268.078,91.37404;Half;False;Property;_1_PannerY;1_PannerY;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-3291.078,-59.62598;Half;False;Property;_1_PannerX;1_PannerX;12;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1286;-2473.031,-21.72963;Inherit;True;MF_UV_TX;-1;;228;8fdb8293e8d00da44843ff33d5199a52;0;10;68;FLOAT2;1,1;False;67;FLOAT4;1,1,0,0;False;52;FLOAT;0;False;53;FLOAT;0;False;48;FLOAT;0;False;72;FLOAT;0;False;45;FLOAT;0;False;56;FLOAT;0;False;57;FLOAT;0;False;50;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1094;-3833.803,-898.7736;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;657;-4148.024,-961.7843;Inherit;False;655;TextureDistort;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;648;-8872.182,-916.1116;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;649;-8680.898,-878.5744;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;650;-8886.114,-783.6525;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TextureTransformNode;652;-9159.613,-840.3428;Inherit;False;640;False;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.TexCoordVertexDataNode;653;-8724.444,-1191.09;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;642;-8691.627,-411.546;Half;False;Property;_6_Rotion;6_Rotion;56;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;644;-9014.419,-397.2804;Inherit;False;Constant;_Float11;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;645;-9012.419,-327.2803;Inherit;False;Constant;_Float13;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;646;-8743.228,-266.5839;Inherit;False;Property;_6_CenterPivot;6_CenterPivot;57;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;647;-8729.327,-111.4852;Inherit;False;Property;_6_UsePolar;6_UsePolar;58;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;639;-7642.363,-988.2825;Inherit;True;Property;_TextureSample0;Texture Sample 0;47;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;853;-7274.94,-779.4796;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;640;-7987.849,-1024.807;Inherit;True;Property;_DistortTex;DistortTex;53;0;Create;True;1;Dissolve______________________________________________________________________________________________;0;0;True;0;False;None;1b55cb70e9e60184c8d6f41156d9ee63;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.BreakToComponentsNode;1289;-8278.723,-526.2811;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1290;-8431.723,-594.2811;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1291;-8581.723,-548.281;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;1292;-8648.723,-673.2811;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;641;-8886.243,-543.7755;Half;False;Property;_6_PannerY;6_PannerY;55;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;643;-8881.243,-631.7755;Half;False;Property;_6_PannerX;6_PannerX;54;0;Create;True;0;0;0;False;0;False;0;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;655;-7077.99,-741.6318;Inherit;False;TextureDistort;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1401;-4429.375,4794.457;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1127;-2320.521,4107.505;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;707;-5224.573,3587.138;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;706;-5459.268,3338.146;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;710;-5031.292,3461.238;Inherit;False;Constant;_Float3;Float 3;59;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;180;-4838.632,3300.805;Half;False;Property;_DissolveValue;DissolveValue;33;0;Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;709;-4839.963,3595.402;Inherit;False;Property;_AlphaforDissolve;Alpha for Dissolve?;34;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;688;-4769.944,3823.598;Inherit;False;485;UV1_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;708;-5052.052,3580.181;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;687;-4439.117,3668.361;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1374;-4013.26,3640.148;Inherit;False;Constant;_Float23;Float 10;63;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1385;-3293.184,3656.328;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;300;-6768.424,5611.543;Inherit;False;Constant;_Float15;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;298;-6483.419,5566.145;Inherit;False;Property;_5_UsePolar;5_UsePolar;50;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;303;-6660.952,4971.903;Inherit;False;Property;_5_Flip;5_Flip;49;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;312;-5166.996,4939.103;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;302;-6945.958,5017.302;Inherit;False;Constant;_Float17;Float 5;10;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;309;-5457.952,4914.328;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;297;-6581.64,5077.386;Half;False;Property;_5_Rotion;5_Rotion;47;0;Create;True;0;0;0;False;0;False;0;-90;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;520;-6555.278,5169.076;Half;False;Property;_5_Tilling;5_Tilling;48;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;299;-6770.424,5541.542;Inherit;False;Constant;_Float12;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;301;-6947.958,4935.3;Inherit;False;Constant;_Float16;Float 4;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1195;-6101.027,4947.936;Inherit;True;MF_Gradient_Alpha;-1;;232;2615dfd5ebdde4f42b1224bd2e1e9e42;0;7;54;FLOAT2;1,1;False;19;FLOAT;1;False;20;FLOAT;0;False;24;FLOAT;0;False;30;FLOAT;0;False;62;FLOAT2;0,0;False;22;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1379;-4706.083,5005.938;Inherit;False;Constant;_Float25;Float 21;63;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1371;-4750.184,2811.328;Inherit;False;Constant;_Float22;Float 18;60;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1380;-4581.184,2685.328;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1381;-3007.499,3273.358;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1376;-4084.184,3883.805;Inherit;False;Property;_LineThickness;Line Thickness;37;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1414;6247.466,-633.986;Inherit;False;1390;Line;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1390;-3730.608,3961.02;Half;False;Line;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1129;-2549.413,4254.073;Inherit;False;487;UV1_Z;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;310;-5754.391,4653.702;Inherit;False;Property;_5_Opacity;5_Opacity;45;1;[Header];Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1422;-2977.026,4118.971;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;834;-2649.665,4114.392;Half;False;Property;_SmoothStepValue2;SmoothStepValue2;36;0;Create;True;0;0;0;False;0;False;0.2;0.132;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1391;6149.977,-930.0786;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1150;-7535.348,-4097.701;Inherit;False;Property;_TillingOffsetXorY;Tilling Offset X or Y;44;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;2;X;Y;Create;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;1151;-7699.885,-4602.205;Inherit;False;Property;_Keyword1;Keyword 0;44;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;1150;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1013;-7988.061,-4124.724;Inherit;False;989;UV2_Y;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1014;-8137.843,-4583.648;Inherit;False;988;UV2_X;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;304;-6666.271,4856.253;Half;False;Property;_5_PowerValue;5_PowerValue;46;0;Create;True;1;Gradient Alpha____________________________________________________________________________________________;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1344;-6588.792,4623.892;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1169;-3665.432,-159.1892;Inherit;False;1166;OffsetMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1424;-6440.355,5261.932;Inherit;False;1166;OffsetMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;1423;-2971.788,4318.165;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1399;-3293.925,4466.525;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1421;-3699.572,4395.651;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;176;5131.931,-137.2419;Inherit;False;Property;_LineMainColor1;LineMainColor1;38;0;Create;True;0;0;0;False;0;False;0,0,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;720;5126.605,117.261;Half;False;Property;_LineMainHDR;LineMainHDR;39;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;721;5431.939,-10.69003;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1404;5740.712,3.46237;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1097;-3635.086,-978.9667;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1096;-3044.939,-947.3016;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1306;-8321.464,1257.231;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1324;-8635.688,1224.174;Inherit;False;655;TextureDistort;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;673;-9307.197,998.4081;Half;False;Property;_3_Distort_DissolveTex;3_Distort_DissolveTex;52;0;Create;True;0;0;0;False;0;False;0;0.06;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1307;-8633.867,1030.061;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1310;-9148.268,1140.96;Inherit;False;991;UV2_W;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1425;-8154.808,1095.54;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1426;-7594.807,1376.54;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1304;-7904.708,1390.104;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1323;-8328.383,1463.27;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1288;-7258.884,2349.559;Inherit;True;MF_UV_TX;-1;;234;8fdb8293e8d00da44843ff33d5199a52;0;10;68;FLOAT2;1,1;False;67;FLOAT4;1,1,0,0;False;52;FLOAT;0;False;53;FLOAT;0;False;48;FLOAT;0;False;72;FLOAT;0;False;45;FLOAT;0;False;56;FLOAT;0;False;57;FLOAT;0;False;50;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1287;-8085.087,-570.3273;Inherit;True;MF_UV_TX;-1;;236;8fdb8293e8d00da44843ff33d5199a52;0;10;68;FLOAT2;1,1;False;67;FLOAT4;1,1,0,0;False;52;FLOAT;0;False;53;FLOAT;0;False;48;FLOAT;0;False;72;FLOAT;0;False;45;FLOAT;0;False;56;FLOAT;0;False;57;FLOAT;0;False;50;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;724;-7949.964,-2573.88;Inherit;False;UV1_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;140;-1914.049,-237.1413;Inherit;True;Property;_MainTex;MainTex;11;0;Create;True;1;Main____________________________________________________________________________________________;0;0;True;0;False;None;54291391fb9deb648be64aa3f42d9135;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;1394;-6443.668,2149.256;Inherit;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;0;False;0;False;-1;49455d8fcd4975c4e934746ffb764262;49455d8fcd4975c4e934746ffb764262;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1294;-2675.642,-1028.641;Inherit;False;DistortAll;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1042;836.4301,-174.7365;Inherit;False;MF_RGB_Alpha;-1;;238;81c413b5668b2004e8bc7cdf85fe8515;0;4;22;FLOAT;0;False;17;FLOAT4;1,1,1,0;False;19;FLOAT4;0,0,0,0;False;23;FLOAT;1;False;2;FLOAT3;25;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;315;-5326.695,2419.683;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1393;-5546.371,2295.827;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;136;291.981,-368.8658;Inherit;False;Property;_1_RGBA_Value;1_RGBA_Value;10;0;Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;1,0,0,0;1,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1428;-5919.759,2089.731;Inherit;False;MF_RGB_Alpha;-1;;239;81c413b5668b2004e8bc7cdf85fe8515;0;4;22;FLOAT;1;False;17;FLOAT4;1,1,1,0;False;19;FLOAT4;1,0,0,1;False;23;FLOAT;1;False;2;FLOAT3;25;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;130;271.3468,152.7783;Inherit;False;Property;_1_Smooth_Step;1_Smooth_Step;20;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1430;-6372.336,2620.348;Inherit;False;Property;_3_Smooth_Step;3_Smooth_Step;31;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;314;-5986.983,2508.928;Half;False;Property;_3_Opacity;3_Opacity;22;1;[Header];Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1429;-6266.899,2388.691;Inherit;False;Property;_3_RGBA_Value;3_RGBA_Value;23;0;Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;1,0,0,1;1,0,0,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1432;5158.602,314.3476;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;1433;5226.367,547.7557;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1434;5549.325,179.9044;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1435;4854.932,442.2987;Half;False;Property;_LineSubHDR;LineSubHDR;41;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1431;4860.259,188.7958;Inherit;False;Property;_LineSubColor1;LineSubColor1;40;0;Create;True;0;0;0;False;0;False;0,0,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;175;2246.499,-2617.476;Inherit;False;Property;_MainColor;MainColor;5;0;Create;True;0;0;0;False;0;False;1,1,1,1;0.8196079,0.1647059,0.2901961,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;1066;2584.679,-3039.836;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1065;2584.364,-2911.226;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;999;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1070;3587.691,-2042.618;Inherit;False;MF_Fill_3_Color;-1;;240;93b9e1825a3927840a67e57099e75cc1;0;9;54;FLOAT;1;False;33;FLOAT3;1,1,1;False;51;FLOAT;1;False;39;FLOAT;1;False;20;FLOAT3;1,1,1;False;42;FLOAT;1;False;19;FLOAT3;1,1,1;False;44;FLOAT;1;False;22;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1027;2231.125,-3019.867;Half;False;Property;_HighColorHDR;HighColorHDR;3;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1029;2311.914,-2797.916;Half;False;Property;_HighColorPower;HighColorPower;4;0;Create;True;0;0;0;False;0;False;0;0.19;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;715;2367.118,-2421.118;Half;False;Property;_MainColorHDR;MainColorHDR;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;683;2340.157,-2198.257;Inherit;False;Property;_SubColor;SubColor;7;0;Create;True;0;0;0;False;0;False;0,0,0,1;0.1137255,0.007843138,0.007843138,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;717;2369.989,-2025.267;Half;False;Property;_SubColorHDR;SubColorHDR;8;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1132;2360.121,-2309.668;Inherit;False;486;UV1_Y;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1025;2287.826,-3252.749;Inherit;False;Property;_HighColor;HighColor;2;1;[Header];Create;True;1;_________________________________________________________________________________________;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1427;2637.129,-2411.485;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1436;-4100.334,-475.1099;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1437;-4114.334,-123.1097;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1438;-4375.225,-356.8989;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;1439;-4867.836,-390.1929;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;1440;-5122.628,-338.969;Inherit;False;1166;OffsetMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1441;-5124.94,-450.3948;Inherit;False;1152;TillingMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureTransformNode;97;-3751.502,-326.1973;Inherit;False;140;False;1;0;SAMPLER2D;;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.GetLocalVarNode;1168;-3692.275,-560.9927;Inherit;False;1152;TillingMain;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;1442;-4687.56,-362.844;Inherit;False;Property;_1_FollowOffsetMain;1_FollowOffsetMain;21;0;Create;True;0;0;0;False;0;False;0;1;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;991;-7918.106,-1948.996;Inherit;False;UV2_W;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;990;-7923.106,-2061.996;Inherit;False;UV2_Z;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1131;2807.522,-2236.868;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;999;False;1;FLOAT;0
WireConnection;423;0;1407;0
WireConnection;423;1;422;0
WireConnection;712;1;788;0
WireConnection;712;0;828;0
WireConnection;788;0;422;4
WireConnection;788;1;828;0
WireConnection;838;0;712;0
WireConnection;1147;1;1013;0
WireConnection;1015;0;1013;0
WireConnection;1019;0;1014;0
WireConnection;1149;1;1014;0
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
WireConnection;1230;2;423;0
WireConnection;1230;3;838;0
WireConnection;152;1;154;0
WireConnection;152;0;155;0
WireConnection;158;1;154;0
WireConnection;158;0;155;0
WireConnection;1279;0;1277;0
WireConnection;1277;0;1278;0
WireConnection;1277;1;1276;0
WireConnection;1276;0;156;0
WireConnection;1276;1;157;0
WireConnection;163;0;161;0
WireConnection;1284;0;1275;0
WireConnection;1284;1;1285;0
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
WireConnection;986;1;985;0
WireConnection;986;0;987;0
WireConnection;480;1;725;0
WireConnection;480;0;479;0
WireConnection;1156;0;1150;0
WireConnection;1167;0;1156;0
WireConnection;1167;1;1156;1
WireConnection;1157;0;1151;0
WireConnection;1155;0;1157;1
WireConnection;1155;1;1157;0
WireConnection;984;0;986;0
WireConnection;481;0;480;0
WireConnection;989;0;984;1
WireConnection;988;0;984;0
WireConnection;1166;0;1167;0
WireConnection;1152;0;1155;0
WireConnection;486;0;481;1
WireConnection;487;0;481;2
WireConnection;485;0;481;0
WireConnection;149;0;146;0
WireConnection;149;1;146;1
WireConnection;149;2;147;0
WireConnection;149;3;147;1
WireConnection;146;0;1172;0
WireConnection;147;0;1170;0
WireConnection;1170;0;97;1
WireConnection;1170;1;1437;0
WireConnection;1172;0;97;0
WireConnection;1172;1;1436;0
WireConnection;1280;0;1281;0
WireConnection;1281;0;1348;0
WireConnection;1281;1;1282;0
WireConnection;658;0;1094;0
WireConnection;658;1;587;0
WireConnection;1134;0;660;0
WireConnection;1134;1;1213;0
WireConnection;1258;0;1096;0
WireConnection;1258;1;1257;0
WireConnection;1258;2;1259;0
WireConnection;1257;0;587;0
WireConnection;1257;1;1256;0
WireConnection;1256;0;1255;0
WireConnection;1256;1;657;0
WireConnection;1255;0;1253;0
WireConnection;1255;1;1254;0
WireConnection;1250;0;1249;0
WireConnection;1250;1;1251;0
WireConnection;1252;0;1250;0
WireConnection;1254;0;1252;1
WireConnection;1254;1;1134;0
WireConnection;1253;0;1134;0
WireConnection;1253;1;1252;0
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
WireConnection;1128;0;183;0
WireConnection;828;0;1386;0
WireConnection;1407;0;1070;0
WireConnection;1407;1;1391;0
WireConnection;1407;2;1392;0
WireConnection;1392;0;1408;0
WireConnection;1375;0;1374;0
WireConnection;1375;1;1376;0
WireConnection;1408;0;1414;0
WireConnection;1412;0;1388;0
WireConnection;1412;1;1384;0
WireConnection;1389;0;1042;0
WireConnection;1389;1;1388;0
WireConnection;1386;0;1389;0
WireConnection;1072;0;1042;25
WireConnection;1072;1;1042;0
WireConnection;133;1;135;0
WireConnection;133;0;134;0
WireConnection;1071;0;1042;25
WireConnection;1071;1;1072;0
WireConnection;1071;2;133;0
WireConnection;1372;0;140;0
WireConnection;1372;1;1286;0
WireConnection;1282;0;94;0
WireConnection;1282;1;95;0
WireConnection;1286;68;1258;0
WireConnection;1286;67;149;0
WireConnection;1286;52;1280;0
WireConnection;1286;53;1280;1
WireConnection;1286;48;93;0
WireConnection;1286;72;1349;0
WireConnection;1286;45;87;0
WireConnection;1286;56;91;0
WireConnection;1286;57;92;0
WireConnection;1286;50;90;0
WireConnection;1094;0;1134;0
WireConnection;1094;1;657;0
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
WireConnection;298;1;299;0
WireConnection;298;0;300;0
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
WireConnection;1380;0;315;0
WireConnection;1380;1;1371;0
WireConnection;1381;0;1380;0
WireConnection;1381;1;1378;0
WireConnection;1390;0;1376;0
WireConnection;1422;1;1399;0
WireConnection;1422;2;1421;0
WireConnection;1391;0;1404;0
WireConnection;1391;1;1070;0
WireConnection;1391;2;1397;0
WireConnection;1150;1;1015;0
WireConnection;1150;0;1147;0
WireConnection;1151;1;1149;0
WireConnection;1151;0;1019;0
WireConnection;1423;1;1399;0
WireConnection;1423;2;1421;0
WireConnection;1399;0;1401;0
WireConnection;1399;1;1378;0
WireConnection;1421;0;310;0
WireConnection;721;0;176;0
WireConnection;721;1;720;0
WireConnection;1404;0;1434;0
WireConnection;1404;1;721;0
WireConnection;1404;2;1412;0
WireConnection;1097;0;1134;0
WireConnection;1096;0;658;0
WireConnection;1096;1;1097;0
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
WireConnection;1287;68;653;0
WireConnection;1287;67;649;0
WireConnection;1287;52;1289;0
WireConnection;1287;53;1289;1
WireConnection;1287;48;642;0
WireConnection;1287;50;647;0
WireConnection;724;0;481;3
WireConnection;1394;0;166;0
WireConnection;1394;1;1288;0
WireConnection;1294;0;1259;0
WireConnection;1042;22;133;0
WireConnection;1042;17;136;0
WireConnection;1042;19;1372;0
WireConnection;1042;23;130;0
WireConnection;315;0;1393;0
WireConnection;1393;0;314;0
WireConnection;1393;1;1428;0
WireConnection;1428;17;1429;0
WireConnection;1428;19;1394;0
WireConnection;1428;23;1430;0
WireConnection;1432;0;1431;0
WireConnection;1432;1;1435;0
WireConnection;1433;0;1435;0
WireConnection;1434;0;721;0
WireConnection;1434;1;1432;0
WireConnection;1434;2;1433;0
WireConnection;1066;0;1027;0
WireConnection;1065;0;1027;0
WireConnection;1070;54;1066;0
WireConnection;1070;33;1025;0
WireConnection;1070;51;1065;0
WireConnection;1070;39;1029;0
WireConnection;1070;20;175;0
WireConnection;1070;42;1131;0
WireConnection;1070;19;683;0
WireConnection;1070;44;717;0
WireConnection;1070;22;1071;0
WireConnection;1427;0;715;0
WireConnection;1427;1;1132;0
WireConnection;1436;0;1438;0
WireConnection;1436;1;1438;1
WireConnection;1437;0;1438;2
WireConnection;1437;1;1438;3
WireConnection;1438;0;1442;0
WireConnection;1439;0;1441;0
WireConnection;1439;2;1440;0
WireConnection;1442;0;1439;0
WireConnection;991;0;984;3
WireConnection;990;0;984;2
WireConnection;1131;0;1427;0
ASEEND*/
//CHKSM=EAA9020C33FCA72883A622526CA59F56F670A8DF