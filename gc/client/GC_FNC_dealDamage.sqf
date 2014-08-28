GC_dealDamage = {
	diag_log text format["GC_dealDamage: %1",_this];
	private ["_damage","_selection","_shooter","_ammo","_nearVehicles"];
	_nearVehicles = nearestObjects [vehicle player, ["LandVehicle","Air","Ship"], 15] - [vehicle player];
	_selection = _this select 0;
	_damage    = _this select 1;
	_shooter   = _this select 2;
	_ammo   = _this select 3;
	if (!(call GC_PlayerInCrimeFree)) then {
		if (!(iscop and (call GC_PlayerInCopBase))) then {				
			if (alive player) then {
				_damage = [_selection,_damage,_ammo] call GC_DamageModifier;
				player SetHit [_selection, _damage];
				if ((damage player + _damage) >= 1 and _selection != "") then {
					player setdamage 1;
					if (_ammo != "") then { 
						diag_log text "calling victim from damage w ammo";
						[_shooter, _nearVehicles, _ammo] call GC_Victim;
					} else {
						if (count _nearVehicles != 0) then {
							diag_log text "calling victim from damage (no ammo, check if shooter is a vehicle)";
							[_shooter, _nearVehicles, _ammo] call GC_Victim;
						} else {
							diag_log "unhandled lethal damage (no ammo, no nearby vehicle)!";
						};
					};
				} else {
					if ((damage player + _damage) >= 1) then {
						player setdamage 1;
						diag_log text "calling victim from damage (no ammo, no selection)";
						[_shooter, _nearVehicles, _ammo] call GC_Victim;
					} else {
						diag_log "unhandled non-lethal damage (no selection)!";
					};
				};
			};
		} else {
			_damage = 0;
		};
	} else {
		_damage = 0;
	};
_damage;
};