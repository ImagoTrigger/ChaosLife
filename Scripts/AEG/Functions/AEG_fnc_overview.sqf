/*
	File: AEG_fnc_overview.sqf
	Version: 1.01
	Author: Loyalguard

	Description:
	A function to populate grid information into the AEG_System dialog.

	Parameters:
	None.
	
	Execution:
	Loaded into memory by AEG_controls.sqf (and only once per mission per client as detemined by the GV AEG_controls).  Function called by interaction with dialog controls or other UI events.
*/

// Create a function to give an overview of the system in the text area on the right of the screen.
AEG_fnc_overview = 
{
	// Scope //
	private ["_output"];
	
	// Create a default structured text giving an overview of the system dialog.
	_output = composeText
	[
		"OVERVIEW:",lineBreak,lineBreak,
		"Welcome to the Chernarus Electrical Grid Transmission and Distribution System!", lineBreak, lineBreak,
		"The status of each node of the grid is displayed on screen.  Green indicates the node is online. Red indicates offline.", lineBreak, lineBreak,
		"Click on the name of each node to view additional information about it and control connectivity."
	];
	
	// Display the text.
	with uiNamespace do {(findDisplay 20700 displayCtrl 20702) ctrlSetStructuredText _output;};	
};