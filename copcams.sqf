private ["_camera"];

_array = _this select 3;
_art   = _array select 0;
_cash  = 'cash' call INV_GetItemAmount;

if (_art == "jailcam") then {

	if (time < next_jailcam_time) exitWith {["GC_Bad2",["CHAOS LIFE JAIL CAM","Camera is currently unavailable, try again in later."]] spawn bis_fnc_showNotification;};
	next_jailcam_time = (time + 360);
	missionnamespace setvariable["GC_Timer_done",false];
	("GC_Timer" call BIS_fnc_rscLayer) cutRsc ["GC_Timer", "plain"];
	timer_handle = (time + 58) spawn 
	 {
		BIS_FD_color = [1, 1, 1, 1];
		BIS_FD_colorHTML = BIS_FD_color call BIS_fnc_colorRGBtoHTML;
		BIS_FD_colorTextHTML = (["IGUI", "TEXT_RGB"] call BIS_fnc_displayColorGet) call BIS_fnc_colorRGBtoHTML;
		private ["_3s","_2s", "_1s"];
		_3s = false;
		_2s = false;
		_1s = false;
		while {(time - _this) < 3} do 
		{
			if (((time - _this) > 0) && !_3s) then {_3s = true;playSound "FD_Timer_F";};
			if (((time - _this) > 1) && !_2s) then {_2s = true;playSound "FD_Timer_F";};
			if (((time - _this) > 2) && !_1s) then {_1s = true;playSound "FD_Timer_F";};
			private ["_timeCount", "_timeCountFormat", "_textCount"];
			_timeCount = (_this + 3) - time;
			_timeCountFormat = [_timeCount, "MM:SS.MS", true] call BIS_fnc_secondsToString;
			_textCount = "<t color='" + BIS_FD_colorTextHTML + "'><img image='A3\Modules_F_Beta\data\FiringDrills\timer_ca' /> ";
			_textCount = _textCount + (format ["<t color='%4'>-%1:%2<t size='0.8'>.%3</t></t>", _timeCountFormat select 0, _timeCountFormat select 1, _timeCountFormat select 2, BIS_FD_colorHTML]);
			_textCount = _textCount + "</t>";
			RscFiringDrillTime_current = parsetext _textCount;
			missionnamespace setvariable["GC_Timer_current",RscFiringDrillTime_current];
			sleep 0.01;
		};
		missionnamespace setvariable["GC_Timer_current",nil];
		missionnamespace setvariable["GC_Timer_done",true];
		[] spawn GC_CloseTimer;
		closeDialog 0;
		["GC_Bad2",["CHAOS LIFE JAIL CAM","The connection to the camera was lost."]] spawn bis_fnc_showNotification;
	 }; 


  _camera = "camera" camCreate [(getPos prison_logic select 0)+40,(getPos prison_logic select 1),20];

  if (!(createDialog "RscMenuMainCam")) exitWith {hint "Dialog Error!";};

  [0,0,0,["camcontrol",_camera,[10,30]]] execVM "copcams.sqf";
  _camera cameraEffect ["internal", "back"];
  _camera camSetPos [(getPos prison_logic select 0)+40,(getPos prison_logic select 1),20];
  _camera camSetTarget prison_logic;
  _camera camSetFOV 0.700;
  _camera camPreload 5;
  _camera camCommit 0;
};

