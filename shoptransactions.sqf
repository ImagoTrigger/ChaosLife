private ["_menge","_cost","_exitvar","_income","_gangarray","_gang","_members","_control","_vest","_amtragen","_gesamtmenge","_gesamtgewicht","_inventargewicht","_spawnIndex","_stock","_einzelSteuer","_gesamtSteuer","_list","_i","_weaps","_mags","_vehicle","_posInVclArray","_CostMitTax","_maxstock","_cash","_art","_itemauswahl","_extrainfo","_extraArr","_item","_einzelCost","_itemnumber","_infos","_itemart","_classname","_shopnumber","_fahne","_crate","_vehSpawn","_shoparray","_license","_itemarray","_license1","_license2"];
_cash  = 'cash' call INV_GetItemAmount;
if ((_this select 1) == -1) exitWith {};
_art        = _this select 0;
_itemauswahl= _this select 1;
 _menge      = _this select 2;

 if (!(_menge call ISSE_str_isInteger)) exitWith {player groupChat localize "STRS_inv_no_valid_number";};
 _menge      = _menge call ISSE_str_StrToInt;
 if (_menge <= 0) exitWith {};
 _extrainfo  = _this select 3;
 _extraArr   = _this select 4;
 _item       = _extraArr select 0;
 _einzelCost = _extraArr select 1;
 _CostMitTax = _extraArr select 2;
 _itemnumber = _extraArr select 3;
 _cost       = _menge*_CostMitTax;
 _infos      = _item  call INV_getitemArray;
 _itemart    = _infos call INV_getitemType;
 _classname  = _infos call INV_getitemClassName;
 _shopnumber = INV_ActiveShopNumber;
 _fahne      = ((INV_ItemShops select _shopnumber) select 0);
 _crate      = ((INV_ItemShops select _shopnumber) select 2);
 _vehSpawn   = ((INV_ItemShops select _shopnumber) select 3);
 _shoparray  = ((INV_ItemShops select _shopnumber) select 4);
 _license    = ((INV_ItemShops select _shopnumber) select 6);
 _itemarray  = (_shoparray select _itemnumber);
 _exitvar    = 0;
 _license1   = _infos call INV_getitemLicense;
 _license2   = _infos call INV_getitemLicense2;
if (isnil "_license1") then {_license1 = "";};
if (isnil "_license2") then {_license2 = "";};

//===========================================================BUY===============================================================

if (_art == "itemkauf") then

