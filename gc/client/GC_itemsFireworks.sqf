private ["_spam","_ctime"];
//if (SunOrMoon != 0) exitWith {player groupchat "Wait until it's dark out to set off fireworks!";};
if (count(nearestObjects[player,["car", "air"],10]) != 0) exitWith {player groupChat "You are too close to a vehicle!";};
if (player != vehicle player) exitWith {player groupChat "You can't use this in a vehicle!";};
if (call GC_PlayerInCrimeFree) exitWith {player groupChat "You can't set off fireworks inside the No Crime Zone!";};
if (count(nearestObjects[player,["House"],15]) != 0) exitWith {player groupChat "You are too close to a building!";};
if (iscop and call GC_PlayerInCopBase) exitWith {player groupChat "You can't set off fireworks inside the Cop Base!";};
_spam = player getvariable "fireworks";
if (!isnil "_spam") exitWith {player groupChat "You can only set off one at a time!";};
player setvariable["fireworks",true,false];
["fireworks", (-1)] call INV_AddInventoreItem;
format ["%1 switchmove ""AinvPknlMstpSlayWrflDnon_medic"";", player] call broadcast;
sleep 3;
_ctime = round(time);
call compile format['
	fireworks_%1_%2 = "Land_CampingTable_small_F" createvehicle getpos %1;
	fireworks_%1_%2 setVehicleVarName "fireworks_%1_%2"; 
',player,_ctime];
call compile format['[[[fireworks_%1_%2,"fireworks_%1_%2"],"gc\global\GC_onVehicleCreated.sqf"],"BIS_fnc_execVM",true,false] call BIS_fnc_MP;',rolestring, _ctime];

call compile format['
	fireworks_%1_%2_b1 = "Bomb" createvehicle getpos %1;
	fireworks_%1_%2_b1 setVehicleVarName "fireworks_%1_%2_b1";
	fireworks_%1_%2_b2 = "Bomb" createvehicle getpos %1;
	fireworks_%1_%2_b2 setVehicleVarName "fireworks_%1_%2_b2";
	fireworks_%1_%2_b3 = "Bomb" createvehicle getpos %1;
	fireworks_%1_%2_b3 setVehicleVarName "fireworks_%1_%2_b3";
	fireworks_%1_%2_b4 = "Bomb" createvehicle getpos %1;
	fireworks_%1_%2_b4 setVehicleVarName "fireworks_%1_%2_b4";
	fireworks_%1_%2_b5 = "Bomb" createvehicle getpos %1;
	fireworks_%1_%2_b5 setVehicleVarName "fireworks_%1_%2_b5";
	fireworks_%1_%2_b1 attachto [fireworks_%1_%2,[0.1,0,0.41]];
	fireworks_%1_%2_b2 attachto [fireworks_%1_%2,[-0.1,0,0.41]];
	fireworks_%1_%2_b3 attachto [fireworks_%1_%2,[0,0,0.41]];
	fireworks_%1_%2_b4 attachto [fireworks_%1_%2,[0,0.1,0.41]];
	fireworks_%1_%2_b5 attachto [fireworks_%1_%2,[0,-0.1,0.41]];
	[fireworks_%1_%2_b1, -90, 0] call setPitchBank; //BIS_fnc_setPitchBank
	[fireworks_%1_%2_b2, -90, 0] call setPitchBank;
	[fireworks_%1_%2_b3, -90, 0] call setPitchBank;
	[fireworks_%1_%2_b4, -90, 0] call setPitchBank;
	[fireworks_%1_%2_b5, -90, 0] call setPitchBank;
	fireworks_%1_%2 setPos [(getPos %1 select 0) + (1 * sin (getdir %1)), (getPos %1 select 1) + (1 * cos (getdir %1)), (getPos %1 select 2)];
	fireworks_%1_%2 setdir (getdir %1);
',player,_ctime];
sleep 0.35;
call compile format['
	fireworks_%1_%2 enableSimulation false;
',player,_ctime];
waituntil {sleep 0.1; animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};
call compile format['SFXPvEh_%1 = ["fireworks_%2_%3","fireworklightsfx"];',rolenumber,rolestring,_ctime];
publicVariable format["SFXPvEh_%1", rolenumber];
call compile format['
	fireworks_%1_%2 say ["fireworklightsfx",100];
',player,_ctime];

player groupchat "You lit the fuze, better stand back!";
sleep 8.6;
popoffpos = [0,0,0];
{
	[_x,_ctime] spawn {
		_suffix = _this select 0;
		_ctime2 = _this select 1;
		_model = "";
		call compile format["_model = fireworks_%1_%2_%3;",rolestring,_ctime2,_suffix];		
		_posx = getPosATL _model select 0;
		_posy = getPosATL _model select 1;
		_posz = getPosATL _model select 2;
		call compile format['SFXPvEh_%1 = ["fireworks_%2_%3","fireworklaunchsfx"];',rolenumber,rolestring,_ctime2];
		publicVariable format["SFXPvEh_%1", rolenumber];
		call compile format['fireworks_%1_%2 say ["fireworklaunchsfx",100];',rolestring,_ctime2];		
		deletevehicle _model;
		_rocket = "M_Air_AT" createvehicle [_posx,_posy,_posz+0.8];
		[_rocket, 90, 0] call setPitchBank;
		_waitforme = _rocket spawn {
			_slow = 0;
			_random = random 20 - random 20;
			_random2 = random 5 - random 5;
			_random3 = random 5 - random 5;
			while{alive _this and _slow < 200} do {
				_this setVelocity[_random2,_random3,12];
				sleep 0.01;
				_slow = _slow + 1;
			};
			_pos = getpos _this;
			deletevehicle _this;
			_rocket = "M_NLAW_AT_F" createvehicle _pos;
			_rocket setpos _pos;
			[_rocket, 90, 0] call setPitchBank;

			while{alive _rocket} do {
				_rocket setVelocity[_random,_random,100];
				popoffpos = getpos _rocket;
				sleep 0.01;
			};
			waituntil{sleep 0.1; !alive _rocket};
		};
		waituntil {sleep 0.1; scriptDone _waitforme};
		_boom2="HelicopterExploBig" createVehicle popoffpos;
		sleep 0.5;
		for "_c" from -10 to 10 do {
			_sparkles = "CMflare_Chaff_Ammo" createvehicle popoffpos;
			_flare = objnull;
			if (_c %10 == 0) then {_flare = "F_40mm_Yellow" createvehicle (getpos _sparkles);};
			_waitforme = [_sparkles,_c, _flare] spawn {
				_sparkles = _this select 0;
				_c = _this select 1;
				_flare = _this select 2;
				_slow = 0;
				_pos = getposATL _sparkles;
				while{alive _sparkles} do {
					if (_slow > 15) then {
						_sparkles setVelocity[random 25,_c,-1];
						_flare setVelocity[random 25 * 1,_c,-1];
						_sparkles setdammage 1;
					} else {
						_sparkles setVelocity[random 25 * 2,_c,-25];
						_flare setVelocity[random 40 * 2,_c,-25];
					};
					sleep 0.01;
					_slow = _slow + 1;
					_pos = getposATL _sparkles;
				};
				_flare spawn {sleep 5; deletevehicle _this;};
				if (_c %3 == 0) then {_sparkles spawn{sleep random 4; "SmallSecondary" createvehicle (getpos _this);};};
			};
		};
		for "_c" from -30 to -11 do {
			_sparkles = "CMflare_Chaff_Ammo" createvehicle popoffpos;
			_flare = objnull;
			if (_c %10 == 0) then {_flare = "F_40mm_Red" createvehicle (getpos _sparkles);};
			_waitforme = [_sparkles,_c,_flare] spawn {
				_flare = _this select 2;
				_sparkles = _this select 0;
				_c = _this select 1;
				_slow = 0;
				while{alive _sparkles} do {
					if (_slow > 20) then {
						_sparkles setVelocity[random 25 * -1,_c,-1];
						_flare setVelocity[random 25 * -1,_c,-1];
						_sparkles setdammage 1;
					} else {
						_sparkles setVelocity[random 25 * -2,_c,-25];
						_flare setVelocity[random 40 * -2,_c,-25];
					};
					sleep 0.01;
					_slow = _slow + 1;
				};
				_flare spawn {sleep 5; deletevehicle _this;};
				if (_c %3 == 0) then {_sparkles spawn{sleep random 4; "SmallSecondary" createvehicle (getpos _this);};};
			};
		};
		for "_c" from 11 to 30 do {
			_sparkles = "CMflare_Chaff_Ammo" createvehicle popoffpos;
			_flare = objnull;
			if (_c %10 == 0) then {_flare = "F_40mm_Green" createvehicle (getpos _sparkles);};
			_waitforme = [_sparkles,_c,_flare] spawn {
				_flare = _this select 2;
				_sparkles = _this select 0;
				_c = _this select 1;
				_slow = 0;
				while{alive _sparkles} do {
					if (_slow > 25) then {
						_sparkles setVelocity[random 25 * -1,_c,-1];
						_flare setVelocity[random 25 * -1,_c,-1];
						_sparkles setdammage 1;

					} else {
						_sparkles setVelocity[random 25 * -2,_c,-25];
						_flare setVelocity[random 40 * -2,_c,-25];
					};
					sleep 0.01;
					_slow = _slow + 1;
				};
				_flare spawn {sleep 5; deletevehicle _this;};
				if (_c %3 == 0) then {_sparkles spawn{sleep random 4; "SmallSecondary" createvehicle (getpos _this);};};
			};
		};
	};
	sleep 2.1;
} foreach ["b1","b2","b3","b4","b5"];
sleep 1;
call compile format['
	deletevehicle fireworks_%1_%2;
',player,_ctime];

player setvariable["fireworks",nil,false];