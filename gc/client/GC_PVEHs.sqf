private ["_i"];
"FFWarnPvEh" addPublicVariableEventHandler {
	_warnarray  = _this select 1;
	_warntarget = (_warnarray select 0);
	_warning    = (_warnarray select 1);

	if (name player != _warntarget && _warntarget != "__EVERYONE__") exitWith {};

	[_warning] spawn {
        private ["_warning"];
        _warning = _this select 0;
		titleText [_warning,"BLACK IN",15];
		player globalChat format ["ADMIN WARNING: %1",_warning];
		hint format ["%1: %2",name player,_warning];
		sleep 0.60;
		player sideChat format ["ADMIN WARNING: %1",_warning];
		hint format ["%1: %2",name player,_warning];
		sleep 0.60;
		player commandChat format ["ADMIN WARNING: %1",_warning];
		hint format ["%1: %2",name player,_warning];
		removeAllWeapons player;
	};
};

for [{_i=0}, {_i <= (playercount)}, {_i=_i+1}] do {
	call compile format["SFXspam_%1 = time;",text (playerstringarray select _i)];
	format["SFXPvEh_%1", _i] addPublicVariableEventHandler {
		_sfxarray = _this select 1;
		_sfxtarget = (_sfxarray select 0);
		_sfx    = (_sfxarray select 1);
		_pause = (_sfxarray select 2);
		if (isNil "_pause") then {_pause = 0;};
		_source = call compile format["%1",_sfxtarget];
		_delay = 0;
		if (isPlayer _source) then {
			_spamtime = call compile format["SFXspam_%1",_sfxtarget];
			_delay = (_spamtime + _pause);
		};
		if (player distance _source < 500 and time >= _delay) then {
			if (_source != vehicle _source) then {
				_source = vehicle _source;
			};		
			if (isPlayer _source) then {
				call compile format["SFXspam_%1 = time;", _sfxtarget];				
			};		
            		[_source,_sfx] spawn {
				(_this select 0) say3D (_this select 1);
			};
		};
	};
};