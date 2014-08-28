//raise or lower the gates
_this = _this select 3; //strip extra action data
_gate = _this select 0;
_action = _this select 1;
_pos = 0;

if (_action == "lower") then {
  _pos = -5;
};

if (_action == "raise") then {
  _pos = 0;
};

{
  call compile format["
    cgate%1%2 setPos [(getPos cgate%1%2 select 0),(getPos cgate%1%2 select 1),%3];
  ", _gate, _x, _pos];
} forEach [1, 2, 3, 4, 5, 6];