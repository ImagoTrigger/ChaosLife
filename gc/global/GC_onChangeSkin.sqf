_obj = _this select 0;
_objval = _this select 1;
_uniform = _this select 2;
_obj setVariable["terrorist", _objval, true];
_obj addUniform _uniform;
diag_log text format["MP fnc - changeskin: %1",_this];