private ["_vcl","_item","_type"];
_vcl  	= vehicle player;
_item	= _this select 1;

if (player == _vcl) exitWith {
	["GC_Bad2",["CHAOS LIFE SAT CAM","You must be in a vehicle to install this!"]] spawn bis_fnc_showNotification;
};

  _installing = _vcl getvariable "installing";
  if (!isnil "_installing")exitwith{player groupchat "Already upgrading, try again in a moment."};

[_item, (-1)] call INV_AddInventoreItem;

player groupchat "Installing SatCam monitor and controls...";
_vcl setvariable ["installing", 1, false];
call compile format['SFXPvEh_%1 = ["%2","tunesfx"];',rolenumber,rolestring];
publicVariable format["SFXPvEh_%1", rolenumber];
_vcl say ["tunesfx",100];
_fuel = fuel _vcl;
_vcl setfuel 0;
sleep 10;
_vcl setfuel _fuel;

_vcl setvariable ["satcam",_item, true];
player groupChat "You have installed the SatCam!";
_vcl setvariable ["installing", nil, false];