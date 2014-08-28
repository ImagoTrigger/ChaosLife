if(fvspam)exitwith{};

_item         = _this select 0;
_infos        = _item call INV_getitemArray;
_shopnum      = equipshop call INV_getshopnum;
_stock        = [_item, _shopnum] call INV_getstock;
_maxstock     = [_item, _shopnum] call INV_getmaxstock;
_preisOhneTax = (_infos call INV_getitemBuyCost)*1;
_preis        = (_infos call INV_getitemCostWithTax)*1;
_demand       = _preis*0.5*(_stock-(_maxstock*0.5))/(0.5*_maxstock);
_preis        = round((_preisOhneTax*(_preis/_preisOhneTax)) - _demand);

fvspam=true;

if(_stock >= _maxstock)exitwith{player groupchat "The shop has reached its maximum stock for this item.";fvspam=false;};

['cash', _preis] call INV_AddInventoreItem;

player groupchat format["The item has been exported for $%1!", _preis];

call compile format['if(%1avail > 0)then{%1avail = %1avail - 1;["%1avail", %1avail] call ClientSaveVar};', _item];

format['["%1", (%2 + 1), %3] call INV_itemstocksupdate;', _item, _stock, _shopnum] call broadcast;

sleep 1;

fvspam=false;
