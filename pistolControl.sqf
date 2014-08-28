_holster = (_this select 3 select 0);
if (!_holster) then {
	unholstering = true;
	player removeAction unholsterPistol;
	saveWeaponPistol set [1,false];
	holsterPistol = player addAction ["Holster Pistol","pistolControl.sqf",[true]];	
	player addWeapon (saveWeaponPistol select 0);
	player selectWeapon (saveWeaponPistol select 0);
	['pistole', 0] call INV_SetItemAmount;
	INV_InventarPistole = (saveWeaponPistol select 0);
	[] spawn {
		sleep 1;
		unholstering = false;
	};
} else {
	player removeAction holsterPistol;
	saveWeaponPistol set [1,true];
	unholsterPistol = player addAction ["Unholster Pistol","pistolControl.sqf",[false]];
	player removeWeapon (saveWeaponPistol select 0);
	['pistole', 1] call INV_SetItemAmount;
	INV_InventarPistole = (saveWeaponPistol select 0);
};