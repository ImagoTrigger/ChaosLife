private ["_mygang","_item","_preis","_preisOhneTax","_name","_index","_infos","_stock","_maxstock","_sellnumber","_demand","_itemsellarray","_i","_control","_mags","_menge","_j","_vehicle","_slider","_moneyanzeige","_cursel","_cash","_shop","_itembuyarray"];
uinamespace setVariable ["GC_Storage", false];
if (!(createDialog "RscMenuPurchase")) exitWith {hint "Dialog Error!"};

if (isNil "INV_ShopDialoge") then {INV_ShopDialoge = 0} else {INV_ShopDialoge = INV_ShopDialoge + 1};

private["_mygang","_exitvar", "_item", "_preis", "_preisOhneTax", "_zerostockcount", "_name", "_index", "_infos","_stock","_maxstock","_sellnumber","_demand","_itemsellarray"];

_this                   = _this select 3;
INV_ActiveShopNumber    = (_this select 0);
INV_ActiveSellShopArray = [];
INV_ActiveBuyShopArray  = [];
_shop                   = ((INV_ItemShops select INV_ActiveShopNumber) select 0);
_itembuyarray           = ((INV_ItemShops select INV_ActiveShopNumber) select 4);
_itemsellarray          = ((INV_ItemShops select INV_ActiveShopNumber) select 5);

if (_shop == clothshop and iscop) exitwith {closedialog 0;["GC_Talk",["CHAOS LIFE CLOTHES SHOP","Only civilians can shop here!!"]] spawn bis_fnc_showNotification;};

_mygang = call INV_mygang;

if (_shop == boatshop2 and  _mygang == "") exitWith {closedialog 0;playsound "warnsfx";["GC_FlagNeut_Red",["CHAOS LIFE GANG BOATS","You must control Camp Tempest before using this shop!"]] spawn bis_fnc_showNotification;};
if (_shop == boatshop7 and  _mygang == "") exitWith {closedialog 0;playsound "warnsfx";["GC_FlagNeut_Red",["CHAOS LIFE GANG BOATS","You must control Camp Tsoukala before using this shop!"]] spawn bis_fnc_showNotification;};
if (_shop == boatshop2 and (gangarea2 getvariable "control") != _mygang) exitWith {closedialog 0;playsound "warnsfx";["GC_FlagNeut_Red",["CHAOS LIFE GANG BOATS","You must control Camp Tempest before using this shop!"]] spawn bis_fnc_showNotification;};
if (_shop == boatshop7 and (gangarea5 getvariable "control") != _mygang) exitWith {closedialog 0;playsound "warnsfx";["GC_FlagNeut_Red",["CHAOS LIFE GANG BOATS","You must control Camp Tsoukala before using this shop!"]] spawn bis_fnc_showNotification;};
if (_shop == caveshop and isnil "GC_CaveFound") then {
  playsound "scoringsfx";
  GC_CaveFound = 1;
  ["GC_CaveFound",GC_CaveFound] call ClientSaveVar;
  ["GC_Good",["Chaos experience awarded","You've found the Scuba Gun Shop!","+25"]] spawn bis_fnc_showNotification;
};

//--------------------------------------BUY-----------------------------------------
for [{_i=0}, {_i < (count _itembuyarray)}, {_i=_i+1}] do {
  _item         = _itembuyarray select _i;
  _infos        = _item call INV_getitemArray;
  _stock        = [_item, INV_ActiveShopNumber] call INV_getstock;
  _preisOhneTax = _infos call INV_getitemBuyCost;
  _preis        = _infos call INV_getitemSteuer;
  _name         = (_infos call INV_getitemName);

  if(_stock != -1) then {
    _maxstock = [_item, INV_ActiveShopNumber] call INV_getmaxstock;
    _demand   = _preis*0.25*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
    _preis    = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);
  };

  if(_infos call INV_getitemType == "item")then {
    if (_item call INV_getitemIsIllegal) then {
      _preis   = _infos call INV_getitemSteuer;
      _control = _shop getvariable["control",""];

      if(_control == (call INV_mygang) and _infos call INV_getitemKindOf == "drug") then {_preis = 0};
    };
  };

  if (_stock != -1) then {
    if (_infos call INV_getitemType == "item") then {
      _index = lbAdd [1, format ["%1 ($%2, %3kg, Stock: %4)", _name, (_preis), (_infos call INV_getitemTypeKg), _stock] ];
    } else {
      _index = lbAdd [1, format ["%1 ($%2, Stock: %3)", _name, (_preis call ISSE_str_IntToStr), _stock] ];
    };
  } else {
    if (_infos call INV_getitemType == "item") then {
      _index = lbAdd [1, format ["%1 ($%2, %3kg)", _name, (_preis), (_infos call INV_getitemTypeKg)] ];
    } else {
      _index = lbAdd [1, format ["%1 ($%2)", _name, (_preis call ISSE_str_IntToStr)] ];
    };
  };

  lbSetData [1, _index, format ["%1", _item] ];
  INV_ActiveBuyShopArray = INV_ActiveBuyShopArray + [ [_item, _preisOhneTax, _preis, _i] ];
};


