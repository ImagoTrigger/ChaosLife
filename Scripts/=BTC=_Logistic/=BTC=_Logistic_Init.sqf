/*
Created by =BTC= Giallustio
Version: 0.52
Date: 05/02/2012
Visit us at: http://www.blacktemplars.altervista.org/
You are not allowed to modify this file and redistribute it without permission given by me (Giallustio).
*/
//Lift
BTC_lift_pilot   = []; //all player classes
BTC_lift         = 1;
BTC_lifted       = 0;
BTC_lift_min_h   = 4;
BTC_lift_max_h   = 18;
BTC_lift_radius  = 4;
BTC_cargo_lifted = objNull;
BTC_Liftable     = ["Motorcycle","Bicycle","ATV","LandVehicle","Car"];
BTC_Hud_Cond     = false;
BTC_HUD_x        = (SafeZoneW+2*SafeZoneX) + 0.045;
BTC_HUD_y        = (SafeZoneH+2*SafeZoneY) + 0.045;
_lift = [] execVM "scripts\=BTC=_Logistic\=BTC=_Lift\=BTC=_LiftInit.sqf";

//Cargo System
/*
BTC_Obj_Dragged      = objNull;
BTC_Veh_Selected     = objNull;
BTC_Dragging         = false;
BTC_Draggable        = ["ReammoBox"];
BTC_Load_In_Vehicles = ["Tank","Wheeled_APC","Truck","Car","Helicopter","C130J","C130J_US_EP1"];
{if (format ["%1", _x getVariable "BTC_Cannot_Drag"] != "1") then {_name = getText (configFile >> "cfgVehicles" >> typeof _x >> "displayName");_x addAction [("<t color=""#ED2744"">" + "Drag " + (_name) + "</t>"),"scripts\=BTC=_Logistic\=BTC=_Cargo_System\=BTC=_Drag.sqf", "", 7, true, true];};} foreach (nearestObjects [player, BTC_Draggable, 50000]);
*/

//Functions
BTC_get_liftable_array =
{
	_chopper = _this select 0;
	_array   = [];
	switch (typeOf _chopper) do
	{
		case "MH6J_EP1"        : {_array = ["Motorcycle","Bicycle","ATV_Base_EP1"];};
		case "AH6J_EP1"        : {_array = ["Motorcycle","Bicycle","ATV_Base_EP1"];};
		case "AH6X_EP1"        : {_array = ["Motorcycle","Bicycle","ATV_Base_EP1"];};
		case "B_AH9_F"		: {_array = ["Motorcycle","Bicycle","ATV_Base_EP1"];};
		case "B_MH9_F"		: {_array = ["Motorcycle","Bicycle","ATV_Base_EP1"];};
		case "O_Ka60_F"		: {_array = ["Motorcycle","Bicycle","ATV_Base_EP1","LandVehicle","Car"];};
		case "O_Ka60_Unarmed_F": {_array = ["Motorcycle","Bicycle","ATV_Base_EP1","LandVehicle","Car"];};
		case "UH1H_TK_GUE_EP1" : {_array = ["Motorcycle","Bicycle","ATV_Base_EP1","LandVehicle","Car"];};
		case "UH1H_TK_EP1"     : {_array = ["Motorcycle","Bicycle","ATV_Base_EP1","LandVehicle","Car"];};
		case "UH60M_EP1"       : {_array = ["Motorcycle","Bicycle","ATV_Base_EP1","LandVehicle","Car"];};
		case "MH60S"           : {_array = ["Motorcycle","Bicycle","ATV_Base_EP1","LandVehicle","Car"];};
		case "Mi17_Civilian"   : {_array = ["Motorcycle","Bicycle","ATV_Base_EP1","LandVehicle","Car"];};
		case "Mi17_TK_EP1"     : {_array = ["Motorcycle","Bicycle","ATV_Base_EP1","LandVehicle","Car"];};
		case "Mi24_D_TK_EP1"   : {_array = ["Motorcycle","Bicycle","ATV_Base_EP1","LandVehicle","Car"];};
		case "Mi171Sh_CZ_EP1"  : {_array = ["Motorcycle","Bicycle","ATV_Base_EP1","LandVehicle","Car"];};
		case "BAF_Merlin_HC3_D": {_array = ["Motorcycle","Bicycle","ATV_Base_EP1","LandVehicle","Car"];};
		case "CH_47F_EP1"      : {_array = ["Motorcycle","Bicycle","ATV_Base_EP1","LandVehicle","Car"];};
		case "CH_47F_BAF"      : {_array = ["Motorcycle","Bicycle","ATV_Base_EP1","LandVehicle","Car"];};
	};
	_array
};
BTC_obj_fall =
{
	_obj    = _this select 0;
	_height = getPos _obj select 2;
	_fall   = 0.09;
	while {(getPos _obj select 2) > 1} do
	{

		_fall = (_fall * 1.1);
		_obj setPos [getPos _obj select 0, getPos _obj select 1, _height];
		_height = _height - _fall;
		sleep 0.01;
	};
	_obj setPos [getPos _obj select 0, getPos _obj select 1, 0];
};
BTC_paradrop =
{
	_Veh          = _this select 0;
	_dropped      = _this select 1;
	_chute_type   = _this select 2;
	private ["_chute"];
	_dropped_type = typeOf _dropped;
	if (typeOf _Veh == "MH6J_EP1") then {_chute = createVehicle [_chute_type, [((position _Veh) select 0) - 5,((position _Veh) select 1) - 10,((position _Veh) select 2)- 4], [], 0, "NONE"];} else {_chute = createVehicle [_chute_type, [((position _Veh) select 0) - 5,((position _Veh) select 1) - 3,((position _Veh) select 2)- 4], [], 0, "NONE"];};
	_smoke        = "SmokeshellGreen" createVehicle position _Veh;
    	_smoke attachto [_dropped,[0,0,0]];
	_dropped attachTo [_chute,[0,0,0]];
	while {getPos _chute select 2 > 2} do {sleep 1;};
	detach _dropped;
	if (_dropped_type isKindOf "ReammoBox") then {_dropped setPosATL [getpos _dropped select 0, getpos _dropped select 1, 0];};
};
BTC_hint = {_text  = _this select 0;_sleep = _this select 1;hintSilent _text;sleep _sleep;hintSilent "";};