setPitchBank = {
	private ["_obj","_pitch","_bank","_yaw","_vdir","_vup","_s ign","_rotate"];

	_obj = _this select 0;
	_pitch = _this select 1;
	_bank = _this select 2;

	_yaw = 360-(getdir _obj);

	//----------------------------
	//function to rotate a 2d vector around the origin
	//----------------------------

	_rotate =
	{
		private ["_v","_d","_x","_y"];
		_v = +(_this select 0); //we don't want to modify the originally passed vector
		_d = _this select 1;
		_x = _v select 0;
		_y = _v select 1;
		_v set [0, (cos _d)*_x - (sin _d)*_y];
		_v set [1, (sin _d)*_x + (cos _d)*_y];
		_v
	};

	//----------------------------
	//find vector dir (pitch)
	//----------------------------

	_sign = [1,-1] select (_pitch < 0);

	while {abs _pitch > 180} do {_pitch = _sign*(abs _pitch - 180)};

	if(abs _pitch == 90) then {_pitch = _sign*(89.9)};

	if(abs _pitch > 90) then {
		_obj setdir (getdir _obj)-180;
		_yaw = 360-(getdir _obj);
		_bank = _bank + 180;
		_pitch = (180 - abs _pitch)*_sign;
	};

	_vdir = [0, cos _pitch, sin _pitch];

	_vdir = [_vdir, _yaw] call _rotate;

	//----------------------------
	//find vector up (bank)
	//----------------------------

	_sign = [1,-1] select (_bank < 0);

	while {abs _bank > 360} do {_bank = _sign*(abs _bank - 360)};

	if(abs _bank > 180) then {_sign = -1*_sign; _bank = (360-_bank)*_sign};

	_vup = [sin _bank, 0, cos _bank];
	_vup = [_vup select 0] + ([[_vup select 1, _vup select 2], _pitch] call _rotate);
	_vup = [_vup, _yaw] call _rotate;

	//----------------------------
	//apply the vectors
	//----------------------------

	_obj setVectorDirAndUp [_vdir, _vup];
};

//goddamn bullshit

bash =

{

_damage = damage player;

[player, 10, 0] call setPitchBank;
sleep 0.01;
[player, -5, 0] call setPitchBank;

"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [10];
"dynamicBlur" ppEffectCommit 0;
waitUntil {ppEffectCommitted "dynamicBlur"};
"dynamicBlur" ppEffectEnable true;
"dynamicBlur" ppEffectAdjust [0];
"dynamicBlur" ppEffectCommit (0.4 + _damage);
waitUntil {ppEffectCommitted "dynamicBlur"};

};

isprone =

{

if(
animationstate player == "amovppnemrunsnonwnondf" or
animationstate player == "amovppnemstpsnonwnondnon" or
animationstate player == "amovppnemstpsraswrfldnon" or
animationstate player == "amovppnemsprslowwrfldf"
) then {true}else{false};

};

targethit =

{

private "_c";
_tg = _this select 0;
_t  = _this select 1;

waituntil {_tg animationphase "terc" == 0};

for [{_c=0}, {_c < _t}, {_c=_c+0.5}] do

	{

	if(_tg animationphase "terc" > 0)exitwith{_c=10; hits = hits + 1};
	sleep 0.5;

	};

if(_tg animationphase "terc" > 0 and _c < 10)exitwith{popped = popped + 1; hits = hits + 1};
_tg animate["terc",1];
popped = popped + 1;

};

TeleToMainbaseFunc = {
if (not((vehicle player) == player)) then
 {
 	_veh = vehicle player;
	_veh setvelocity [0,0,0];
	_veh lock 0;
	{
		_x Action ["eject", _veh];
		_x Action ["getout", _veh];
	} forEach (crew _veh);
	[_veh, "impound"] execVM "impound.sqf";
};

   if (iscop) then {
    player setpos (getmarkerpos "respawn_west");
 } else {
   player setpos (getmarkerpos "civarea");
 };

 player groupChat localize "STRS_verbotene_zone_teleport";
};


TurnWantedFunc =

{

if (_this) then

	{

    	format["civ%1_wanted = 1;", rolenumber] call broadcast;

	} else {format["civ%1_wanted = 0;", rolenumber] call broadcast;};

};

DialogSpielerListe = {
private ["_Fart", "_Fid", "_Fname", "_Fingame", "_Findex", "_Flistlen", "_Feigenenum"];
    _Fart = _this select 0;
   _Fid = _this select 1;
_Fname = _this select 2;
_Fingame = _this select 3;
   _Findex = 0;
_Flistlen = 0;
   _Feigenenum = -1;
  for [{
_c=0}, {
_c < (count playerstringarray)}, {
_c=_c+1}] do {
   _Fspieler = playerstringarray select _c;
   if ( ((_Fart == 0) or ((_Fart == 1) and (_c > civscount)) or ((_Fart == 2) and (_c < civscount))) and ((_Fingame) or (_Fspieler call ISSE_UnitExists)) ) then
 {
    if (_Fname) then
 {
    _Findex = lbAdd [_Fid, format ["%1 - (%2)", _Fspieler, name (call compile _Fspieler)]];
   } else {
    _Findex = lbAdd [_Fid, _Fspieler];
};

   lbSetData [_Fid, _Findex, format["%1", _c]];
    if (_Fspieler == rolestring) then
 {
_Feigenenum = _Flistlen;
};

  _Flistlen = _Flistlen + 1;
};

  };

[_Flistlen, _Feigenenum]};

