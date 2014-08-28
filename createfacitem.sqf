if ((_this select 0) == "") exitWith {player groupChat localize "STRS_inv_no_selection";};
_item        = _this select 0;
_fabriknum   = _this select 1;
_type        = _this select 2;
_queue       = (INV_ItemFabriken select _fabriknum) select 8;
_ablage      = (INV_ItemFabriken select _fabriknum) select 7;
_spawn       = (INV_ItemFabriken select _fabriknum) select 4;
_crate       = (INV_ItemFabriken select _fabriknum) select 3;
_name        = (INV_ItemFabriken select _fabriknum) select 2;
_infos       = _item call INV_getitemArray;
_cost	     = (_infos call INV_getitemBuyCost)*0.5;
_itemart     = _infos call INV_getitemType;
_amount      = (["cash", _ablage] call INV_GetStorageAmount);

if(_type == "mani") then {
	if (_amount < _cost) exitWith {player groupChat localize "STRS_inv_fac_not_enough"};
	["cash", -(_cost), _ablage] call INV_AddItemStorage;

	call compile format['%1 = %1 + [_item]; %2pend = %2pend + 1; ["%2pend", %2pend] call ClientSaveVar;', _queue, _item];

	player groupChat "Added to the production line.";
	call compile format['["%1", %1] call ClientSaveVar;["%2", %2] call ClientSaveVar;', _ablage, _queue];
	_addskill = (1 / 25); //Every 25 Items made = 1 skill point..
	["SKILL_MANUFACTURING",_addskill] call GC_addSkill;
};
if(_type == "create") then {
	if(fvspam)exitwith{};

	call compile format['favail = %1avail; if(%1avail > 0)then{%1avail = %1avail - 1;["%1avail", %1avail] call ClientSaveVar};', _item];
	if(favail < 1)exitwith{player groupchat "There are no vehicles of this type available."};

	if (_itemart == "Item") then {
		player groupchat "creating...";
		fvspam=true;
		sleep 1;
		[_item, 1, _ablage] spawn INV_CreateItem;
		fvspam=false;
	};
	if (_itemart == "waffe") then {
		player groupchat "creating...";
		fvspam=true;
		sleep 1;
		[(_infos call INV_getitemClassName), 1, _crate] spawn INV_CreateWeapon;
		fvspam=false;
	};
	if (_itemart == "magazin") then {
		player groupchat "creating...";
		fvspam=true;
		sleep 1;
		if (_infos call INV_getitemKindOf == "uniform" or _infos call INV_getitemKindOf == "vest" or _infos call INV_getitemKindOf == "hat" or _infos call INV_getitemKindOf == "attachment"  or _infos call INV_getitemKindOf == "a3item") then {
			[(_infos call INV_getitemClassName), 1, _crate] spawn INV_CreateA3Item;
		} else {
			if (_infos call INV_getitemKindOf == "backpack") then {
				[(_infos call INV_getitemClassName), 1, _crate] spawn INV_CreateBackpack;
			} else {
				[(_infos call INV_getitemClassName), 1, _crate] spawn INV_CreateMag;							
			};
		};
		fvspam=false;
	};
	if (_itemart == "Fahrzeug") then {
		player groupchat "creating...";
		fvspam=true;
		sleep 5;
		if ((_infos call INV_getitemClassName) iskindof "ship") then {_spawn = vfacspawn_boat1;};
		[_item, _spawn] spawn INV_CreateVehicle;
		fvspam=false
	};
	player groupchat "Item created!";
};
if(_type == "export") then {
	if(fvspam)exitwith{};
	call compile format['favail = %1avail', _item];
	if(favail < 1)exitwith{player groupchat "There are no items/vehicles of this type available."};
	if (_itemart == "Fahrzeug") then {[_item] execVM "choosecity.sqf";};
	if (_itemart == "waffe") then {[_item] execVM "exportweapon.sqf";};
	if (_itemart == "magazin") then {[_item] execVM "exportmagazine.sqf";};
	_itemType     = _infos call INV_getitemKindOf;
	if (_itemType == "service") then {[_item] execVM "choosegasstation.sqf";};
	if (_itemType == "Shop") then {
		if ((isClass (configFile >> "CfgGlasses" >> _item))) then {
			[_item] execVM "exportmagazine.sqf";
		} else {
			[_item] execVM "chooseshop.sqf";
		};
	};
	if (_itemType == "carobjects") then {[_item] execVM "choosecartuning.sqf";};
	if (_itemType == "Equipment") then {[_item] execVM "exportequip.sqf";};
	if (_itemType == "misc") then {[_item] execVM "exportmining.sqf";};
	if (_itemType == "Ring") then {[_item] execVM "exportring.sqf";};
};
