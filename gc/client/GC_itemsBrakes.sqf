_art = _this select 0;

if (_art == "use") then

{

_item = _this select 1;
_vcl  = vehicle player;
_type	= typeof _vcl;

if(_vcl getvariable["brakes",0] == 1)exitwith{["GC_HandBad",["CHAOS LIFE TUNING","This vehicle already has brake upgrades installed."]] spawn bis_fnc_showNotification;};
if (player == _vcl) exitWith {player groupChat localize "STRS_inv_items_speed_car"};
if ((_vcl iskindof "Air") or _type call INV_getitemTypeKg > 2 or _type in notuning) exitWith {["GC_HandBad",["CHAOS LIFE TUNING","You can't tune this vehicle!"]] spawn bis_fnc_showNotification;};
_installing = _vcl getvariable "installing";
if (!isnil "_installing")exitwith{player groupchat "Already upgrading, try again in a moment."};

[_item, -1] call INV_AddInventoreItem;
player groupchat "Tuning vehicle...";
call compile format['SFXPvEh_%1 = ["%2","tunesfx"];',rolenumber,rolestring];
publicVariable format["SFXPvEh_%1", rolenumber];
vehicle player say "tunesfx";
_vcl setvariable ["installing", 1, false];
_fuel = fuel _vcl;
_vcl setfuel 0;
sleep 10;
_vcl setfuel _fuel;
_vcl setvariable ["brakes", 1, true];
player groupchat "Upgraded brakes installed!!";
sleep 2;
player groupchat "Press and hold X to activate brakes!";
_vcl setvariable ["installing", nil, false];
};



