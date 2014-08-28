/*
	File: AEG_fnc_password.sqf
	Version: 1.01
	Author: Loyalguard

	Description:
	A function to check if the player has entered the correct password to access the grid control system dialog.

	Parameters:
	None.

	Execution:
	Loaded into memory by AEG_logon.sqf.  Called by the AEG_Logon dialog when the "OK" button is clicked.
*/

// Create a function to check the password entered by the player.
AEG_fnc_password =
{
	// Get the password entered in the input box of the AEG_Logon dialog.
	_password = with uiNamespace do {ctrlText (findDisplay 20900 displayCtrl 20901);};

	// If the password is correct then execute the grid control system dialog script.  If not, display an incorrect password warning to the player.
	if (_password == AEG_password) then
	{
		closeDialog 20900;
		_nul = execVM "scripts\AEG\Scripts\AEG_system.sqf";
	}
	else
	{
		with uiNamespace do {(findDisplay 20900 displayCtrl 20902) ctrlSetText "Incorrect Password.";};
	};
};