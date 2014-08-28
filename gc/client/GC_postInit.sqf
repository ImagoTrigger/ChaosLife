//detect bug slot
{
	_npc = _x getvariable "NPC";
	if (not isnil "_npc") then {
		_slot = format["%1",_x];
		{
			if (_slot == _x) then {
				_unit = playerarray select _foreachindex;
				if (name player == name _unit) then {
					call GC_EndMission;
				};
			};
		}foreach playerstringarray;
	};
} foreach allUnits;

//player say "bugzsfx";

//ensure empty group
if (!gangmember) then {
	while {count units group player > 1} do {
		[player] joinsilent grpNull;
		sleep 0.5;
	};
};

//delete blown up aircraft
{
	if (!alive _x) then {
		if (_x isKindof "Air") then {
			deletevehicle _x;
		}
	};
} foreach vehicles;

removebackpack player; 

//uniform effect
if (isciv) then {
	if(("Pistollicense" in INV_LizenzOwner) or ("shotgun" in INV_LizenzOwner) or ("Riflelicense" in INV_LizenzOwner) or ("automatic" in INV_LizenzOwner)) then {
		_vest = vest player;
		if (isnil "_vest" or _vest == "") then {
			player addvest "V_Rangemaster_belt";
		};
	};

	if("engineer" in INV_LizenzOwner) then {
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

	if("air" in INV_LizenzOwner) then {
		player addheadgear "H_PilotHelmetHeli_O";
	};
	//keep terrorists wanted
	if ("bomb" in INV_LizenzOwner) then {
		"U_B_CombatUniform_mcam" call GC_ChangeSkin;
		format [" [""Terror"", %1] spawn Isse_AddCrimeLogEntry; if(!(""known terrorist"" in %1_reason))then{%1_reason = %1_reason + [""known terrorist""]; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 250000;}; ", player] call broadcast;
	} else {
		player setVariable ["terrorist", false, true]; //durandal did this
	};
} else {

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
};


//vest effect
_vest = vest player;
if (isnil "_vest" or _vest == "") then {
	_armor1 = 'HeavyArmor' call INV_GetItemAmount;
	_armor2 = 'LightArmor' call INV_GetItemAmount;
	_armor = _armor1 + _armor2;
	if (_armor > 0) then {
		player addvest "V_PlateCarrier1_cbr";
	};
};

_bpack = ((GC_A3 select 0) select 0);
if (_bpack != "") then {
	player addBackpack _bpack;
	{
		_class = [_x] call BIS_fnc_classMagazine;
		_parents = [_class,true] call BIS_fnc_returnParents;
		if (!("CA_Magazine" in _parents)) then {player additem _x;};
	} foreach ((GC_A3 select 0) select 1);
};
_vest = ((GC_A3 select 0) select 2);
if (_vest != "") then {
	player addVest _vest;
	{
		_class = [_x] call BIS_fnc_classMagazine;
		_parents = [_class,true] call BIS_fnc_returnParents;
		if (!("CA_Magazine" in _parents)) then {player additem _x;};
	} foreach ((GC_A3 select 0) select 3);
};
_uniform = ((GC_A3 select 0) select 4);
if (_uniform != "") then {
	if (iscop and _uniform == "U_BasicBody") then {
		player addUniform "U_B_HeliPilotCoveralls"; //no naked cops
	} else {
		player addUniform _uniform;
	};
	{
		_class = [_x] call BIS_fnc_classMagazine;
		_parents = [_class,true] call BIS_fnc_returnParents;
		if (!("CA_Magazine" in _parents)) then {player additem _x;};
	} foreach ((GC_A3 select 0) select 5);
} else {
	if (isciv) then {player addUniform "U_BasicBody";};
	if (iscop) then {player addUniform "U_B_HeliPilotCoveralls";};  //no naked cops
};
_hat = ((GC_A3 select 0) select 6);
if (_hat != "") then {
	player addHeadgear _hat;
} else {
	if (headgear player != "H_Cap_brn_SERO" and isciv) then {
		removeheadgear player;
	};
};
_glasses = ((GC_A3 select 0) select 7);
if (_glasses != "") then {player addGoggles _glasses;};

if (iscop) then {
	format['%1 setObjectTexture [0, "\A3\Characters_F\Common\Data\coveralls_urbancamo_co.paa"];',player] call broadcast;
	if (count playerWeapons == 0 and count playermagazines == 0) then {
		{player addMagazine _x} forEach CopStartGear_Mags;
		{player addWeapon   _x} forEach CopStartGear_Weap;

	} else {
		player addWeapon "NVGoggles";
		player addWeapon "Binocular";
		{player addMagazine _x} forEach playerMagazines;
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
	{player addSecondaryWeaponItem _x;} foreach ((GC_A3 select 0) select 8);
	{player addPrimaryWeaponItem _x;} foreach ((GC_A3 select 0) select 9);

	//cop global actions
	copcar addaction ["Impound Lot","maindialogs.sqf",["impound"],1,false,true,"","_this distance copcar <= 5"];
	copair addaction ["Helo Impound Lot","maindialogs.sqf",["impound2"],1,false,true,"","_this distance copair <= 5"];
	storage_2 addaction ["Private storage (saved)","storage.sqf",["private_storage", "save"],1,false,true,"","_this distance storage_2 < 3.4"];
	copbank addaction ["Get patrol mission","coppatrol.sqf",["start"],1,false,true,"","_this distance copbank <= 4 and !pmissionactive and !patrolwaittime"];
	copbank addaction ["Cancel patrol mission","coppatrol.sqf",["end"],1,false,true,"","pmissionactive and _this distance copbank <= 4"];
	copgate2 addaction ["Raise gates","gates.sqf",[2, "raise"],1,false,true,"","_this distance copgate2 <= 4"];
	copgate3 addaction ["Raise gates","gates.sqf",[3, "raise"],1,false,true,"","_this distance copgate3 <= 4"];
	copgate4 addaction ["Raise gates","gates.sqf",[4, "raise"],1,false,true,"","_this distance copgate4 <= 4"];
	copgate5 addaction ["Raise gates","gates.sqf",[5, "raise"],1,false,true,"","_this distance copgate5 <= 4"];

} else {
	{format['%1 setObjectTexture [0, "\A3\Characters_F\Common\Data\coveralls_urbancamo_co.paa"];',_x];} foreach coparray;

	//rob
	safe1 addaction ["Rob safe","bankrob.sqf", ["ausrauben", safe1],1,false,true,"","_this distance safe1 <= 1.90"];
	safe2 addaction ["Rob safe","bankrob.sqf", ["ausrauben", safe2],1,false,true,"","_this distance safe2 <= 1.90"];
	safe3 addaction ["Rob safe","bankrob.sqf", ["ausrauben", safe3],1,false,true,"","_this distance safe3 <= 1.90"];
	{call compile format["%1 addaction [""Rob Store"",""robthestations.sqf"",[%1],1,false,true,"""",""(call INV_isArmed) and %1money >= 5000 and _this distance %1 <= 3""];", _x];} forEach robbable;
	//impound
	impoundbuy addaction ["Impound Lot","maindialogs.sqf",["impound"],1,false,true,"","_this distance impoundbuy <= 5"];
	impoundbuy2 addaction ["Helo Impound Lot","maindialogs.sqf",["impound2"],1,false,true,"","_this distance impoundbuy2 <= 5"];
	bailflag addaction ["Pay bail","maindialogs.sqf", ["bail"],1,false,true,"","_this distance bailflag <= 5"];
	//jobs
	delivery1 addaction ["Get Delivery Job","delivery.sqf", ["getajob_delivery"],1,false,true,"","(_this distance delivery1 <= 5)"];
	delivery1 addaction ["Cancel Delivery Job","delivery.sqf", ["cancel"],1,false,true,"","(player distance _This <= 5) and alreadygotaworkplacejob == 1"];
	taxi1 addaction ["Get Taxi Job","taxi.sqf", ["getajob_taxi"],1,false,true,"","(_this distance taxi1 <= 7)"];
	taxi1 addaction ["Finish Taxi Job","taxi.sqf", ["canceljob_taxi"],1,false,true,"","(_this distance taxi1 <= 5 ) and workplacejob_taxi_active"];
	assassin addaction ["Get assassination job","assassination.sqf",["getajob_assassin"],1,false,true,"","_this distance assassin <= 3"];
	prostituteflag addaction [format ["Buy prostitute ($%1)", prostitute_cost],"prostitute.sqf", ["Prostitute"],1,false,true,"","_this distance prostituteflag <= 5"];
	hostage addaction ["Take hostage mission","hostage.sqf",["getajob_hostage"],1,false,true,"","_this distance hostage <= 3"];
	workplace_getjobflag_1 addaction [localize "STRS_workplacemission_addaction_searchjob","search.sqf",["getajob_search"],1,false,true,"","_this distance workplace_getjobflag_1 <= 5 and alreadygotaworkplacejob != 2"];
	workplace_getjobflag_2 addaction [localize "STRS_workplacemission_addaction_searchjob","search.sqf",["getajob_search"],1,false,true,"","_this distance workplace_getjobflag_2 <= 5 and alreadygotaworkplacejob != 2"];
	workplace_getjobflag_3 addaction [localize "STRS_workplacemission_addaction_searchjob","search.sqf",["getajob_search"],1,false,true,"","_this distance workplace_getjobflag_3 <= 5 and alreadygotaworkplacejob != 2"];
	//legit
	{call compile format["%3 addaction [format [localize ""STRS_addAction_buy_shop"", ""%1"", %2], ""buyshop.sqf"", [""immobilie"",%5],1,false,true,"""", ""_this distance %3 <= 5 and !(""""%4"""" in BuildingsOwnerArray)""];", _x select 1, _x select 3, _x select 2, _x select 0,_foreachindex];} forEach BuyAbleBuildingsArray;
	Diamond_1 addaction ["Refine diamond rocks into rings","itemprocess.sqf",["Diamond rock", "Diamondring", 12, "diamond"],1,false,true,"","_this distance Diamond_1 <= 5"];
	Oil_1 addaction ["Process Oil","itemprocess.sqf",["Oil", "OilBarrel", 10, "oil"],1,false,true,"","_this distance Oil_1 <= 5"];
	//ga1
	gangshop1 addaction ["Process LSD","itemprocess.sqf",["Unprocessed_LSD", "lsd", 5, "lsd ga1"],1,false,true,"","_control = gangarea1 getvariable ""control"";!isnil ""_control"" and _this distance gangshop1 <= 5 and (_control == (call INV_mygang))"];
	gangshop1 addaction ["Process Cocaine","itemprocess.sqf",["Unprocessed_Cocaine", "cocaine", 5, "cocaine ga1"],1,false,true,"","_control = gangarea1 getvariable ""control"";!isnil ""_control"" and _this distance gangshop1 <= 5 and (_control == (call INV_mygang))"];
	gangarea1 addaction ["Neutralise flag","gangflags.sqf",[gangarea1, "neutralise"],1,false,true,"",'_control = gangarea1 getvariable "control";if(isnil "_control")then{_control = ""};_this distance gangarea1 <= 8 and _control != (call INV_mygang) and _control != "" and gangmember and !takingFlag'];
	gangarea1 addaction ["Capture flag","gangflags.sqf",[gangarea1, "capture"],1,false,true,"",'_control = gangarea1 getvariable "control";_this distance gangarea1 <= 10 and isnil "_control" and gangmember and !takingFlag'];
	gangshop1 addaction [format["%1", gangarea1 call INV_getItemShopName],"shopdialogs.sqf",[(gangarea1 call INV_getshopnum)],1,false,true,"","_control = gangarea1 getvariable ""control"";!isnil ""_control"" and _this distance gangshop1 <= 5 and (_control == (call INV_mygang))"];
	//ga2
	gangshop2 addaction ["Process LSD","itemprocess.sqf",["Unprocessed_LSD", "lsd", 5, "lsd ga2"],1,false,true,"","_control = gangarea2 getvariable ""control"";!isnil ""_control"" and _this distance gangshop2 <= 5 and (_control == (call INV_mygang))"];
	gangshop2 addaction ["Process Heroin","itemprocess.sqf",["Unprocessed_Heroin", "heroin", 5, "heroin ga2"],1,false,true,"","_control = gangarea2 getvariable ""control"";!isnil ""_control"" and _this distance gangshop2 <= 5 and (_control == (call INV_mygang))"];
	gangarea2 addaction ["Neutralise flag","gangflags.sqf",[gangarea2, "neutralise"],1,false,true,"",'_control = gangarea2 getvariable "control";if(isnil "_control")then{_control = ""};_this distance gangarea2 <= 8 and _control != (call INV_mygang) and _control != "" and gangmember and !takingFlag'];
	gangarea2 addaction ["Capture flag","gangflags.sqf",[gangarea2, "capture"],1,false,true,"",'_control = gangarea2 getvariable "control";_this distance gangarea2 <= 10 and isnil "_control" and gangmember and !takingFlag'];
	gangshop2 addaction [format["%1", gangarea2 call INV_getItemShopName],"shopdialogs.sqf",[(gangarea2 call INV_getshopnum)],1,false,true,"","_control = gangarea2 getvariable ""control"";!isnil ""_control"" and _this distance gangshop2 <= 5 and (_control == (call INV_mygang))"];
	//ga3
	gangshop3 addaction ["Process Heroin","itemprocess.sqf",["Unprocessed_Heroin", "heroin", 5, "heroin ga3"],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and _this distance gangshop3 <= 5 and (_control == (call INV_mygang))"];
	gangshop3 addaction ["Process Marijuana","itemprocess.sqf",["Unprocessed_Marijuana", "marijuana", 5, "marijuana ga3"],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and _this distance gangshop3 <= 5 and (_control == (call INV_mygang))"];
	gangarea3 addaction ["Neutralise flag","gangflags.sqf",[gangarea3, "neutralise"],1,false,true,"",'_control = gangarea3 getvariable "control";if(isnil "_control")then{_control = ""};_this distance gangarea3 <= 8 and _control != (call INV_mygang) and _control != "" and gangmember and !takingFlag'];
	gangarea3 addaction ["Capture flag","gangflags.sqf",[gangarea3, "capture"],1,false,true,"",'_control = gangarea3 getvariable "control";_this distance gangarea3 <= 10 and isnil "_control" and gangmember and !takingFlag'];
	gangshop3 addaction [format["%1", gangarea3 call INV_getItemShopName],"shopdialogs.sqf",[(gangarea3 call INV_getshopnum)],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and _this distance gangshop3 <= 5 and (_control == (call INV_mygang))"];
	//ga4
	gangshop4 addaction ["Process Cocaine","itemprocess.sqf",["Unprocessed_Cocaine", "cocaine", 5, "cocaine ga4"],1,false,true,"","_control = gangarea4 getvariable ""control"";!isnil ""_control"" and _this distance gangshop4 <= 5 and (_control == (call INV_mygang))"];
	gangshop4 addaction ["Process Marijuana","itemprocess.sqf",["Unprocessed_Marijuana", "marijuana", 5, "marijuana ga4"],1,false,true,"","_control = gangarea4 getvariable ""control"";!isnil ""_control"" and _this distance gangshop4 <= 5 and (_control == (call INV_mygang))"];
	gangarea4 addaction ["Neutralise flag","gangflags.sqf",[gangarea4, "neutralise"],1,false,true,"",'_control = gangarea4 getvariable "control";if(isnil "_control")then{_control = ""};_this distance gangarea4 <= 8 and _control != (call INV_mygang) and _control != "" and gangmember and !takingFlag'];
	gangarea4 addaction ["Capture flag","gangflags.sqf",[gangarea4, "capture"],1,false,true,"",'_control = gangarea4 getvariable "control";_this distance gangarea4 <= 10 and isnil "_control" and gangmember and !takingFlag'];
	gangshop4 addaction [format["%1", gangarea4 call INV_getItemShopName],"shopdialogs.sqf",[(gangarea4 call INV_getshopnum)],1,false,true,"","_control = gangarea4 getvariable ""control"";!isnil ""_control"" and _this distance gangshop4 <= 5 and (_control == (call INV_mygang))"];
	//ga5
	gangshop5 addaction ["Process Cocaine","itemprocess.sqf",["Unprocessed_Cocaine", "cocaine", 5, "cocaine ga5"],1,false,true,"","_control = gangarea5 getvariable ""control"";!isnil ""_control"" and _this distance gangshop5 <= 5 and (_control == (call INV_mygang))"];
	gangshop5 addaction ["Process Marijuana","itemprocess.sqf",["Unprocessed_Marijuana", "marijuana", 5, "marijuana ga5"],1,false,true,"","_control = gangarea5 getvariable ""control"";!isnil ""_control"" and _this distance gangshop5 <= 5 and (_control == (call INV_mygang))"];
	gangshop5 addaction ["Process LSD","itemprocess.sqf",["Unprocessed_LSD", "lsd", 5, "lsd ga5"],1,false,true,"","_control = gangarea5 getvariable ""control"";!isnil ""_control"" and _this distance gangshop5 <= 5 and (_control == (call INV_mygang))"];
	gangshop5 addaction ["Process Heroin","itemprocess.sqf",["Unprocessed_Heroin", "heroin", 5, "heroin ga5"],1,false,true,"","_control = gangarea5 getvariable ""control"";!isnil ""_control"" and _this distance gangshop5 <= 5 and (_control == (call INV_mygang))"];
	gangarea5 addaction ["Neutralise flag","gangflags.sqf",[gangarea5, "neutralise"],1,false,true,"",'_control = gangarea5 getvariable "control";if(isnil "_control")then{_control = ""};_this distance gangarea5 <= 8 and _control != (call INV_mygang) and _control != "" and gangmember and !takingFlag'];
	gangarea5 addaction ["Capture flag","gangflags.sqf",[gangarea5, "capture"],1,false,true,"",'_control = gangarea5 getvariable "control";_this distance gangarea5 <= 10 and isnil "_control" and gangmember and !takingFlag'];
	gangshop5 addaction [format["%1", gangarea5 call INV_getItemShopName],"shopdialogs.sqf",[(gangarea5 call INV_getshopnum)],1,false,true,"","_control = gangarea5 getvariable ""control"";!isnil ""_control"" and _this distance gangshop5 <= 5 and (_control == (call INV_mygang))"];
	//export
	shop1export addaction [format["%1", shop1export call INV_getItemShopName],"shopdialogs.sqf",[(shop1 call INV_getshopnum)],1,false,true,"","_this distance shop1export <= 3"];
	shop2export addaction [format["%1", shop2export call INV_getItemShopName],"shopdialogs.sqf",[(shop2 call INV_getshopnum)],1,false,true,"","_this distance shop2export <= 3"];
	shop3export addaction [format["%1", shop3export call INV_getItemShopName],"shopdialogs.sqf",[(shop3 call INV_getshopnum)],1,false,true,"","_this distance shop3export <= 3"];
	shop4export addaction [format["%1", shop4export call INV_getItemShopName],"shopdialogs.sqf",[(shop4 call INV_getshopnum)],1,false,true,"","_this distance shop4export <= 3"];
	//alcohol
	grapeprocess addaction ["Ferment Grapes into Wine","itemprocess.sqf",["Grapes", "wine", 3, ""],1,false,true,"","_this distance grapeprocess <= 5"];
	hopsprocess addaction ["Brew Hops into Beer","itemprocess.sqf",["Hops", "beer2", 3, ""],1,false,true,"","_this distance hopsprocess <= 5"];
	barleyprocess addaction ["Distill Barley into Vodka","itemprocess.sqf",["Barley", "vodka", 3, ""],1,false,true,"","_this distance barleyprocess <= 5"];
	ryeprocess addaction ["Distill Rye into Whiskey","itemprocess.sqf",["Rye", "whiskey", 3, ""],1,false,true,"","_this distance ryeprocess <= 5"];
};

weaponsloaded = true;

player setVariable["uniform",uniform player];

//set gang area markers locally
if (count gangsarray > 0) then {
	{
		_gangmarker = "";
		_label = "";
		_read = _x getvariable "control";
		if (!isnil "_read") then {
			if(_x == gangarea1) then {
				_label = format["%1's Camp (cocaine - lsd)", _read];
				_gangmarker = "gangmarker1";
			};
			if(_x == gangarea2) then {
				_label = format["%1's Camp (heroin - lsd)", _read];
				_gangmarker = "gangmarker2";
			};
			if(_x == gangarea3) then {
				_label = format["%1's Camp (heroin - marijuana)", _read];
				_gangmarker = "gangmarker3";
			};
			if(_x == gangarea4) then {
				_label = format["%1's Camp (marijuana - cocaine)", _read];
				_gangmarker = "gangmarker4";
			};
			if(_x == gangarea5) then {
				_label = format["%1's Camp (all drugs)", _read];
				_gangmarker = "gangmarker5";
			};
		};
		_gangmarker setMarkerColorLocal "ColorOrange";
		_gangmarker setMarkerTextLocal _label;
	} foreach gangareas;
};

if (isnil "DisplayReports") then {DisplayReports = true;};

player addEventHandler ["handleDamage", {_this call onHandleDamage;}];

cook switchmove "acts_StandingSpeakingUnarmed";

if (profileName != "ChaosBot") then {
	["animals",180,20,25] call GC_Crows;

	//everyone gets these
	
	if (isMultiplayer) then { //no annoying music in single player
		intromusic_obj addaction ["Turn off intro music","gc\client\GC_FNC_noScript.sqf",'deletevehicle intromusic_obj; intromusic_obj=objnull;',1,true,true,"",'(!(isnull intromusic_obj) and (_this distance copbank <= 10 or _this distance intromusic_obj <= 20))'];
		//^-- todo NYI A3  try to make this action appear w/o having to look at it
	};
	
	mainbank addaction [format["Buy bank insurance ($%1)", ("bankversicherung" call INV_getitemBuyCost)],"gc\client\GC_FNC_noScript.sqf",'if("cash" call INV_GetItemAmount < ("bankversicherung" call INV_getitemBuyCost))exitwith{player groupchat "not enough money"};doingSomething = true;["cash", -("bankversicherung" call INV_getitemBuyCost)] call INV_AddInventoreItem;["bankversicherung", 1] call INV_AddInventoreItem;player groupchat format["you bought bank insurance for $%1", ("bankversicherung" call INV_getitemBuyCost)];doingSomething = false;',1,false,true,"","(_this distance mainbank <= 3) and !doingSomething"];
	bagshop addaction ["Trade for Bags", "bagshop.sqf", [], 1, false, true, "", "_this distance bagshop <= 5"];
	radio1 addaction ["Turn on Radio", "gc\client\GC_Music.sqf", [radio1,0], 1, false, true, "", '_track = radio1 getvariable "track"; _this distance radio1 <= 2 and isnil "_track"'];
	radio2 addaction ["Turn on Radio", "gc\client\GC_Music.sqf", [radio2,0], 1, false, true, "", '_track = radio2 getvariable "track"; _this distance radio2 <= 2 and isnil "_track"'];
	radio3 addaction ["Turn on Radio", "gc\client\GC_Music.sqf", [radio3,0], 1, false, true, "", '_track = radio3 getvariable "track"; _this distance radio3 <= 2 and isnil "_track"'];
	storage addaction ["Private storage (saved)","storage.sqf",["private_storage", "save"],1,false,true,"","_this distance storage < 3.4"];
	boatimpoundbuy addaction ["Boat Impound","maindialogs.sqf",["impound3"],1,false,true,"","_this distance boatimpoundbuy <= 5"];
	//cps
	copgate2 addaction ["Lower gates","gates.sqf",[2, "lower"],1,false,true,"","_this distance copgate2 <= 4"];
	copgate3 addaction ["Lower gates","gates.sqf",[3, "lower"],1,false,true,"","_this distance copgate3 <= 4"];
	copgate4 addaction ["Lower gates","gates.sqf",[4, "lower"],1,false,true,"","_this distance copgate4 <= 4"];
	copgate5 addaction ["Lower gates","gates.sqf",[5, "lower"],1,false,true,"","_this distance copgate5 <= 4"];
};

//single-player debugging
if (!isMultiplayer) then {
	chaos = true;
	Kontostand = 4999999;
	["cash", 999999] call INV_AddInventoreItem;
} else {
	["GC_Talk",["CHAOS LIFE VERSION 1.3","Please report bugs with the `!report bug` chat command."]] spawn bis_fnc_showNotification;
};

[] call GC_posNPCs;

sleep 5;
{ _x disableCollisionWith player; } foreach nearestobjects [getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["Fin_random_F","Alsatian_Random_F","Hen_random_F","Cock_Random_F","Land_Suitcase_F"], 20000];

