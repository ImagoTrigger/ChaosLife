/*
    File: AEG_smoke.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to emit smoke from  power plant smokestacks.

    Parameters:
    _this select 0: The AEG object co-located with game logic that emits smoke (string).

    Execution:
    Executed from AEG_common.sqf on all machines except MP dedicated servers (since there is no one there to see the smoke).
    Multiple instances of this script will be running concurrently, one for every logic that might emit smoke in the simulation.
    If effects are stopped, this script can also be executed by AEG_events.sqf if/when effects are restarted.
*/

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_smoke.sqf: Thread started for:", (_this select 0)] call LGD_fnc_debugMessage;};  

// Scope //
private ["_name", "_bool", "_logic", "_source"];

// Parameter(s) //
_name = (_this select 0);

// Assign local variables to store necessary information for the script to function.
_onStr = (format ["AEG_on_%1", _name]);
_logicStr = (format ["AEG_logic_%1", _name]);
_logic = missionNameSpace getVariable _logicStr; // The primary logic assigned to this object.

// Wait until "power" is on for this smokestack.
waitUntil {(missionNameSpace getVariable _onStr)};

// Create a particle source and emit smoke particles from the smokestack.  Smokestack logics are located near the top of the stack.
_smoke = "#particlesource" createVehicleLocal getPos _logic;
_smoke setParticleCircle [0, [0, 0, 0]];
_smoke setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_smoke setParticleParams [["\Ca\Data\Cl_basic.p3d", 1, 0, 1], "", "Billboard", 1, 12.5, [0, 0, 0], [0, 0, 0.75], 0, 10, 7.9, 0.075, [1.2, 2, 4], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _logic];
_smoke setDropInterval 0.05;

// Emit smoke as long as "power" stays on.  When off, stop the smoke. by deleting the source
waitUntil {!(missionNameSpace getVariable _onStr)};
deleteVehicle _smoke;

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_smoke.sqf: Thread finished for:", (_this select 0)] call LGD_fnc_debugMessage;}; 