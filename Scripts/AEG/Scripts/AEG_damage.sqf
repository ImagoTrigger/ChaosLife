/*          
    File: AEG_damage.sqf
    Version: 1.01
    Author: Loyalguard
    
    Description:
    A script to ensure that AEG objects that have been destroyed are made inoperational to ensure they cannot be manipulated by players.

    Parameters:
    None.
 
    Execution:
    Executed from AEG_server.sqf.  It will only run in SP, on a MP host, or on a MP dedicated server since AEG_server.sqf only runs on such machines.
*/
 
//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_damage.sqf: Thread started."] call LGD_fnc_debugMessage;}; 

// Scope //
private ["_name", "_object", "_logic", "_opStr", "_op", "_dam"];

// Begin an endless loop that checks the "operational" status and damage level of each AEG objects once every five seconds.
while {true} do
{
    // Loop through all the elements of the AEG_ojects global array to identify all AEG objects.
    { // BEGIN FOREACH LOOP.
        // Extract the name of the logic and a pointer to the object or the object's class name.
        _name = (_x select 0); // "Type_Name_Location".
        _object = (_x select 2); // Object "Class" or ID of the object.  The type of value (string or integer) will depend on if the object has a config class or not.

        // Determine the logic associated with this object as well as the object's "operational" status and damage level.
        _logic = missionNameSpace getVariable (format ["AEG_logic_%1", _name]);
        _opStr  = format ["AEG_op_%1", _name];
        _op = missionNameSpace getVariable _opStr;
        _dam = (getDammage (position _logic nearestObject _object));

        // If the object is "operational" AND 100% damaged, ensure it is made "inoperational" and  broadcast status to all machines.            
        if ((_op) && (_dam == 1)) then
        {
            missionNameSpace setVariable [_opStr, false];
            publicVariable _opStr;
        };
        sleep .01; // Brief pause.
     } forEach AEG_objects; // END FOREACH LOOP.
     
 // Pause between loop iterations.  
 sleep 5;
}; // END WHILE LOOP BUT LOOP NEVER ENDS.