if (_art == "civcam") then {
  _civs      = _array select 1;
  if (isnil "_civs") exitWith {player groupChat "There are no civs!";};
  _watchtime = round(_array select 2);
  _cost      = _watchtime*1000;
  _civ       = playerarray select _civs;
  if (not((format["%1", (_civ)]) call ISSE_UnitExists)) exitWith {player groupChat "Selected player is not in game.";};
  _exit = false;

  if (_civs < civscount) then {
    if (_cash < _cost) exitWith{
      player groupChat format[localize "STRS_camciv_nomoney"];
      _exit = true;
    };
    
	if (time < next_civcam_time) exitWith {["GC_Bad2",["CHAOS LIFE CIV CAM","Cameras are no longer in position, try again in later."]] spawn bis_fnc_showNotification;};
	next_civcam_time = (time + 720);
	missionnamespace setvariable["GC_Timer_done",false];
	("GC_Timer" call BIS_fnc_rscLayer) cutRsc ["GC_Timer", "plain"];
	timer_handle = ((time + _watchtime) - 1) spawn 
	 {
		BIS_FD_color = [1, 1, 1, 1];
		BIS_FD_colorHTML = BIS_FD_color call BIS_fnc_colorRGBtoHTML;
		BIS_FD_colorTextHTML = (["IGUI", "TEXT_RGB"] call BIS_fnc_displayColorGet) call BIS_fnc_colorRGBtoHTML;
		private ["_3s","_2s", "_1s"];
		_3s = false;
		_2s = false;
		_1s = false;
		while {(time - _this) < 3} do 
		{
			if (((time - _this) > 0) && !_3s) then {_3s = true;playSound "FD_Timer_F";};
			if (((time - _this) > 1) && !_2s) then {_2s = true;playSound "FD_Timer_F";};
			if (((time - _this) > 2) && !_1s) then {_1s = true;playSound "FD_Timer_F";};
			private ["_timeCount", "_timeCountFormat", "_textCount"];
			_timeCount = (_this + 3) - time;
			_timeCountFormat = [_timeCount, "MM:SS.MS", true] call BIS_fnc_secondsToString;
			_textCount = "<t color='" + BIS_FD_colorTextHTML + "'><img image='A3\Modules_F_Beta\data\FiringDrills\timer_ca' /> ";
			_textCount = _textCount + (format ["<t color='%4'>-%1:%2<t size='0.8'>.%3</t></t>", _timeCountFormat select 0, _timeCountFormat select 1, _timeCountFormat select 2, BIS_FD_colorHTML]);
			_textCount = _textCount + "</t>";
			RscFiringDrillTime_current = parsetext _textCount;
			missionnamespace setvariable["GC_Timer_current",RscFiringDrillTime_current];
			sleep 0.01;
		};
		missionnamespace setvariable["GC_Timer_current",nil];
		missionnamespace setvariable["GC_Timer_done",true];
		[] spawn GC_CloseTimer;
		closeDialog 0;
		["GC_Bad2",["CHAOS LIFE CIV CAM","The connection to the camera was lost."]] spawn bis_fnc_showNotification;
	 };    
    

    ['cash', -(_cost)] call INV_AddInventoreItem;

    if ((call compile format ["%1_wanted", _civ]) == 1) then {
      titletext [format[localize "STRS_civcam_wanted", playerstringarray select _civs], "plain down"];
    } else {
      titletext [format[localize "STRS_civcam_notwanted", playerstringarray select _civs], "plain down"];
    };
  };

  if (_exit) exitWith {};

  _camera = "camera" camcreate [(getpos vehicle _civ select 0),(getpos vehicle _civ select 1),15];
  if (!(createDialog "RscMenuMainCam")) exitWith {hint "Dialog Error!";};
  [0,0,0,["camcontrol",_camera,[10,30]]] execVM "copcams.sqf";
  _camera cameraEffect ["internal", "back"];
  _camera camSetPos [(getPos vehicle _civ select 0),(getPos vehicle _civ select 1),10];
  _camera camSetTarget vehicle _civ;
  _camera camSetFOV 0.700;
  _camera camPreload 5;
  _camera camCommit 0;
  waitUntil {camCommitted _camera};

  _camera camsetpos [(getPos vehicle _civ select 0),(getPos vehicle _civ select 1),10];
  _camera camSetTarget vehicle _civ;
  _camera camSetFOV 0.700;
  _camera camCommit 0;
  _endTime = time + _watchtime;

  sliderSetRange [1055, 0, 50];
  sliderSetSpeed [1055, 100, 250];
  sliderSetPosition [1055, 10];

  _dx = -20;

  while {(ctrlVisible 1050) and (time < _endTime)} do {
    _camera camSetTarget [(10 * sin (getDir vehicle _civ))+(getPos vehicle _civ select 0), 10*cos (getDir vehicle _civ)+(getPos vehicle _civ select 1), (getPos vehicle _civ select 2)];
    _camera camSetPos [(getPos vehicle _civ select 0) + _dx * sin (getDir vehicle _civ), (getPos vehicle _civ select 1) + _dx * cos (getDir vehicle _civ), (getPos vehicle _civ select 2)+(round(sliderPosition 1055))];
    _camera camSetFOV 0.700;
    _camera camCommit 0;

    waituntil {camCommitted _camera};
    sleep 0.01;
  };

  setAperture -1;
  closeDialog 0;
};

if (_art == "camcontrol") then {
  _camera = _array select 1;
  _zoom  = _array select 2;
  buttonSetAction [25, format["camUseNVG true;"] ];
  buttonSetAction [26, format["camUseNVG false;"] ];
  buttonSetAction [28, format["
	terminate timer_handle;
	missionnamespace setvariable[""GC_Timer_current"",nil];
	missionnamespace setvariable[""GC_Timer_done"",true];
	[] spawn GC_CloseTimer;
	closeDialog 0;
  "]];
  sliderSetRange [10, (_zoom select 0), (_zoom select 1)];
  sliderSetSpeed [10, 0.05, 0.25];
  sliderSetRange [11, 0, 200];
  sliderSetSpeed [11, 0.05, 20];
  _slider1 = 0;
  _slider2 = 0;

  while {(ctrlVisible 1050)} do {
    if ( (sliderPosition 10) != _slider1 ) then {_slider1 = (round(sliderPosition 10));};
    if ( (sliderPosition 11) != _slider2 ) then {
      _slider2 = (sliderPosition 11);if (_slider2 < 600) then {setAperture _slider2;}else{setAperture -1;};
    };

    sleep 0.1;
  };

  _camera cameraEffect ["terminate","back"];
  titleCut [" ","Black in",1];
  camDestroy _camera;
};
