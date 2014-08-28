diag_log format["GC_onKilled: %1",_this];
private ["_i","_object","_item","_amount","_gangFlagUser","_suicide","_deadtime"];
_killed = player getvariable "killed";
if (!isnil "_killed") exitWith{};
player setvariable["killed",1,false];
player setVariable["uniform",uniform player];
closeDialog 0;
("BIS_layerStatic" call BIS_fnc_rscLayer) cutRsc ["RscStatic", "PLAIN"];
weaponsloaded = false;
impersonating = false;
INV_hunger = 25;
deadtimes  = deadtimes + 1;
["deadtimes", deadtimes] call ClientSaveVar;
if (isciv) then {
	for [{_i=0}, {_i < (count INV)}, {_i=_i+1}] do {
		_item   = ((INV select _i) select 0);
		_amount = (_item call INV_GetItemAmount);
		if (_amount > 0 and (_item call INV_getitemDropable)) then {
			_class = "Land_Suitcase_F";
			if (_item == "cash") then {
				_class = "Land_Money_F";
			};
			_pos = getposASL player;
			_posx = _pos select 0;
			_posy = _pos select 1;
			_posz = _pos select 2;
			_object = _class createvehicle _pos;
			{_object disableCollisionWith _x;} foreach playableUnits;
			_object setposASL [_posx, _posy, _posz];
			_object setvariable ["droparray", [_amount, _item], true];
			_object spawn {
				waituntil{sleep 0.1;(isTouchingGround _this or surfaceIsWater position _this)};
				_this enablesimulation false;
			};
		};
	};
	call INV_InventarLeeren;

	_playerPos = getPosASL player;
	_skull = createVehicle ["Land_HumanSkull_F", _playerPos, [], 0, "NONE"];
	{_skull disablecollisionwith _x;} foreach playableUnits;
	_skull setPosASL _playerPos;
	_skull setvariable ["nameskull",name player,true];
	_skull setvariable ["droparray",[1,"skull"],true];

	if(isdead == 0 and (_this select 0) == (_this select 1)) then {
		_suicide = true;
		[] spawn {
			diag_log text "calling victim from onKilled";
			[player, "suicide",""] call GC_Victim;
			["isdead", isdead] call ClientSaveVar;
		};
	};

	shoveldur=20;
	pickaxedur=50;
	hammerdur=100;
	alreadygotaworkplacejob=0;
	isterror=false;
	takingFlag = false;
	{
		_gangFlagUser = _x getVariable "mover";
		if (player == _gangFlagUser) then {
			_x setVariable["mover", nil, true];
		};
	} forEach gangAreas;

	if (gangleader) then {group player selectLeader player};

	DeadWaitSec = DeadWaitSec + respawntimeinc;
	if (DeadWaitSec > DeadTimeMax) then {DeadWaitSec = DeadTimeMax};
	["DeadWaitSec", DeadWaitSec] call ClientSaveVar;
	titleText [format[localize "STRS_deadcam_deadwait_civ", deadtimes, round(DeadWaitSec), CivsKilled+CopsKilled, extradeadtime, SelfKilled], "plain"];
	if (_suicide) then {
		_suicide = false;
		_deadtime = DeadWaitSec + extradeadtime;
		_deadtime = _deadtime + suicidepenalty;
		_deadtime = _deadtime + 15;
		setPlayerRespawnTime _deadtime;
		[] spawn {
			sleep 10;
			titletext[format["Because you suicided this round your spawn time has increased by %1 seconds.", suicidepenalty], "plain"]
		};
	} else {
		_deadtime = DeadWaitSec + extradeadtime;
		_deadtime = _deadtime + 15;
		setPlayerRespawnTime _deadtime;
	};
};

if (iscop) then {
	_myname = player getVariable "deadname";
	if (_myname in copraidarray) then {
		copraidarray = copraidarray - [_myname];
		format['
			if (iscop and "%1" in copraidarray) then {
				copraidarray = copraidarray - ["%1"];
			};
		',_myname] call broadcast;

		if (count copraidarray < 2) then {
			_last_checkpoint = player getvariable "last_checkpoint";
			raidarray = raidarray - [_last_checkpoint];
			format['
				if (iscop or isServer) then {raidarray = raidarray - ["%1"];};
			',_last_checkpoint] call broadcast;
		};
	};
	_amount = ("cash" call INV_GetItemAmount);
	if (_amount > 0) then {
		_pos = getposASL player;
		_posx = _pos select 0;
		_posy = _pos select 1;
		_posz = _pos select 2;
		_object = "Land_Money_F" createvehicle _pos;
		_object setposASL [_posx, _posy, _posz];
		_object setvariable ["droparray", [_amount, "cash"], true];
		_object spawn {
			waituntil{sleep 0.1;isTouchingGround _this};
			_this enablesimulation false;
		};
		["cash", -(_amount)] call INV_AddInventoreItem;
	};

	_playerPos = getPosASL player;
	_skull = createVehicle ["Land_HumanSkull_F", _playerPos, [], 0, "NONE"];
	{_skull disablecollisionwith _x;} foreach playableUnits;
	_skull setPosASL _playerPos;
	_skull setvariable ["droparray", [1, "skull"], true];

	if (DeadWaitSec > DeadTimeMax) then {DeadWaitSec = DeadTimeMax};
	["DeadWaitSec", DeadWaitSec] call ClientSaveVar;
	titleText [format[localize "STRS_deadcam_deadwait_cop", round(DeadWaitSec+extradeadtime)], "plain"];
	_deadtime = DeadWaitSec + extradeadtime;
	_deadtime = _deadtime + 15;
	setPlayerRespawnTime _deadtime;
};
deadcam     = 1;
extradeadtime = 0;
["extradeadtime", extradeadtime] call ClientSaveVar;