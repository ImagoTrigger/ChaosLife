private ["_vcl","_item","_type"];
_vcl  	= vehicle player;
_item	= _this select 1;

if (player == _vcl) exitWith {
	player groupChat localize "STRS_inv_items_speed_car";
};

if (!(_vcl iskindof "LandVehicle") or _type call INV_getitemTypeKg > 2) exitWith {
	player groupChat "You can't install a custom horn in this thing!";
};

  _installing = _vcl getvariable "installing";
  if (!isnil "_installing")exitwith{player groupchat "Already upgrading, try again in a moment."};

[_item, (-1)] call INV_AddInventoreItem;

player groupchat "Installing Custom Horn...";
_vcl setvariable ["installing", 1, false];
call compile format['SFXPvEh_%1 = ["%2","tunesfx"];',rolenumber,rolestring];
publicVariable format["SFXPvEh_%1", rolenumber];
_vcl say ["tunesfx",100];
_fuel = fuel _vcl;
_vcl setfuel 0;
sleep 10;
_vcl setfuel _fuel;

_vcl setvariable ["customhorn",_item, true];
player groupChat "You have installed the Custom Horn (H key)!";
_vcl setvariable ["installing", nil, false];