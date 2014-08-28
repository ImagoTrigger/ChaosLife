private ["_item","_no","_inhuntingarea","_animal","_r"];
if doingSomething exitwith {};
doingSomething = true;
_animal = _this select 3;
_r = floor(random 2);
_item = "";
_no = 0;

if (iscop) then {
	if (!("huntinglicense" in INV_LizenzOwner)) then {
		_animal = "none";
		["GC_HandBad",["CHAOS LIFE POLICE","As a cop, you must have a hunting license!"]] spawn bis_fnc_showNotification;
	} else {
		_inhuntingarea = false;
		{
			if (player distance getmarkerpos (_x select 0) <= (_x select 1)) exitWith {
				_inhuntingarea = true;
			}
		} foreach huntinggrounds;

		if (!_inhuntingarea) then {
			_animal = "none";
			["GC_HandBad",["CHAOS LIFE POLICE","As a cop, you must be in the hunting grounds!"]] spawn bis_fnc_showNotification;
		};
	};
};

switch _animal do
{
	case "rabbit":
	{
		switch _r do
		{
			case 0: {
				_item = "boar"; //actually rabbit (A3 hack)
				_no = ceil(random 2);
			};
			case 1: {
				_item = "boarpelt";
				_no = 1;
			};
		};
		if (((call INV_GetOwnWeight) + (_item call INV_getitemTypeKg)*_no) > INV_Tragfaehigkeit) exitwith
		{
			["GC_HandBad",["CHAOS LIFE HUNTING",localize "STRS_inv_buyitems_maxgewicht"]] spawn bis_fnc_showNotification;
		};
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		(nearestObjects [player, ["Rabbit_F"],  3] select 0) setVariable ["inuse", 1, true];
 		call compile format['SFXPvEh_%1 = ["%2","harvestsfx"];',rolenumber,rolestring];
		publicVariable format["SFXPvEh_%1", rolenumber];			
		vehicle player say ["harvestsfx",100];
		
		sleep 3;
		waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
		deleteVehicle (nearestObjects [player, ["Rabbit_F"],  3] select 0);
		[_item, _no] call INV_AddInventoreItem;
		_addskill = (_no / 100);
		["SKILL_HUNTING",_addskill] call GC_addSkill;
		["GC_Hand",["CHAOS LIFE HUNTING",format["you got %1 %2", _no, (_item call INV_getItemName)]]] spawn bis_fnc_showNotification;
	};
	case "snake":
	{
		switch _r do
		{
			case 0: {
				_item = "snake";
				_no = ceil(random 2);
			};
			case 1: {
				_item = "snakeskin";
				_no = 1;
			};
		};
		if (((call INV_GetOwnWeight) + (_item call INV_getitemTypeKg)*_no) > INV_Tragfaehigkeit) exitwith
		{
			["GC_HandBad",["CHAOS LIFE HUNTING",localize "STRS_inv_buyitems_maxgewicht"]] spawn bis_fnc_showNotification;
		};
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		(nearestObjects [player, ["Snake_random_F"],  3] select 0) setVariable ["inuse", 1, true];
 		call compile format['SFXPvEh_%1 = ["%2","harvestsfx"];',rolenumber,rolestring];
		publicVariable format["SFXPvEh_%1", rolenumber];			
		vehicle player say ["harvestsfx",100];
		
		sleep 3;
		waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
		deleteVehicle (nearestObjects [player, ["Snake_random_F"],  3] select 0);
		[_item, _no] call INV_AddInventoreItem;
		_addskill = (_no / 100);
		["SKILL_HUNTING",_addskill] call GC_addSkill;
		["GC_Hand",["CHAOS LIFE HUNTING",format["you got %1 %2", _no, (_item call INV_getItemName)]]] spawn bis_fnc_showNotification;
	};	
	case "sheep":
	{
		switch _r do
		{
			case 0: {
				_item = "sheep";
				_no = ceil(random 2);
			};
			case 1: {
				_item = "sheepskin";
				_no = 1
			};
		};
		if (((call INV_GetOwnWeight) + (_item call INV_getitemTypeKg)*_no) > INV_Tragfaehigkeit) exitwith
		{
			["GC_HandBad",["CHAOS LIFE HUNTING",localize "STRS_inv_buyitems_maxgewicht"]] spawn bis_fnc_showNotification;
		};
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		(nearestObjects [player, ["Sheep_random_F"],  3] select 0) setVariable ["inuse", 1, true];
 		call compile format['SFXPvEh_%1 = ["%2","harvestsfx"];',rolenumber,rolestring];
		publicVariable format["SFXPvEh_%1", rolenumber];					
		vehicle player say ["harvestsfx",100];
		sleep 3;
		waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
		deleteVehicle (nearestObjects [player, ["Sheep_random_F"],  3] select 0);
		[_item, _no] call INV_AddInventoreItem;
		_addskill = (_no / 100);
		["SKILL_HUNTING",_addskill] call GC_addSkill;
		["GC_Hand",["CHAOS LIFE HUNTING",format["you got %1 %2", _no, (_item call INV_getItemName)]]] spawn bis_fnc_showNotification;
	};
	case "turtle":
	{
		switch _r do
		{
			case 0: {
				_item = "turtle";
				_no = ceil(random 2);
			};
			case 1: {
				_item = "turtleshell";
				_no = 1;
			};
		};
		if (((call INV_GetOwnWeight) + (_item call INV_getitemTypeKg)*_no) > INV_Tragfaehigkeit) exitwith
		{
			["GC_HandBad",["CHAOS LIFE HUNTING",localize "STRS_inv_buyitems_maxgewicht"]] spawn bis_fnc_showNotification;
		};
		//player playMove "AinvPknlMstpSlayWrflDnon_medic";
		(nearestObjects [player, ["Turtle_F"],  3] select 0) setVariable ["inuse", 1, true];
 		call compile format['SFXPvEh_%1 = ["%2","harvestsfx"];',rolenumber,rolestring];
		publicVariable format["SFXPvEh_%1", rolenumber];			
		vehicle player say ["harvestsfx",100];
		
		sleep 3;
		//waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
		deleteVehicle (nearestObjects [player, ["Turtle_F"],  3] select 0);
		[_item, _no] call INV_AddInventoreItem;
		_addskill = (_no / 100);
		["SKILL_HUNTING",_addskill] call GC_addSkill;
		["GC_Hand",["CHAOS LIFE HUNTING",format["you got %1 %2", _no, (_item call INV_getItemName)]]] spawn bis_fnc_showNotification;
	};
	case "fish":
	{
		_item = "fish";
		_no = ceil(random 2);

		if (((call INV_GetOwnWeight) + (_item call INV_getitemTypeKg)*_no) > INV_Tragfaehigkeit) exitwith
		{
			["GC_HandBad",["CHAOS LIFE HUNTING",localize "STRS_inv_buyitems_maxgewicht"]] spawn bis_fnc_showNotification;
		};
		//player playMove "AinvPknlMstpSlayWrflDnon_medic";
		(nearestObjects [player, fishtypes,  3] select 0) setVariable ["inuse", 1, true];
 		call compile format['SFXPvEh_%1 = ["%2","harvestsfx"];',rolenumber,rolestring];
		publicVariable format["SFXPvEh_%1", rolenumber];			
		vehicle player say ["harvestsfx",100];
		
		sleep 3;
		//waitUntil {animationState player != "AinvPknlMstpSlayWrflDnon_medic"};
		deleteVehicle (nearestObjects [player, fishtypes,  3] select 0);
		[_item, _no] call INV_AddInventoreItem;
		_addskill = (_no / 100);
		["SKILL_FISHING",_addskill] call GC_addSkill;
		["GC_Hand",["CHAOS LIFE HUNTING",format["you got %1 %2", _no, (_item call INV_getItemName)]]] spawn bis_fnc_showNotification;
	};	
};

if (!("huntinglicense" in INV_LizenzOwner)) then {
	format [" [""Poaching"", %1] spawn Isse_AddCrimeLogEntry; if(!(""poaching"" in %1_reason))then{%1_reason = %1_reason + [""poaching""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 5000;", player, name player] call broadcast;
} else {
	_inhuntingarea = false;
	{
		if (player distance getmarkerpos (_x select 0) <= (_x select 1)) exitWith {
			_inhuntingarea = true;
		}
	} foreach huntinggrounds;
	
	if (!_inhuntingarea) then {
		format [" [""Poaching"", %1] spawn Isse_AddCrimeLogEntry; if(!(""poaching"" in %1_reason))then{%1_reason = %1_reason + [""poaching""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 5000;", player, name player] call broadcast;
	};
};

doingSomething = false;