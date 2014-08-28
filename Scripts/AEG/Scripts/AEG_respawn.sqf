/*
    File: AEG_respawn.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to ensure the AEG simulation remains consistent for respawning players.

    Parameters:
    None.

    Execution:
    Executed by a "Respawn" event handler added to players in AEG_common.sqf.
*/

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_respawn.sqf: Thread started."] call LGD_fnc_debugMessage;}; 
 
// Scope //
private ["_name", "_object", "_action", "_logic", "_trip", "_close"];

// Perform necessary code to ensure respawned players are properly updated.   Begin a forEach loop to extract information from the AEG_objects needed for respawning players.
{ 
    // Assign local variables to elements extracted from the AEG_objects array in this iteration of the forEach loop.
    _name = (_x select 0); // "Type_Name_Location".
    _object = (_x select 2); // Object "Class" or ID of the object.  The type of value (string or integer) will depend on if the object has a config class or not.
    _action = (_x select 3); // Boolean to determine whether or not this object get an action menu command added to it.
   
    // Get the name of logic assigned to this AEG object.
   _logic = missionNameSpace getVariable (format ["AEG_logic_%1", _name]);

    // If designated in the AEG_objects array, give this object an action menu command to trip/open or close a circuit breaker  for a transformer to cut-off outgoing power (to other transformers/substations and/or street lamps).  The appropriate action will only be seen only if the mission maker has not disabled it, if it matches to the current boolean state, and the unit is close enough to the object for action commands.
    if (_action) then
    {
        // If the object has no class (_object is not a string), then add the action to the (human) player.  See AEG_common.sqf for original addAction code.
        if (typeName _object != "STRING") then
        {
            [_name] call AEG_fnc_actions;
        };
    };

    sleep .01;
	
} forEach AEG_objects; // AEG_objects was initialized in a world specfic script executed from AEG_init.sqf.
 
//DEBUG 
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_respawn.sqf: Thread finished."] call LGD_fnc_debugMessage;}; 