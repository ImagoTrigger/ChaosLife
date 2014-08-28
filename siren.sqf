_this 				= _this select 3;
_option  			= _this select 0;
_vcl  				= vehicle player;
_playtime     = 120;
_lichtstaerke = 0.3;
_shortDur     = 0.72;
_longDur      = 4.87;

if (_option == "activate") then {
	_code  = _this select 1;

	if (isNil "SIREN_SirenePlaying") then {
		SIREN_SirenePlaying = false;
	};

	if ((SIREN_SirenePlaying) or (!(player == (driver (vehicle player))))) exitWith {};

	SIREN_SirenePlaying = true;
	_turnOn             = false;

	if (call compile format["isNil(""%1_Sirene_on"");", rolestring]) then {
		_turnOn = true;
	} else {
		if (call compile format["not(%1_Sirene_on);", rolestring]) then {
			_turnOn = true;
		} else {
			_turnOn = false;
		};
	};

	_timechk = player getvariable "nextsirenontime";
	if (isNil "_timechk") then {
		_timechk = time;
	};

	if (_turnOn) then {
		if (time >= _timechk) then {
			player setVariable["nextsirenontime",(time + 5),true];
			format ["if (!isServer) then{[0,0,0,[""client"", ""%1"", %2]] execVM ""siren.sqf"";}", rolestring,_code] call broadcast;
			titletext["Lights/Siren on", "PLAIN DOWN"];
			siren_is_on = true;
		};
	} else {
		call compile format["%1_Sirene_on = false; publicVariable ""%1_Sirene_on"";", rolestring];
		titletext["Lights/Siren off", "PLAIN DOWN"];
		siren_is_on = false;
	};

	sleep 1;

	SIREN_SirenePlaying = false;
};

if (_option == "client") then {
	_obj 				= call compile (_this select 1);
	_vcl        = vehicle _obj;
	_driver     = driver _vcl;
	_starttime  = time;
	_code       = _this select 2;

	_vclstr = format["%1",(_this select 1)];
	call compile format["%1_Sirene_on = true;", _vclstr];

	_light1 = "#lightpoint" createVehicleLocal (getpos _vcl);
	_light1 setLightBrightness _lichtstaerke;
	_light1 setLightAmbient   [0, 0, 0.3];
	_light1 setLightColor     [0, 0, 0.5];
	_light1 setLightDayLight true;

	_light2 = "#lightpoint" createVehicleLocal (getpos _vcl);
	_light2 setLightBrightness _lichtstaerke;
	_light2 setLightAmbient   [0.3, 0, 0];
	_light2 setLightColor     [0.5, 0, 0];
	_light2 setLightDayLight true;
	_lichtscript = [0,1,2,["licht", _vcl, [_light1, _light2]]] execVM "siren.sqf";

	while {( ((time < _starttime+_playtime) or (_driver == driver _vcl)) and (alive _vcl) and (call compile format["%1_Sirene_on", _vclstr]))} do {
		if (alive player and player distance _vcl < 500 and deadcam == 0 and isdead == 0) then {
			if (speed _vcl == 0 or _code == 1) then {
				sleep 1;
			} else {
				if (speed _vcl > 60) then {
					_vcl say ["Siren_Long", 1];
					sleep _longDur;
				} else {
					_vcl say ["Siren_Short", 1];
					sleep _shortDur;
				};
			};
		} else {
			sleep 5;
		};
		if (isNull(_vcl)) exitWith {};
	};

	terminate _lichtscript;
	deleteVehicle _light1;
	deleteVehicle _light2;
	call compile format["%1_Sirene_on = false;", _vclstr];
	siren_is_on = false;
};

if (_option == "licht") then {
	_vcl    = _this select 1;
	_light1 = ((_this select 2) select 0);
	_light2 = ((_this select 2) select 1);

	while {true} do {
		if (player in _vcl) then {
			_light1 setLightBrightness (_lichtstaerke / 2);
			_light2 setLightBrightness (_lichtstaerke / 2);
		} else {
			_light1 setLightBrightness _lichtstaerke;
			_light2 setLightBrightness _lichtstaerke;
		};

		_light1 lightAttachObject [_vcl, [0,0,0]];

		sleep 0.15;

		LightDetachObject _light1;
		_light1 setpos [0,0,0];

		sleep 0.075;

		_light2 lightAttachObject [_vcl, [0,0,0]];

		sleep 0.15;

		LightDetachObject _light2;
		_light2 setpos [0,0,0];

		sleep 0.075;

		_light1 lightAttachObject [_vcl, [0,0,0]];

		sleep 0.15;

		LightDetachObject _light1;
		_light1 setpos [0,0,0];

		sleep 0.5;

		_light2 lightAttachObject [_vcl, [0,0,0]];

		sleep 0.15;

		LightDetachObject _light2;
		_light2 setpos [0,0,0];

		sleep 0.5;
	};
};