/*
    File: AEG_server.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to initialize all the required server-side components of the AEG simulation.

    Parameters:
    None.

    Execution:
    Executed from AEG_init.sqf.  It will only run in SP, on a MP host, or on a MP dedicated server due to conditions checked in AEG_init.sqf.
*/

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_server.sqf: Thread started."] call LGD_fnc_debugMessage;};

// Scope //
private ["_side", "_group", "_name", "_pos", "_object", "_logic", "_inStr", "_outStr", "_onStr", "_opStr", "_supplies"];

// Create a side and group for subsequent game logics.
_side = createCenter sideLogic;
_group = createGroup sideLogic;

// BEGIN A MULTI-STEP PER ITERATION FOREACH LOOP TO INITIALIZE COMPONENTS OF THE AEG SIMULATION.
// Loop through all the elements of the AEG_ojects global array that was initialized in this world's specific init script.
{
    // Assign local variables to elements extracted from the AEG_objects array in this iteration of the forEach loop.
    _name = (_x select 0); // "Type_Name_Location".
    _pos = (_x select 1); // [Object Position].
    _object = (_x select 2); // Object "Class" or ID of the object.  The type of value (string or integer) will depend on if the object has a config class or not.
    _effect = (_x select 4); // Effect type (sound or particles) associated with object.
    _supplies = (_x select 5); // Other objects/nodes that this object supplies power to.

    // Create a game logic used to locate and identify AEG objects and emit sounds as required. Give it name unique to its assigned object.  If the object the logic is co-located with has a config class (_object is a string),  If the object has no class (_object is an integer or other type), then use setPosATL to put the logic at terrain level to ensure proper addAction and sound behaivor handled in other scripts.
        if (typeName _object == "STRING") then
        {
               "Logic" createUnit [_pos, _group, (format ["AEG_logic_%1 = this; this setPos [%2, %3, %4];", _name, (_pos select 0), (_pos select 1), (_pos select 2)])];
        }
        else
        {
              "Logic" createUnit [_pos, _group, (format ["AEG_logic_%1 = this; this setPosATL [%2, %3, %4];", _name, (_pos select 0), (_pos select 1), 0])];
        };

    // Create two game logics specifically to emit effect sounds as required.  Give them names unique to their assigned object.  If the object the logics are co-located with has a config class (_object is a string), then setPos them to the same coordinates as the object.  If the object has no class (_object is an integer or other type), then use setPosATL to put the logics at terrain level to ensure proper behaivor handled in other scripts.
        if (typeName _object == "STRING") then
        {
            "Logic" createUnit [_pos, _group, (format ["AEG_sound_1_%1 = this; this setPos [%2, %3, %4];", _name, (_pos select 0), (_pos select 1), (_pos select 2)])];
            "Logic" createUnit [_pos, _group, (format ["AEG_sound_2_%1 = this; this setPos [%2, %3, %4];", _name, (_pos select 0), (_pos select 1), (_pos select 2)])];
        }
        else
        {
            "Logic" createUnit [_pos, _group, (format ["AEG_sound_1_%1 = this; this setPosATL [%2, %3, %4];", _name, (_pos select 0), (_pos select 1), 0])];
            "Logic" createUnit [_pos, _group, (format ["AEG_sound_2_%1 = this; this setPosATL [%2, %3, %4];", _name, (_pos select 0), (_pos select 1), 0])];
        };

    // Create a public variable (integer) to store the percentage of power "flowing into" this AEG object.
    _inStr = format ["AEG_in_%1", _name];
    missionNameSpace setVariable [_inStr, 1];
    publicVariable _inStr;

    // Create a public variable (boolean) to indicate if power is "flowing out" of this AEG object.
    _outStr = format ["AEG_out_%1", _name];
    missionNameSpace setVariable [_outStr, true];
    publicVariable _outStr;

    // Create a public variable (boolean) to indicate if power is "on" for this AEG object.
    _onStr = format ["AEG_on_%1", _name];
    missionNameSpace setVariable [_onStr, true];
    publicVariable _onStr;

    // Create a public variable (boolean) to indicate if this AEG object is "operational".
    _opStr  = format ["AEG_op_%1", _name];
    missionNameSpace setVariable [_opStr, true];
    publicVariable _opStr;

    // Store a pointer to the primary logic for this object in a local variable to pass to AEG_monitor.sqf.
    _logic = missionNameSpace getVariable (format ["AEG_logic_%1", _name]);

    // Execute a new instance of AEG_monitor.sqf for this object, passing to it the class of the object, the pertinent logic, the object's name, and other objects/nodes that this object supplies power to.
    [_object, _logic , _name, _supplies] execVM "scripts\AEG\Scripts\AEG_monitor.sqf";

    sleep .01;

 } forEach AEG_objects; // END FOREACH LOOP.

 // Initialize a function used to adjust incoming power values that is called/spawned later by AEG_monitor.sqf.
 _nul = execVM "scripts\AEG\Functions\AEG_fnc_supply.sqf";

// Execute AEG_common.sqf which has common code for required for SP, MP hosts, and MP clients but NOT required for MP dedicated servers.
if (!isDedicated) then
{
    _nul = [] execVM "scripts\AEG\Scripts\AEG_common.sqf";
};

// Execute AEG_damage.sqf that checks damage levels and the operational status of all AEG objectsto ensure they appropriately correspond.
_nul = execVM "scripts\AEG\Scripts\AEG_damage.sqf";

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_server.sqf: Thread finished."] call LGD_fnc_debugMessage;};