private ["_vcl","_type"];
_vcl  	= vehicle player;
_type	= typeof _vcl;

if (_vcl getvariable "radar" == 1) exitwith {
	player groupchat "This vehicle already has a radar installed.";
};

if (player == _vcl) exitWith {
	player groupChat localize "STRS_inv_items_speed_car";
};

if (!(_vcl iskindof "LandVehicle") or _type call INV_getitemTypeKg > 2) exitWith {
	player groupChat "You can't install a radar in this thing!";
};

  _installing = _vcl getvariable "installing";
  if (!isnil "_installing")exitwith{player groupchat "Already upgrading, try again in a moment."};

['radar', (-1)] call INV_AddInventoreItem;
player groupchat "Installing speed radar...";
_vcl setvariable ["installing", 1, false];
call compile format['SFXPvEh_%1 = ["%2","tunesfx"];',rolenumber,rolestring];
publicVariable format["SFXPvEh_%1", rolenumber];
vehicle player say ["tunesfx",100];
_fuel = fuel _vcl;
_vcl setfuel 0;
sleep 10;
_vcl setfuel _fuel;
_vcl setvariable ["radar", 1, true];
_vcl execVM "gc\client\GC_Radar.sqf";
player groupChat "You have installed the Speed Radar!";
_vcl setvariable ["installing", nil, false];