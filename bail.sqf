_bail = _this select 0;
if (!(_bail call ISSE_str_isInteger)) exitWith {player groupChat localize "STRS_inv_no_valid_number"};

_bail = _bail call ISSE_str_StrToInt;
if (_bail <= 0) exitWith {};

_copplayernumber = playersNumber west;

_copbail = round(_bail/_copplayernumber);

_cash    = 'cash' call INV_GetItemAmount;

if (_cash > _bail) exitwith {
  ['cash', -(_bail)] call INV_AddInventoreItem;
  _math = round(_bail/500);
  _sec = (player getVariable "releasetime");

  player setVariable["releasetime",(_sec - _math),false];
  player groupChat format [localize "STRS_bail_self", (_bail call ISSE_str_IntToStr)];
  format ["if (iscop) then {[""cash"", %2] call INV_AddInventoreItem; player groupChat format [localize ""STRS_bail_addbail"", %2, ""%3""];}; titletext [format[localize ""STRS_bail_payed"",%3, %1], ""plain""]; kopfcash_%4 = kopfcash_%4 - %1; if(kopfcash_%4 < 0)then{kopfcash_%4 = 0};", (_bail call ISSE_str_IntToStr), (_copbail call ISSE_str_IntToStr), rolenumber, player] call broadcast;
	BailPaid = BailPaid + _bail;
};


if (kontostand > _bail) exitWith  {
  kontostand = kontostand - _bail;
  _math = round(_bail/500);
  _sec = (player getVariable "releasetime");
  player setVariable["releasetime",(_sec - _math),false];
  player groupChat format [localize "STRS_bail_self", (_bail call ISSE_str_IntToStr)];
  format ["if (iscop) then {[""cash"", %2] call INV_AddInventoreItem; player groupChat format [localize ""STRS_bail_addbail"", %2, ""%3""];}; titletext [format[localize ""STRS_bail_payed"",%3, %1], ""plain""]; kopfcash_%4 = kopfcash_%4 - %1; if(kopfcash_%4 < 0)then{kopfcash_%4 = 0};", (_bail call ISSE_str_IntToStr), (_copbail call ISSE_str_IntToStr), rolenumber, player] call broadcast;
	BailPaid = BailPaid + _bail;
};

player groupChat localize "STRS_bail_cantpay";