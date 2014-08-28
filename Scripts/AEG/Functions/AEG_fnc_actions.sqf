/*
	File: AEG_fnc_actions.sqf
	Version: 1.01
	Author: Loyalguard

	Description:
	A function to give players action menu commands to trip/open or close a circuit breaker if the pertinent object has no config class.

	Parameters:
	_this select 0: "Type_Name_Location" of the pertinent object (String).

	Execution:
	Loaded into memory by AEG_common.sqf.  Function called by AEG_common.sqf, AEG_respawn.sqf, or AEG_team.sqf.
*/

// Create a function to give players action menu commands to trip/open or close a circuit breaker
AEG_fnc_actions =
{
	// Scope //
	private ["_name", "_trip", "_close"];

    // Parameters //
    _name = _this select 0;

    // Add action menu commands to the player.  See AEG_common.sqf for full details.
    _trip = player addAction ["Trip Circuit Breaker", "scripts\AEG\Scripts\AEG_actions.sqf", _name, 6, true, true, "", (format ["((AEG_manual) && (AEG_op_%1) && (AEG_out_%1) && ((_this distance AEG_logic_%1) < 2) && (_this == _target))", _name])];
    _close = player addAction ["Close Circuit Breaker", "scripts\AEG\Scripts\AEG_actions.sqf", _name, 6, true, true, "", (format ["((AEG_manual) && (AEG_op_%1) && (!AEG_out_%1) && ((_this distance AEG_logic_%1) < 2) && (_this == _target))", _name])];
};