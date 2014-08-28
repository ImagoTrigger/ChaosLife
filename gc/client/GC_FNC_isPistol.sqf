// Function for pistol data - by Spooner
isPistol =
{
	
private ["_isPistol","_unknownConfig","_unknownWeaponClass","_pistolConfig"];
_unknownWeaponClass = _this select 0;
	
	_unknownConfig = configFile >> "CfgWeapons" >> _unknownWeaponClass;
	_pistolConfig = configFile >> "CfgWeapons" >> "PistolCore";
	
	_isPistol = false;
	while {isClass _unknownConfig} do
	{
	    if (_unknownConfig == _pistolConfig) exitWith
	    {
	        _isPistol = true;
	    };
	
	    _unknownConfig = inheritsFrom _unknownConfig;
	};
	
	_isPistol; // Return.
};