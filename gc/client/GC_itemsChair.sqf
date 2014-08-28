private ["_opt","_item","_chair","_model","_brug","_carpet","_rotate","_chairname"];
_opt  = _this select 0;
_item = _this select 1;

if (count _this > 2) then {
	if (TypeName (_this select 3) == "ARRAY") then {
		if (count (_this select 3) > 1) then {
			_opt = (_this select 3 select 0);
			_item = (_this select 3 select 1);
			_chairname = (_this select 3 select 2);
		};
	};
};

if (_opt == "use") then {
	if (surfaceIsWater position player) exitWith {
		["GC_Bad2",["CHAOS LIFE CHAIRS","You can't use your chair in the water!"]] spawn bis_fnc_showNotification;
	};
	_model = "Land_ChairPlastic_F";
	_brug = false;
	_bshade = false;
	_carpet = objnull;
	_rotate = 90;
	switch (_item) do {
		 case "chair":  {
		 	_model = "Land_ChairPlastic_F";
		 	_rotate = 90;
		 };
		 case "chair_rug":  {
		 	_model = "Land_ChairPlastic_F";
		 	_brug = true;
		 	_rotate = 90;
		 };
		 case "bench":  {
		 	_model = "Land_Bench_F";
		 	_rotate = 90;
		 };
		 case "bench_rug":  {			//<------- not so hot in A3 Alpha 0.54
		 	_model = "Land_Bench_F";
		 	_brug = true;
		 	_rotate = 90;
		 };
		 case "wood_chair":  {
		 	_model = "WoodChair";
		 	_rotate = 180;
		 };
		 case "wood_chair_rug":  {
		 	_model = "WoodChair";
		 	_brug = true;
		 	_rotate = 180;
		 };
		 case "a3_camping_chair": {
		 	_model = "Land_CampingChair_V2_F";
		 	_rotate = 180;
		 };
		 case "a3_sun_chair": {
		 	_model = "Land_Sun_chair_F";
		 	_rotate = 0;
		 };
		 case "a3_camping_chair_rug": {
		 	_model = "Land_CampingChair_V2_F";
		 	_brug = true;
		 	_rotate = 180;
		 };
		 case "a3_sun_chair_shade": {
		 	_model = "Land_Sun_chair_F";
		 	_bshade = true;
		 	_rotate = 0;
		 };
	};
	if(vehicle player != player)exitwith{player groupchat "You cannot use this in a vehicle!"};
	if (player distance getMarkerPos "jailarea" <= 30) exitWith { hint "You cannot take out your chair while in jail."; };
	_weapons = weapons player;
	_weparray = _weapons - nonlethalweapons;
	_allpistol = true;
	{
		if ([_x] call isPistol) then {
			_allpistol = true;
		} else {
			_allpistol = false;
		};
	} foreach _weparray;

	if (!_allpistol) exitWith {player GroupChat "Drop the large weapon in order to take out your chair!";};
	if (count _weparray > 0 and _allpistol) then {
		if (('piastole' call INV_GetItemAmount) <= 0) then {
			player removeaction unholsterPistol;
			_pc_handle = [false,false,false,[true]] execVM "pistolControl.sqf";
			waituntil{sleep 0.1; scriptDone _pc_handle};
			player removeaction unholsterPistol;
		};
	};
	if (_brug) then {
		_carpet = "Land_Pallet_F" createVehicle getPosATL player;
	};
	if (_bshade) then {
		_carpet = "Land_Sunshade_F" createVehicle getPosATL player;
	};
	_chair = _model createVehicle getPosATL player;
	_chair disableCollisionWith player;
	_chair setPosATL (getPosATL player);
	_chair setDir (getDir player);
	if (_brug or _bshade) then {
		_carpet disableCollisionWith _chair;
		_carpet setPosATL (getPosATL _chair);
		_carpet setDir (getDir _chair);
		if (_bshade) then {
			_spos = getpos _carpet;
			_sx = _spos select 0;
			_sy = _spos select 1;
			_carpet setpos [_sx-1,_sy-1];
		}
	};
	player setDir ((getDir _chair) + 90);
	if (_model == "Land_Sun_chair_F") then {
		player enableCollisionWith _chair;
		(format ["%1 switchmove ""%2"";", player, "AinjPpneMstpSnonWnonDnon_injuredHealed"]) call broadcast;
		player setDir (getDir player - 180);
		_ppos = getpos player;
		_px = _ppos select 0;
		_py = _ppos select 1;
		_pz = _ppos select 2;
		player setpos [_px,_py,_pz+0.3];
	} else {
		(format ["%1 switchmove ""%2"";", player, "Crew"]) call broadcast;
	};
	_chair setDir ((getDir _chair) - _rotate);
	player setDir ((getDir player) - 90);

	[_chair,_carpet] spawn {
		_chair = _this select 0;
		_carpet = _this select 1;
		while {true} do {
			if (player distance _chair > 1) exitWith {
				(format ["%1 switchmove ""%2"";", player, ""]) call broadcast;
				player removeAction chairaction;
				deletevehicle _chair;
				deletevehicle _carpet;
				chairaction = -1;
			};
			sleep 0.5;
			player removeaction unholsterPistol;
		};
	};
	chairaction = player addAction ["Get up","gc\client\GC_itemsChair.sqf",["GetUp",_model,_item]];
	player GroupChat "You are now sitting in your chair!";
	[_item, (-1)] call INV_AddInventoreItem;
};

if (_opt == "GetUp") then {
	if (('pistole' call INV_GetItemAmount) > 0) then {
		player removeaction unholsterPistol;
		unholsterPistol = player addAction ["Unholster Pistol","pistolControl.sqf",[false]];
	};
	player removeAction chairaction;
	chairaction = -1;
	_chair = getPosATL player nearestObject _item;
	_carpet = getPosATL player nearestObject "Land_Pallet_F";
	_umb = getPosATL player nearestObject "Land_Sunshade_F";
	(format ["%1 switchmove ""%2"";", player, ""]) call broadcast;
	deletevehicle _chair;
	deletevehicle _carpet;
	deletevehicle _umb;

	player GroupChat "You have put your chair away!";
	[_chairname, (+1)] call INV_AddInventoreItem;
};