//--------------------------------------SELL-----------------------------------------
for [{_i=0}, {_i < (count _itemsellarray)}, {_i=_i+1}] do {
  _item         = _itemsellarray select _i;
  _infos        = _item call INV_getitemArray;
  _stock        = [_item, INV_ActiveShopNumber] call INV_getstock;
  _preisOhneTax = (_infos call INV_getitemBuyCost)*0.5;
  _preis        = (_infos call INV_getitemSteuer)*0.5;
  _name         = (_infos call INV_getitemName);
  _sellnumber   = _i;

  if(_stock != -1) then {
    _maxstock    = [_item, INV_ActiveShopNumber] call INV_getmaxstock;
    _demand      = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
    _preis       = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);
  };

  if(_infos call INV_getitemType == "item")then{if (_item call INV_getitemIsIllegal)then{_preis = (_infos call INV_getitemSellCost)};};

  if (((INV_ItemShops select INV_ActiveShopNumber) select 0) == OilSell1) then {
    _demand = ((refuelCost - minPetrolPrice)/200);
    _preis  = round((_preisOhneTax*(_preis/_preisOhneTax))*_demand);
    if (_preis < oilbaseprice) then {_preis = oilbaseprice};
  };

  if ((_infos call INV_getitemType) == "Waffe") then {
  	_class = _infos call INV_getitemClassName;
    if ((secondaryWeapon player) == _class or (primaryWeapon player) == _class or (handgunWeapon player) == _class) then {
      INV_ActiveSellShopArray = INV_ActiveSellShopArray + [ [_item, _preisOhneTax, _preis, _sellnumber] ];
      _index = lbAdd [101, format["%1 ($%2)", _name, _preis] ];
      lbSetData [101, _index, _item];
    };
  };

  if ((_infos call INV_getitemType) == "Magazin") then {
  
	if (_infos call INV_getitemKindOf == "uniform" or _infos call INV_getitemKindOf == "vest" or _infos call INV_getitemKindOf == "hat" or _infos call INV_getitemKindOf == "attachment"  or _infos call INV_getitemKindOf == "a3item") then {
	    if ((_infos call INV_getitemClassName) in (items player)) then {
	      INV_ActiveSellShopArray = INV_ActiveSellShopArray + [ [_item, _preisOhneTax, _preis, _sellnumber] ];
	      _items  = {_x == (_infos call INV_getitemClassName)} count items player;
	      _menge = _items;
	      _index = lbAdd [101, format["%1 ($%2 %3x)", _name, (_preis call ISSE_str_IntToStr), (_menge call ISSE_str_IntToStr)] ];
	      lbSetData [101, _index, _item];
	    };
	} else {
		if (_infos call INV_getitemKindOf == "backpack") then {
			_class = _infos call INV_getitemClassName;
		    if ((backpack player) == _class ) then {
		      INV_ActiveSellShopArray = INV_ActiveSellShopArray + [ [_item, _preisOhneTax, _preis, _sellnumber] ];
		      _index = lbAdd [101, format["%1 ($%2)", _name, _preis] ];
		      lbSetData [101, _index, _item];
		    };
		} else {
		    if ((_infos call INV_getitemClassName) in (magazines player)) then {
		      INV_ActiveSellShopArray = INV_ActiveSellShopArray + [ [_item, _preisOhneTax, _preis, _sellnumber] ];
		      _mags  = {_x == (_infos call INV_getitemClassName)} count magazines player;
		      _menge = _mags;
		      _index = lbAdd [101, format["%1 ($%2 %3x)", _name, (_preis call ISSE_str_IntToStr), (_menge call ISSE_str_IntToStr)] ];
		      lbSetData [101, _index, _item];
		    };
		};

	};  
  };

  if ((_infos call INV_getitemType) == "Item") then {
    if ( ((_item call INV_GetItemAmount) > 0) and (_item call INV_getitemDropable) ) then {
      INV_ActiveSellShopArray = INV_ActiveSellShopArray + [ [_item, _preisOhneTax, _preis, _sellnumber] ];
      _index = lbAdd [101, format["%1 ($%2, %5kg, %4x)", _name, (_preis call ISSE_str_IntToStr), 0, (_item call INV_GetItemAmount), (_infos call INV_getitemTypeKg)] ];
      lbSetData [101, _index, (format ["%1", _item])];
    };
  };

  if ((_infos call INV_getitemType) == "Fahrzeug") then {
    for [{_j=0}, {_j < (count INV_VehicleArray)}, {_j=_j+1}] do {
      if (!(isNull(INV_VehicleArray select _j))) then {
        _vehicle = (INV_VehicleArray select _j);

        if ((typeOf _vehicle) == _item or
          ((_item == "C_Quadbike_01_F_red" or _item == "C_Quadbike_01_F_blue" or _item == "C_Quadbike_01_F_white"  or _item == "C_Quadbike_01_F_black") and (typeOf _vehicle) == "C_Quadbike_01_F") or
          ((_item == "C_Offroad_01_F_cop" or _item == "C_Offroad_01_F_red" or _item == "C_Offroad_01_F_tan" or _item == "C_Offroad_01_F_white"  or _item == "C_Offroad_01_F_teal" or _item == "C_Offroad_01_F_maroon" or _item == "C_Offroad_01_F_blue") and (typeOf _vehicle) == "C_Offroad_01_F") or
          (_item == "O_Heli_Light_02_unarmed_F_civ" and (typeOf _vehicle) == "O_Heli_Light_02_unarmed_F") or
          (_item == "B_Heli_Light_01_F_blue" and (typeOf _vehicle) == "B_Heli_Light_01_F") or
          (_item == "B_MRAP_01_F_cop" and (typeOf _vehicle) == "B_MRAP_01_F"))
        then {
          INV_ActiveSellShopArray = INV_ActiveSellShopArray + [ [_item, _preisOhneTax, _preis, _sellnumber] ];
          _index = lbAdd [101, format["%1 ($%2, %3)", _vehicle, (_preis call ISSE_str_IntToStr), _name] ];
          lbSetData [101, _index, format["%1", _vehicle] ];
        };
      };
    };
  };
};


