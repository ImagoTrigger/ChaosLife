GC_RequstDeck = {
  [[player],"GC_FNC_SRV_GetDeck",false,false] spawn BIS_fnc_MP;
};

GC_RequstTable = {
  _currentTable = player getVariable "currentTable";
  if (isNil "_currentTable") then {
    [[player], "GC_FNC_SRV_GetTable", false, false] spawn BIS_fnc_MP;
    waitUntil {
      _currentTable = player getVariable "currentTable";
      !(isNil "_currentTable");
    };
  };

  _currentTable;
};

GC_FNC_SetTable = {
  _table = _this select 0;
  player setVariable["currentTable", _table];
};

GC_FNC_GetHand = {
  _table = player getVariable "currentTable";

  if (!isNil("_table")) then {
    [[_table, player], "GC_FNC_SRV_GetHand", false, false] spawn BIS_fnc_MP;
  } else {
    hint "Not currently playing.";
  };
};

GC_FNC_HitMe = {
  _table = player getVariable "currentTable";
  _currentHand = player getVariable "currentHand";

  if (!isNil("_table")) then {
    if (!isNil("_currentHand")) then {
      [[_table, player], "GC_FNC_SRV_HitPlayer", false, false] spawn BIS_fnc_MP;
    } else {
      hint "No Hand";
    };
  } else {
    hint "Not Currently Playing";
  };
};

GC_FNC_SetHand = {
  _hand = _this select 0;
  player setVariable ["currentHand", _hand];
};

GC_CurrentHand = {
  _currentHand = player getVariable "currentHand";
  if (isNil "_currentHand") then {
    call GC_FNC_GetHand;
    waitUntil {
      _currentHand = player getVariable "currentHand";
      !(isNil "_currentHand");
    };
  };

  _currentHand;
};