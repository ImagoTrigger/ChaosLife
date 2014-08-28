_art = _this select 0;

if (_art == "use") then {
  if (!(createDialog "RscMenuHandy")) exitWith {hint "Dialog Error!";};

  [2, true, false] call INV_DialogPlayers;
  lbSetCurSel [99, 0];
  ctrlSetText [4, format[localize "STRD_description_handy_cost", INV_smscost]];
  buttonSetAction [3, "[""send"", ctrlText 1, call compile lbData [2, lbCurSel 2]] execVM ""handy.sqf""; closedialog 0;"];
};

if (_art == "send") then {
  _valid_sms_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_ .!=$,";
  _smstext         = format["%1", [_this select 1, _valid_sms_chars] call BIS_fnc_filterString];
  _smsplayernumber = _this select 2;
  _smsplayer       = INV_PLAYERLIST select _smsplayernumber;
  _cash            = 'cash' call INV_getitemamount;

  if (_smstext == "") exitWith {player groupChat localize "STRS_inv_item_handy_leermsg";};
  if (not((format["%1", (_smsplayer)]) call ISSE_UnitExists)) exitWith {player groupChat localize "STRS_inv_item_handy_noplayer";};
  if (_cash < INV_smscost)  exitWith {player groupChat localize "STRS_inv_item_handy_keincash";};
  if ((_smstext call ISSE_str_Length) > 160) exitWith {player groupChat localize "STRS_inv_item_handy_text_zu_lang";};
  ['cash', -(INV_smscost)] call INV_AddInventoreItem;
  player groupChat format [localize "STRS_inv_item_handy_gesendet", name _smsplayer];

  format ['if (%2 == player) then {titletext [format [localize "STRS_inv_item_handy_nachricht", "%1", "%3"], "plain"];};', _smstext, _smsplayer, name player] call broadcast;
};