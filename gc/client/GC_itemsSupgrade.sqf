_art  = _this select 0;
_item = _this select 1;
_vcl  = vehicle player;
_type = typeof _vcl;

if (_art == "use") then {
  if (_vcl == player) exitwith { ["GC_HandBad",["CHAOS LIFE TUNING","You must be in a vehicle!"]] spawn bis_fnc_showNotification;};
  if (_vcl iskindof "Motorcycle" or _type call INV_getitemTypeKg > 2 or _type in notuning) exitwith {["GC_HandBad",["CHAOS LIFE TUNING","You can't tune this vehicle!"]] spawn bis_fnc_showNotification;};
  if (_vcl iskindof "tank" and ( _item == "supgrade2" or _item == "supgrade3" or _item == "supgrade4" or _item == "supgrade5")) exitwith {
  	["GC_HandBad",["CHAOS LIFE TUNING","You can only tune tanks with 1.0L Engine Upgrade."]] spawn bis_fnc_showNotification;
  };
  _installing = _vcl getvariable "installing";
  if (!isnil "_installing")exitwith{player groupchat "Already upgrading, try again in a moment."};

  [_item, -1] call INV_AddInventoreItem;
  call compile format['SFXPvEh_%1 = ["%2","tunesfx"];',rolenumber,rolestring];
  publicVariable format["SFXPvEh_%1", rolenumber];
  vehicle player say "tunesfx";
  _vcl setvariable ["installing", 1, false];
  _au = false;
  if (_item == "supgrade1" and _vcl getvariable["tuning",0] < 1) then {player groupchat "Tuning vehicle..."; _fuel = fuel _vcl; _vcl setfuel 0; sleep 6;  _vcl setfuel _fuel; _vcl setvariable ["tuning", 1, true]; player groupchat "Vehicle tuned!";} else {_au = true;};
  if (_item == "supgrade2" and _vcl getvariable["tuning",0] < 2) then {_au = false; player groupchat "Tuning vehicle..."; _fuel = fuel _vcl; _vcl setfuel 0; sleep 7;  _vcl setfuel _fuel; _vcl setvariable ["tuning", 2, true]; player groupchat "Vehicle tuned!";} else {_au = true;};
  if (_item == "supgrade3" and _vcl getvariable["tuning",0] < 3) then {_au = false; player groupchat "Tuning vehicle..."; _fuel = fuel _vcl; _vcl setfuel 0; sleep 8;  _vcl setfuel _fuel; _vcl setvariable ["tuning", 3, true]; player groupchat "Vehicle tuned!";} else {_au = true;};
  if (_item == "supgrade4" and _vcl getvariable["tuning",0] < 4) then {_au = false; player groupchat "Tuning vehicle..."; _fuel = fuel _vcl; _vcl setfuel 0; sleep 9;  _vcl setfuel _fuel; _vcl setvariable ["tuning", 4, true]; player groupchat "Vehicle tuned!";} else {_au = true;};
  if (_item == "supgrade5" and _vcl getvariable["tuning",0] < 5) then {_au = false; player groupchat "Tuning vehicle..."; _fuel = fuel _vcl; _vcl setfuel 0; sleep 10; _vcl setfuel _fuel; _vcl setvariable ["tuning", 5, true]; player groupchat "Vehicle tuned!";} else {_au = true;};
  if (_au) then {
  	["GC_HandBad",["CHAOS LIFE TUNING","This vehicle's engine is already upgraded!"]] spawn bis_fnc_showNotification;
  };
   _vcl setvariable ["installing",nil, false];
};