/*
	File: AEG_actions.sqf
	Version: 1.01
	Author: Loyalguard

	Description:
	A script to execute code from an action menu command, specifically, to manually turn power off and on at a transformer circuit bus.

	Parameters:
	_this select 3: object name passed from the addAction command array.

	Execution:
	Executed from an action menu command attached to an AEG object (addAction added in AEG_common.sqf).  Will only run locally on the machine that activated it.
*/

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_actions.sqf: Thread Started for:", (_this select 3)] call LGD_fnc_debugMessage;};

// Scope //
private ["_name", "_outStr", "_out", "_logicStr", "_logic", "_odds", "_result1", "_result2"];

// Parameter(s) //
_name = (_this select 3);

// Get the value of the "power out" status of this object and store it in a local variable.
_outStr = format ["AEG_out_%1", _name];
_out = missionNameSpace getVariable _outStr;

// Determine the game logic co-located with this object.
_logicStr = (format ["AEG_logic_%1", _name]);
_logic = missionNameSpace getVariable _logicStr;

//Get the current state of the "power out" switch of the object.  If true (on) then set to false, if false (off) set to true.
if ((_out)) then
{
	missionNameSpace setVariable [_outStr, false];
}
else
{
	missionNameSpace setVariable [_outStr, true];
};

// Public variable the change to all other machines (if they exist) for possible action in a thread of AEG_monitor.sqf running for this object.
publicVariable _outStr;

// Make the game logic at the object's location emit the appropriate sound of a circuit breaker opening (tripping) or closing.
if ((_out)) then
{
	_logic say ["AEG_Open", 5];
}
else
{
	_logic say ["AEG_Close", 5];
};

// Determine whether manipulating the breaker will cause an arc flash explosion.  Determined by the missionmaker by declaring a value to AEG_arc.  Default (nil) is zero chance of arc flash.
if (isNil "AEG_explode") then {} else
{
	// If the object is not operational then skip the check to see whether an arc-flash should occur.
    if (!(missionNameSpace getVariable format ["AEG_op_%1", _name])) exitWith {};

    // Get the odds that the missionmaker has set for explosions and ensure it is an integer. Use it as a seed for a random number for two different results.
	_odds = round (AEG_explode);
	_result1 = ceil (random _odds);
	_result2 = ceil (random _odds);

    // If both results are the same, then cause an arc-flash explosion to occur.
	if (_result1 == _result2) then
	{
		// If the machine is SP or a MP Host (servers) or a MP client (Multiplayer) then directly execute the script to cause an explosion and pertinent effects since a PVEH will not fire on those machines.
		// Pass the name of the AEG object to the script or PVEH as appropriate.
        if ((isServer) or (isMultiplayer)) then
		{
			_nul = [_name] execVM "scripts\AEG\Scripts\AEG_flash.sqf";
		};

		// If this is a multiplayer game then broadcast that an explosion should occur to all other machines by triggering a PVEH.
        // This PVEH was added in AEG_init.sqf.
		if (isMultiplayer) then
		{
			AEG_arc = _name;
			publicVariable "AEG_arc";
		};
	};
};

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_actions.sqf: Thread finished for:", (_this select 3)] call LGD_fnc_debugMessage;};