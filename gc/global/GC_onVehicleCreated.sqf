//DOA <imagotrigger@gmail.com> for Arma3 Chaos Life
private ["_code","_code2","_timeout","_obj","_objstr"];
_timeout = 0;
_obj = _this select 0;
_objstr = _this select 1;
_code = nil;
_code2 = nil;
if (count _this > 2) then {
	_code = _this select 2;
};
if (count _this > 3) then {
	_code2 = _this select 3;
};
diag_log text format["MP fnc - vehicle created: %1",_this];
_obj setVehicleVarName _objstr;
PublicVariable _objstr;
while {isnil "_obj"} do {
	_timeout = _timeout + 1;
	if (_timeout > 100) exitwith{diag_log text "GC FAIL";};
	sleep 0.15;
};
while {(vehicleVarName _obj) != _objstr} do {
	_timeout = _timeout + 1;
	if (_timeout > 50) exitwith{diag_log text "GC FAIL 2";};
	sleep 0.15;
};
_obj setVehicleVarName _objstr;
[_obj,0] execVM "scripts\mountOnVcl\mount_vcl_init.sqf";
clearWeaponCargo _obj;
clearMagazineCargo _obj;
clearItemCargo _obj;
clearBackpackCargo _obj;
if (!isServer) then {
	if (!isnil "_code") then {
		if (_code != "") then {
			sleep 2;
			diag_log text format["MP fnc - vehicle code running: %1",_code];
			call compile _code;
		};
	};
	if (!isnil "_code2") then {
		if (_code2 != "") then {
			diag_log text format["MP fnc - vehicle code running: %1",_code2];
			call compile _code2;
		};
	};
};