GC_Crows = {
	private ["_flockPos","_flockArea","_flockCount","_wp0","_wp1","_wp2","_wp3","_crowList","_crow","_flockHeight"];
	_flockPos = _this select 0;
	_flockArea = if (count _this > 1) then {_this select 1} else {50};
	_flockCount = if (count _this > 2) then {_this select 2} else {_flockArea / 5};
	_flockHeight = if (count _this > 3) then {_this select 3} else {30 + random 10};

	if (typename _flockPos == typename objnull) then {_flockPos = position _flockPos};
	if (typename _flockPos == typename "") then {_flockPos = markerpos _flockPos};

	_flockPos set [2,_flockHeight];
	_wp0 = [_flockPos, _flockArea, 00] call GC_relPos;
	_wp1 = [_flockPos, _flockArea, 090] call GC_relPos;
	_wp2 = [_flockPos, _flockArea, 180] call GC_relPos;
	_wp3 = [_flockPos, _flockArea, 270] call GC_relPos;
	_crowList = [];
	for "_i" from 1 to _flockCount do {
		_crow = "Kestrel_Random_F" camcreate [
			(_flockPos select 0) - _flockArea + (random _flockArea)*2,
			(_flockPos select 1) - _flockArea + (random _flockArea)*2,
			_flockHeight
		];
		[_crow,_wp0,_wp1,_wp2,_wp3,_flockArea] execfsm "gc\global\GC_flock.fsm";
		_crowList = _crowList + [_crow];
	};

	_crowList;
};


GC_Sandstorm = {
	private ["_obj","_density","_colorCoef","_newspapers","_pos","_velocity","_relPos","_color","_alpha","_ps","_newsParams","_newsRandom","_newsCircle","_newsInterval","_times","_herald","_tribune","_result","_duration"];

	_obj = _this select 0;
	_density = if (count _this > 1) then {_this select 1} else {0.07}; if (_density < 0) then {_density = 0.07};
	_colorCoef = if (count _this > 2) then {_this select 2} else {1}; if (_colorCoef < 0) then {_density = 1};
	_newspapers = if (count _this > 3) then {_this select 3} else {true};
	_pos = position _obj;

	//--- Dust
	_duration = 2;
	_velocity = [0,7,0];
	_relPos = [-((_velocity select 1) * (_duration / 2)), 0, -6];
	_color = [1.0 * _colorCoef, 0.9 * _colorCoef, 0.8 * _colorCoef];
	_alpha = 0.2;
	_ps = "#particlesource" createVehicleLocal _pos;  
	_ps setParticleParams [["\A3\Data_F\ParticleEffects\Universal\universal.p3d", 16, 12, 8, 0], "", "Billboard", 1, _duration, _relPos, _velocity, 1, 1.275, 1, 0, [5], [_color + [0], _color + [_alpha], _color + [0]], [1000], 1, 0, "", "", _obj];
	_ps setParticleRandom [3, [10, 10, 0], [0, 0, 0], 1, 0, [0, 0, 0, 0.05], 0, 0];
	_ps setParticleCircle [0.1, [0, 0, 0]];
	_ps setDropInterval _density;

	//--- Newspapers
	_result = if (_newspapers) then {
		_newsParams = [["\ca\Missions_PMC\gnews1.p3d", 1, 0, 1], "", "SpaceObject", 1, 5, [0, 0, 1], _velocity, 1, 1.25, 1, 0.2, [0,1,1,1,0], [[1,1,1,1]], [0.7], 1, 0, "", "", _obj];
		_newsRandom = [0, [30, 30, 0], [5, 5, 0], 2, 0.3, [0, 0, 0, 0], 10, 0];
		_newsCircle = [0.1, [1, 1, 0]];
		_newsInterval = 1;

		_times = "#particlesource" createVehicleLocal _pos;  
		_times setParticleParams _newsParams;
		_times setParticleRandom _newsRandom;
		_times setParticleCircle _newsCircle;
		_times setDropInterval _newsInterval;

		_newsParams set [0,["\ca\Missions_PMC\gnews2.p3d", 1, 0, 1]];
		_herald = "#particlesource" createVehicleLocal _pos;  
		_herald setParticleParams _newsParams;
		_herald setParticleRandom _newsRandom;
		_herald setParticleCircle _newsCircle;
		_herald setDropInterval _newsInterval;

		_newsParams set [0,["\ca\Missions_PMC\gnews3.p3d", 1, 0, 1]];
		_tribune = "#particlesource" createVehicleLocal _pos;  
		_tribune setParticleParams _newsParams;
		_tribune setParticleRandom _newsRandom;
		_tribune setParticleCircle _newsCircle;
		_tribune setDropInterval _newsInterval;

		[_ps,_times,_herald,_tribune]
	} else {
		[_ps]
	};

	_result

};

