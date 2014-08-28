/*
    File: AEG_logon.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to create the logon dialog for the AEG Grid Control System.

    Parameters:
    None.

    Execution:
    By any executing instance such as an addAction commmand, trigger, or execute command as desired by the mission maker.
*/

// Load the password function required for the dialog into memory (if not already loaded).
if (isNil "AEG_fnc_password") then
{
    _nul = [] execVM "scripts\AEG\Functions\AEG_fnc_password.sqf";
};

// If a password has been designated by the mission maker than open the logon dialog to require the player to enter a password.  If no password has been designated (default), directly execute the grid control system dialog script.
if (!isNil ("AEG_password")) then
{
    _nul = createDialog "AEG_Logon";
}
else
{
    _nul = execVM "scripts\AEG\Scripts\AEG_system.sqf";
};
