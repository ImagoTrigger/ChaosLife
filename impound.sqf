_vcl = _this select 0;
_art = _this select 1;

if(_art == "impound")then

{

if ((count crew _vcl) > 0) exitWith {player groupChat "The vehicle is not empty!"};
if(_vcl distance impoundarea2 < 30)exitwith{player groupchat "The vehicle is already out of the impound lot!"};
if(_vcl iskindof "air")exitwith{player groupchat "You cannot impound this vehicle!"};

_incarpark = false;

{if ((player distance (_x select 0)) < (_x select 1)) then {_incarpark = true};} forEach INV_VehicleGaragen;

if(_incarpark)exitwith{player groupchat "this vehicle is in a carpark. you cannot impound it!"};

_vcl setpos [(getPos impoundarea1 select 0)-(random 50)+(random 50), (getPos impoundarea1 select 1)-(random 50)+(random 50), getPos impoundarea1 select 2];

player groupChat localize "STRS_inventar_impound_success";

format['if (!isServer) then {hint format[localize "STRS_inventar_impound_gesehen", %1, %2]};', player, _vcl] call broadcast;

_vcl setdamage 0;
_vcl engineOn false;
//_vcl setvehiclelock "locked";
if (iscop) then {["LandImpounded", player, _vcl] spawn Isse_AddCrimeLogEntry;};
};

if(_art == "buy")then

{

_cash = "cash" call INV_getitemamount;

if(_cash < impoundpay)exitwith{player groupchat "You do not have enough money."};

if(iscop and count (nearestobjects [getpos ccarspawn_3,["Ship","car","motorcycle","truck","tank"], 4]) > 0)exitwith{player groupchat "There is a vehicle blocking the spawn!"};

["cash", -impoundpay] call INV_AddInventoreItem;

_vcl = call compile format["%1", _vcl];
if(isciv)then

	{

	_vcl setpos [(getPos impoundarea2 select 0)-(random 10)+(random 10), (getPos impoundarea2 select 1)-(random 10)+(random 10), getPos impoundarea2 select 2];
	_vcl setdir getdir impoundarea2;

	}else{

	_vcl setpos getpos ccarspawn_3;
	_vcl setdir getdir ccarspawn_3;

	};
	
player groupchat format["You payed the $%1 fine and retrieved your vehicle!", impoundpay];

};





