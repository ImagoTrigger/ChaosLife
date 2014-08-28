_item     = _this select 0;
_infos    = _item call INV_getitemArray;
_fuelsinv = (tuning1 call INV_getshopArray) select 4;

if ([_item, _fuelsinv] call INV_iteminshop) exitwith {
  if (!(createDialog "RscMenuDistribute3")) exitWith {hint "Dialog Error!"};

  //=====================TUNING SHOP 1====================================
  _shopnum      = tuning1 call INV_getshopnum;
  _stock        = [_item, _shopnum] call INV_getstock;
  _maxstock     = [_item, _shopnum] call INV_getmaxstock;
  _preisOhneTax = (_infos call INV_getitemBuyCost)*1;
  _preis        = (_infos call INV_getitemCostWithTax)*1;
  _demand       = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
  _preis        = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);
  _shopName     = tuning1 call INV_getItemShopName;

  ctrlSetText [3, format["%1 for $%2", _shopName, _preis]];
  buttonSetAction [3, format['[%1,"%2",%3,%4,%5] execVM "exportitem.sqf";', _preis, _item, _stock, _maxstock, _shopnum]];

  //=====================TUNING SHOP 2====================================
  _shopnum      = tuning2 call INV_getshopnum;
  _stock        = [_item, _shopnum] call INV_getstock;
  _maxstock     = [_item, _shopnum] call INV_getmaxstock;
  _preisOhneTax = (_infos call INV_getitemBuyCost)*1;
  _preis        = (_infos call INV_getitemCostWithTax)*1;
  _demand       = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
  _preis        = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);
  _shopName     = tuning2 call INV_getItemShopName;

  ctrlSetText [4, format["%1 for $%2", _shopName, _preis]];
  buttonSetAction [4, format['[%1,"%2",%3,%4,%5] execVM "exportitem.sqf";', _preis, _item, _stock, _maxstock, _shopnum]];
};

player groupchat "No shops will buy the selected item.";