GC_infoText = {
    	private ["_textArrayUnicode","_textArrayTemp","_line","_emptyArray","_nArrayTemp","_n","_textArray","_element","_nArray","_text","_textArrayLines","_finalArray","_display","_textControl"];
    	("BIS_layerInfoText" call bis_fnc_rscLayer) cutrsc ["rscInfoText","plain"];

	//--- Separate lines
	_text = _this;
	_textArrayUnicode = [];
	{_textArrayUnicode = _textArrayUnicode + [toarray _x]} foreach _text;


	//--- Separate letters
	_textArrayLines = [];
	for "_i" from 0 to (count _textArrayUnicode - 1) do {
		_line = _textArrayUnicode select _i;
		_textArrayTemp = [];
		{_textArrayTemp = _textArrayTemp + [tostring [_x]]} foreach _line;
		_textArrayLines set [_i,_textArrayTemp];
	};


	//--- Merge arrays
	_textArray = [];
	_emptyArray = [];
	_nArrayTemp = [];
	_n = 0;
	{
		_line = _x;
		_textArray = _textArray + _line + ["\n"];
		{
			//_emptyArray = _emptyArray + [_line call bis_fnc_selectrandom]; //--- Shuffled text
			//_emptyArray = _emptyArray + [str floor random 2]; //--- Binary Solo
			//_emptyArray = _emptyArray + [""]; //--- Rolling text
			_emptyArray = _emptyArray + [" "]; //--- Space
			_nArrayTemp = _nArrayTemp + [_n];
			_n = _n + 1;
		} foreach _x;
		_n = _n + 1;
		_emptyArray = _emptyArray + ["\n"];
	} foreach _textArrayLines;
	_finalArray = _emptyArray;
	_text = composetext _finalArray;


	//--- Random order
	_nArray = [];
	while {count _nArrayTemp > 0} do {
		_element = _nArrayTemp select (floor random (count _nArrayTemp));
		_nArray = _nArray + [_element];
		_nArrayTemp = _nArrayTemp - [_element];
	};


	//--- Visualization
	disableserialization;
	_display = uinamespace getvariable "BIS_InfoText";
	_textControl = _display displayctrl 3101;


	_text = composetext _finalArray;
	_textControl ctrlsettext str _text;
	_textControl ctrlcommit 0.01;
	sleep 1;

	{
		_finalArray set [_x,_textArray select _x];
		_text = composetext _finalArray;
		_textControl ctrlsettext str _text;
		_textControl ctrlcommit 0.01;
		playsound "ClickSoft"; 
		if (random 1 > 0.9) then {sleep 0.1};
		sleep 0.01;
	} foreach _nArray;

	sleep 2;


	//--- Fade away
	{
		_finalArray set [_x," "];
		_text = composetext _finalArray;
		_textControl ctrlsettext str _text;
		_textControl ctrlcommit 0.01;
		playsound "ClickSoft"; 
		//if (random 1 > 0.9) then {sleep 0.2};
		sleep 0.01;
	} foreach _nArray;


	("BIS_layerInfoText" call bis_fnc_rscLayer) cuttext ["","plain"];
};

GC_dynamicText = {
	private ["_delay","_fade","_array","_x","_w","_y","_h","_text","_moveY","_layer","_display","_control","_pos","_spawn"];
	disableserialization;

	_text = _this select 0;
	_x = if (count _this > 1) then {_this select 1} else {-1};
	_y = if (count _this > 2) then {_this select 2} else {-1};
	_w = -1;
	_h = -1;
	_delay = if (count _this > 3) then {_this select 3} else {4};
	_fade = if (count _this > 4) then {_this select 4} else {1};
	_moveY = if (count _this > 5) then {_this select 5} else {0};
	_layer = if (count _this > 6) then {_this select 6} else {789};
	if (_delay < 0) then {_delay = 4};
	if (_fade < 0) then {_fade = 1};

	//--- Width and Height
	if (typename _x == typename []) then {
		_array = _x;
		_x = _array select 0;
		_w = _array select 1;
	};
	if (typename _y == typename []) then {
		_array = _y;
		_y = _array select 0;
		_h = _array select 1;
	};

	_layer cutrsc ["rscDynamicText","plain"];

	_display = uinamespace getvariable "BIS_dynamicText";
	_control = _display displayctrl 9999;
	_control ctrlsetfade 1;
	_control ctrlcommit 0;
	_pos = ctrlposition _control;
	if (_x != -1) then {_pos set [0,_x]};
	if (_y != -1) then {_pos set [1,_y]};
	if (_w != -1) then {_pos set [2,_w]};
	if (_h != -1) then {_pos set [3,_h]};
	_control ctrlsetposition _pos;
	_control ctrlsetstructuredtext parsetext _text;
	_control ctrlcommit 0;

	_control ctrlsetfade 0;
	_control ctrlcommit _fade;
	waituntil {ctrlcommitted _control};

	if (_moveY != 0) then {
		_y = _pos select 1;
		_pos set [1,_y + _moveY];
		_control ctrlsetposition _pos;
		_control ctrlcommit _delay;
	};

	//if (_layer != 789) exitwith {};

	_spawn = missionnamespace getvariable format ["bis_dynamicText_spawn_%1",_layer];
	if (!isnil "_spawn") then  {terminate _spawn};
	_spawn = [_control,_delay,_fade,_moveY,_layer] spawn {		
	private ["_control","_delay","_fade","_moveY","_layer"];
		disableserialization;
		_control = _this select 0;
		_delay = _this select 1;
		_fade = _this select 2;
		_moveY = _this select 3;
		_layer = _this select 4;

		if (_moveY != 0) then {waituntil {ctrlcommitted _control}} else {sleep _delay};

		_control ctrlsetfade 1;
		_control ctrlcommit 1;
		waituntil {ctrlcommitted _control};

		_layer cuttext ["","plain"];
	};
	missionnamespace setvariable [format ["bis_dynamicText_spawn_%1",_layer],_spawn];
	waituntil {scriptdone _spawn};
};

