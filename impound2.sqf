_vcl = _this select 0;
_art = _this select 1;

if(_art == "impound2")then

{

if ((count crew _vcl) > 0) exitWith {player groupChat "The aircraft is not empty!"};
if(_vcl distance impoundarea4 < 30)exitwith{player groupchat "The aircraft is already impounded!"};

_vcl setpos [(getPos impoundarea3 select 0)-(random 50)+(random 50), (getPos impoundarea3 select 1)-(random 50)+(random 50), getPos impoundarea3 select 2];

player groupChat localize "STRS_inventar_impound_success2";

format['if (!isServer) then {hint format[localize "STRS_inventar_impound_gesehen2", %1, %2]};', player, _vcl] call broadcast;

_vcl setdamage 0;
_vcl engineOn false;
//_vcl setvehiclelock "locked";


if (iscop) then {["AirImpounded", player, _vcl] spawn Isse_AddCrimeLogEntry;};

};

if(_art == "buy")then

{

_cash = "cash" call INV_getitemamount;

if(_cash < impoundpay2)exitwith{player groupchat "You do not have enough money."};

if(iscop and count (nearestobjects [getpos cairspawn_0,["Air"], 3]) > 0)exitwith{player groupchat "There is an aircraft blocking the spawn!"};

["cash", -impoundpay2] call INV_AddInventoreItem;

_vcl = call compile format["%1", _vcl];

if(isciv)then

	{

	_vcl setpos [(getPos impoundarea4 select 0)-(random 10)+(random 10), (getPos impoundarea4 select 1)-(random 10)+(random 10), getPos impoundarea4 select 2];
	_vcl setdir getdir impoundarea4;

	}else{

	_vcl setpos getpos cairspawn_0;
	_vcl setdir getdir cairspawn_0;

	};

player groupchat format["You payed the $%1 fine and retrieved your aircraft!", impoundpay2];

};



//Foster

