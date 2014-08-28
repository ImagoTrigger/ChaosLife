if (typename _this == "ARRAY") exitwith {
  _id      = _this select 3;
  _arr     = (INV_ItemFabriken select _id);
  _queue   = (_arr select 8);
  _fqueue  = call compile format["%1", _queue];
  _cash    = "cash" call INV_getitemamount;
  _workers = call compile format['%1workers', _queue];

  if (_workers >= maxfacworkers) exitwith { player groupchat "Max factory workers reached!" };
  if (_cash < facworkercost) exitwith { player groupchat "You do not have enough money." };
  if (doingSomething) exitWith {};

  doingSomething = true;

  ["cash", -facworkercost] call INV_AddInventoreItem;

  call compile format['%1workers = %1workers + 1;["%1workers", %1workers] call ClientSaveVar;', _queue];

  player groupchat "Factory worker hired!";

  if(count _fqueue > 0)then{call compile format['%1eta = %1eta - (%1eta/maxfacworkers);', (_fqueue select 0)];};

  doingSomething = false;
};