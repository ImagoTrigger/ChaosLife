_art = _this select 0;

if (_art == "use") then 

{

_item    = _this select 1;
_class	 = _item call INV_getitemClassName;
_exitvar = 0;

if (player != vehicle player) exitWith {player groupChat localize "STRS_inv_item_sperre_invcl";};

	{

	if (player distance (_x select 0) < (_x select 1)) exitWith 

		{

		_exitvar = 1;
		player groupChat localize "STRS_inv_item_sperre_hiernicht";

		};

	} forEach INV_SperrenVerbotArray;

if (_exitvar == 1) exitWith {};

[_item, -1] call INV_AddInventoreItem;	

_pos = [(position player select 0) + (sin(getdir player)*2), (position player select 1) + (cos(getdir player)*2), 0];
_obj = _class createvehicle [0, 0, 0];
_obj setdir getdir player;
_obj setpos _pos;
_time = round time;
_obj setvehiclevarname format['%1%2%3', player, _class, _time];
//call compile format['%1%2%3 = %4;', player, _class, _time,_obj];
(format ["publicarbeiterarctionarray = publicarbeiterarctionarray + [ [%1%2%3, %1] ];", player, _class, _time]) call broadcast_srv;

_counter = 0;

while{alive _obj} do

	{

	if(player distance _obj > 300)then{_counter = _counter + 1}else{_counter = 0};

	if(_counter > 55 and _counter < 55)then{player groupchat "WARNING: you have been away from one of your objects for almost an hour, it will despawned in 5 minutes!";};

	if(_counter > 60)exitwith{player groupchat "you have been away from one of your objects for more than an hour so it has despawned!"; deletevehicle _obj};

	sleep 60;

	};

};