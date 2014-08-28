ISSE_pub_varCount = playercount;
ISSE_pub_varNum   = rolenumber;
ISSE_pub_varName  = format["ISSE_pub_Pstr_%1", ISSE_pub_varNum];

for [{_i=0}, {_i <= (ISSE_pub_varCount)}, {_i=_i+1}] do {
  _varName = format["ISSE_pub_Pstr_%1", _i];
  call compile format['%1 = " ";', _varName];
  _varName addPublicVariableEventHandler {call compile (_this select 1);};
};

broadcast = {
  if ((TypeName _this) == "STRING") then {
    call compile format['%1 = ''%2'';', ISSE_pub_varName, _this];
    publicVariable ISSE_pub_varName;
    call compile _this;
  } else {
    hint "Public Error: expecting String.";
  };
};

broadcast_cli = {
  if (!isServer) then {exit;};
  _string = _this select 0;
  _owner = _this select 1;
  if ((TypeName _string) == "STRING") then {
    call compile format['%1 = ''%2'';', ISSE_pub_varName, _string];
    _owner publicVariableClient ISSE_pub_varName;
  } else  {
    diag_log text "Public Error: expecting String.";
  };
};

broadcast_srv = {
  if (isServer) then {exit;};
  if ((TypeName _this) == "STRING") then {
    call compile format['%1 = ''%2'';', ISSE_pub_varName, _this];
    publicVariableServer ISSE_pub_varName;
  } else {
    hint "Public Error: expecting String.";
  };
};

ISSE_pub_execStr = {
  if ((TypeName _this) == "STRING") then {call compile _this;} else {hint "Public Error: expecting String.";};
};
