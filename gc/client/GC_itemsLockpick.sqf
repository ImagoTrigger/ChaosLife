_art = _this select 0;

if (_art == "use") then {
  _item      = _this select 1;
  _anzahl    = _this select 2;
  _closeVcl  = dummyobj;
  _closest   = -1;
  _incarpark = false;

  {
    if (!isnull _x) then {
      if (player distance _x < 7 and (player distance _x < _closest or _closest == -1)) then {
        _closest  = (player distance _x);
        _closeVcl = _x;
      };
    };
  } forEach INV_ServerVclArray;

  if (!(call GC_PlayerInCrimeFree)) then {
    if (not(_closest == -1)) then {
      // Already picked.
      if (_closeVcl in INV_VehicleArray) then {
        player groupchat localize "STRS_inventar_lockpick_already";
      } else {
        {
          if ((player distance (_x select 0)) < (_x select 1)) then {_incarpark = true};
        } forEach INV_VehicleGaragen;

        // Success!
        if ((random 100) < floor(lockpickchance + (0.75 * SKILL_LOCKPICKING))) then {
          INV_VehicleArray = INV_VehicleArray + [_closeVcl];
          player groupChat localize "STRS_inventar_lockpick_success";
          call compile format['SFXPvEh_%1 = ["%2","pick4sfx"];',rolenumber,rolestring];
          publicVariable format["SFXPvEh_%1", rolenumber];
          vehicle player say ["pick4sfx",100];
          _addskill = (1 / 150);
           ["SKILL_LOCKPICKING",_addskill] call GC_addSkill;

          // If there are cops or players around.
          if (([player, (civarray + coparray), 40] call INV_Seen or _incarpark) and !iscop) then {
            format [" [""StoleVcl"", %1, %2] spawn Isse_AddCrimeLogEntry; if(!(""vehicle theft"" in %1_reason))then{%1_reason = %1_reason + [""vehicle theft""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 10000; hint format[localize ""STRS_inventar_lockpick_gesehen"",%1, %2]; ", player, _closeVcl] call broadcast;
          };

          if (_closeVcl getvariable "caralarm" == 1) then {
            call compile format['SFXPvEh_%1 = ["%2","armsfx"];',rolenumber,_closeVcl];
            publicVariable format["SFXPvEh_%1", rolenumber];
            _closeVcl say ["armsfx",100];
          };

        } else {
          // Failure.
          player groupChat localize "STRS_inventar_lockpick_noluck";
          _addskill = (1 / 200);
          ["SKILL_LOCKPICKING",_addskill] call GC_addSkill;

          // If there are cops or civs around.
          if (([player, (civarray + coparray), 40] call INV_Seen or _incarpark) and !iscop) then {
            format [" [""AttemptedStoleVcl"", %1, %2] spawn Isse_AddCrimeLogEntry; if(!(""attempted vehicle theft"" in %1_reason))then{%1_reason = %1_reason + [""attempted vehicle theft""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 2000; hint ""%1 was seen attempting to lockpick a vehicle (Registration plate: %2)"";", player, _closeVcl] call broadcast;
          };

          if (_closeVcl getvariable "caralarm" == 1) then {
		if (time >= (_closeVcl getvariable "nextalarmtime")) then {
 			call compile format['SFXPvEh_%1 = ["%2","caralarm1sfx",15];',rolenumber,_closeVcl];
			publicVariable format["SFXPvEh_%1", rolenumber];
			_closeVcl say ["caralarm1sfx",100];
			_closeVcl setVariable ["nextalarmtime", (time + 15), true];
			_closeVcl spawn {
				for "_i" from 1 to 15 do {
					impoundbuy action["LIGHTON",_this];
					sleep 0.5;
					impoundbuy action["LIGHTOFF",_this];
					sleep 0.5;
				};
			};
		};
          };

          PickArray = [
            "pick1sfx",
            "pick2sfx",
            "pick3sfx"
          ];
          _current = floor(random (count PickArray));
          _picksfx = format["%1", PickArray select _current];
		call compile format['SFXPvEh_%1 = ["%2","%3"];',rolenumber,rolestring,_picksfx];
		publicVariable format["SFXPvEh_%1", rolenumber];
	        vehicle player say [_picksfx,1];
        };

        // Take away lockpick.
        [_item, -1] call INV_AddInventoreItem;
      };
    } else {
      // Care is too far away.
      player groupChat localize "STRS_inventar_lockpick_zuweit";
    };
  } else {
    player groupChat "You cannot pick cars in the crime free zone!";
  };
};
