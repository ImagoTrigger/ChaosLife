/*
	File: AEG_fnc_video.sqf
	Version: 1.01
	Author: Loyalguard

	Description:
	A function to populate information into the AEG_Video dialog.

	Parameters:
	_this select 0: The substation corresponding to the camera (string).
	
	Execution:
	Loaded into memory by AEG_controls.sqf (and only once per mission per client as detemined by the GV AEG_controls).  Function called by interaction with dialog controls or other UI events.
*/

// Create a function that will switch the current video view to the corresponding button pressed in the AEG Video dialog.
AEG_fnc_video = 
{
	// Scope //
	private ["_sub", "_camTarget", "_camPos", "_camFOV", "_label"];
	
	// Parameter(s) //
	_sub = _this select 0;
	
	// Determine which camera to create and switch to.
	switch (_sub) do
	{
		case "P_Elek":
		{
			_camTarget =  [109647.73,-9756.41,6.89];
			_camPos =  [10418.75,2637.61,3.17];
			_camFOV =  0.700;
			_label = "Cam 01 - Elektrovadosk Power Plant";
		};	
	
		case "SZag":
		{
			_camTarget =  [91258.86,-48171.19,-7230.62];
			_camPos =  [5651.04,2991.91,4.39];
			_camFOV =  0.871;
			_label = "Cam 02 - South Zagoria Regional Substation";
		};	
		
		case "Soln":
		{
			_camTarget =  [-86451.16,-5957.63,-217.65];
			_camPos =  [12805.46,6212.99,3.15];
			_camFOV =  0.700;
			_label = "Cam 03 - Solnichniy Distribution Substation";
		};	
		
		case "D_Cher":
		{
			_camTarget =  [87210.31,61140.95,7.73];
			_camPos =  [6237.09,2460.98,2.26];
			_camFOV =  0.942;
			_label = "Cam 04 - Chernogorsk Distribution Substation";
		};	
		
		case "P_Cher":
		{
			_camTarget =  [102353.55,-25260.80,7.51];
			_camPos =  [6194.80,2189.06,3.40];
			_camFOV =  0.700;
			_label = "Cam 05 - Chernogorsk Power Plant";
		};	
	
		case "Zele":
		{
			_camTarget =  [-60075.76,82813.73,9020.17];
			_camPos =  [2298.12,5210.53,7.72];
			_camFOV =  0.700;
			_label = "Cam 06 - Zelenogorsk Substation";	
		};	
		
		case "Bere":
		{
			_camTarget =  [-78120.11,51323.38,-428.73];
			_camPos =  [12882.55,9868.40,3.17];
			_camFOV =  0.700;
			_label = "Cam 07 - Berezino Substation";	
		};	
	}; //end switch-do

	// Create and switch to the camera determined above.
	titlecut [" ","BLACK IN",.5];
	AEG_video = "camera" camcreate [0,0,0];
	AEG_video cameraEffect ["internal", "back"];
	AEG_video camPrepareTarget _camTarget;
	AEG_video camPreparePos _camPos;
	AEG_video camPrepareFOV _camFOV;
	AEG_video camCommitPrepared 0;
	waitUntil {camCommitted AEG_video};
	
	// Allow momentary pause for showCinemaBorder false to take effect.
	sleep .01;
	showCinemaBorder false;
	
	// If enabled by the mission maker, allow the camera to use NVG during set hours.  Default hours are between 1900-0600 unless changed by mission maker using AEG_dark and AEG_light.
	if ((AEG_NVG) and ((daytime > AEG_dark) or (daytime < AEG_light))) then {camUseNVG true};
	
	// Update the on screen label displaying the name of the active camera.
	with uiNamespace do {(findDisplay 20800 displayCtrl 20802) ctrlSetText _label;};

	// Apply "video" effects to the camera picture.
	"filmGrain" ppEffectEnable true; 
	"FilmGrain" ppEffectAdjust [0.05, 0.9, 0, 0.61, 0.39, true];
	"filmGrain" ppEffectCommit 0;
};