_item     = _this select 0;
_infos    = _item call INV_getitemArray;
_cars1inv  = (carshop1 call INV_getshopArray) select 4;
_cars2inv  = (carshop2 call INV_getshopArray) select 4;
_cars3inv  = (carshop3 call INV_getshopArray) select 4;
_airinv   = (airshop call INV_getshopArray) select 4;
_truckinv = (truckshop call INV_getshopArray) select 4;

_carisexportable1 = [_item, _cars1inv] call INV_iteminshop;
_carisexportable2 = [_item, _cars2inv] call INV_iteminshop;
_carisexportable3 = [_item, _cars3inv] call INV_iteminshop;

if (_carisexportable1 or _carisexportable2 or _carisexportable3) exitwith {
  if (!(createDialog "RscMenuDistribute3")) exitWith {hint "Dialog Error!"};

	if (_carisexportable1) then {
	  //===================== CAR SHOP 1====================================
	  _shopnum      = carshop1 call INV_getshopnum;
	  _stock        = [_item, _shopnum] call INV_getstock;
	  _maxstock     = [_item, _shopnum] call INV_getmaxstock;
	  _preisOhneTax = (_infos call INV_getitemBuyCost)*1;
	  _preis        = (_infos call INV_getitemCostWithTax)*1;
	  _demand       = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
	  _preis        = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);
	  _shopName     = carshop1 call INV_getItemShopName;

	  ctrlSetText [3, format["%1 for $%2", _shopName, _preis]];
	  buttonSetAction [3, format['[%1,"%2",%3,%4,%5] execVM "exportvehicle.sqf";', _preis, _item, _stock, _maxstock, _shopnum]];
	};

	if (_carisexportable2) then {
	  //===================== CAR SHOP 2====================================
	  _shopnum      = carshop2 call INV_getshopnum;
	  _stock        = [_item, _shopnum] call INV_getstock;
	  _maxstock     = [_item, _shopnum] call INV_getmaxstock;
	  _preisOhneTax = (_infos call INV_getitemBuyCost)*1;
	  _preis        = (_infos call INV_getitemCostWithTax)*1;
	  _demand       = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
	  _preis        = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);
	  _shopName     = carshop2 call INV_getItemShopName;

	  ctrlSetText [4, format["%1 for $%2", _shopName, _preis]];
	  buttonSetAction [4, format['[%1,"%2",%3,%4,%5] execVM "exportvehicle.sqf";', _preis, _item, _stock, _maxstock, _shopnum]];
	};

	if (_carisexportable3) then {
	  //=====================CAR SHOP 3====================================
	  _shopnum      = carshop3 call INV_getshopnum;
	  _stock        = [_item, _shopnum] call INV_getstock;
	  _maxstock     = [_item, _shopnum] call INV_getmaxstock;
	  _preisOhneTax = (_infos call INV_getitemBuyCost)*1;
	  _preis        = (_infos call INV_getitemCostWithTax)*1;
	  _demand       = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
	  _preis        = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);
	  _shopName     = carshop3 call INV_getItemShopName;

	  ctrlSetText [5, format["%1 for $%2", _shopName, _preis]];
	  buttonSetAction [5, format['[%1,"%2",%3,%4,%5] execVM "exportvehicle.sqf";', _preis, _item, _stock, _maxstock, _shopnum]];
	};
};

if ([_item, _airinv] call INV_iteminshop) exitwith {
  if (!(createDialog "RscMenuDistribute3")) exitWith {hint "Dialog Error!"};

  //===================== AIR SHOP 1====================================
  _shopnum      = airshop call INV_getshopnum;
  _stock        = [_item, _shopnum] call INV_getstock;
  _maxstock     = [_item, _shopnum] call INV_getmaxstock;
  _preisOhneTax = (_infos call INV_getitemBuyCost)*1;
  _preis        = (_infos call INV_getitemCostWithTax)*1;
  _demand       = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
  _preis        = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);
  _shopName     = airshop call INV_getItemShopName;

  ctrlSetText [3, format["%1 for $%2", _shopName, _preis]];
  buttonSetAction [3, format['[%1,"%2",%3,%4,%5] execVM "exportvehicle.sqf";', _preis, _item, _stock, _maxstock, _shopnum]];
};

if ([_item, _truckinv] call INV_iteminshop) exitwith {
  if (!(createDialog "RscMenuDistribute1")) exitWith {hint "Dialog Error!"};

  //=====================TRUCK SHOP====================================
  _shopnum      = truckshop call INV_getshopnum;
  _stock        = [_item, _shopnum] call INV_getstock;
  _maxstock     = [_item, _shopnum] call INV_getmaxstock;
  _preisOhneTax = (_infos call INV_getitemBuyCost)*1;
  _preis        = (_infos call INV_getitemCostWithTax)*1;
  _demand       = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
  _preis        = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);
  _shopName     = truckshop call INV_getItemShopName;

  passvararray  = [_preis, _item, _stock, _maxstock, _shopnum, truckshop];

  ctrlSetText [3, format["%1 for $%2", _shopName, _preis]];
  buttonSetAction [3, format['[%1,"%2",%3,%4,%5] execVM "exportvehicle.sqf";', _preis, _item, _stock, _maxstock, _shopnum]];
};

player groupchat "No shops will buy the selected vehicle.";
