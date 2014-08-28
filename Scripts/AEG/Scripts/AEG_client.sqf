/*
    File: AEG_client.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to initialize all the required client-side components of the AEG simulation.

    Parameters:
    None.

    Execution:
    Executed from AEG_init.sqf.  Will only run on MP clients due to conditions checked in AEG_init.sqf.
*/

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_client.sqf: Thread started"] call LGD_fnc_debugMessage;};

// Scope //
private ["_name"];

// Begin a forEach loop to create PVEHs on clients that will fire when the power status of a AEG object changes.
{
    // Assign a local variable to the first element extracted from the AEG_objects array in this iteration of the forEach loop.
    _name = (_x select 0); // "Type_Name_Location".

    // Pause loop to ensure that the public variable is created before the PVEH for that PV is.
    waitUntil {!(isNil (format ["AEG_on_%1", _name]))};

    // Add the PVEH to the PV.  When the PVEH fires it will execute AEG_events.sqf and pass to it the name of PV and the new value.
    (format ["AEG_on_%1", _name]) addPublicVariableEventHandler {[(_this select 0), (_this select 1)] execVM "scripts\AEG\Scripts\AEG_events.sqf"};

    sleep .01;

} forEach AEG_objects;  // AEG_objects was initialized in a world specfic script executed from AEG_init.sqf.

// Execute the script AEG_common.sqf which has common code for required for SP, MP hosts, and MP clients but NOT required  for MP dedicated servers.
_nul = [] execVM "scripts\AEG\Scripts\AEG_common.sqf";

// If the machine is a JIP MP client (determined in AEG_init.sqf) then wait until the player has connected (is not null) and then execute AEG_JIP.sqf to ensure that the "power on" state of all AEG objects is correct for JIP players.
if (AEG_JIP) then
{
     //DEBUG
    _debug = ["AEG_client.sqf: AEG_JIP returned true - player is:", player] call LGD_fnc_debugMessage;

    waitUntil {!(isNull player)};

    //DEBUG
    if (!isNil "AEG_DEBUG") then {_debug = ["AEG_client.sqf: isNull player wait complete - player now is:", player] call LGD_fnc_debugMessage;};

    _nul = [] execVM "scripts\AEG\Scripts\AEG_JIP.sqf";
};

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_client.sqf: Thread finished."] call LGD_fnc_debugMessage;};