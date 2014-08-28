ClientSaveVar = {
  private ["_Fvarname", "_Fvarvalue"];
  _Fvarname  = _this select 0;
  _Fvarvalue = _this select 1;

  if (! (isNull player)) then {
  	format ["[%1, ""%2"", %3] call ServerSaveVar;", player, _Fvarname, _Fvarvalue] call broadcast_srv;
	} else {
    hint "Error: player is Null.";
  };
  true
};

ClientLoadVar = {
  private ["_c", "_Fvararray"];
  _Fvararray = _this;

  for [{_c=0}, {_c < (count _Fvararray)}, {_c=_c+1}] do {
    call compile format ['%1 = %2;', ((_Fvararray select _c) select 0), ((_Fvararray select _c) select 1)];
    // diag_log text format["Setting %1 = %2",((_Fvararray select _c) select 0), ((_Fvararray select _c) select 1)];
	};

  JIP_Stats_Ready = true;
  true
};