_art = _this select 0;

if (_art == "use") then  {
	_item    = _this select 1;
	_class	 = "Land_Razorwire_F";

	[_item, -1] call INV_AddInventoreItem;	

	_pos = [(position player select 0) + (sin(getdir player)*2), (position player select 1) + (cos(getdir player)*2), 0];

	call compile format['
	%1%2 = "%2" createvehicle [0, 0, 0];
	%1%2 setdir getdir %1;
	%1%2 setpos %3;
	%1%2 setDammage 1;
	%1%2 setvehiclevarname "%1%2";
	[[[%1%2,"%1%2"],"gc\global\GC_onVehicleCreated.sqf"],"BIS_fnc_execVM",true,true] call BIS_fnc_MP;
	', rolestring, _class,_pos];
	sleep 1;
	(format ["publicarbeiterarctionarray = publicarbeiterarctionarray + [ [%1%2, %1] ];", rolestring, _class]) call broadcast_srv;
};