{
instock=true;
_stock = [_item, INV_ActiveShopNumber] call INV_getstock;

if (_stock != -1) then

	{

	if (_stock < _menge)then{_menge = _stock; _cost = _menge*_CostMitTax;};


	};

if(_menge == 0)then{instock=false};

if(_cash == 0)exitwith{player groupchat localize "STRS_inv_buyitems_keincash"; _exitvar = 1};

_einzelSteuer = ( _CostMitTax - _einzelCost );
_gesamtSteuer = _einzelSteuer*_menge;

if (_itemart == "Item" and instock) then

	{

	if (!(_license1 call INV_HasLicense) and isciv and _license) exitWith {
		closedialog 0;
		["GC_MoneyBad",["CHAOS LIFE LICENSES",format[localize "STRS_inv_buyitems_nolicense", (_license1 call INV_GetLicenseName)]]]  spawn bis_fnc_showNotification;
		_exitvar = 1;
	};
	if (!(_license2 call INV_HasLicense) and iscop and _license) exitWith {
		closedialog 0;
		["GC_MoneyBad",["CHAOS LIFE LICENSES",format[localize "STRS_inv_buyitems_nolicensecop", (_license2 call INV_GetLicenseName)]]]  spawn bis_fnc_showNotification;
		_exitvar = 1;
	};
	_amtragen          = (_item call INV_GetItemAmount);
	_gesamtmenge       = _amtragen + _menge;
	_gesamtgewicht     = (_infos call INV_getitemTypeKg)*_menge;
	_inventargewicht   = call INV_GetOwnWeight;
	if (((_infos call INV_getitemIsIllegal)) and (! INV_CANDOILLEGAL)) exitWith {player groupChat localize "STRS_inv_buyitems_notallowed"; _exitvar = 1};

	if ((_gesamtgewicht + _inventargewicht) > INV_Tragfaehigkeit) then

		{

		_menge = (floor((INV_Tragfaehigkeit - _inventargewicht) / (_infos call INV_getitemTypeKg)));
		_cost  = _menge*_CostMitTax;
		if (_menge <= 0) exitWith {player groupChat localize "STRS_inv_buyitems_maxgewicht"; _exitvar = 1;};

		};

	if (_cash < _cost) then

		{

		_menge = (floor(_cash/_CostMitTax));
		_cost  = _menge*_CostMitTax;
		if (_menge <= 0) exitWith {player groupChat localize "STRS_inv_buyitems_keincash"; _exitvar = 1;};

		};

	if (_exitvar == 1) exitWith {};

	if (_infos call INV_getitemIsIllegal and _cost > 0 and _infos call INV_getitemKindOf == "drug") then

		{

		_control = _fahne getvariable "control";

		for "_c" from 0 to (count gangsarray - 1) do

			{

			_gangarray = gangsarray select _c;
			_gang	   = _gangarray select 0;
			_members   = _gangarray select 1;

			if(_control == _gang and count _members > 0)then

				{

				_income = _cost/(count _members);
				format['if(name player in %1)then{player groupchat "You received $%2 from a drug sale"; kontostand = kontostand + %2};', _members, _income] call broadcast;

				};

			};

		};

	if(primaryweapon player == "" and secondaryweapon player == "")then{player playmove "AmovPercMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon"}else{player playmove "AinvPknlMstpSlayWrflDnon"};
	[_item, _menge, "INV"] call INV_CreateItem;
	if (_item == "HeavyArmor" or _item == "LightArmor") then {
		_vest = vest player;
		if (isnil "_vest" or _vest == "") then {
			player addvest "V_PlateCarrier1_cbr";
		};
	};
	['cash', -(_cost)] call INV_AddInventoreItem;
	INV_SteuernGezahlt = (INV_SteuernGezahlt + (_menge*_einzelSteuer));
	if(_cost == 0)exitwith{player groupchat format['you took %1 %2', (_menge call ISSE_str_IntToStr), (_infos call INV_getitemName)]};
	player groupChat format [localize "STRS_inv_buyitems_gekauft", (_menge call ISSE_str_IntToStr), (_infos call INV_getitemName), (_cost call ISSE_str_IntToStr)];

	};

if (((_itemart == "waffe") or (_itemart == "magazin")) and instock) then {

	if (!(_license1 call INV_HasLicense) and isciv and _license) exitWith {
		closedialog 0;
		["GC_MoneyBad",["CHAOS LIFE LICENSES",format[localize "STRS_inv_buyitems_nolicense", (_license1 call INV_GetLicenseName)]]]  spawn bis_fnc_showNotification;
		_exitvar = 1;
	};
	if (!(_license2 call INV_HasLicense) and iscop and _license) exitWith {
		closedialog 0;
		["GC_MoneyBad",["CHAOS LIFE LICENSES",format[localize "STRS_inv_buyitems_nolicensecop", (_license2 call INV_GetLicenseName)]]]  spawn bis_fnc_showNotification;
		_exitvar = 1;
	};
	if (_cash < _cost) exitWith {player groupChat localize "STRS_inv_buyitems_keincash"; _exitvar = 1};
	['cash', -(_cost)] call INV_AddInventoreItem;
	INV_SteuernGezahlt = (INV_SteuernGezahlt + _gesamtSteuer);

	//weapons
	if (_itemart == "Waffe") then {
			[(_infos call INV_getitemClassName), _menge, _crate] spawn INV_CreateWeapon;
	//mags & items
	} else {
		if (_infos call INV_getitemKindOf == "uniform" or _infos call INV_getitemKindOf == "vest" or _infos call INV_getitemKindOf == "hat" or _infos call INV_getitemKindOf == "attachment"  or _infos call INV_getitemKindOf == "a3item") then {
			[(_infos call INV_getitemClassName), _menge, _crate] spawn INV_CreateA3Item;
		} else {
			if (_infos call INV_getitemKindOf == "backpack") then {
				[(_infos call INV_getitemClassName), _menge, _crate] spawn INV_CreateBackpack;
			} else {
				[(_infos call INV_getitemClassName), _menge, _crate] spawn INV_CreateMag;
			};

		};
	};
	//the dialog for ths shop is over the notification ;-(
	player groupChat format[localize "STRS_inv_buyitems_gekauft", (_menge call ISSE_str_IntToStr), (_infos call INV_getitemName), (_cost call ISSE_str_IntToStr)];
};

if (_itemart == "fahrzeug" and instock) then

	{

	_menge = 1;
	if (!(_license1 call INV_HasLicense) and isciv and _license) exitWith {
		closedialog 0;
		["GC_MoneyBad",["CHAOS LIFE LICENSES",format[localize "STRS_inv_buyitems_nolicense", (_license1 call INV_GetLicenseName)]]]  spawn bis_fnc_showNotification;
		_exitvar = 1;
	};
	if (!(_license2 call INV_HasLicense) and iscop and _license) exitWith {
		closedialog 0;
		["GC_MoneyBad",["CHAOS LIFE LICENSES",format[localize "STRS_inv_buyitems_nolicensecop", (_license2 call INV_GetLicenseName)]]]  spawn bis_fnc_showNotification;
		_exitvar = 1;
	};
	if (INV_UsingCarshop == 1)  exitWith {player groupChat localize "STRS_inv_buyvehicles_store_in_use"; _exitvar = 1};
	if (_cash < _CostMitTax) exitWith {player groupChat localize "STRS_inv_buyitems_keincash"; _exitvar = 1};

	_spawnIndex = 0;

	while {count (nearestobjects [_vehSpawn select _spawnIndex, ["Ship","car","motorcycle","truck","Tank","air"], 4]) > 0} do {
		_spawnIndex = _spawnIndex + 1;
	};

	if (_spawnIndex == count _vehSpawn)	exitWith {
		player groupchat "there is a vehicle blocking the spawn!";
		_exitvar = 1;
	};

	['cash', -(_CostMitTax)] call INV_AddInventoreItem;
	INV_SteuernGezahlt = (INV_SteuernGezahlt + _einzelSteuer);
	player groupChat format [localize "STRS_inv_buyvehicles_buy_car", (_infos call INV_getitemName), (_CostMitTax call ISSE_str_IntToStr)];

	[_item, _vehSpawn select _spawnIndex] spawn

		{

		INV_UsingCarshop = 1;
		if (not(alive player)) exitWith {};
		[_this select 0, _this select 1] spawn INV_CreateVehicle;
		sleep 5;
		INV_UsingCarshop = 0;

		};

	};

if(!instock)exitwith{player groupchat "out of stock"};

if (_stock != -1 and _exitvar == 0) then

	{

	format['["%1", (%2 - %3), %4] call INV_itemstocksupdate;', _item, _stock, _menge, INV_ActiveShopNumber] call broadcast;

	};

};



