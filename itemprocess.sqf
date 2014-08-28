if(iscop)exitwith{player groupchat "Only civilians can do this!"};

_this        = _this select 3;
_unprocItem  = _this select 0;
_procItem    = _this select 1;
_perProc     = _this select 2;
_license     = _this select 3;

if (!(_unprocItem call INV_getitemIsIllegal)) then {
  if(!(_license call INV_HasLicense))exitwith{player groupchat "You do not have the license to do this!"};
};

if (!doingSomething) then {
  doingSomething = true;

  _amountUnproc  = _unprocItem call INV_GetItemAmount;

  _amountProc = floor(_amountUnproc/_perProc);
  _amountUsed = _perProc*_amountProc;

  [_unprocItem, -(_amountUsed)] call INV_AddInventoreItem;
  [_procItem, _amountProc, "INV"] call INV_CreateItem;

  _name1   = _unprocItem call INV_getitemName;
  _name2   = _procItem call INV_getitemName;

  player groupchat format["%1 %2 was processed into %3 %4!", _amountUsed, _name1, _amountProc, _name2];

  doingSomething = false;
};