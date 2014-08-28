GC_FNC_NormalizeGangFlagHeight = {
  private['__height', '__change', '_ret'];
  __height = _this select 0;
  __change = _this select 1;

  _ret = __height + __change;

  if ((__height + __change) <= -7.00) then {
    _ret = -7.00;
  };

  if ((__height + __change) >= 0.00) then {
    _ret = 0.00;
  };

  _ret;
};