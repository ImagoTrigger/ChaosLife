_art = _this select 0;
_item   = _this select 1;
if (_art == "use") then {
	if (call GC_PlayerInCrimeFree) exitWith {
		["GC_Bad2",["CHAOS LIFE BOMBS","You can't arm a bomb inside the No Crime Zone!"]] spawn bis_fnc_showNotification;
	};
	player setvariable["vest",vest player];
	removevest player;
	player addvest "V_HarnessOGL_gry";
	player setvariable["bomber",player,true];
	_exp0 = "DemoCharge_Remote_Ammo" createVehicle getPos player;
	_exp0 attachto [player,[-0.17,0.13,0],"Pelvis"];
	[_exp0, 0, 270] call setPitchBank;
	
	_exp3 = "DemoCharge_Remote_Ammo" createVehicle getPos player;
	_exp3 attachto [player,[0,0.18,0],"Pelvis"];
	[_exp3, 0, 270] call setPitchBank;

	_exp5 = "DemoCharge_Remote_Ammo" createVehicle getPos player;
	_exp5 attachto [player,[0.17,0.13,0],"Pelvis"];
	[_exp5, 0, 270] call setPitchBank;
	
	_exp6 = "DemoCharge_Remote_Ammo" createVehicle getPos player;
	_exp6 attachto [player,[0.11,0.15,0],"Pelvis"];
	[_exp6, 0, 270] call setPitchBank;

	_exp7 = "DemoCharge_Remote_Ammo" createVehicle getPos player;
	_exp7 attachto [player,[0.05,0.17,0],"Pelvis"];
	[_exp7, 0, 270] call setPitchBank;

	_exp8 = "DemoCharge_Remote_Ammo" createVehicle getPos player;
	_exp8 attachto [player,[-0.01,0.17,0],"Pelvis"];
	[_exp8, 0, 270] call setPitchBank;

	_exp9 = "DemoCharge_Remote_Ammo" createVehicle getPos player;
	_exp9 attachto [player,[-0.06,0.17,0],"Pelvis"];
	[_exp9, 0, 270] call setPitchBank;

	_exp10 = "DemoCharge_Remote_Ammo" createVehicle getPos player;
	_exp10 attachto [player,[-0.12,0.15,0],"Pelvis"];
	[_exp10, 0, 270] call setPitchBank;
	
	[_item, (-1)] call INV_AddInventoreItem;
	if (([player, (civarray + coparray), 40] call INV_Seen) and !iscop) then {
		format [" [""Bomb"", %1] spawn Isse_AddCrimeLogEntry; if(!(""used a bomb"" in %1_reason))then{%1_reason = %1_reason + [""used a bomb""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 50000;", player] call broadcast;
	};	
	[player,5,false] execVM "ammo_burn.sqf";
	call compile format['SFXPvEh_%1 = ["%2","bombscreamsfx"];',rolenumber,rolestring];
	publicVariable format["SFXPvEh_%1", rolenumber];          
	vehicle player say ["bombscreamsfx",100];
	sleep 5;
	{ 
		_c4 = "Grenade" createvehicle (getPosATL _x);
		deletevehicle _x; 
	} foreach (player nearObjects ["DemoCharge_Remote_Ammo",5]);
	sleep 0.65;
	_posx = getPosATL player select 0;
	_posy = getPosATL player select 1;
	_posz = getPosATL player select 2;
	removevest player;
	player addvest (player getvariable "vest");
	player setdamage 1;
	_rocket = "R_60mm_HE" createvehicle [_posx,_posy,_posz+1];
	[_rocket, -90, 0] call setPitchBank;
	sleep 0.4;
	_rocket2 = "R_80mm_HE" createvehicle [_posx,_posy,_posz+1];
	[_rocket2, -90, 0] call setPitchBank;	

};
