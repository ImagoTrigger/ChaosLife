_art = _this select 0;

if (_art == "use") then {
  _item    = _this select 1;
  _vcl     = vehicle player;
  _outside = false;
  _vcls    = nearestobjects [player,["LandVehicle", "Air", "Ship","Tank"], 4];

  if (player == _vcl and isNil "_vcls") exitWith {player groupChat "You're not near a vehicle!";};

  if (player == _vcl) then {
  	_vcl     = _vcls select 0;
  	_outside = true;
  };

  if (isNil "_vcl") exitWith {player groupChat "You're not near a vehicle!";};
  if (_outside and count (crew _vcl) > 0) exitWith {player groupChat "The vehicle must be empty!";};

  if (!_outside and player != driver _vcl) exitWith {player groupChat localize "STRS_inv_items_repair_refuel_notdriver";};
  if ((damage _vcl) == 0) exitWith {player groupChat localize "STRS_inv_items_repair_notneeded";};
  if ((_vcl isKindOf "air") and (isEngineOn _vcl)) exitWith {player groupChat "The engine must be turned off to use this";};

  player groupchat "Repairing vehicle ...";
  call compile format['SFXPvEh_%1 = ["%2","repairsfx"];',rolenumber,rolestring];
  publicVariable format["SFXPvEh_%1", rolenumber];
  vehicle player say ["repairsfx",100];

  if (_outside) then {
  	format ["%1 switchmove ""AinvPknlMstpSlayWrflDnon_medic"";", player] call broadcast;
  };

  [_item, -1] call INV_AddInventoreItem;

  _fuel = fuel _vcl;
  _vcl setFuel 0;
  sleep 8;
  _vcl setFuel _fuel;
  _vcl setDamage 0;
  player groupChat localize "STRS_inv_items_repair_repaired";
};