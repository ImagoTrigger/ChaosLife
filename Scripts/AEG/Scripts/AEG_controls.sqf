/*
    File: AEG_controls.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to load functions into memory if the AEG System Dialog is created to update controls and perform other dialog functions.

    Parameters:
    None.

    Execution:
    Executed by AEG_system.sqf (and only once per mission per client as detemined by the GV AEG_controls).
*/

_nul = [] execVM "scripts\AEG\Functions\AEG_fnc_user.sqf";
_nul = [] execVM "scripts\AEG\Functions\AEG_fnc_overview.sqf";
_nul = [] execVM "scripts\AEG\Functions\AEG_fnc_status.sqf";
_nul = [] execVM "scripts\AEG\Functions\AEG_fnc_commands.sqf";
_nul = [] execVM "scripts\AEG\Functions\AEG_fnc_node.sqf";
_nul = [] execVM "scripts\AEG\Functions\AEG_fnc_video.sqf";

// If the mission maker has not enabled the CCTV night vision option (by declaring AEG_NVG = true in the init.sqf), then ensure it is disabled.  Also ensure AEG_light and AEG_dark have default values assigned.
if (isNil "AEG_NVG") then {AEG_NVG = false};
if (isNil "AEG_dark") then {AEG_dark = 19};
if (isNil "AEG_light") then {AEG_light = 6};

// Assign the value to true once this script is run once so that it is not loaded every time AEG_system.sqf is executed.
AEG_controls = true;