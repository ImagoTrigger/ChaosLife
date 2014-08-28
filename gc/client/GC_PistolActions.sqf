_pistola = handgunWeapon player;
_prevention = true;
if (_pistola != "") then {
	_prevention = false;
	if ((_pistola != saveWeaponPistol select 0) && saveWeaponPistol select 1) then {
		_prevention = true;
		saveWeaponPistol set [1,false];
	};
	saveWeaponPistol set [0,_pistola];
};
if (_prevention && !(saveWeaponPistol select 1)) then {
	saveWeaponPistol set [2,true];
	player removeAction holsterPistol;
	player removeAction unholsterPistol;
} else {
	if (saveWeaponPistol select 2) then {
		holsterPistol = player addAction ["Holster Pistol","pistolControl.sqf",[true]];
		saveWeaponPistol set [2,false];
	};
};