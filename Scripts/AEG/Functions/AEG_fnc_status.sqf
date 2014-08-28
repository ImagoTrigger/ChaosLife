/*
	File: AEG_fnc_status.sqf
	Version: 1.01
	Author: Loyalguard

	Description:
	A function to update grid information in the AEG_System dialog.

	Parameters:
	None.
	
	Execution:
	Loaded into memory by AEG_controls.sqf (and only once per mission per client as detemined by the GV AEG_controls).  Function called by interaction with dialog controls or other UI events.
*/

// Create a function that will update the status of all of the grid nodes (called once every second by a loop in AEG_system.sqf).
AEG_fnc_status =
{
	// Scope //
	private ["_controls"];

	// Create an array of the pertinent variable pointers and their corresponding on screen indicators (controls).
	_controls = 
	[
		[AEG_on_D_Bere, 20710],
		[AEG_on_D_Cher, 20711],
		[AEG_on_D_SZag, 20712],
		[AEG_on_D_Soln, 20713],
		[AEG_on_D_Zele, 20714],
		[AEG_on_P_Cher, 20715],
		[AEG_on_P_Elek, 20716],
		[AEG_on_T_Cher_1, 20717],
		[AEG_on_T_Elek_1, 20718],
		[AEG_on_T_Elek_2, 20719],
		[AEG_on_D_Elek, 20720],
		[AEG_on_T_SZag_1, 20721],
		[AEG_on_T_SZag_2, 20722],
		[AEG_on_T_SZag_3, 20723],
		[AEG_on_T_Zele_1, 20724],
		[AEG_on_T_Zele_2, 20725]		
	];

	// If power is on, turn the indicator green.  If off then turn it red.
	{
		If ((_x select 0)) then
		{
			with uiNamespace do {(findDisplay 20700 displayCtrl (_x select 1)) ctrlSetBackgroundColor [0, 1, 0, 1];}; // Green
		}
		else
		{
			with uiNamespace do {(findDisplay 20700 displayCtrl (_x select 1)) ctrlSetBackgroundColor [1, 0, 0, 1];}; // Red
		};	
	} forEach _controls;
}; 