//---------------------------------SETDATA----------------------------------------

if(shopactivescript) then {
	buttonSetAction [3, "player groupChat ""Transaction in progress..."";"];
	buttonSetAction [103, "player groupChat ""Transaction in progress..."";"];
} else {
	buttonSetAction [3,
	"
	  if(shopactivescript) exitWith {player groupChat ""Transaction in progress..."";};
	  shopactivescript = true;
	  [""itemkauf"",    lbCurSel 1,  ctrlText 2,   lbData [101, (lbCurSel 1)  ], INV_ActiveBuyShopArray select (lbCurSel 1)]    execVM ""shoptransactions.sqf"";
	"];
	buttonSetAction [103,
	"
	  if(shopactivescript) exitWith {player groupChat ""Transaction in progress..."";};
	  shopactivescript = true;
	  [""itemverkauf"", lbCurSel 101, ctrlText 102, lbData [101, (lbCurSel 101)], INV_ActiveSellShopArray select (lbCurSel 101)] execVM ""shoptransactions.sqf"";
	"];
};





ctrlSetText [101,format [localize "STRS_inv_shopdialog_itemshop", ('cash' call INV_GetItemAmount)]];


// TODO doubleclick handler to buy one or sell one A3 Imago
//_itemList ctrlAddEventHandler ["LBDblClick", "with uinamespace do {['item_action',['use'],''] call RscMenuInventory_script};"];
//

//--------------------------------REFRESH-----------------------------------------
disableSerialization;
_display = findDisplay 13000;
_submit  = _display displayCtrl 3;
_submit2 = _display displayCtrl 103;
_header  = _display displayCtrl 1000;

while {ctrlVisible 1015} do {
  _header ctrlSetText "Shop";
  _cash = 'cash' call INV_GetItemAmount;

  _cursel = (lbCurSel 1);
  if (_cursel >= 0) then {
    _item   = (INV_ActiveBuyShopArray select (lbCurSel 1)) select 0;
    _preis  = (INV_ActiveBuyShopArray select (lbCurSel 1)) select 2;
    _infos  = _item call INV_getitemArray;
    _name   = _infos call INV_getitemName;
    _slider = ctrlText 2;

    if (!(_slider call ISSE_str_isInteger)) then {_slider = "0";};
    _slider = _slider call ISSE_str_StrToInt;

    if (_slider < 0) then {_slider = 0;};
    _moneyanzeige = (_slider*_preis);


    if (_cash >= _moneyanzeige) then {
      if (_moneyanzeige > 9999999) then {_moneyanzeige = ">9999999";};

      if (_infos call INV_getitemType == "item") then {
        _submit ctrlEnable true;
        _submit ctrlSetTooltip format ["Buying: %1 (%2kg)", _name,  (_slider*(_infos call INV_getitemTypeKg))];
        _submit ctrlSetText format ["Buy ($%1)", _moneyanzeige];
        _submit ctrlCommit 0;
      } else {
      	_submit ctrlSetTooltip format ["Buying: %1", _name];
        _submit ctrlEnable true;
        _submit ctrlSetText format ["Buy ($%1)", _moneyanzeige];
        _submit ctrlCommit 0;
        //ctrlSetText [3, format ["Buy ($%1)", _moneyanzeige]];
      };
    } else {
      _submit ctrlSetText format ["Buy ($%1)", _moneyanzeige];
      _submit ctrlEnable false;
      _submit ctrlSetTooltip "You don't have enough money.";
      _submit ctrlCommit 0;
    };
  } else {
    _submit ctrlEnable false;
    _submit ctrlSetTooltip "Select an item to purchase.";
    _submit ctrlSetText "No Item";
    _submit ctrlCommit 0;
  };

  _cursel = (lbCurSel 101);
  if (_cursel >= 0) then {
    _item   = (INV_ActiveSellShopArray select (lbCurSel 101)) select 0;
    _preis  = (INV_ActiveSellShopArray select (lbCurSel 101)) select 2;
    _infos  = _item call INV_getitemArray;
    _name   = _infos call INV_getItemName;
    _slider = ctrlText 102;

    if (!(_slider call ISSE_str_isInteger)) then {_slider = "0";};
    _slider = _slider call ISSE_str_StrToInt;

    if (_slider < 0) then {_slider = 0;};
    _moneyanzeige = ((_slider*_preis) call ISSE_str_IntToStr);

    if (_infos call INV_getitemType == "item") then {
      _submit2 ctrlEnable true;
      _submit2 ctrlSetTooltip format ["Selling: %1 (%2kg)", _name, (_slider*(_infos call INV_getitemTypeKg))];
      _submit2 ctrlSetText format ["Sell ($%1)", _moneyanzeige];
      _submit2 ctrlCommit 0;
    } else {
      _submit2 ctrlEnable true;
      _submit2 ctrlSetTooltip format ["Selling: %1", _name];
      _submit2 ctrlSetText format ["Sell ($%1)", _moneyanzeige];
      _submit2 ctrlCommit 0;
    };
  } else {
    _submit2 ctrlEnable false;
    _submit2 ctrlSetTooltip "No item selected";
    _submit2 ctrlSetText "No Item";
    _submit2 ctrlCommit 0;
  };

  ctrlSetText [100, format ["$%1", _cash]];
  if ((_infos call INV_getitemType) != "Fahrzeug") then
  {
    ctrlSetText [10, format ["Capacity: %1/%2kg", (call INV_GetOwnWeight), INV_Tragfaehigkeit]];
  };
  sleep 0.1;
  if (INV_ShopDialoge > 1) exitWith {};
};

INV_ShopDialoge = INV_ShopDialoge - 1;