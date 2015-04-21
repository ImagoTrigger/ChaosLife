("BIS_layerStatic" call BIS_fnc_rscLayer) cutRsc ["RscStatic", "PLAIN"];

player setVariable["deadname",name player,true];

{ _x setFuelCargo 0; } foreach nearestobjects [getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["Land_FuelStation_Feed_F"], 20000];

if (isciv) then {
	[] spawn {
		sleep (random 2);
		_animals = {alive _x} count nearestobjects [getmarkerpos "civarea", ["Alsatian_Random_F"], 25];
		if (_animals == 0) then {
			_agent = createAgent ["Alsatian_Random_F", getmarkerpos "civarea", [], 3, "FORM"];
			_agent setDir 200;
			_agent setvariable["marker","animals",true];
		};
	};
};

if (!isMultiplayer) then {
	JIP_Stats_Ready = true;
	[player] call GC_preloadStats;
};
if (profileName == "ChaosBot") then {
	JIP_Stats_Ready = true;
	[player] call GC_preloadStats;

};

waitUntil {sleep 2; player commandChat format["%1...", ([] call GC_Cfg_RandomLoadingMessage)]; JIP_Stats_Ready};
player setvariable["loaded",true,true];

player removeweapon "ItemGPS";
player removeitem "FirstAidKit";
player unassignitem "FirstAidKit";
removegoggles player;

