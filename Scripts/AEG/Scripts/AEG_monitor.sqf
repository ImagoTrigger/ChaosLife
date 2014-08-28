/*
    File: AEG_monitor.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to monitor damage and power "in" and "out" status of pertinent AEG  objects.
    When a change is detected it will pass the relevant information to a PVEH running on clients or directly to AEG_event.sqf.

    Parameters:
    _this select 0: The class name (string) or object ID (integer) of the AEG object.
    _this select 1: The logic assigned to the AEG object (object).
    _this select 2: The AEG object closest to the logic (string).
    _this select 3: Other objects/nodes that this object supplies power to (array).

    Execution:
    Executed from AEG_server.sqf.  Will only run in SP, on a MP host, or on a dedicated server due to conditions checked in AEG_server.sqf.
    Multiple instances of this script will be running concurrently, one for every primary logic assigned to each object used by the simulation.
*/

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_monitor.sqf: Thread started for:", (_this select 2)] call LGD_fnc_debugMessage;};

// Scope //
private ["_object", "_logic", "_name", "_supplies", "_onStr", "_sound1Str", "_sound1", "_sound2Str", "_sound2", "_pos", "_group"];

// Parameter(s) //
_object = (_this select 0);
_logic = (_this select 1);
_name = (_this select 2);
_supplies = (_this select 3);

// Run a Continuous loop to check "operational" status, damage, power "in", and power "out" status of each pertinent AEG object.  If there is a relevant change in status of any of the conditions then broadcast them to clients (for action by a PVEH  or directly execute and pass them to AEG_events.sqf if the machine is SP or a MP Host.
while {true} do
{
    // Assign local variables for this iteration of the while loop (pertaining to sound logics).
    _sound1Str = (format ["AEG_sound_1_%1", _name]);
    _sound1 = missionNameSpace getVariable _sound1Str;  // The  first "sound" logic assignd to this AEG object.
    _sound2Str = (format ["AEG_sound_2_%1", _name]);
    _sound2 = missionNameSpace getVariable _sound2Str;  // The second "sound" logic assignd to this AEG object.
    _pos = getPos _sound1; // The shared position of the sound logics (needed to re-create them if deleted when power goes out).
    _group = group _sound1; // The shared group assigned to the sound logics (needed to re-create them if deleted when power goes out).


    ///////////////////////////////
    //// POWER OFF CONDITIONS ////
    /////////////////////////////


    // Pause the loop until the object is NOT "operational", 100% DAMAGED, it is NOT receiving power (in), OR it is NOT sending power (out).
    waitUntil
    {

            (!(missionNameSpace getVariable format ["AEG_op_%1", _name]))
            or
            (getDammage (position _logic nearestObject _object)  == 1)
            or
            ((missionNameSpace getVariable format ["AEG_in_%1", _name]) == 0)
            or
            (!(missionNameSpace getVariable format ["AEG_out_%1", _name]))
    };

    // If the object is destroyed then ensure that it is considered NOT operational to hide actions and other related aspects.
    if ((getDammage (position _logic nearestObject _object)  == 1)) then
    {
        _opStr  = format ["AEG_op_%1", _name];
        missionNameSpace setVariable [_opStr, false];
        publicVariable _opStr;
    };

    //DEBUG
    if (!isNil "AEG_DEBUG") then {_debug = ["AEG_monitor.sqf: Power OFF Condidtions for:", (_this select 2)] call LGD_fnc_debugMessage;};

    // Change the object's power status to OFF (false).
    _onStr = format ["AEG_on_%1", _name];
    missionNameSpace setVariable [_onStr, false];

    // Delete the sound logics to immediately stop the sound loop.
    deleteVehicle _sound1;
    deleteVehicle _sound2;

    // If the machine is a server then public variable the object's power status to all clients so the relevant PVEH will fire.
    if (isServer) then
    {
        publicVariable _onStr;
    };

    // If the machine is SP or a MP host then manually send the public variable that stores the power status of an object to AEG_events.sqf  to ensure that its processes the latest power-related conditions.  This is required since PVEHs don't fire on machines  where the PV is broadcast from.
    if ((isServer) and (!isDedicated)) then
     {
         _nul = [_onStr, false] execVM "scripts\AEG\Scripts\AEG_events.sqf";
     };

    // If this object supplies power to other nodes then spawn an instance of a function to adjust incoming power at those nodes.
    if ((count _supplies) > 0) then {[false, _supplies] spawn AEG_fnc_supply;};

    // Momentarily pause the loop to ensure all conditions are updated.
    sleep .01;


    //////////////////////////////
    //// POWER ON CONDITIONS ////
    ////////////////////////////


    // Pause the loop until the object is "operational", less than 100% DAMAGE, it is RECEIVING power (in), AND it is SENDING power (out).
    waitUntil
    {
        ((missionNameSpace getVariable format ["AEG_op_%1", _name]))
        and
        (getDammage (position _logic nearestObject _object) < 1)
        and
        ((missionNameSpace getVariable format ["AEG_in_%1", _name]) > 0)
        and
        ((missionNameSpace getVariable format ["AEG_out_%1", _name]))
    };

    //DEBUG
    if (!isNil "AEG_DEBUG") then {_debug = ["AEG_monitor.sqf: Power ON Condidtions for:", (_this select 2)] call LGD_fnc_debugMessage;};

    // Recreate the sound logics so that the sound loop can begin again.
    "Logic" createUnit [_pos, _group, (format ["AEG_sound_1_%1 = this; this setPos [%2, %3, %4];", _name, (_pos select 0), (_pos select 1), (_pos select 2)])];
    "Logic" createUnit [_pos, _group, (format ["AEG_sound_2_%1 = this; this setPos [%2, %3, %4];", _name, (_pos select 0), (_pos select 1), (_pos select 2)])];

    // Change the object's power status to ON (true).
    _onStr = format ["AEG_on_%1", _name];
    missionNameSpace setVariable [_onStr, true];

    // If the machine is a server then public variable the object's power status to all clients so the relevant PVEH will fire.
    if (isServer) then
    {
        publicVariable _onStr;
    };

    // If the machine is SP or a MP host then manually send the public variable that stores the power status of an object to AEG_events.sqf  to ensure that its processes the latest power-related conditions.  This is required since PVEHs don't fire on machines where the PV is broadcast from.
    if ((isServer) and (!isDedicated)) then
     {
         _nul = [_onStr, true] execVM "scripts\AEG\Scripts\AEG_events.sqf";
     };

    // If this object supplies power to other nodes then spawn an instance of a function to adjust incoming power at those nodes.
    if ((count _supplies) > 0) then {[true, _supplies] spawn AEG_fnc_supply;};

    // Momentarily pause the loop before repeating.
    sleep .01;

    // Start next iteration of the loop.

}; // End While-Loop Block (But Loop Never Ends!)