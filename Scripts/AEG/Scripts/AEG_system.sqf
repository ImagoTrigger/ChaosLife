/*
    File: AEG_system.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to create the AEG System Dialog and perform related dialog functions.

    Parameters:
    None.

    Execution:
    By any executing instance such as AEG_logon.sqf, AEG_fnc_password function call, an addAction commmand, trigger, or execute command as desired by the mission maker.
*/

// If not already loaded, load functions required for the dialog into memory.
if (isNil "AEG_controls") then
{
	_nul = [] execVM "scripts\AEG\Scripts\AEG_controls.sqf";
};

// Create the dialog.
_nul = createDialog "AEG_System";

// Disable the connect and disconnect buttons by default since no node has been selected yet.
with uiNamespace do {(findDisplay 20700 displayCtrl 20703) ctrlEnable false;};
with uiNamespace do {(findDisplay 20700 displayCtrl 20704) ctrlEnable false;};

// Pause long enough for the dialog to load.
sleep .5;

// Populate user login information in the status bar and system overview information in the area to the right of the screen.
call AEG_fnc_user;
call AEG_fnc_overview;

// As long as the dialog is open update node information by a function once per second.
while {dialog} do
{
	call AEG_fnc_status;
	sleep 1;
};