Isse_AddCrimeLogEntry = {
	if (isServer) exitwith {};
	private ["_logtime", "_logdate", "_logtext", "_logart", "_logplayer", "_zusatzinfo"];
	_logart = _this select 0;
   	_logplayer = format["%1", _this select 1];
   	_criminal = (_this select 1) getvariable "deadname";
   	if (isnil "_criminal") then {
   		_criminal = name (_this select 1);
   	};
  	_zusatzinfo = "";
  	_handled = false;
 	if (count _this > 2) then {_zusatzinfo = _this select 2};
 	_logdate = date;
    	_logtext = "";
	if ((_this select 1) == vehicle player) then {
	    	_info2 = ""; _info = _zusatzinfo; _uid = "";
	    	if (_logart == "PrisonIn" or _logart == "Stole" or _logart == "Wanted" or _logart == "Unwanted" or _logart == "TerroristArrested" or _logart == "Disarm" or _logart == "Heal") then {
	    		_info = _zusatzinfo getvariable "deadname";
	    		if (isnil "_info") then {
	    			_info = name _zusatzinfo;
	    		};
	    		_uid = getPlayerUID _zusatzinfo;
	    		_info2 = _this select 3;
	    	};
	    	if (_logart == "Ticket") then {
	    		_info2 = (_this select 3) getvariable "deadname";
	    		if (isnil "_info2") then {
	    			_info2 = name (_this select 3);
	    		};	    		
	    		_uid = getPlayerUID (_this select 3);
	    	};
	    	if (_logart == "Died") then {
	    		if (typename _zusatzinfo != "STRING") then {
				_info = _zusatzinfo getvariable "deadname";
				if (isnil "_info") then {
					_info = name _zusatzinfo;
				};	    			
				_uid = getPlayerUID _zusatzinfo;
	    		};
	    		_info2 = _this select 3;
	    	};     	
	    	if (_logart == "Robbed") then {
	    		_info2 = _this select 3;
	    	};  
	    	
	     	if (_logart != "KilledCiv" and _logart != "KilledCop" and _logart != "Died") then {
	    		format['GC_Crimes = ["%1","%2","%3","%4","%5"];',_criminal,_logart,_info,_info2,_uid] call broadcast_srv;
	    	};
	};
    	if (isciv) exitwith {};
	switch (_logart) do {
		case "Bank": {
			_logtext = format[localize "STRS_functions_crimelog_msg1", _zusatzinfo];
			_handled = true;
		};
	   	case "Stole": {
			_logtext = format[localize "STRS_functions_crimelog_msg2"];
			_handled = true;
		};
	  	case "KilledCiv": {
			_logtext = format[localize "STRS_functions_crimelog_msg3", _zusatzinfo];
			_handled = true;
		};
	   	case "KilledCop": {
			_logtext = format[localize "STRS_functions_crimelog_msg4", _zusatzinfo];
			_handled = true;
		};
		case "PrisonIn": {
			_logtext = format[localize "STRS_functions_crimelog_msg5"];
			_handled = true;
		};
		case "PrisonOut": {
			_logtext = format[localize "STRS_functions_crimelog_msg6"];
			_handled = true;
		};
		case "PrisonEsc": {
			_logtext = format[localize "STRS_functions_crimelog_msg7"];
			_handled = true;
		};
		case "Died": {
			_logtext = format[localize "STRS_functions_crimelog_msg8"];
			_handled = true;
		};

		case "Ticket": {
			_logtext = format[localize "STRS_functions_crimelog_msg9", _zusatzinfo];
			_handled = true;
		};
		 case "Bomb": {
			_logtext = format[localize "STRS_functions_crimelog_msg10"];
			_handled = true;
		};
		case "Prostitute": {
			_logtext = format[localize "STRS_functions_crimelog_msg11"];
			_handled = true;
		};
		 case "Speed": {
			_logtext = format[localize "STRS_functions_crimelog_msg12"];
			_handled = true;
		};
		case "StoleVcl": {
			_logtext = format[localize "STRS_functions_crimelog_msg13", _zusatzinfo];
			_handled = true;
		};
		case "AttemptedStoleVcl": {
			_logtext = format[localize "STRS_functions_crimelog_msg14", _zusatzinfo];
			_handled = true;
		};
		case "AssassinAttempt": {
			_logtext = format[localize "STRS_functions_crimelog_msg15"];
			_handled = true;
		};
		case "HostageAttempt": {
			_logtext = "Is a hostage taker";
			_handled = true;
		};
		case "Terror": {
			_logtext = "Is a Terrorist";
			_handled = true;
		};
		case "Impersonating": {
			_logtext = "Is impersonating Police";
			_handled = true;
		};	
		case "Poaching": {
			_logtext = "Is a poacher";
			_handled = true;
		};		
	};
	if (_handled) then {
		if (_logart == "Bank") then {_criminal = "UNKNOWN";};
		CopLog = [ [_criminal, _logtext, _logdate] ] + CopLog;
	};
};


GetRandomObjectName = {
 private ["_name"];
   if (isNil("GespawnteObjekteCounter")) then
 {
GespawnteObjekteCounter = 0;
};

_name = format["SpawnedObject_%1_%2_%3", round(time), rolenumber, GespawnteObjekteCounter];
GespawnteObjekteCounter = GespawnteObjekteCounter + 1;
_name};

//stupid fuckign shit

SayDirectSpeach = {
 private ["_text", "_dis"];
   _text = _this select 0;
    _art = _this select 1;
    if (not ((_text == "") or (_text == " ")) ) then
 {
    _text = format["%1 shouts: %2", player, _text];
  if (_art == "direct") then
 {
_dis = 50;
    format ["if ((player distance %1) < %3) then {titleText[""%2"", ""PLAIN""];};", player, _text, _dis] call broadcast;
 };

   if (_art == "side") then
 {
   format ["%1 sideChat ""%2"";", player, _text] call broadcast;
};

if (_art == "global") then
 {
 format ["%1 globalChat ""%2"";", player, _text] call broadcast;
  };

};

};

