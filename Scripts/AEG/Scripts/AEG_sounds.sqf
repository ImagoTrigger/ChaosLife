/*
    File: AEG_sound.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to emit a sound or noise from game logics assigned/co-located with certain AEG objects.

    Parameters:
    _this select 0: The AEG object co-located with game logics that will emit sound. (string)

    Execution:
    Executed from AEG_common.sqf on all machines except MP dedicated servers (since there is no one there to hear the sound).
    Multiple instances of this script will be running concurrently, one for every power plant or transformer object in the simulation.
*/

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_sounds.sqf: Thread started for:", (_this select 1)] call LGD_fnc_debugMessage;};  

// Scope //
private ["_effect", "_name", "_onStr", "_logicStr", "_logic", "_sound1Str", "_sound1", "_sound2Str", "_sound2"];

// Parameter(s) //
_effect = (_this select 0);
_name = (_this select 1);

// Assign local variables to store necessary information for the script to function.
_onStr = (format ["AEG_on_%1", _name]);
_logicStr = (format ["AEG_logic_%1", _name]);
_logic = missionNameSpace getVariable _logicStr; // The primary logic assigned to this object.
_sound1Str = (format ["AEG_sound_1_%1", _name]);
_sound1 = missionNameSpace getVariable _sound1Str; // The 1st sound logic assigned to this object.
_sound2Str = (format ["AEG_sound_2_%1", _name]);
_sound2 = missionNameSpace getVariable _sound2Str; // The 2nd sound logic assigned to this object.

// Determine which sound(s) to emit depending on the type of of object (transformer "XFMR" or power plant "PLANT").
switch (_effect) do
{
	case "XFMR":
    {
        // Ensure power is "on" before beginning the loop.
        waitUntil {!isNil _onStr};	
        waitUntil {(missionNameSpace getVariable _onStr)};

        // As long as the power is "on" for this object, make the sound logic play a loop of transformer humming noise if the player is close enough to hear it.  Two sound sources are used so they are no gaps in the loop.
        while {(missionNameSpace getVariable _onStr)} do
        {
                while {(missionNameSpace getVariable _onStr) && (_logic distance player < 50)} do 
                {
                        _sound1 say ["AEG_Hum",5];
                        sleep 1.25;
                        _sound2 say ["AEG_Hum",5];
                        sleep 1.25;
                };
                sleep .001;
        };
    };
	
    case "PLANT":
    {
        // Esure power is "on" before beginning the loop.
        waitUntil {!isNil _onStr};	
        waitUntil {(missionNameSpace getVariable _onStr)};

        // As long as the power is "on" for this object, make the sound logic play a loop of power plant noises if the player is close enough to hear it.  Two sound sources are used so they are no gaps in the loop.
        while {(missionNameSpace getVariable _onStr)} do
        {
                while {(missionNameSpace getVariable _onStr) && (_logic distance player < 40)} do 
                {
                        _sound1 say ["AEG_Plant",5];
                        sleep 1;
                        _sound2 say ["AEG_Plant",5];
                        sleep 1;
                };
                sleep .001;
        };			
    };
};

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_sounds.sqf: Thread finished for:", (_this select 1)] call LGD_fnc_debugMessage;};  