_item     = _this select 0;
_infos    = _item call INV_getitemArray;
_fuelsinv = (fuelshop1 call INV_getshopArray) select 4;

if ([_item, _fuelsinv] call INV_iteminshop) exitwith {
  if (!(createDialog "RscMenuDistribute4")) exitWith {hint "Dialog Error!"};

  //===================== FUEL SHOP 1====================================
  _shopnum      = fuelshop1 call INV_getshopnum;
  _stock        = [_item, _shopnum] call INV_getstock;
  _maxstock     = [_item, _shopnum] call INV_getmaxstock;
  _preisOhneTax = (_infos call INV_getitemBuyCost)*1;
  _preis        = (_infos call INV_getitemCostWithTax)*1;
  _demand       = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
  _preis        = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);
  _shopName     = fuelshop1 call INV_getItemShopName;

  ctrlSetText [3, format["%1 for $%2", _shopName, _preis]];
  buttonSetAction [3, format['[%1,"%2",%3,%4,%5] execVM "exportitem.sqf";', _preis, _item, _stock, _maxstock, _shopnum]];

  //===================== FUEL SHOP 2====================================
  _shopnum      = fuelshop2 call INV_getshopnum;
  _stock        = [_item, _shopnum] call INV_getstock;
  _maxstock     = [_item, _shopnum] call INV_getmaxstock;
  _preisOhneTax = (_infos call INV_getitemBuyCost)*1;
  _preis        = (_infos call INV_getitemCostWithTax)*1;
  _demand       = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
  _preis        = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);
  _shopName     = fuelshop2 call INV_getItemShopName;

  ctrlSetText [4, format["%1 for $%2", _shopName, _preis]];
  buttonSetAction [4, format['[%1,"%2",%3,%4,%5] execVM "exportitem.sqf";', _preis, _item, _stock, _maxstock, _shopnum]];

  //=====================FUEL SHOP 3====================================
  _shopnum      = fuelshop3 call INV_getshopnum;
  _stock        = [_item, _shopnum] call INV_getstock;
  _maxstock     = [_item, _shopnum] call INV_getmaxstock;
  _preisOhneTax = (_infos call INV_getitemBuyCost)*1;
  _preis        = (_infos call INV_getitemCostWithTax)*1;
  _demand       = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
  _preis        = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);
  _shopName     = fuelshop3 call INV_getItemShopName;

  ctrlSetText [5, format["%1 for $%2", _shopName, _preis]];
  buttonSetAction [5, format['[%1,"%2",%3,%4,%5] execVM "exportitem.sqf";', _preis, _item, _stock, _maxstock, _shopnum]];

  //=====================FUEL SHOP 4====================================
  _shopnum      = fuelshop4 call INV_getshopnum;
  _stock        = [_item, _shopnum] call INV_getstock;
  _maxstock     = [_item, _shopnum] call INV_getmaxstock;
  _preisOhneTax = (_infos call INV_getitemBuyCost)*1;
  _preis        = (_infos call INV_getitemCostWithTax)*1;
  _demand       = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
  _preis        = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);
  _shopName     = fuelshop4 call INV_getItemShopName;

  ctrlSetText [6, format["%1 for $%2", _shopName, _preis]];
  buttonSetAction [6, format['[%1,"%2",%3,%4,%5] execVM "exportitem.sqf";', _preis, _item, _stock, _maxstock, _shopnum]];
};


player groupchat "No shops will buy the selected item.";





