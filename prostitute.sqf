private ["_i","_exitvar","_a1","_action","_arbeiternummer","_prostitutenumber","_prostitutename","_civ","_arbeitercash","_selection","_cash","_skulls","_skullamt"];
_selection  = ((_this select 3) select 0);
_cash = 'cash' call INV_GetItemAmount;
_skulls = 'skull' call INV_GetItemAmount;
_skullamt = 5;
_prostitutename = objnull;
if (_selection == "prostitute") then {
	if (localprostitute >= maxprostitute) exitwith {role groupchat localize "STRS_prostitute_zuviele"};
	if (_cash < prostitute_cost && _skulls < _skullamt) exitwith {role groupchat (format[localize "STRS_prostitute_nomoney",_skullamt]);};
	if (gangmember) exitwith {player groupchat "You cannot buy prostitutes while in a gang!"};
	if (doingSomething) exitwith {};
	doingSomething = true;
	if(_skulls < _skullamt) then {
		['cash', -(prostitute_cost)] call INV_AddInventoreItem;
	} else {
		['skull', -(_skullamt)] call INV_AddInventoreItem;
	};

	player groupchat "Take your prostitute to a workplace to earn money.";

	_arbeiternummer = localprostitutecounter;
	localprostitutecounter = localprostitutecounter + 1;
	localprostitute = localprostitute + 1;
	_prostitutenumber = localprostitutecounter;
	_prostitutename = player;
	_civ = civprostitutearray select round random(count civprostitutearray - 1);

	doingSomething = false;

	call compile format ['
		%1prostitute%2 = objnull;
		_prostitutename = "%3" createUnit [position player, group player, "%1prostitute%2 = this; removeallweapons this; removeVest this; removeHeadgear this; removeGoggles this; removeUniform this; this unassignitem ""NVGoggles_INDEP""; this unassignitem ""NVGoggles""; this setvariable[""pimp"",""%4"",true]; this setVehicleVarName ""%1prostitute%2"";"]; 
		sleep 1;
		%1prostitute%2 setpos getpos player;
	', rolestring, _prostitutenumber, _civ, (name player)];

	(format ["publicarbeiterarctionarray = publicarbeiterarctionarray + [ [%1prostitute%2, %3] ];", rolestring, _prostitutenumber, player]) call broadcast_srv;

	call compile format ["arbeitercash%1 = 0;", _arbeiternummer];
	_exitvar = 0;
	_a1 = 0;
	_action = 0;
	call compile format['_prostitutename = %1prostitute%2;',rolestring, _prostitutenumber];
	while {true} do {
		if (_exitvar == 1) exitwith {};

		{
			if ((player distance (_x select 0)) < (_x select 1)) then {call compile format ["arbeitercash%1 = arbeitercash%1 + prostitutemoneyprosekunde + round(random 1000 - 500);", _arbeiternummer];};
		} forEach prostitutearray;

		for [{_i=0}, {_i < 60}, {_i=_i+1}] do {
			if ( (not(alive _prostitutename)) or (not(alive player)))  exitWith {
				sleep 2;
				if(!isnull _prostitutename) then {
					player groupchat localize "STRS_prostitute_tot";
				} else {
				player groupchat "A prostitute you were working has snitched on you. You're now wanted!";
			};
			localprostitute = localprostitute - 1; _prostitutename setdamage 1; _exitvar = 1;};

			if ((player distance _prostitutename >= 5 or (call compile format ["arbeitercash%1 == 0", _arbeiternummer])) and _a1 == 1) then {player removeaction _action; _a1 = 0;};

			if (player distance _prostitutename < 5 and _a1 == 0 and (call compile format ["arbeitercash%1 > 0", _arbeiternummer])) then {
				_action = player addaction [localize "STRS_prostitute_moneyaction", "prostitute.sqf",["cash", _arbeiternummer]]; _a1 = 1;
			};

			if ((rolecop == 0) and (_prostitutename call GC_InCopBase) and (alive _prostitutename)) then {
				player groupchat localize "STRS_arbeiter_in_copbase";
				if (not((vehicle _prostitutename) == _prostitutename)) then {_prostitutename action ["eject", (vehicle _prostitutename)];};
				_prostitutename setpos getmarkerpos "civarea";
			};
			sleep 1;
		};
	};

	player removeaction _action;
	sleep 15;
	deletevehicle _prostitutename;
};

if (_selection == "cash") then {
	_arbeiternummer = (_this select 3) select 1;
	_arbeitercash   = call compile format ["arbeitercash%1;", _arbeiternummer];

	if ((_arbeitercash > 0) and !doingSomething) then {
		doingSomething = true;
		['cash', _arbeitercash] call INV_AddInventoreItem;
		call compile format ["arbeitercash%1 = 0;", _arbeiternummer];
		player groupchat format [localize "STRS_prostitute_cashabnahme_ja", (_arbeitercash call ISSE_str_IntToStr)];
		doingSomething = false;
	};
};
