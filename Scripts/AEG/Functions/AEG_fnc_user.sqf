/*
	File: AEG_fnc_user.sqf
	Version: 1.01
	Author: Loyalguard

	Description:
	A function to populate information into the "status bar" of the AEG_System dialog.

	Parameters:
	None.
	
	Execution:
	Loaded into memory by AEG_controls.sqf (and only once per mission per client as detemined by the GV AEG_controls).  Function called by interaction with dialog controls or other UI events.
*/

// Create a function to set the text of the status bar of the the dialog with user login information.
AEG_fnc_user =
{
	
	// Scope //
	private ["_date", "_year", "_month", "_day", "_hour", "_min"];

	// Assign local variables to store information necessary for the function.
	_date = date;
	_year = (_date select 0);
	_month = (_date select 1);
	_day = (_date select 2);
	_hour = (_date select 3);
	_min = (_date select 4);

	// Display which user logged on (always "Remote") and the last login date/time stamp.
	with uiNamespace do {(findDisplay 20700 displayCtrl 20701) ctrlSetText format ["User: Remote        Last Login: %1/%2/%3 (MM/DD/YYYY) - %4:%5 HRS", _month, _day, _year, _hour, _min];};
};