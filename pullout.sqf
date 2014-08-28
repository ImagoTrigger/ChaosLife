_target  = (crew _this) select 0;
_n 		   = (floor random 5) + 5;
_exitvar = false;

if (locked _this != 0) then {
	player groupChat "The car is locked. This might take a while.";
	_n = (floor random 16) + 10;
};

player groupChat format ["You're pulling out %1. Stay close to the car!", _target];
format['if(player == %1)then{player groupChat "%2 is pulling you out of the car!"}', _target, player] call broadcast;

for [{_i=0}, {_i < _n}, {_i=_i+1}] do {
	if (player distance _target > 4) exitWith {
		player groupChat "You are too far away.";
		_exitvar = true;
	};
	sleep 0.3;
};

if(_exitvar)exitwith{};

_this lock 0;

player switchMove "AmovPercMstpSnonWnonDnon_AcrgPknlMstpSnonWnonDnon_getInLow";

sleep 0.4;

if (isPlayer _target) then {
	format['if(player == %2)then{keyblock=false;player action["eject", vehicle player];player setFatigue 1;}; server globalChat "%1 pulled %2 out of a car!";', player, _target] call broadcast;
} else {
	_playername = _target getvariable "pimp";
	if (!isnil "_playername") then {
		format['if((name player) == "%1")then{%4 lock 0; %2 action["eject", %4]; %2 action["getout", %4];}; server globalChat "%3 pulled %2 out of a car!";',_playername, _target, name player, _this] call broadcast;
	} else {
		format['server globalChat "%1 tried to pull %2 out of a car!";', player, _target] call broadcast;
	};
};