GC_customGPS = {
	private ["_params","_frame","_dx","_dy","_posMap","_posFrame"];
	_params = ["ca\missions_pmc\data\ui_gps_ca.paa",-0.26,0.16];
	_frame = _params select 0;
	_dx = if (count _params > 1) then {_params select 1} else {0};
	_dy = if (count _params > 2) then {_params select 2} else {0};

	#define GPS_DISPLAY	(_this select 0)
	#define GPS_MAP		(GPS_DISPLAY displayctrl 101)
	#define GPS_FRAME	(GPS_DISPLAY displayctrl 101000)

	_posMap = ctrlposition GPS_MAP;
	_posMap set [0,(_posMap select 0) + _dx];
	_posMap set [1,(_posMap select 1) + _dy];
	GPS_MAP ctrlsetposition _posMap;
	GPS_MAP ctrlcommit 0;   

	_posFrame = ctrlposition GPS_FRAME;
	_posFrame set [0,(_posFrame select 0) + _dx];
	_posFrame set [1,(_posFrame select 1) + _dy];

	GPS_FRAME ctrlsetposition _posFrame;
	GPS_FRAME ctrlsettext _frame;
	GPS_FRAME ctrlcommit 0;
};

GC_Fireball = {
	private ["_veh","_delspeed","_source01","_source02","_sfx_handle","_source03"];
	_veh = _this select 0;
    	_sfx_handle = [] spawn {};
	if (player == driver _veh) then {gc_fireballed = true;};
	_delspeed = _this select 1;
	_source03 =  "Land_HelipadEmpty_F" createVehicleLocal getposASL _veh;
	_source03 attachto [_veh,[0,0,0]];	
	while {(alive _veh && canMove _veh && speed _veh >= _delspeed && count crew _veh != 0)} do {
		if (scriptDone _sfx_handle) then {
			_sfx_handle = _source03 spawn {
				while {true} do {
					_this say3D ["nosloopsfx",100];
					sleep 8.545;
				};
			};
			sleep 0.05;
			_source01 = "#particlesource" createVehicleLocal getposASL _veh;
			_source01 setParticleClass "ObjectDestructionFire1Smallx";
			_source01 attachto [_veh,[0,0,0]];
			_source02 = "#particlesource" createVehicleLocal getposASL _veh;
			_source02 setParticleClass "ObjectDestructionSmokeSmallx";
			_source02 attachto [_veh,[0,0,0]];			
		};
		sleep 1;
	};
	if (!isnil "_source01") then {deletevehicle _source01;};
	if (!isnil "_source02") then {deletevehicle _source02;};
	if (!isnil "_source03") then {deletevehicle _source03;};
	terminate _sfx_handle;
	if (player == driver _veh) then {gc_fireballed = false;};
};

