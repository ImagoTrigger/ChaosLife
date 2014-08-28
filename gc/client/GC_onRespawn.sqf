private ["_weapons","_weparray","_corpse"];
player setvariable["killed",nil,false];
player setvariable["bomber",nil,true];
("BIS_layerStatic" call BIS_fnc_rscLayer) cutRsc ["RscStatic", "PLAIN"];
_corpse = _this select 1;
if("car" call INV_haslicense)then{demerits = 10};
if (wipewanted) then {
	if ("bomb" in INV_LizenzOwner) then {
		_class = player getvariable "uniform";
		_class call GC_ChangeSkin;
		INV_LizenzOwner = INV_LizenzOwner - ["bomb"];
		["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;
		last_terror_time = time;
	};
	if(call compile format["%1_arrest > 0", player]  )then{format["%1_arrest = 0;", player]   call broadcast;};
	if(call compile format["%1_wanted > 0", player]  )then{format["%1_wanted = 0;", player]   call broadcast;};
	if(call compile format['count %1_reason > 0', player]  )then{format['%1_reason = [];', player]   call broadcast;};
	if(call compile format["kopfcash_%1 > 0", player])then{format["kopfcash_%1 = 0;", player] call broadcast;};
	wipewanted = false;
};
removeAllWeapons _corpse;
removebackpack _corpse;
removeVest _corpse;
removeHeadgear _corpse;
removeGoggles _corpse;
hidebody _corpse;
_corpse spawn {
	sleep 8;
	deleteVehicle _this;
};
if (gangleader) then {group player selectLeader player};
removeAllWeapons player;
if (!(player getVariable "terrorist")) then {
	removebackpack player;
	removeVest player;
	removeHeadgear player;
	removeGoggles player;
};
isdead = 0;
siren_is_on = false;
["isdead", isdead] call ClientSaveVar;
if (local_arrest == 0) then {
	if (isciv) then {player setpos getpos (respawnarray select (floor(random(count respawnarray))));};
} else {
	player switchmove "inbasemoves_handsbehindback1";
	["arrest", CivTimeInPrison, player] execVM "civmenu.sqf";
};
if (iscop) then {
	format['%1 setObjectTexture [0, "\A3\Characters_F\Common\Data\coveralls_urbancamo_co.paa"];',player] call broadcast;

	if("patrol_training" in INV_LizenzOwner) then {
		if (!("air_support_training" in INV_LizenzOwner)) then {
			player addheadgear "H_Booniehat_mcamo";
		};
	};

	if("response_training" in INV_LizenzOwner) then {
		if (!("swat_training" in INV_LizenzOwner)) then {
			player addvest "V_Rangemaster_belt";
		};
	};

	if("air_support_training" in INV_LizenzOwner) then {
		player addheadgear "H_PilotHelmetHeli_B";
	};

	if("swat_training" in INV_LizenzOwner) then {
		player addvest "V_PlateCarrier2_rgr";
	};

	if (count playerWeapons == 0 and count playermagazines == 0) then {
		{player addMagazine _x} forEach CopStartGear_Mags;
		{player addWeapon   _x} forEach CopStartGear_Weap;

	} else {
		player assignitem "NVGoggles";
		player assignitem "Binocular";
		{player addMagazine _x} forEach playermagazines;
		{player addWeapon   _x} forEach playerWeapons;
	};

	if ( (primaryWeapon player) != "") then {
		private['_type', '_muzzles'];
		_type = primaryWeapon player;
		_muzzles = getArray(configFile >> "cfgWeapons" >> _type >> "muzzles");

		if (count _muzzles > 1) then {
			player selectWeapon (_muzzles select 0);
		} else {
			player selectWeapon _type;
		};
	};
	if ("B_UavTerminal" in (assigneditems player)) then {player addweapon "B_UavTerminal";} else {player addweapon "ItemGPS";};
	_pistola = handgunWeapon player;
	if (_pistola != "") then {
		saveWeaponPistol = [_pistola,false,true];
		player action ["SWITCHWEAPON", player, player, 1];
		player action ["SWITCHWEAPON", player, player, 0];
	};
	[] call GC_pistolActions;

	if (('pistole' call INV_GetItemAmount) > 0) then {
		unholsterPistol = player addAction ["Unholster Pistol","pistolControl.sqf",[false]];
	};
} else {
	saveWeaponPistol = ["",false,false];
	if (!(player getVariable "terrorist")) then {
		_uniform = player getvariable "uniform";
		if (_uniform == "" or _uniform == "U_B_HeliPilotCoveralls") then {
			removeUniform player;
		} else {
			player addUniform _uniform;
		};

		player unassignitem "NVGoggles";

		if(("Pistollicense" in INV_LizenzOwner) or ("shotgun" in INV_LizenzOwner) or ("Riflelicense" in INV_LizenzOwner) or ("automatic" in INV_LizenzOwner)) then {
			_vest = vest player;
			if (isnil "_vest" or _vest == "") then {
				player addvest "V_Rangemaster_belt";
			};
		};

		if("engineer" in INV_LizenzOwner) then {
			player addheadgear "H_Cap_brn_SERO";
		};

		if("air" in INV_LizenzOwner) then {
			player addheadgear "H_PilotHelmetHeli_O";
		};

	} else {
		"U_B_CombatUniform_mcam" call GC_ChangeSkin;
	};
	player removeweapon "ItemGPS";
};

//kill flashlight
format['
	if (!isNil "%1flashLight") then {
		deleteVehicle %1flashLight;
		%1flashLight = nil;
	};
', player] call broadcast;

weaponsloaded = true;
wipewanted = true;
terminate hud_handle;
hud_handle = [] spawn GC_HUD;
terminate hud_handle_tags;
hud_handle_tags = [] spawn GC_HUD_Tags;

deadcam = 0;