//======================================================SELL===========================================================

if (_art == "itemverkauf") then

{
maxstock=false;
_stock    = [_item, INV_ActiveShopNumber] call INV_getstock;
_maxstock = [_item, INV_ActiveShopNumber] call INV_getmaxstock;

if (_maxstock != -1) then

	{

	if ((_stock + _menge) > _maxstock)then{maxstock=true; _menge = _maxstock - _stock;_cost = _menge*_CostMitTax;};

	};

if(_menge <= 0)exitwith{player groupchat "the shop has reached its maximum stock for this item/vehicle"};

if (_itemart == "item") then

	{

	if (_item call INV_GetItemAmount == 0) exitWith {player groupChat localize "STRS_inv_buyitems_sell_notenough"; _exitvar = 1};
	if (_item call INV_GetItemAmount < _menge) then {_menge = (_item call INV_GetItemAmount); _cost = _CostMitTax*_menge;};

	if (_infos call INV_getitemIsIllegal and _infos call INV_getitemKindOf == "drug") then

		{

		_list = _fahne getvariable "druglist";
		if(isnil "_list")then{_list = [[player, _menge, _cost/_menge]]}else{_list = _list + [[player, _menge, _cost/_menge]]};
		_fahne setvariable["druglist", _list, true];

		};

	if (!(_license1 call INV_HasLicense) and isciv and _license) exitWith {
		closedialog 0;
		["GC_MoneyBad",["CHAOS LIFE LICENSES",format[localize "STRS_inv_sellitems_nolicense", (_license1 call INV_GetLicenseName)]]]  spawn bis_fnc_showNotification;
		_exitvar = 1;
	};
	if (!(_license2 call INV_HasLicense) and iscop and _license) exitWith {
		closedialog 0;
		["GC_MoneyBad",["CHAOS LIFE LICENSES",format[localize "STRS_inv_sellitems_nolicensecop", (_license2 call INV_GetLicenseName)]]]  spawn bis_fnc_showNotification;
		_exitvar = 1;
	};

	_cost = floor(_cost);
	['cash', _cost] call INV_AddInventoreItem;
	[_item, -(_menge)] call INV_AddInventoreItem;
	if(primaryweapon player == "" and secondaryweapon player == "")then{player playmove "AmovPercMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon"}else{player playmove "AinvPknlMstpSlayWrflDnon"};
	player groupChat format [localize "STRS_inv_shop_sold", (_menge call ISSE_str_IntToStr), (_infos call INV_getitemName), (_cost call ISSE_str_IntToStr)];

	};

if (_itemart == "waffe") then {
	_class = _infos call INV_getitemClassName;
	_weaps = 0;
	_pistol = false;
	if ((secondaryWeapon player) == _class or (primaryWeapon player) == _class or (handgunWeapon player) == _class) then {_weaps = 1;};
	if (_weaps == 0) exitWith {player groupChat localize "STRS_inv_buyitems_sell_notenough"; _exitvar = 1};
	_cost = _CostMitTax;
	_cost = floor(_cost);
	['cash', _cost] call INV_AddInventoreItem;
	if(primaryweapon player == "" and secondaryweapon player == "")then{player playmove "AmovPercMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon"}else{player playmove "AinvPknlMstpSlayWrflDnon"};
	if ((handgunWeapon player) == _class) then {
		_pistol = true;
	};
	player removeWeaponGlobal (_infos call INV_getitemClassName);
	player groupChat format [localize "STRS_inv_buyitems_verkauft", 1, (_infos call INV_getitemName), (_CostMitTax call ISSE_str_IntToStr)];
	if (_pistol) then {  
		saveWeaponPistol = ["",false,false];
		[] call GC_PistolActions;
	};
};
if (_itemart == "magazin") then {
	if (_infos call INV_getitemKindOf == "uniform" or _infos call INV_getitemKindOf == "vest" or _infos call INV_getitemKindOf == "hat" or _infos call INV_getitemKindOf == "attachment"  or _infos call INV_getitemKindOf == "a3item") then {
		_items      = {_x == (_infos call INV_getitemClassName)} count items player;
		if (_items == 0) exitWith {player groupChat localize "STRS_inv_buyitems_sell_notenough"; _exitvar = 1};
		if (_items < _menge) then {_menge = _items;};
		_cost = _menge*_CostMitTax;
		_cost = floor(_cost);
		['cash', _cost] call INV_AddInventoreItem;
		if(primaryweapon player == "" and secondaryweapon player == "")then{player playmove "AmovPercMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon"}else{player playmove "AinvPknlMstpSlayWrflDnon"};
		for [{_i=0}, {_i < _menge}, {_i=_i+1}] do {player removeItem (_infos call INV_getitemClassName);};
	} else {
		if (_infos call INV_getitemKindOf == "backpack") then {
			_packs = 0;
			if ((_infos call INV_getitemClassName) == (backpack player)) then {_packs = 1;};
			if (_packs == 0) exitWith {player groupChat localize "STRS_inv_buyitems_sell_notenough"; _exitvar = 1};
			_cost = _CostMitTax;
			_cost = floor(_cost);
			['cash', _cost] call INV_AddInventoreItem;
			if(primaryweapon player == "" and secondaryweapon player == "")then{player playmove "AmovPercMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon"}else{player playmove "AinvPknlMstpSlayWrflDnon"};
			removeBackpack player;
		} else {
			_mags      = {_x == (_infos call INV_getitemClassName)} count magazines player;
			if (_mags == 0) exitWith {player groupChat localize "STRS_inv_buyitems_sell_notenough"; _exitvar = 1};
			if (_mags < _menge) then {_menge = _mags;};
			_cost = _menge*_CostMitTax;
			_cost = floor(_cost);
			['cash', _cost] call INV_AddInventoreItem;
			if(primaryweapon player == "" and secondaryweapon player == "")then{player playmove "AmovPercMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon"}else{player playmove "AinvPknlMstpSlayWrflDnon"};
			for [{_i=0}, {_i < _menge}, {_i=_i+1}] do {player removeMagazineGlobal (_infos call INV_getitemClassName);};
		};
	};
	player groupChat format [localize "STRS_inv_buyitems_verkauft", (_menge call ISSE_str_IntToStr), (_infos call INV_getitemName), (_cost call ISSE_str_IntToStr)];
	_exitvar = 1;
};

if (_itemart == "fahrzeug") then

	{

	_menge = 1;
	_vehicle = call compile format ["%1", _extrainfo];
	_posInVclArray = INV_VehicleArray find _vehicle;
	if (_posInVclArray == -1) exitWith {player groupChat localize "STRS_inv_buyvehicles_noowner"; _exitvar = 1};
	if (not (alive _vehicle))            exitWith {player groupChat localize "STRS_inv_buyvehicles_destroyed"; _exitvar = 1};
	if ((_vehicle distance player) > 25) exitWith {player groupChat localize "STRS_inv_buyitems_sell_toofar"; _exitvar = 1};
	_CostMitTax = floor(_CostMitTax);
	['cash', (_CostMitTax)] call INV_AddInventoreItem;
	player groupChat format [localize "STRS_inv_shop_vehiclesold", (_CostMitTax call ISSE_str_IntToStr)];
	INV_VehicleArray = INV_VehicleArray - [_vehicle];
	deleteVehicle _vehicle;


	};

if (_stock != -1 and _exitvar == 0 and _infos call INV_getitemKindOf != "food") then

	{

	format['["%1", (%2 + %3), %4] call INV_itemstocksupdate;', _item, _stock, _menge, INV_ActiveShopNumber] call broadcast;

	};

//============================================== OIL TRADING SUPPLY/DEMAND ============================================
if (((INV_ItemShops select INV_ActiveShopNumber) select 0) == OilSell1) then{
	refuelCost = refuelCost - oilsellpricedec*_menge;
	sleep 0.1;
	if(refuelCost < minPetrolPrice) then {refuelCost = minPetrolPrice};
	publicvariable "refuelCost";
};
//=======================================================================================================================

if(maxstock)then{player groupchat "the shop has reached its maximum stock for this item/vehicle"};

};
sleep 0.001;
shopactivescript = false;