GC_Blood = {	
	private ["_f","_control","_id","_c","_p","_unit","_selection","_damage","_int","_display","_w","_h","_pos"];
	disableserialization;

	_unit = _this select 0;
	_selection = _this select 1;
	_damage = _this select 2;

	//--- Different player - terminate
	if (_selection != "" || _unit != player || (!alive player) || _damage <= 0.012) exitwith {};

	//--- Calculate blood size
	_int = 0.5 + (_damage min 1);

	//--- Display not created
	if (isnil {uinamespace getvariable "BIS_RscMissionScreen_Blood"}) then {
		15 cutrsc ["RscMissionScreen","plain"];
		waituntil {!isnull (uinamespace getvariable "BIS_RscMissionScreen")};
		uinamespace setvariable ["BIS_RscMissionScreen_Blood",uinamespace getvariable "BIS_RscMissionScreen"];
	} else {
		if (isnull (uinamespace getvariable "BIS_RscMissionScreen_Blood")) then {
			15 cutrsc ["RscMissionScreen","plain"];
			waituntil {!isnull (uinamespace getvariable "BIS_RscMissionScreen")};
			uinamespace setvariable ["BIS_RscMissionScreen_Blood",uinamespace getvariable "BIS_RscMissionScreen"];
		};
	};
	_display = uinamespace getvariable "BIS_RscMissionScreen_Blood";

	/// EW ///////////////////////////////////////////////////////
	"dynamicblur" ppeffectenable true;
	"dynamicblur" ppeffectadjust [1];
	"dynamicblur" ppeffectcommit 0;
	"dynamicblur" ppeffectadjust [0];
	"dynamicblur" ppeffectcommit (1 + random 1);

/*
	//--- Vignette
	_vignette = _display displayctrl 1106;
	_vignette ctrlsettext "\A3\ui_f\data\IGUI\RscTitles\HealthTextures\vignette_gs.paa";
	_vignette ctrlsetposition [safezoneX,safezoneY,safezoneW,safezoneH];
	_vignette ctrlsetfade 0;
	_vignette ctrlcommit 0.1;
*/
	//--- Select free layer
	_control = controlnull;
	_id = 0;
	for "_i" from 1100 to 1105 do {
		_c = _display displayctrl _i;
		_f = ctrlfade _c;
		_p = ctrlposition _c;
		if ((_p select 3) == safezoneH) then {_f = 1};
		if (_f == 1) exitwith {_control = _c; _id = _i % 3};
	};
	if (isnull _control) exitwith {};

	//--- Select position
	_w = safezoneW * _int;
	_h = _w / 0.75;
	_pos = [
		((safezoneX - _w/2) + random (safezoneW)),
		((safezoneY - _h/2) + random (safezoneH)),
		_w,
		_h
	];

	switch (_id) do {
		case 0: {
			_id = "a";
		};
		case 1: {
			_id = "b";
		};
		case 2: {
			_id = "c";
		};
		default {
			_id = "a";
		};
	};

	//--- Fade out (0s)
	_control ctrlsettext format ["images\blood%1.paa",_id];
	_control ctrlsetposition _pos;
	_control ctrlsetfade 1;
	_control ctrlcommit 0;

	//--- Fade in (0.1s)
	_control ctrlsetfade 0;
	_control ctrlcommit 0.1;
	waituntil {ctrlcommitted _control};

	//sleep 0.1;
	//_vignette ctrlsetfade 1;
	//_vignette ctrlcommit 6;

	sleep 3;

	//--- Fade out (random 5-15s)
	_control ctrlsetfade 1;
	_control ctrlcommit (5 + random 10);
	waituntil {ctrlcommitted _control};

	//--- Reset
	if (ctrlfade _control == 0) then {
		_control ctrlsetposition [0,0,0,0];
		_control ctrlcommit 0;
	};
	//_vignette ctrlsetfade 1;
	//_vignette ctrlcommit 0.1;
};

GC_CloseTimer = {
	disableserialization;
	_timerUi = uiNamespace getVariable "GC_Timer";
	_groupCtrl = _timerUi displayCtrl 2300;
	_ctrlGroupPos = ctrlposition _groupCtrl;
	_ctrlGroupPosDefault = +_ctrlGroupPos;
	_ctrlGroupPosX = _ctrlGroupPos select 0;
	_ctrlGroupPosW = _ctrlGroupPos select 2;
	_ctrlGroupPos set [0,_ctrlGroupPosX + _ctrlGroupPosW / 2];
	_ctrlGroupPos set [2,0];
	_groupCtrl ctrlsetposition _ctrlGroupPos;
	_groupCtrl ctrlcommit 0.2;
};

format_integer = {
	private["_value", "_nan", "_separator"];
	_nan = "NotANumber"; 
	_value = _this select 0;
	_separator = _this select 1;
	
	if (isNil "_value") exitWith {_nan};
	if (typeName _value != "SCALAR") exitWith {_nan};
	
	if (_value == 0) exitWith {"0"};
	
	private["_string_value", "_digits", "_remainder", "_sign"];
	_string_value = "";
	_digits = 0;
	_sign = if (_value < 0) then {"-"} else {""};
	_value = abs(round(_value));
	while { _value >= 1 } do {
		_digits = _digits + 1;
		if ( _digits > 1 && ((_digits - 1) % 3) == 0) then {
			_string_value = _separator + _string_value;
		};
		_remainder = _value % 10;
		_string_value = str(_remainder) + _string_value;
		_value = floor(_value / 10);
	};
	
	_sign+_string_value
};