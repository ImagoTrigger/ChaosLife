/*
    File: AEG_common.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to initialize all the required SP, MP host, and MP client-side components of the AEG simulation.

    Parameters:
    None.

    Execution:
    Executed from AEG_server.sqf or AEG_client.sqf  Will only run on SP, MP hosts, and MP clients due to conditions checked in the executing instance.
*/

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_common.sqf: Thread started."] call LGD_fnc_debugMessage;};

// Scope //
private ["_name", "_object", "_action", "_effect", "_logic", "_trip", "_close"];

// Load a function into memory that will be used to add action menu commands for non-class objects.
_nul = [] execVM "scripts\AEG\Functions\AEG_fnc_actions.sqf";
waitUntil {!isNil "AEG_fnc_actions"};

// If the mission maker has not disabled the option (by declaring AEG_manual = false in the init.sqf), then allow players to manually trip and close circuit breakers to cut off and restore power.
if (isNil "AEG_manual") then {AEG_manual = true};

// Begin a forEach loop to perform several different functions for the AEG simulation.
{
    // Assign local variables to elements extracted from the AEG_objects array in this iteration of the forEach loop.
    _name = (_x select 0); // "Type_Name_Location".
    _object = (_x select 2); // Object "Class" or ID of the object.  The type of value (string or integer) will depend on if the object has a config class or not.
    _action = (_x select 3); // Boolean to determine whether or not this object get an action menu command added to it.
    _effect = (_x select 4); // Effect type (sound or particles) associated with object.
    _logic = missionNameSpace getVariable (format ["AEG_logic_%1", _name]); // Get the name of logic assigned to this object.

    // If designated in the AEG_objects array, give this object an action menu command to trip/open or close a circuit breaker for a transformer to cut-off outgoing power (to other transformers/substations and/or street lamps).  The appropriate action will only be seen only if the mission maker has not disabled it, if it matches to the current boolean state, and the unit is close enough to the object for action commands.
    if (_action) then
    {
        // If the object the logic is co-located with has a config class (_object is a string), then add the action to the object itself.  If the object has no class (_object is an integer or other type), then add the action to the (human) player via a specialized function.  The distances for class and non-class objects are different since action for class objects are centered on a specific memory point and actions for non-class objects are centered on the position of the co-located logic, not the object itself.
        if (typeName _object == "STRING") then
        {
            _trip = (position _logic nearestObject _object) addAction ["Trip Circuit Breaker", "scripts\AEG\Scripts\AEG_actions.sqf", _name, 6, true, true, "", (format ["((AEG_manual) && (AEG_out_%1) && ((_this distance _target) < 7))", _name])];
            _close = (position _logic nearestObject _object) addAction ["Close Circuit Breaker", "scripts\AEG\Scripts\AEG_actions.sqf", _name, 6, true, true, "", (format ["((AEG_manual) && (!AEG_out_%1) && ((_this distance _target) < 7))", _name])];
        }
        else
        {
            [_name] call AEG_fnc_actions;
        };
    };

    // Determine which effect (if any) has been assigned to this AEG object as designated in the AEG_objects array: Transformer hum sound, power plant noise sound, or smoke particles eminating from the plant's smokestack.
    switch (_effect) do
    {
        case "XFMR":
        {
            _nul = ["XFMR", _name] execVM "scripts\AEG\Scripts\AEG_sounds.sqf";
        };

        case "PLANT":
        {
            _nul = ["PLANT", _name] execVM "scripts\AEG\Scripts\AEG_sounds.sqf";
        };

        case "SMOKE":
        {
            _nul = [_name] execVM "scripts\AEG\Scripts\AEG_smoke.sqf";
        };
    };

    sleep .01;

} forEach AEG_objects; // AEG_objects was initialized in a world specfic script executed from AEG_init.sqf.

// Add a respawn event handler to ensure the simulation is consistent for respawning players.  The EH executes a script for that purpose.
 player addEventHandler ["Respawn", {_nul = [] execVM "scripts\AEG\Scripts\AEG_respawn.sqf"}];

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_common.sqf: Thread finished."] call LGD_fnc_debugMessage;};