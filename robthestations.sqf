private ["_storename","_stolen","_selection","_addskill"];
_selection = ((_this select 3) select 0);
_stolen = 0;

if (!(call INV_isArmed)) exitwith {player groupchat "You need a gun to rob the store!";};

if (!doingSomething) then {
  doingSomething = true;
  {
    if (_selection == _x) then {
      call compile format["_stolen = %1money;%1money = 0;publicvariable ""%1money"";", _x];
    };
  } forEach robbable;
  _storename = _selection call INV_getItemShopName;
  (format['["Robbed", %1, %2, "%3"] spawn Isse_AddCrimeLogEntry; if(!("Robbed a store" in %1_reason))then{%1_reason = %1_reason + ["Robbed a store"]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + wantedamountforrobbing;', player,_stolen,_storename]) call broadcast;
  (format ["server globalchat ""Someone robbed %1!"";", _storename]) call broadcast;

  _addskill = ((_stolen / 250) * 0.00015);
  ["SKILL_ROBBERY",_addskill] call GC_addSkill;
  _stolen = _stolen + round(100 * SKILL_ROBBERY); //add $100 per skill point
  ['cash', _stolen] call INV_AddInventoreItem;

  ["GC_Money",[_storename,format ["You stole $%1 from the store!", _stolen]]] spawn bis_fnc_showNotification;
  _stolen = 0;
  doingSomething = false;
};