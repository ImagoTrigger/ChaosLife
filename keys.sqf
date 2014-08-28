 private ["_index","_hascaralarm","_vcl","_spielernum","_spieler","_playerobject","_art"];
_art = _this select 0;

if (_art == "use") then {

  if (!(createDialog "RscMenuKeys")) exitWith {
    hint "Dialog Error!";
  };

  // Populate vehicles.
  {
    if (not(isnull _x)) then {
      _index = lbAdd [1, format ["%1 (%2) - %3 Meters", (typeOf _x) call INV_getitemName, _x, round(player distance _x)]];
      lbSetData [1, _index, format ["%1", _x]];
    };
  } forEach INV_VehicleArray;

  // Populate Players Dropdown.
  {
    if (_x call ISSE_UnitExists and _x != "ChaosBot") then {
      _index = lbAdd [2100, format ["%1 - (%2)", _x, name (call compile _x)]];
      lbSetData [2100, _index, format["%1", _forEachIndex]];
    };
  } forEach INV_PLAYERSTRINGLIST;

  // Select first player
  lbSetCurSel [2100, 0];


  buttonSetAction [2, "if ((lbCurSel 1) > -1) then {[""schluessel"", (INV_VehicleArray select lbCurSel 1), lbCurSel 1] execVM ""keys.sqf"";};closedialog 0;"];

  buttonSetAction [4, "if ((lbCurSel 1) > -1) then {[""dropschluessel"", (INV_VehicleArray select lbCurSel 1), lbCurSel 1] execVM ""keys.sqf"";};closedialog 0;"];

  buttonSetAction [5, "if ((lbCurSel 1) > -1) then {[""schluesseluebergabe"", (INV_VehicleArray select lbCurSel 1), lbCurSel 1, call compile lbData [2100, lbCurSel 2100]] execVM ""keys.sqf"";};closedialog 0;"];
};

if (_art == "schluessel") then {
  _vcl = _this select 1;

  if (player distance _vcl < 10) then {
    if (locked _vcl == 0) then {
      format ["%1 lock 2;", _vcl] call broadcast;
      player groupChat localize "STRS_inv_items_vehiclelock_locked";
      _hascaralarm = _vcl getvariable "caralarm";
      if (!isNil "_hascaralarm") then {
        call compile format['SFXPvEh_%1 = ["%2","armsfx",1];',rolenumber,rolestring];
        publicVariable format["SFXPvEh_%1", rolenumber];
        _vcl spawn {_this say "armsfx";};
      } else {
        call compile format['SFXPvEh_%1 = ["%2","locksfx",1];',rolenumber,rolestring];
        publicVariable format["SFXPvEh_%1", rolenumber];
        _vcl spawn {_this say "locksfx";};
      };

    } else {
      format ["%1 lock 0;", _vcl] call broadcast;
      player groupChat localize "STRS_inv_items_vehiclelock_unlocked";
      call compile format['SFXPvEh_%1 = ["%2","unlocksfx",1];',rolenumber,rolestring];
      publicVariable format["SFXPvEh_%1", rolenumber];
      _vcl spawn {_this say "unlocksfx";};
    };
  } else {
    player groupChat localize "STRS_inv_items_vehiclelock_closer";
  };
};

if (_art == "dropschluessel") then {
  _vcl = _this select 1;

  INV_VehicleArray = INV_VehicleArray - [_vcl];
  player groupChat localize "STRS_inv_items_weggeworfen";
};

if (_art == "schluesseluebergabe") then {
  _vcl = _this select 1;
  _player = _this select 3;
  _spieler = INV_PLAYERSTRINGLIST select _player;
  _playerobject = INV_PLAYERLIST select _player;

  if (!(_spieler call ISSE_UnitExists))  exitWith {
    player groupChat localize "STRS_inv_not_ingame";
  };

  if (_playerobject == player)  exitWith {
    player groupChat localize "STRS_inv_inventar_uebergabe_self";
  };

  if (player distance _playerobject > 20)  exitWith {
    player groupChat localize "STRS_inv_inventar_uebergabe_distance";
  };

  format ["if (INV_ROLESTRING == ""%1"") then {INV_VehicleArray = INV_VehicleArray + [%2];player groupChat localize ""STRS_inv_items_uebergabe_schluessel_success""};", _spieler, _vcl] call broadcast;
  //INV_VehicleArray = INV_VehicleArray - [_vcl];
  player groupChat localize "STRS_inv_items_uebergabe_schluessel_success_self";
};