if (isciv) then {
	removeUniform player;
	call compile format['
		%1_arrest = ((GC_Wanted select 0) select 0);
		%1_wanted = ((GC_Wanted select 0) select 1);
		%1_reason = ((GC_Wanted select 0) select 2);
		%kopfcash_%1 = ((GC_Wanted select 0) select 3);
		publicVariable "%1_arrest";
		publicVariable "%1_wanted";
		publicVariable "%1_reason";
		publicVariable "kopfcash_%1";
	', player];
	if (('pistole' call INV_GetItemAmount) > 0) then {['pistole', 0] call INV_SetItemAmount;};

	//check gangsaray and become leader / member
	for "_c" from 0 to (count gangsarray - 1) do {
		_gangarray = gangsarray select _c;
		_gang      = _gangarray select 0;
		_members   = _gangarray select 1;
		_leader    = _members select 0;
		if (!isnil "_leader") then {
			if (_leader == (name player)) then {
				gangleader = true;
				gangmember = true;
				if (true) exitWith {};
			} else {
				if ((name player) in _members) exitWith {
					gangmember = true;
				};
			};
		};
	};
};
["INV", "drug"] call INV_StorageRemoveKindOf;
["INV", "drink"] call INV_StorageRemoveKindOf;
["INV", "food"] call INV_StorageRemoveKindOf;
["INV", "ressource"] call INV_StorageRemoveKindOf;  //intentional misspelling!
["INV", "bomb"] call INV_StorageRemoveKindOf;
["INV", "Ring"] call INV_StorageRemoveKindOf;
if (('cash' call INV_GetItemAmount) > 0) then {['cash', 420] call INV_SetItemAmount;};
["private_storage", "drug"] call INV_StorageRemoveKindOf;
["private_storage", "drink"] call INV_StorageRemoveKindOf;
["private_storage", "food"] call INV_StorageRemoveKindOf;
["private_storage", "ressource"] call INV_StorageRemoveKindOf;  //intentional misspelling!
["private_storage", "bomb"] call INV_StorageRemoveKindOf;
["private_storage", "Ring"] call INV_StorageRemoveKindOf;
["private_storage", "static"] call INV_StorageRemoveKindOf;

if (count private_storage > 0) then {
	{
		_item = (_x select 0);
		_amt = (_x select 1);
		if (_item == "cash") then {
			if (donatorcashbonus == 0) then {
				if (_amt > 200000) then {
					[_item, 200000, "private_storage"] call INV_SetStorageAmount;
				};
			} else {
				if (_amt > 400000) then {
					[_item, 400000, "private_storage"] call INV_SetStorageAmount;
				};
			};
		} else {
			if (donatorcashbonus == 0) then {
				if (_amt > 5) then {
					[_item, 5, "private_storage"] call INV_SetStorageAmount;
				};
			} else {
				if (_amt > 10) then {
					[_item, 10, "private_storage"] call INV_SetStorageAmount;
				};
			};
		};
	} foreach private_storage;
};
if (profileName != "ChaosBot") then {
	_slotstring = format["%1Slot",rolestring];
	if (!isnil "oldSlot") then {
		_array = toArray tolower (oldSlot select 0);
		_iscop1 = 0; if ((_array select 0) == 99 && (_array select 1) == 111 && (_array select 2) == 112) then {_iscop1 = 1;};
		_array = toArray tolower rolestring;
		_iscop2 = 0; if ((_array select 0) == 99 && (_array select 1) == 111 && (_array select 2) == 112) then {_iscop2 = 1;};

		if (_iscop1 != _iscop2) then {
			if not (['<t align="left">Because you are switching sides, your <img image="images\cl.paa"/> saved data will be deleted.<br/><br/>ARE YOU SURE YOU WANT TO DO THIS?</t>',"GLOBAL CHAOS GAMING - SAVED STATS WIPE","Yes","No",(finddisplay 46),false,true] call BIS_fnc_guiMessage) then {
				if (_iscop1 == 1) then {_slotstring = format["%1Slot","cop0"];} else {_slotstring = format["%1Slot","civ0"];};
				["oldSlot", [_slotstring]] call ClientSaveVar;
				call GC_EndMission;
			} else {
				INV_LizenzOwner = [];
				BuildingsOwnerArray = [];
				playerweapons = [];
				playermagazines = [];
				INV_Fabrikowner = [];
				INV_LizenzOwner = [];
				INV_VehicleArray = [];
				INV = [];
				GC_LastPos = [0,0,0];
				GC_A3 = [["",[],"",[],"",[],"","",[],[]]];
				["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;
				["BuildingsOwnerArray", BuildingsOwnerArray] call ClientSaveVar;
				["playerweapons", playerweapons] call ClientSaveVar;
				["playermagazines", playermagazines] call ClientSaveVar;
				["INV_Fabrikowner", INV_Fabrikowner] call ClientSaveVar;
				["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;
				["INV_VehicleArray", INV_VehicleArray] call ClientSaveVar;
				["INV", INV] call ClientSaveVar;
				["GC_A3", GC_A3] call ClientSaveVar;
				["GC_LastPos", GC_LastPos] call ClientSaveVar;
				player groupchat "SOME OF YOUR SAVED DATA WAS REMOVED WHEN SWITCHING SIDES"; //ha ha
			};
		};
		if ((oldSlot select 0) != _slotstring) then {
			oldSlot = _slotstring;
			["oldSlot", [oldSlot]] call ClientSaveVar;
		};
	} else {
		oldSlot = _slotstring;
		["oldSlot", [oldSlot]] call ClientSaveVar;
	};
};
if (local_arrest == 1) then {player switchmove "inbasemoves_handsbehindback1"; waituntil {sleep 0.3; animationstate player == "inbasemoves_handsbehindback1"}; ["arrest", 20, player] execVM "civmenu.sqf";};

if (isdead == 1 and isciv) then {player setpos getpos (respawnarray select (floor(random(count respawnarray))));[] execVM "rejoincamera.sqf";};

if (format["%1",GC_LastPos] != "[0,0,0]") then {
	_th = getTerrainHeightASL [(GC_LastPos select 0), (GC_LastPos select 1)];
	_touching = false;
	if (_th < 0) then {
		_th = 0;
	} else {
		_probe = "Rabbit_F" createVehicleLocal [0,0,0]; 
		_probe hideobject true;
		_probe setPosASL GC_LastPos;
		_touching = isTouchingGround _probe;
		deletevehicle _probe;
	};
	_offground = (_th + 3);
	if ((GC_LastPos select 2) > _offground and !_touching) then {
		_newh = (GC_LastPos select 2);
		if (_newh < 65) then {_newh = _offground + 65;};
		player setposASL [(GC_LastPos select 0), (GC_LastPos select 1), _newh];
		_chute = "NonSteerable_Parachute_F" createVehicle [0,0,0]; 
		_chute setPosASL getposASL player; 
		player moveIndriver _chute;
	} else {
		player setposASL GC_LastPos;
	};
};

if (chaos) then {
	_myPlayerUID = getPlayerUID player;
	_pid = (PlayerUID select 0);
	if (!(isnil "_pid")) then {
		if (_pid != _myPlayerUID) then {
			chaos = false;
			format['diag_log text "%1 is a GC imposter!"',name player] call broadcast_srv;
		};
	} else {
		chaos = false;
	};
};

["Slot", [rolestring]] call ClientSaveVar;
[] call addActions;

if (!isnil "TLS") then {
	_ago = "a few moments ago";
	_mins = round(abs(TC - TLS) / 60);
	if (_mins > 59) then {
		_hours = floor (_mins / 60);
		if (_hours == 1) then {
			_ago = format["%1 hour ago",_hours];
		} else {
			_ago = format["%1 hours ago",_hours];
		};
	} else {
		if (_mins != 0) then {
			if (_mins == 1) then {
				_ago = format["%1 minute ago",_mins];
			} else {
				_ago = format["%1 minutes ago",_mins];
			};
		};
	};
	player commandchat format["Last saved %1",_ago];
} else {
	if (isMultiplayer and profileName != "ChaosBot") then {
		if (scriptDone intro_handle) then {
			["FAQ"] execVM "settings.sqf";
			processDiaryLink gc_diarylink;
		} else {
			showChaosKeys = true;
		};
	};
};

if (isnil "donatorcashbonus") then {donatorcashbonus = 0;};
if (isnil "Kontostand") then { Kontostand = 0;};