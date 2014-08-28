//ImagoTrigger <imagotrigger@gmail.com> for Chaos Life
private ["_ga","_mover"];
_ga = _this select 3;
_mover = _ga getVariable "mover";
if (!isnil "_mover") then {
	if (_mover == player) then {
		_ga setVariable["mover", nil, true];
	};
};
takingFlag = false; 
player removeAction flagCancel;