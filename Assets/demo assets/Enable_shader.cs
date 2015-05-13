using UnityEngine;
using System.Collections;

public class Enable_shader : MonoBehaviour {
	
	private bool toggleRim = true;
    private bool toggleOutline = true;

	private float myOutline;
	private float myRim;
	private Color rimColor;
	
	public Material rimMat;
	
	
	void Start(){
		myOutline = rimMat.GetFloat("_Outline");
		myRim = rimMat.GetFloat("_RimPower");
		rimColor = rimMat.GetColor("_RimColor");	
	}

 	void OnGUI() {
	    toggleRim = GUI.Toggle(new Rect(10, 10, 100, 30), toggleRim, "RimLight");	
		toggleOutline = GUI.Toggle(new Rect(10, 40, 100, 30), toggleOutline, "Outline");
    }
	
	// Update is called once per frame
	void Update () {
		if(toggleRim){
			rimMat.SetFloat("_RimPower", myRim);
			rimMat.SetColor("_RimColor", rimColor);
		}
		else{
			rimMat.SetFloat("_RimPower", 10);
			rimMat.SetColor("_RimColor", Color.black);
		}
		
		if(toggleOutline)
			rimMat.SetFloat("_Outline", myOutline);
		else
			rimMat.SetFloat("_Outline", 0);
	}
}
