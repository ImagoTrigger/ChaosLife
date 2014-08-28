_art = _this select 0;

if (_art == "use") then 

{

_item   = _this select 1;
_anzahl = _this select 2;

if(vehicle player != player)exitwith{player groupchat "You cannot use this in a vehicle!"};

[_item, -1] call INV_AddInventoreItem;
player call INV_heal;

};

