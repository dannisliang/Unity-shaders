//Shader Mirror - Created by Benjamin Robert - All rights reserved
//Burden - Episode 0

Shader "BurdenShaders/Ghost" {
   Properties {
    _Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)
	_BumpMap ("Normal Map", 2D) = "bump" {}
	_RimColor ("Emissive Color", Color) = (0.3,0.2,0.15,1.0)
    _RimPower ("Emissive Power", Range(0.3,10.0)) = 3.0
  }
  SubShader {
    Tags { "Queue"="Transparent"
			"IgnoreProjector"="True"
			"RenderType"="Transparent" 
	}
    Blend SrcAlpha OneMinusSrcAlpha
    LOD 300
 
    CGPROGRAM
    #pragma surface surf BlinnPhong 
 
    fixed4 _Color;
 	sampler2D _BumpMap;
 	float4 _RimColor;
 	float _RimPower;	

    struct Input {
      float2 uv_MainTex;
      float2 uv_BumpMap;
      float3 viewDir;
    };
 
    void surf (Input IN, inout SurfaceOutput o) {
      o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));
      half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
      o.Albedo = _Color.rgb * pow (rim, _RimPower);
	  o.Emission = _RimColor.rgb * pow (rim, _RimPower);
      o.Alpha = _Color.a;
    }
    ENDCG
  } 
  FallBack "Diffuse"
}