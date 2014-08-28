private ["_item","_art"];
_art = _this select 0;
if (_art == "use") then {
	_item   = _this select 1;
	if (player == vehicle player)  exitWith {
		["GC_Bad2",["CHAOS LIFE BOMBS","You must arm this inside a vehicle!"]] spawn bis_fnc_showNotification;		
	};
	if ((damage vehicle player) >= 0.95) exitWith {
		["GC_Bad2",["CHAOS LIFE BOMBS","This vehicle is already destroyed!"]] spawn bis_fnc_showNotification;
	};																							   
	if (call GC_PlayerInCrimeFree) exitWith {
		["GC_Bad2",["CHAOS LIFE BOMBS","You can't plant a bomb inside the No Crime Zone!"]] spawn bis_fnc_showNotification;
	};
	_veh = vehicle player;
	_veh setvariable["bomber",player,true];
	[_item, (-1)] call INV_AddInventoreItem;
	if (!(_veh isKindOf "bicycle")) then {[_veh,15,false] execVM "ammo_burn.sqf";};
	player groupchat "The bomb has been armed!! GET OUT QUICKLY BEFORE IT EXPLODES!";
	if (([player, (civarray + coparray), 40] call INV_Seen) and !iscop) then {
		format [" [""Bomb"", %1] spawn Isse_AddCrimeLogEntry; if(!(""used a bomb"" in %1_reason))then{%1_reason = %1_reason + [""used a bomb""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 50000;", player] call broadcast;
	};	
	call compile format['SFXPvEh_%1 = ["%2","bombbeepsfx"];',rolenumber,rolestring];
	publicVariable format["SFXPvEh_%1", rolenumber];          
	_veh say ["bombbeepsfx",100];	
	sleep 5;
	{
		if (getdammage _x < 0.75) then {
			_x setdamage 0.75;
		};
	} foreach crew _veh;	
	_posx = getPosATL _veh select 0;
	_posy = getPosATL _veh select 1;
	_posz = getPosATL _veh select 2;
	sleep 0.25;
	_rocket = "R_60mm_HE" createvehicle [_posx,_posy,_posz+1];
	[_rocket, -90, 0] call setPitchBank;
	sleep 0.25;
	_rocket2 = "R_80mm_HE" createvehicle [_posx,_posy,_posz+1];
	[_rocket2, -90, 0] call setPitchBank;	
	
	"SmallSecondary" createvehicle (getPos _veh);
	_veh setDamage 0.95;
	sleep 0.25;
	"SmallSecondary" createvehicle (getPos _veh);
};