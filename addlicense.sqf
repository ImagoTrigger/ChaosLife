private ["_prostitutes","_vest","_nonotify","_license","_name","_cost","_number","_art"];
_this    = _this select 3;
_number  = _this select 0;
_art     = _this select 1;

if ((_art == "remove") or (_art == "add")) then

{

if (_art == "add") then {
	_nonotify = true;
	_license = ((INV_Lizenzen select _number) select 0);
	_name    = ((INV_Lizenzen select _number) select 2);
	_cost    = ((INV_Lizenzen select _number) select 3);
	if (_license call INV_HasLicense) exitWith {player groupChat localize "STRS_inv_buylicense_alreadytrue";};
	if (('cash' call INV_GetItemAmount) < _cost) exitWith {player groupChat localize "STRS_inv_buylicense_nomoney";};
	if(_license == "car" or _license == "truck")then{demerits = 10};
	if (_license == "bomb" and gangmember) exitWith {["GC_FlagNeut_Red",["CHAOS LIFE TERROR CAMP","You can't sign a terror pact while in a gang!"]] spawn bis_fnc_showNotification;};
	if (_license == "bomb" and last_terror_time > 0 and (time - last_terror_time) < 3600) exitWith {["GC_BadTime",["CHAOS LIFE TERROR CAMP","You can't sign another terror pact so soon, try again later."]] spawn bis_fnc_showNotification;};
	if (_license == "bomb") then {
		_prostitutes = false;
  		{if (!isPlayer _x) then {_x setDamage 1; _prostitutes = true;};} forEach units group player;
  		if (_prostitutes) then {["GC_Bad2",["CHAOS LIFE TERROR CAMP","You can't sign another terror pact so soon, try again later."]] spawn bis_fnc_showNotification;};
		"U_B_CombatUniform_mcam" call GC_ChangeSkin;
		format [" [""Terror"", %1] spawn Isse_AddCrimeLogEntry; if(!(""known terrorist"" in %1_reason))then{%1_reason = %1_reason + [""known terrorist""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 250000;server globalChat ""%2 IS NOW A TERRORIST, THEY MAY BE KILLED ON SIGHT!"";", player, name player] call broadcast;
	};
	['cash', -(_cost)] call INV_AddInventoreItem;
	if (_license == "car" or _license == "truck") then {
		_nonotify = false;
		["GC_Vehicle_Good",["CHAOS LIFE LICENCES",format[localize "STRS_inv_buylicense_gottraining", (_cost call ISSE_str_IntToStr), _name]]] spawn bis_fnc_showNotification;
	};

	if(_license == "patrol_training") then {
		_nonotify = false;
		["GC_Vehicle_Good",["CHAOS LIFE POLICE TRAINING",format[localize "STRS_inv_buylicense_gottraining", (_cost call ISSE_str_IntToStr), _name]]] spawn bis_fnc_showNotification;
		if (!("air_support_training" in INV_LizenzOwner)) then {
			player addheadgear "H_Booniehat_mcamo";
		};
	};

	if(_license == "response_training") then {
		_nonotify = false;
		["GC_Gear",["CHAOS LIFE POLICE TRAINING",format["Response training completed for $%1", (_cost call ISSE_str_IntToStr), _name]]] spawn bis_fnc_showNotification;
		if (!("swat_training" in INV_LizenzOwner) and !("sniper_training" in INV_LizenzOwner)) then {
			player addvest "V_Rangemaster_belt";
		};
	};

	if(_license == "swat_training") then {
		_nonotify = false;
		["GC_Kill",["CHAOS LIFE POLICE TRAINING",format[localize "STRS_inv_buylicense_gottraining", (_cost call ISSE_str_IntToStr), _name]]] spawn bis_fnc_showNotification;
		player addvest "V_PlateCarrier2_rgr";
	};

	if(_license == "air_support_training") then {
		player addheadgear "H_PilotHelmetHeli_B";
	};

	if((_license == "Pistollicense") or (_license == "shotgun") or (_license == "Riflelicense") or (_license == "automatic")) then {
		_vest = vest player;
		if (isnil "_vest" or _vest == "") then {
			player addvest "V_Rangemaster_belt";
		};
	};

	if(_license == "engineer") then {
		_nonotify = false;
		["GC_Repair",["CHAOS LIFE LICENCES",format[localize "STRS_inv_buylicense_gottraining", (_cost call ISSE_str_IntToStr), _name]]] spawn bis_fnc_showNotification;
		player addheadgear "H_Cap_brn_SERO";
		flashlightStrength = 0.20;
		//kill old flashlight
		format['
			if (!isNil "%1flashLight") then {
				deleteVehicle %1flashLight;
				%1flashLight = nil;
			};
		', player] call broadcast;
	};

	if(_license == "air") then {
		player addheadgear "H_PilotHelmetHeli_O";
	};

	INV_LizenzOwner = INV_LizenzOwner + [_license];
	["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;

	if (_nonotify) then {
		["GC_Money",["CHAOS LIFE LICENCES",format[localize "STRS_inv_buylicense_gottraining", (_cost call ISSE_str_IntToStr), _name]]] spawn bis_fnc_showNotification;
	};


	}
	else
	{

	_license = ((INV_Lizenzen select _number) select 0);
	_name    = ((INV_Lizenzen select _number) select 2);
	if (not(_license call INV_HasLicense)) exitWith {player groupChat localize "STRS_inv_buylicense_alreadyfalse";};
	INV_LizenzOwner = INV_LizenzOwner - [_license];
	player groupChat format[localize "STRS_inv_buylicense_losttraining", _name];
	["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;

	};

};