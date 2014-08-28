if(fvspam)exitwith{};
_preis      = _this select 0;
_item       = _this select 1;
_stock      = _this select 2;
_maxstock   = _this select 3;
_shopnum    = _this select 4;

fvspam=true;

if(_stock >= _maxstock)exitwith{player groupchat "The shop has reached its maximum stock for this vehicle.";fvspam=false;};
																			
['cash', _preis] call INV_AddInventoreItem;

player groupchat format["The vehicle has been exported for $%1!", _preis];

call compile format['if(%1avail > 0)then{%1avail = %1avail - 1;["%1avail", %1avail] spawn ClientSaveVar};', _item];

format['["%1", (%2 + 1), %3] call INV_itemstocksupdate;', _item, _stock, _shopnum] call broadcast;

closedialog 0;

sleep 1;

fvspam=false;
