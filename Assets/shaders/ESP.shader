//Shader Mirror - Created by Benjamin Robert - All rights reserved
//Burden - Episode 0

Shader "BurdenShaders/ESP" {

    Properties {
      _MainTex ("Diffuse Map", 2D) = "white" {}
      _SliceGuide ("Dissolve Map", 2D) = "white" {}
      _SliceAmount ("Dissolve Range", Range(0.0, 1.0)) = 0.5
      _RimColor ("Emissive Color", Color) = (0.3,0.2,0.15,1.0)
      _RimPower ("Emissive Power", Range(0.0,1.0)) = .3
    }
    SubShader {
      Tags { "RenderType" = "Transparent" }
      Blend SrcAlpha OneMinusSrcAlpha
     // Cull Off
      
      CGPROGRAM
      #pragma surface surf Lambert addshadow
      
      struct Input {
          float2 uv_MainTex;
          float2 uv_SliceGuide;
          float _SliceAmount;
          float3 viewDir;
      };
      
      sampler2D _MainTex;
      sampler2D _SliceGuide;
      float _SliceAmount;
      float4 _RimColor;
 	  float _RimPower;

      
      void surf (Input IN, inout SurfaceOutput o) {
          clip(tex2D (_SliceGuide, IN.uv_SliceGuide).rgb - _SliceAmount);
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
          half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
	 	  o.Emission = _RimColor.rgb * pow (rim, _RimPower);
    	  o.Alpha = _RimColor.a;
      }
      
      ENDCG
    } 
    Fallback "Diffuse"
  }
