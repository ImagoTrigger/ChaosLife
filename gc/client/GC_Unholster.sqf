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