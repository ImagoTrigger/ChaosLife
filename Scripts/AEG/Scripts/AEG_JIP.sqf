/*
    File: AEG_JIP.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to ensure the MP clients joining in progress (JIP) have the correct public variable values for different aspects of the AEG Simulation.

    Parameters:
    None.

    Execution:
    Executed from AEG_client.sqf.  Will only run on JIP MP clients due to conditions checked in AEG_client.sqf.
*/

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_JIP.sqf: Thread started."] call LGD_fnc_debugMessage;};

// Scope //
private ["_name", "_onStr", "_on"];

// Begin a forEach loop to ensure the power on state of AEG objects is correct for JIP players.
{
    // Assign local variables to elements extracted from the AEG_objects array in this iteration of the forEach loop.
    _name = (_x select 0); // "Type_Name_Location".
    _onStr = (format ["AEG_on_%1", _name]);

    // Get the current "power on" state for this object.
    _on = missionNameSpace getVariable _onStr;

    // If the power state is off, then execute AEG_events.sqf and pass the "power on" state of this object to it.
    if (!(_on)) then
    {
            _nul = [_onStr, _on] execVM "scripts\AEG\Scripts\AEG_events.sqf";
    };

    sleep .01;

} forEach AEG_objects; // AEG_objects was initialized in a world specfic script executed from AEG_init.sqf.

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_JIP.sqf: Thread finished."] call LGD_fnc_debugMessage;};