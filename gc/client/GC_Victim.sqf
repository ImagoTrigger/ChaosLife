diag_log text format["GC_Victim: %1",_this];
private ["_killerlicense","_killer","_killedByVehicle","_vehicle","_infos","_killerstring","_murdered","_vehx","_nearVehicles"];
if(isdead == 1)exitwith{};

isdead = 1;

_killer 	= _this select 0;
_nearVehicles  	= _this select 1;
_ammo		= _this select 2;
_killerLicense  = nil;
suicided    	= false;
_murdered	= true;
_killerstring	= format["%1", _killer];
_killedByVehicle = false;
_victimname = player getvariable "deadname";
//player setvariable["deadname",_victimname,true];

_victimside = side (group vehicle player);


if (_ammo == "" and _killer == driver vehicle _killer) then {

	_murdered = false;

	if(typename _nearVehicles == "STRING" and INV_hunger < 100)exitwith{suicided = true;wipewanted = false;};

	_vehx = _nearVehicles select 0;
	if (!isNull _vehx) then {
		if (alive _vehx and speed _vehx != 0) then {
			_killer		 = driver _vehx;
			_killedByVehicle = true;
			_vehicle         = typeof _vehx;
			_infos           = _vehicle call INV_getitemArray;
			_killerLicense    = (_infos select 4) select 1;
			_killerstring 	 = format["%1", _killer];
		};
	};
};

if (_killer == vehicle _killer) then {
	{
		if (isPlayer _x) exitWith {
			_killer = _x;
			_killerstring = format["%1", _killer];
			if (!_killedByVehicle) then {_murdered = true};
		};
	} foreach (crew _killer);
};

_weapon = currentWeapon _killer;
_killerside1 = side (group _killer);

_playerSide = "";
if (_victimside == CIVILIAN or _victimside == Resistance) then {_playerSide = "civ"};
if (_victimside == WEST or vehicle player in coparray) then {_playerSide = "cop"};
if (player getVariable "terrorist" or _victimside == EAST) then {_playerSide = "terrorist"};

_killerSide = "self";
if (_killerside1 == CIVILIAN or _killerside1 == Resistance) then {_killerSide = "civ"};
if (_killerside1 == WEST) then {_killerSide = "cop"};
if (_killer getVariable "terrorist" or _killerside1 == EAST) then {_killerSide = "terrorist"};

if(_killerside1 == RESISTANCE and !isPlayer _killer) exitwith {
	format['["Died", %1, "AI", %4] spawn Isse_AddCrimeLogEntry;server globalChat "%2 (%3) was killed by AI!"', player, _victimname, _playerSide, _killedByVehicle] call broadcast;
	wipewanted = false;
};



if (isNil "_killerLicense") then {
	_killerLicense = "";
};

if (_killerLicense == "") then {
	_killerLicense = 0;
};

_killername = _killer getvariable "deadname";
if (isnil "_killername") then {
	_killername = name _killer;
};
_killeruid = getPlayerUID _killer;
_unarmed = 0;
_unarmedstr = "";
_wanted = 0;
_wantedstr = "";
if ( (('pistole' call INV_GetItemAmount) <= 0) and !(call INV_isArmed) ) then {
	_unarmed = 1;
	_unarmedstr = " ~UNARMED~";
};
if(call compile format["%1_wanted > 0", player])then{
	_wanted = 1;
	_wantedstr = " ~WANTED~";
};

if (!isnull _killer) then {
	(format ["[""Died"", %1, %2, %5] spawn Isse_AddCrimeLogEntry;
	if(%7 and !%5)then{server globalChat ""%3 (%9)%11%12 was killed by %4 (%10)""};if (%5) then {server globalChat ""%4 (%10) hit %3 (%9)%11%12 with a vehicle"";};if(INV_hunger == 100)exitwith{server globalChat ""%3 starved to death!""};
	if(player == %8) then {[%1, %5, %6] execVM ""killer.sqf""};", player,  _killer, _victimname, _killername, _killedByVehicle, _killerLicense, _murdered, _killerstring, _playerSide, _killerSide,_unarmedstr,_wantedstr]) call broadcast;
} else {
	(format ["[""Died"", %1, ""%2"", %5] spawn Isse_AddCrimeLogEntry;
	if(%7 and !%5)then{server globalChat ""%3 (%9)%11%12 was killed by %4 (%10)""};if (%5) then {server globalChat ""%4 (%10) hit %3 (%9)%11%12 with a vehicle"";};if(INV_hunger == 100)exitwith{server globalChat ""%3 starved to death!""};
	if(player == %1) then {[%1, %5, %6] execVM ""killer.sqf""};", player,  "<NULL-object>", _victimname, _killername, _killedByVehicle, _killerLicense, _murdered, _killerstring, _playerSide, _killerSide,_unarmedstr,_wantedstr]) call broadcast;
};


if (isnil "_vehicle") then {
	_vehicle = "";
};
if (isnil "_weapon") then {
	_weapon = "";
};
if (isnil "_ammo") then {
	_ammo = "";
};
format['GC_Kills = ["%1","%2","%3","%4","%5",%6,%7,"%8","%9","%10"];',_killername,_killerSide,_killeruid,_victimname,_playerSide,_unarmed,_wanted,_vehicle,_weapon,_ammo] call broadcast_srv;

removeAllWeapons player;

if (wipewanted and isciv) then {
	[] spawn {
		sleep 3;
		if (!("bomb" in INV_LizenzOwner)) then {
			if(call compile format["%1_arrest > 0", player]  )then{format["%1_arrest = 0;", player]   call broadcast;};
			if(call compile format["%1_wanted > 0", player]  )then{format["%1_wanted = 0;", player]   call broadcast;};
			if(call compile format['count %1_reason > 0', player]  )then{format['%1_reason = [];', player]   call broadcast;};
			if(call compile format["kopfcash_%1 > 0", player])then{format["kopfcash_%1 = 0;", player] call broadcast;};
		};
	};
};

[player,_killer,_playerSide,_killerSide,_weapon,_ammo,_vehicle] execvm "gc\client\GC_KillCam.sqf";