 /*
	File: AEG_events.sqf
	Version: 1.01
	Author: Loyalguard

	Description:
	A script to trigger power "on" or "off" events based on input and output of grid components.  This is the core script that turns power on or off.

	Parameters:
	_this select 0: Name of public variable that has changed value (string).
	_this select 1: The current value of the public variable after being changed (boolean).

	Execution:
	Executed either from a PVEH for the public variable (added in AEG_client.sqf) or directly from AEG_monitor.sqf if SP or MP host.
*/

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_events.sqf: Thread Started for:", (_this select 0), (_this select 1)] call LGD_fnc_debugMessage;};

// Scope //
private ["_var", "_bool", "_wName", "_world", "_events", "_feeds", "_effect", "_name", "_stack", "_zones"];

// Parameter(s) //
_var = (_this select 0); // Name of public variable that has changed value.
_bool = (_this select 1); // The current value of the public variable after being changed.  true = on.  false = off.

// Determine which power plant or transformer bus is being affected by a power related event.
_wName = worldName;
_world = toUpper _wName;

// Determine the pertinent commands for either power on or off events by calling a function specific to the current world.  The function's return value will determine what is affected and how.
switch (_world) do
{
	case "CHERNARUS":
	{
		_events = _var call AEG_fnc_chernarus;
	};
    case "ZARGABAD":
	{
		_events = _var call AEG_fnc_zargabad;
	};
    case "UTES":
	{
		_events = _var call AEG_fnc_utes;
	};
    case "TAKISTAN":
	{
		_events = _var call AEG_fnc_takistan;
	};
    case "TUP_QOM":
	{
		_events = _var call AEG_fnc_qom;
	};
};

// Extract elements from the _events array (returned by the pertinent function call above) and assign the values to local variables.
_feeds = (_events select 0); // Boolean to determine whether this nodes feeds power to street lamps.
_effect = (_events select 1); // String to determine what effects (sounds or particles) are associated with this node.
_name = (_events select 2); // A class string to determine the name of this object.
_stack = (_events select 3); // If this is a power plant, determine which smokestack is associated with it (if applicable).
_zones = (_events select 4); // The array of "zones" that this objects feeds/distributes power to (if applicable).

// If a "power on" event then restart the pertinent effects that would have previously been stopped by a "power off" event.
if (_bool) then
{
	switch (_effect) do
	{
		case "PLANT":
		{
			_nul = ["PLANT", _name] execVM "scripts\AEG\Scripts\AEG_sounds.sqf";
			_nul = [_stack] execVM "scripts\AEG\Scripts\AEG_smoke.sqf";
		};
		case "XFMR":
		{
			_nul = ["XFMR", _name] execVM "scripts\AEG\Scripts\AEG_sounds.sqf";
		};
	};
};

// If this node feeds power to specific distribution zones then switch off street lamps in those zones.  Since this is accomplished by a forEach loop nested within another forEach loop, there are pauses inserted in each primary and sub-iteration to minimize lag.  The routine is: Identify a zone, find the first street lamp in that zone, switch it on/off, pause, find the next streetlamp...once all lamps in a zone have been switched pause and identify the next zone and repeat the switching process until all zones have been covered.
if (_feeds) then
{
	if (!_bool) then
	{
		{{_x switchLight "OFF"; sleep .001;} forEach ((_x select 0) nearObjects ["StreetLamp", (_x select 1)]); sleep .001;} forEach _zones;
	}
	else
	{
		{{_x switchLight "AUTO"; sleep .001} forEach ((_x select 0) nearObjects ["StreetLamp", (_x select 1)]); sleep .001;} forEach _zones;
	};
};

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_events.sqf: Thread finished for:", _var, _bool] call LGD_fnc_debugMessage;};