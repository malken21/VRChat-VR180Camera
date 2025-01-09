// Made with Amplify Shader Editor v1.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Marumasa/VR180-Camera"
{
	Properties
	{
		[NoScaleOffset][SingleLineTexture]_LeftEyeL("LeftEye-L", 2D) = "black" {}
		[NoScaleOffset][SingleLineTexture]_LeftEyeR("LeftEye-R", 2D) = "black" {}
		[NoScaleOffset][SingleLineTexture]_LeftEyeUP("LeftEye-UP", 2D) = "black" {}
		[NoScaleOffset][SingleLineTexture]_LeftEyeDOWN("LeftEye-DOWN", 2D) = "black" {}
		[NoScaleOffset][SingleLineTexture]_RightEyeR("RightEye-R", 2D) = "black" {}
		[NoScaleOffset][SingleLineTexture]_RightEyeL("RightEye-L", 2D) = "black" {}
		[NoScaleOffset][SingleLineTexture]_RightEyeUP("RightEye-UP", 2D) = "black" {}
		[NoScaleOffset][SingleLineTexture]_RightEyeDOWN("RightEye-DOWN", 2D) = "black" {}
		_ScreenWidth("Screen Width", Float) = 16
		_ScreenHeight("Screen Height", Float) = 9
		[Toggle]_DebugMode("DebugMode", Float) = 0
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Overlay"  "Queue" = "Overlay+1000" "DisableBatching" = "True" "IsEmissive" = "true"  }
		Cull Front
		ZWrite On
		ZTest Always
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.5
		#define ASE_VERSION 19800
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float4 screenPos;
		};

		uniform sampler2D _LeftEyeL;
		uniform sampler2D _RightEyeL;
		uniform sampler2D _RightEyeR;
		uniform sampler2D _LeftEyeR;
		uniform sampler2D _RightEyeDOWN;
		uniform sampler2D _LeftEyeDOWN;
		uniform sampler2D _RightEyeUP;
		uniform sampler2D _LeftEyeUP;
		uniform float _DebugMode;
		uniform float _ScreenWidth;
		uniform float _ScreenHeight;
		uniform float _Cutoff = 0.5;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 ase_positionSS = float4( i.screenPos.xyz , i.screenPos.w + 1e-7 );
			float4 ase_positionSSNorm = ase_positionSS / ase_positionSS.w;
			ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
			float2 temp_cast_0 = (-UNITY_PI).xx;
			float2 temp_cast_1 = (UNITY_PI).xx;
			float2 break6 = (temp_cast_0 + ((ase_positionSSNorm).xy - float2( 0,0 )) * (temp_cast_1 - temp_cast_0) / (float2( 1,1 ) - float2( 0,0 )));
			float temp_output_7_0 = ( break6.y / 2.0 );
			float temp_output_13_0 = cos( temp_output_7_0 );
			float temp_output_8_0 = ( break6.x + radians( 45.0 ) );
			float3 appendResult15 = (float3(( temp_output_13_0 * sin( temp_output_8_0 ) ) , sin( temp_output_7_0 ) , ( temp_output_13_0 * cos( temp_output_8_0 ) )));
			float3 SphereVector18 = appendResult15;
			float3 break22 = SphereVector18;
			float3 appendResult24 = (float3(0.0 , break22.y , break22.z));
			float3 normalizeResult28 = normalize( appendResult24 );
			float dotResult33 = dot( normalizeResult28 , SphereVector18 );
			float3 appendResult25 = (float3(break22.x , break22.y , 0.0));
			float3 normalizeResult27 = normalize( appendResult25 );
			float dotResult30 = dot( normalizeResult27 , SphereVector18 );
			float3 appendResult26 = (float3(break22.x , 0.0 , break22.z));
			float3 normalizeResult29 = normalize( appendResult26 );
			float dotResult35 = dot( normalizeResult29 , SphereVector18 );
			float3 appendResult36 = (float3(dotResult33 , dotResult30 , dotResult35));
			float3 break40 = sqrt( ( 1.0 - ( appendResult36 * appendResult36 ) ) );
			float2 temp_output_48_0 = ( ( 1.0 / break40.x ) * (SphereVector18).yz );
			float2 temp_output_59_0 = saturate( (float2( 0,0 ) + (temp_output_48_0 - float2( -1,-1 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( -1,-1 ))) );
			float2 break197 = temp_output_59_0;
			float2 appendResult198 = (float2(break197.y , break197.x));
			float2 break65 = ( 1.0 - floor( temp_output_59_0 ) );
			float2 break66 = ceil( temp_output_59_0 );
			float dotResult53 = dot( SphereVector18 , float3(-1,0,0) );
			float2 temp_output_127_0 = saturate( (float2( 0,0 ) + (temp_output_48_0 - float2( -1,1 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 1,-1 ) - float2( -1,1 ))) );
			float2 break203 = temp_output_127_0;
			float2 appendResult204 = (float2(break203.y , break203.x));
			float2 break131 = ( 1.0 - floor( temp_output_127_0 ) );
			float2 break132 = ceil( temp_output_127_0 );
			float dotResult122 = dot( SphereVector18 , float3(1,0,0) );
			float2 temp_output_49_0 = ( ( 1.0 / break40.y ) * (SphereVector18).xy );
			float2 temp_output_143_0 = saturate( (float2( 0,0 ) + (temp_output_49_0 - float2( 1,-1 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( -1,1 ) - float2( 1,-1 ))) );
			float2 break147 = ( 1.0 - floor( temp_output_143_0 ) );
			float2 break148 = ceil( temp_output_143_0 );
			float dotResult138 = dot( SphereVector18 , float3(0,0,-1) );
			float2 temp_output_159_0 = saturate( (float2( 0,0 ) + (temp_output_49_0 - float2( -1,-1 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( -1,-1 ))) );
			float2 break163 = ( 1.0 - floor( temp_output_159_0 ) );
			float2 break164 = ceil( temp_output_159_0 );
			float dotResult154 = dot( SphereVector18 , float3(0,0,1) );
			float2 temp_output_50_0 = ( ( 1.0 / break40.z ) * (SphereVector18).xz );
			float2 temp_output_175_0 = saturate( (float2( 0,0 ) + (temp_output_50_0 - float2( -1,-1 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( -1,-1 ))) );
			float2 break179 = ( 1.0 - floor( temp_output_175_0 ) );
			float2 break180 = ceil( temp_output_175_0 );
			float dotResult170 = dot( SphereVector18 , float3(0,-1,0) );
			float temp_output_173_0 = saturate( ceil( dotResult170 ) );
			float temp_output_222_0 = saturate( ceil( ( -0.5 + ase_positionSSNorm.x ) ) );
			float temp_output_223_0 = ( 1.0 - temp_output_222_0 );
			float2 temp_output_191_0 = saturate( (float2( 0,0 ) + (temp_output_50_0 - float2( -1,1 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 1,-1 ) - float2( -1,1 ))) );
			float2 break195 = ( 1.0 - floor( temp_output_191_0 ) );
			float2 break196 = ceil( temp_output_191_0 );
			float dotResult186 = dot( SphereVector18 , float3(0,1,0) );
			float temp_output_189_0 = saturate( ceil( dotResult186 ) );
			o.Emission = ( ( tex2D( _LeftEyeL, appendResult198 ) * break65.x * break65.y * break66.x * break66.y * saturate( ceil( dotResult53 ) ) ) + ( tex2D( _RightEyeL, appendResult204 ) * break131.x * break131.y * break132.x * break132.y * saturate( ceil( dotResult122 ) ) ) + ( tex2D( _RightEyeR, temp_output_143_0 ) * break147.x * break147.y * break148.x * break148.y * saturate( ceil( dotResult138 ) ) ) + ( tex2D( _LeftEyeR, temp_output_159_0 ) * break163.x * break163.y * break164.x * break164.y * saturate( ceil( dotResult154 ) ) ) + ( tex2D( _RightEyeDOWN, temp_output_175_0 ) * break179.x * break179.y * break180.x * break180.y * temp_output_173_0 * temp_output_222_0 ) + ( tex2D( _LeftEyeDOWN, temp_output_175_0 ) * break179.x * break179.y * break180.x * break180.y * temp_output_173_0 * temp_output_223_0 ) + ( tex2D( _RightEyeUP, temp_output_191_0 ) * break195.x * break195.y * break196.x * break196.y * temp_output_189_0 * temp_output_222_0 ) + ( tex2D( _LeftEyeUP, temp_output_191_0 ) * break195.x * break195.y * break196.x * break196.y * temp_output_189_0 * temp_output_223_0 ) ).rgb;
			o.Alpha = 1;
			clip( min( abs( sign( ( _ScreenParams.x - _ScreenParams.y ) ) ) , (( _DebugMode )?( 1.0 ):( ( 1.0 - abs( sign( ( ( _ScreenParams.x / _ScreenParams.y ) - ( _ScreenWidth / _ScreenHeight ) ) ) ) ) )) ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19800
Node;AmplifyShaderEditor.CommentaryNode;20;-1040,-336;Inherit;False;1924;466.4518;Equirectangular Vector;17;18;8;9;14;11;7;10;13;17;16;15;5;6;3;4;1;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;1;-992,-288;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PiNode;3;-896,-112;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;2;-768,-288;Inherit;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NegateNode;4;-704,-160;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;5;-528,-208;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RadiansOpNode;9;-352,16;Inherit;False;1;0;FLOAT;45;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;6;-320,-208;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-160,-80;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;7;-160,-224;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;14;-48,-48;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;11;-48,-112;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;13;-48,-192;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;10;-48,-256;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;224,-80;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;224,-176;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;480,-272;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;309;-1538,142;Inherit;False;2420;771;Angle;29;21;22;25;26;24;27;29;259;32;260;28;30;35;33;36;37;38;39;40;308;296;307;49;50;48;45;44;46;47;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;18;640,-272;Inherit;False;SphereVector;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;-1488,528;Inherit;False;18;SphereVector;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;22;-1264,528;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;25;-1024,528;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;-1024,720;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;24;-1024,304;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;27;-880,528;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;29;-880,720;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;259;-880,608;Inherit;False;18;SphereVector;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;-880,384;Inherit;False;18;SphereVector;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;260;-880,800;Inherit;False;18;SphereVector;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;28;-880,304;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;30;-640,528;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;35;-640,720;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;33;-640,304;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;36;-448,496;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-288,496;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;38;-144,496;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SqrtOpNode;39;0,496;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;40;112,496;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;45;-16,256;Inherit;False;18;SphereVector;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;313;2686,3006;Inherit;False;1380;547;Camera Mask;14;230;274;275;263;265;276;279;231;280;282;312;283;227;228;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;68;1536,-1376;Inherit;False;986;704;Left;3;67;62;57;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;133;1536,64;Inherit;False;986;704;Right;3;136;134;135;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;308;304,400;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;296;304,496;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;307;304,592;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;44;208,192;Inherit;False;False;True;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;46;208,256;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;47;208,320;Inherit;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;62;1584,-976;Inherit;False;424;304;Mapping;2;58;59;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;135;1568,448;Inherit;False;424;304;Mapping;2;143;142;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;149;1536,784;Inherit;False;986;704;Right;2;152;150;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;151;1584,1184;Inherit;False;424;304;Mapping;2;159;158;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;165;1536,1504;Inherit;False;986;704;Up;2;168;166;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;167;1584,1904;Inherit;False;424;304;Mapping;2;175;174;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;181;1536,2224;Inherit;False;986;704;Down;2;184;182;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;183;1584,2624;Inherit;False;424;304;Mapping;2;191;190;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;224;1600,3008;Inherit;False;836;259;LR Mask;5;219;220;221;222;223;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;117;1536,-656;Inherit;False;986;704;Left;4;120;118;127;126;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;704,496;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;704,592;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;704,400;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenParams;230;2736,3136;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;274;2736,3360;Inherit;False;Property;_ScreenWidth;Screen Width;8;0;Create;True;0;0;0;False;0;False;16;16;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;275;2736,3440;Inherit;False;Property;_ScreenHeight;Screen Height;9;0;Create;True;0;0;0;False;0;False;9;9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;58;1632,-928;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;-1,-1;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;126;1632,-208;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;-1,1;False;2;FLOAT2;1,-1;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;136;1584,112;Inherit;False;744;331;Direction Mask;5;141;140;139;138;137;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;142;1616,496;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;1,-1;False;2;FLOAT2;-1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;152;1584,832;Inherit;False;744;331;Direction Mask;5;157;156;155;154;153;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;158;1632,1232;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;-1,-1;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;168;1584,1552;Inherit;False;744;331;Direction Mask;5;173;172;171;170;169;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;174;1632,1952;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;-1,-1;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;184;1584,2272;Inherit;False;744;331;Direction Mask;5;189;188;187;186;185;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;190;1632,2672;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;-1,1;False;2;FLOAT2;1,-1;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;219;1648,3056;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;120;1584,-608;Inherit;False;744;331;Direction Mask;5;125;124;123;122;121;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;57;1584,-1328;Inherit;False;744;331;Direction Mask;5;52;53;54;55;56;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;263;2992,3264;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;265;2992,3360;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;67;2016,-976;Inherit;False;452;283;Mapping Mask;5;60;61;63;65;66;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;118;2016,-256;Inherit;False;452;283;Mapping Mask;5;132;131;130;129;128;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;59;1808,-928;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;127;1808,-208;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;134;2016,464;Inherit;False;452;283;Mapping Mask;5;148;147;146;145;144;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;137;1632,160;Inherit;False;18;SphereVector;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;139;1648,256;Inherit;False;Constant;_Vector2;Vector 0;0;0;Create;True;0;0;0;False;0;False;0,0,-1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;143;1792,496;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;150;2016,1184;Inherit;False;452;283;Mapping Mask;5;164;163;162;161;160;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;1632,880;Inherit;False;18;SphereVector;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;155;1648,976;Inherit;False;Constant;_Vector3;Vector 0;0;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;159;1808,1232;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;166;2016,1904;Inherit;False;452;283;Mapping Mask;5;180;179;178;177;176;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;169;1632,1600;Inherit;False;18;SphereVector;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;171;1648,1696;Inherit;False;Constant;_Vector4;Vector 0;0;0;Create;True;0;0;0;False;0;False;0,-1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;182;2016,2624;Inherit;False;452;283;Mapping Mask;5;196;195;194;193;192;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;185;1632,2320;Inherit;False;18;SphereVector;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;191;1808,2672;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;187;1648,2416;Inherit;False;Constant;_Vector5;Vector 0;0;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;220;1888,3056;Inherit;False;2;2;0;FLOAT;-0.5;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;175;1808,1952;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;121;1632,-560;Inherit;False;18;SphereVector;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;123;1648,-464;Inherit;False;Constant;_Vector1;Vector 0;0;0;Create;True;0;0;0;False;0;False;1,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;52;1632,-1280;Inherit;False;18;SphereVector;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;54;1648,-1184;Inherit;False;Constant;_Vector0;Vector 0;0;0;Create;True;0;0;0;False;0;False;-1,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;276;3136,3264;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;60;2080,-928;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FloorOpNode;128;2080,-208;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;197;2592,-1376;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DotProductOpNode;138;1872,160;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;144;2080,512;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DotProductOpNode;154;1872,880;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;160;2080,1232;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DotProductOpNode;170;1872,1600;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;176;2080,1952;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DotProductOpNode;186;1872,2320;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;192;2080,2672;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CeilOpNode;221;2000,3056;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;203;2592,-656;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DotProductOpNode;122;1872,-560;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;53;1872,-1280;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SignOpNode;279;3280,3264;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;63;2192,-928;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CeilOpNode;129;2080,-112;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;130;2192,-208;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;198;2720,-1376;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CeilOpNode;140;2000,160;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;145;2080,608;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;146;2192,512;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CeilOpNode;156;2000,880;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;161;2080,1328;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;162;2192,1232;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CeilOpNode;172;2000,1600;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;177;2080,2048;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;178;2192,1952;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CeilOpNode;188;2000,2320;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;193;2080,2768;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;194;2192,2672;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;222;2112,3056;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;204;2720,-656;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CeilOpNode;124;2000,-560;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;61;2080,-832;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CeilOpNode;55;2000,-1280;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;231;2992,3056;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;280;3392,3264;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;65;2336,-928;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;131;2336,-208;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;132;2336,-112;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;200;2880,-1376;Inherit;True;Property;_LeftEyeL;LeftEye-L;0;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;cffb75c011450ea44b7db3cce3ae0144;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.BreakToComponentsNode;147;2336,512;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;148;2336,608;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SaturateNode;157;2128,880;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;163;2336,1232;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;164;2336,1328;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SaturateNode;173;2128,1600;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;179;2336,1952;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;180;2336,2048;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;209;2592,1504;Inherit;True;Property;_RightEyeDOWN;RightEye-DOWN;7;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;5cf7cdc5f38bd154dbb7a7bd1a7acfde;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SaturateNode;189;2128,2320;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;196;2336,2768;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;195;2336,2672;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.OneMinusNode;223;2256,3056;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;211;2592,1728;Inherit;True;Property;_LeftEyeDOWN;LeftEye-DOWN;3;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;06bb8d35c64056144aca2d74de7d7718;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;210;2592,2224;Inherit;True;Property;_RightEyeUP;RightEye-UP;6;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;0afd259467229cd479ac79ff774459f6;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;212;2592,2448;Inherit;True;Property;_LeftEyeUP;LeftEye-UP;2;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;891716875c53bbb4ab2ed04c360a6006;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;208;2592,784;Inherit;True;Property;_LeftEyeR;LeftEye-R;1;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;6655fc6f40e6b0d4695dbfab498f1543;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;201;2592,64;Inherit;True;Property;_RightEyeR;RightEye-R;4;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;58b09c22434375a44bce22390c8452ac;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;207;2880,-656;Inherit;True;Property;_RightEyeL;RightEye-L;5;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;9247bded2c17a9141b78b320caa9dfef;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SaturateNode;141;2128,160;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;125;2128,-560;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;66;2336,-832;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SaturateNode;56;2128,-1280;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SignOpNode;282;3136,3056;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;312;3504,3264;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;233;3790,606;Inherit;False;532;523;Output;2;206;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;202;3200,-1376;Inherit;True;6;6;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;213;3200,64;Inherit;True;6;6;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;214;3200,784;Inherit;True;6;6;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;215;3200,1504;Inherit;True;7;7;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;218;3200,2448;Inherit;True;7;7;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;216;3200,1728;Inherit;True;7;7;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;217;3200,2224;Inherit;True;7;7;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;205;3200,-656;Inherit;True;6;6;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.AbsOpNode;283;3248,3056;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;227;3664,3264;Inherit;False;Property;_DebugMode;DebugMode;10;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;206;3840,704;Inherit;True;8;8;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMinOpNode;228;3920,3056;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;4048,656;Float;False;True;-1;3;ASEMaterialInspector;0;0;Unlit;Marumasa/VR180-Camera;False;False;False;False;True;True;True;True;True;True;True;True;False;True;False;False;False;False;False;False;False;Front;1;False;;7;False;;False;0;False;;0;False;;False;0;Custom;0.5;True;True;1000;True;Overlay;;Overlay;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;11;-1;-1;-1;0;False;0;0;False;;-1;0;False;_MaskClip;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;119;1584,-256;Inherit;False;424;304;Mapping;0;;1,1,1,1;0;0
WireConnection;2;0;1;0
WireConnection;4;0;3;0
WireConnection;5;0;2;0
WireConnection;5;3;4;0
WireConnection;5;4;3;0
WireConnection;6;0;5;0
WireConnection;8;0;6;0
WireConnection;8;1;9;0
WireConnection;7;0;6;1
WireConnection;14;0;8;0
WireConnection;11;0;8;0
WireConnection;13;0;7;0
WireConnection;10;0;7;0
WireConnection;17;0;13;0
WireConnection;17;1;14;0
WireConnection;16;0;13;0
WireConnection;16;1;11;0
WireConnection;15;0;16;0
WireConnection;15;1;10;0
WireConnection;15;2;17;0
WireConnection;18;0;15;0
WireConnection;22;0;21;0
WireConnection;25;0;22;0
WireConnection;25;1;22;1
WireConnection;26;0;22;0
WireConnection;26;2;22;2
WireConnection;24;1;22;1
WireConnection;24;2;22;2
WireConnection;27;0;25;0
WireConnection;29;0;26;0
WireConnection;28;0;24;0
WireConnection;30;0;27;0
WireConnection;30;1;259;0
WireConnection;35;0;29;0
WireConnection;35;1;260;0
WireConnection;33;0;28;0
WireConnection;33;1;32;0
WireConnection;36;0;33;0
WireConnection;36;1;30;0
WireConnection;36;2;35;0
WireConnection;37;0;36;0
WireConnection;37;1;36;0
WireConnection;38;0;37;0
WireConnection;39;0;38;0
WireConnection;40;0;39;0
WireConnection;308;1;40;0
WireConnection;296;1;40;1
WireConnection;307;1;40;2
WireConnection;44;0;45;0
WireConnection;46;0;45;0
WireConnection;47;0;45;0
WireConnection;49;0;296;0
WireConnection;49;1;46;0
WireConnection;50;0;307;0
WireConnection;50;1;47;0
WireConnection;48;0;308;0
WireConnection;48;1;44;0
WireConnection;58;0;48;0
WireConnection;126;0;48;0
WireConnection;142;0;49;0
WireConnection;158;0;49;0
WireConnection;174;0;50;0
WireConnection;190;0;50;0
WireConnection;263;0;230;1
WireConnection;263;1;230;2
WireConnection;265;0;274;0
WireConnection;265;1;275;0
WireConnection;59;0;58;0
WireConnection;127;0;126;0
WireConnection;143;0;142;0
WireConnection;159;0;158;0
WireConnection;191;0;190;0
WireConnection;220;1;219;1
WireConnection;175;0;174;0
WireConnection;276;0;263;0
WireConnection;276;1;265;0
WireConnection;60;0;59;0
WireConnection;128;0;127;0
WireConnection;197;0;59;0
WireConnection;138;0;137;0
WireConnection;138;1;139;0
WireConnection;144;0;143;0
WireConnection;154;0;153;0
WireConnection;154;1;155;0
WireConnection;160;0;159;0
WireConnection;170;0;169;0
WireConnection;170;1;171;0
WireConnection;176;0;175;0
WireConnection;186;0;185;0
WireConnection;186;1;187;0
WireConnection;192;0;191;0
WireConnection;221;0;220;0
WireConnection;203;0;127;0
WireConnection;122;0;121;0
WireConnection;122;1;123;0
WireConnection;53;0;52;0
WireConnection;53;1;54;0
WireConnection;279;0;276;0
WireConnection;63;0;60;0
WireConnection;129;0;127;0
WireConnection;130;0;128;0
WireConnection;198;0;197;1
WireConnection;198;1;197;0
WireConnection;140;0;138;0
WireConnection;145;0;143;0
WireConnection;146;0;144;0
WireConnection;156;0;154;0
WireConnection;161;0;159;0
WireConnection;162;0;160;0
WireConnection;172;0;170;0
WireConnection;177;0;175;0
WireConnection;178;0;176;0
WireConnection;188;0;186;0
WireConnection;193;0;191;0
WireConnection;194;0;192;0
WireConnection;222;0;221;0
WireConnection;204;0;203;1
WireConnection;204;1;203;0
WireConnection;124;0;122;0
WireConnection;61;0;59;0
WireConnection;55;0;53;0
WireConnection;231;0;230;1
WireConnection;231;1;230;2
WireConnection;280;0;279;0
WireConnection;65;0;63;0
WireConnection;131;0;130;0
WireConnection;132;0;129;0
WireConnection;200;1;198;0
WireConnection;147;0;146;0
WireConnection;148;0;145;0
WireConnection;157;0;156;0
WireConnection;163;0;162;0
WireConnection;164;0;161;0
WireConnection;173;0;172;0
WireConnection;179;0;178;0
WireConnection;180;0;177;0
WireConnection;209;1;175;0
WireConnection;189;0;188;0
WireConnection;196;0;193;0
WireConnection;195;0;194;0
WireConnection;223;0;222;0
WireConnection;211;1;175;0
WireConnection;210;1;191;0
WireConnection;212;1;191;0
WireConnection;208;1;159;0
WireConnection;201;1;143;0
WireConnection;207;1;204;0
WireConnection;141;0;140;0
WireConnection;125;0;124;0
WireConnection;66;0;61;0
WireConnection;56;0;55;0
WireConnection;282;0;231;0
WireConnection;312;0;280;0
WireConnection;202;0;200;0
WireConnection;202;1;65;0
WireConnection;202;2;65;1
WireConnection;202;3;66;0
WireConnection;202;4;66;1
WireConnection;202;5;56;0
WireConnection;213;0;201;0
WireConnection;213;1;147;0
WireConnection;213;2;147;1
WireConnection;213;3;148;0
WireConnection;213;4;148;1
WireConnection;213;5;141;0
WireConnection;214;0;208;0
WireConnection;214;1;163;0
WireConnection;214;2;163;1
WireConnection;214;3;164;0
WireConnection;214;4;164;1
WireConnection;214;5;157;0
WireConnection;215;0;209;0
WireConnection;215;1;179;0
WireConnection;215;2;179;1
WireConnection;215;3;180;0
WireConnection;215;4;180;1
WireConnection;215;5;173;0
WireConnection;215;6;222;0
WireConnection;218;0;212;0
WireConnection;218;1;195;0
WireConnection;218;2;195;1
WireConnection;218;3;196;0
WireConnection;218;4;196;1
WireConnection;218;5;189;0
WireConnection;218;6;223;0
WireConnection;216;0;211;0
WireConnection;216;1;179;0
WireConnection;216;2;179;1
WireConnection;216;3;180;0
WireConnection;216;4;180;1
WireConnection;216;5;173;0
WireConnection;216;6;223;0
WireConnection;217;0;210;0
WireConnection;217;1;195;0
WireConnection;217;2;195;1
WireConnection;217;3;196;0
WireConnection;217;4;196;1
WireConnection;217;5;189;0
WireConnection;217;6;222;0
WireConnection;205;0;207;0
WireConnection;205;1;131;0
WireConnection;205;2;131;1
WireConnection;205;3;132;0
WireConnection;205;4;132;1
WireConnection;205;5;125;0
WireConnection;283;0;282;0
WireConnection;227;0;312;0
WireConnection;206;0;202;0
WireConnection;206;1;205;0
WireConnection;206;2;213;0
WireConnection;206;3;214;0
WireConnection;206;4;215;0
WireConnection;206;5;216;0
WireConnection;206;6;217;0
WireConnection;206;7;218;0
WireConnection;228;0;283;0
WireConnection;228;1;227;0
WireConnection;0;2;206;0
WireConnection;0;10;228;0
ASEEND*/
//CHKSM=4CCB52BB7C6A07DDC45C9E932E731572B20C040F