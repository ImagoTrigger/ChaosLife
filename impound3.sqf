_vcl = _this select 0;
_art = _this select 1;

if(_art == "impound3")then

{

if ((count crew _vcl) > 0) exitWith {player groupChat "The boat is not empty!"};
if(_vcl distance boatimpoundarea < 30)exitwith{player groupchat "The boat is already impounded!"};

_vcl setpos [(getPos boatyard select 0)-(random 75)+(random 75), (getPos boatyard select 1)-(random 75)+(random 75), getPos boatyard select 2];

player groupChat localize "STRS_inventar_impound_success3";

format['if (!isServer) then {hint format[localize "STRS_inventar_impound_gesehen3", %1, %2]};', player, _vcl] call broadcast;

_vcl setdamage 0;
_vcl engineOn false;
//_vcl setvehiclelock "locked";


if (iscop) then {["BoatImpounded", player, _vcl] spawn Isse_AddCrimeLogEntry;};

};

if(_art == "buy")then

{

_cash = "cash" call INV_getitemamount;

if(_cash < impoundpay3)exitwith{player groupchat "You do not have enough money."};

if(count (nearestobjects [getpos boatimpoundarea,["Boat"], 3]) > 0)exitwith{player groupchat "There is a boat blocking the spawn!"};

["cash", -impoundpay3] call INV_AddInventoreItem;

_vcl = call compile format["%1", _vcl];

_vcl setpos getpos boatimpoundarea;
_vcl setdir getdir boatimpoundarea;


player groupchat format["You payed the $%1 fine and retrieved your boat!", impoundpay2];

};



//Foster

