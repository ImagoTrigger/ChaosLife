if(fvspam)exitwith{};
_item 	      = _this select 0;
_infos        = _item call INV_getitemArray;
_shopnum      = 0;
_type         = _item call INV_getitemKindOf;
_noun = "ammunition";

if (_type == "pistol") then {
  _shopnum = pistolshop call INV_getshopnum;
};

if (_type == "rifle") then {
  _shopnum = rifleshop call INV_getshopnum;
};

if (_type == "uniform" or _type == "hat") then {
  _shopnum = clothshop call INV_getshopnum;
  _noun = "clothing";
};

if (_type == "vest" or _type == "backpack") then {
  _shopnum = armyshop call INV_getshopnum;
  _noun = "item";
};

if (_type == "backpack" and _item in gc_bags) then {
  _shopnum = bagshop call INV_getshopnum;
  _noun = "bag";
};

if (_type == "attachment") then {
  _shopnum = attachshop call INV_getshopnum;
  _noun = "attachment";
};

//dirty 
if (_type == "Shop") then {
  _shopnum = goggleshop call INV_getshopnum;
  _noun = "eyewear";
};

_stock        = [_item, _shopnum] call INV_getstock;
_maxstock     = [_item, _shopnum] call INV_getmaxstock;
_preisOhneTax = (_infos call INV_getitemBuyCost)*1;
_preis        = (_infos call INV_getitemCostWithTax)*1;
_demand       = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
_preis        = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);

fvspam=true;

if(_stock >= _maxstock)exitwith{player groupchat format["The shop has reached its maximum stock for this %1.",_noun];fvspam=false;};

['cash', _preis] call INV_AddInventoreItem;

player groupchat format["The %2 has been exported for $%1!", _preis,_noun];

call compile format['if(%1avail > 0)then{%1avail = %1avail - 1;["%1avail", %1avail] call ClientSaveVar};', _item];

format['["%1", (%2 + 1), %3] call INV_itemstocksupdate;', _item, _stock, _shopnum] call broadcast;

sleep 1;

fvspam=false;
