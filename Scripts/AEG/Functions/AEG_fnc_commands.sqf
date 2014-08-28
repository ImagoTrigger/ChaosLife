/*
	File: AEG_fnc_commands.sqf
	Version: 1.01
	Author: Loyalguard

	Description:
	A function to execute commands to remotely control power status in the AEG_System dialog.

	Parameters:
	_this select 0: The pertinent AEG object (string).
	
	Execution:
	Loaded into memory by AEG_controls.sqf (and only once per mission per client as detemined by the GV AEG_controls).  Function called by interaction with dialog controls or other UI events.
*/

// Create a function to give the connect and disconnect buttons the ability to connect ot disconnect a node after the user clicks on the node's name on the screen.
AEG_fnc_commands = 
{
	// Scope//
	private ["_name", "_outStr", "_logicStr"];

	// Parameter(s) //
   	 _name = (_this select 0);
     
     // Determine the game logic co-located with the AEG object at this location.
	_outStr = (format ["AEG_out_%1", _name]);
    _logicStr = (format ["AEG_logic_%1", _name]);
	
	// Call the node function to populate the information area of the screen with node specific information.	
	[_name] call AEG_fnc_node;
	
	// Disable the "Connect" and "Disconnect" and remove any action previously assigned to them.
	with uiNamespace do {(findDisplay 20700 displayCtrl 20703) ctrlEnable false;};	
	with uiNamespace do {(findDisplay 20700 displayCtrl 20703) buttonSetAction "";};	
	with uiNamespace do {(findDisplay 20700 displayCtrl 20704) ctrlEnable false;};
	with uiNamespace do {(findDisplay 20700 displayCtrl 20704) buttonSetAction "";};

	// If the object is NOT operational then exit immediately.
	if (!(missionNameSpace getVariable format ["AEG_op_%1", _name])) exitWith{};
	
	// If the power out state of the object is "on" then enable the "Disconnect" button and give it the action to turn power off.  If it is "off" then enable the "Connect" button give it the action to turn power on.  If the button is clicked the appropriate code will be run.
	if  ((missionNameSpace getVariable _outStr)) then
    {       
       	with uiNamespace do {(findDisplay 20700 displayCtrl 20704) ctrlEnable true;};
		with uiNamespace do {(findDisplay 20700 displayCtrl 20704) buttonSetAction (format 
		[
			"
				missionNameSpace setVariable [""%1"", false];
				publicVariable ""%1"";
				if ((""%2"" == ""AEG_logic_P_Elek"") or (""%2"" == ""AEG_logic_P_Cher"")) then {} else {%2 say [""AEG_Open"", 5];};
				with uiNamespace do {(findDisplay 20700 displayCtrl 20704) ctrlEnable false;};
				with uiNamespace do {(findDisplay 20700 displayCtrl 20704) buttonSetAction """";};
				call AEG_fnc_overview;
			", _outStr, _logicStr
		])};
	}
    else
    {
        with uiNamespace do {(findDisplay 20700 displayCtrl 20703) ctrlEnable true;}; 
		with uiNamespace do {(findDisplay 20700 displayCtrl 20703) buttonSetAction (format 
		[
			"
				missionNameSpace setVariable [""%1"", true];
				publicVariable ""%1"";
				if ((""%2"" == ""AEG_logic_P_Elek"") or (""%2"" == ""AEG_logic_P_Cher"")) then {} else {%2 say [""AEG_Close"", 5];};
				with uiNamespace do {(findDisplay 20700 displayCtrl 20703) ctrlEnable false;};
				with uiNamespace do {(findDisplay 20700 displayCtrl 20703) buttonSetAction """";};
				call AEG_fnc_overview;
			", _outStr, _logicStr
		])};
	};
};