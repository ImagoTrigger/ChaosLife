private ["_veh"];
_veh = vehicle player;
OutOFBoundsTicks = OutOFBoundsTicks + 1;
if (OutOFBoundsTicks > 1) then {
	titleText [localize "STRS_southChernarus_area", "plain"];
	playSound "warnsfx";
};
if (OutOFBoundsTicks > 10) then {
	OutOFBoundsTicks = 0;
	if (_veh != player) then {
		_veh setvelocity [0,0,0];
		if (!(_veh isKindOf "bicycle")) then {[_veh,45,false] execVM "ammo_burn.sqf";};
		_veh setdammage 1;
		_veh lock 0;
		player Action ["eject", _veh];
		player Action ["getout", _veh];
		player setdammage 1;
	} else {
		player setdammage 1;
	};
};