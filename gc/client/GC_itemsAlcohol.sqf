// Alcohol Effects

_art = _this select 0;
if (_art == "init") then {
	INV_alkoholusesperre = 0;
	INV_alkohol_usesperre = FALSE;
	INV_AlkoholCounter = 0;
};
	if (_art == "use") then {
		_item   = _this select 1;
		_anzahl = _this select 2;
 		call compile format['SFXPvEh_%1 = ["%2","drinksfx"];',rolenumber,rolestring];
		publicVariable format["SFXPvEh_%1", rolenumber];
		vehicle player say ["drinksfx",100];
		if (INV_alkoholusesperre == 1) exitWith {player groupChat localize "STRS_inv_item_druguse_toomany";};
		["DrugUse", player, _item] spawn Isse_AddCrimeLogEntry;
		prevWhistles = [-60, -60, -60, -60, -60, -60];
		if (INV_alkohol_usesperre) then {INV_alkoholusesperre = 1;};
		INV_AlkoholCounter =  INV_AlkoholCounter + _anzahl;
		[_item, -(_anzahl)] call INV_AddInventoreItem;
		_endeZeit = time + 45 + (_anzahl * 10);
		_fadeInTime   = 0;
		_fadeOutTime  = 0;
		_faded = false;
		"dynamicBlur" ppEffectEnable true;
		"dynamicBlur" ppEffectAdjust [1];
		"dynamicBlur" ppEffectCommit 4;
		// Normal Beer, Weizenbier, White-Wine
		if (_item == "beer" OR _item == "smirnoff" OR _item == "wine" OR _item == "wine2") then {
			while {time < _endeZeit} do {
				if (not(alive player)) exitWith {};
				//player setdamage ((damage player) - 0.01);
				if (vehicle player == player) then {
					_v1 = velocity player select 0;
					_v2 = velocity player select 1;
					_v3 = 1;
					_v1add = (random 4 - random 4); _v2add = (random 3 - random 3);
					player setVelocity [_v1+_v1add, _v2+_v2add, _v3];
				} else {
					_d = direction vehicle player;
					_dAdd = (random 30) - 15;
					vehicle player setDir (_d + _dAdd);
				};
				if (time > _fadeInTime) then {
					titleCut ["","BLACK OUT",0];
					_fadeOutTime = time + 1;
					_fadeInTime  = time + 5;
					_faded = false;
				};
				if ((time > _fadeOutTime) and (!_faded)) then {
					titleCut ["","BLACK IN",0];
					_faded = true;
				};
				sleep 1;
			};
		};
		if (_item == "Vodka" OR _item == "beer2" OR _item == "whiskey") then {
			while {time < _endeZeit} do {
				if (not(alive player)) exitWith {};
				//player setdamage ((damage player) - 0.01);
				if (vehicle player == player) then {
					_v1 = velocity player select 0;
					_v2 = velocity player select 1;
					_v3 = 1;
					_v1add = (random 10 - random 8); _v2add = (random 12 - random 10);
					player setVelocity [_v1+_v1add, _v2+_v2add, _v3];
				} else {
					_d = direction vehicle player;
					_dAdd = (random 30) - 15;
					vehicle player setDir (_d + _dAdd);
				};
				if (time > _fadeInTime) then {
					titleCut ["","BLACK OUT",0];
					_fadeOutTime = time + 1;
					_fadeInTime  = time + 10;
					_faded       = false;
				};
				if ((time > _fadeOutTime) and (!_faded)) then {
					titleCut ["","BLACK IN",0];
					_faded = true;
				};
				sleep 1;
			};
		};
		titleCut ["","BLACK IN",0];
		sleep 10;
		player groupChat localize "STRS_inv_item_druguse_ende";
		INV_alkoholusesperre = 0;
		INV_AlkoholCounter =  INV_AlkoholCounter - _anzahl;

		"dynamicBlur" ppEffectAdjust [0];
		"dynamicBlur" ppEffectCommit 4;
		"dynamicBlur" ppEffectEnable false;
	};