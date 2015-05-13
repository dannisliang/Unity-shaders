//Shader Mirror - Created by Benjamin Robert - All rights reserved
//Burden - Episode 0

Shader "BurdenShaders/Mirror" { 
	Properties {
	    _MainTex ("Diffuse Map", 2D) = "white" {}
	    _ReflectionTex ("Reflection Map", 2D) = "white" { TexGen ObjectLinear }
	}
	
	Subshader { 
	    Pass {
	        SetTexture[_MainTex] { combine texture }
	        SetTexture[_ReflectionTex] { matrix [_ProjMatrix] combine texture * previous }
	    }
	}
	
	Subshader {
	    Pass {
	        SetTexture [_MainTex] { combine texture }
	    }
	}

}
