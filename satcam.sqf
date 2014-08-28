_Position = _this select 0;
_satcam = (vehicle player) getvariable "satcam";
if (isnil "_satcam") exitWith {hint "SatCam Error!";};
if (time < next_satcam_time) exitWith {["GC_Bad2",["CHAOS LIFE SAT CAM","Satellite is no longer in position, try again in later."]] spawn bis_fnc_showNotification;};
_time = 28;
next_satcam_time = (time + 720);
if (_satcam == "satcam2") then {_time = 58;next_satcam_time = (time + 360)};
if (_satcam == "satcam3") then {_time = 118;next_satcam_time = (time + 180)};
missionnamespace setvariable["GC_Timer_done",false];
("GC_Timer" call BIS_fnc_rscLayer) cutRsc ["GC_Timer", "plain"];
timer_handle = (time + _time) spawn 
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
	["GC_Bad2",["CHAOS LIFE SAT CAM","The connection to the satellite was lost."]] spawn bis_fnc_showNotification;
 };

CAM_FreecamMoveTime = 1;
FreeCamera = "camera" camCreate _Position;
FreeCamera cameraEffect ["internal", "back"];
FreeCamera camSetFOV 0.700;
FreeCamera camPreload 5;
FreeCamera camCommit 0;
FreeCamera setVectorUp [(sin 0)*(cos -89),-(sin -89),(cos 0)*(cos -89)];
waitUntil {camCommitted FreeCamera};

if (!(createDialog "RscMenuSatCam")) exitWith {hint "Dialog Error!";};

CAM_FreeCamActive = true;

(findDisplay 2001) displaySetEventHandler["KeyDown", 'nul = _this spawn

{

switch (_this select 1) do

	{

	case 17: {FreeCamera camsetpos [(getpos FreeCamera select 0),     (getpos FreeCamera select 1)+100, (getpos FreeCamera select 2)]; FreeCamera camCommit CAM_FreecamMoveTime;};
	case 30: {FreeCamera camsetpos [(getpos FreeCamera select 0)-100, (getpos FreeCamera select 1),     (getpos FreeCamera select 2)]; FreeCamera camCommit CAM_FreecamMoveTime;};
	case 32: {FreeCamera camsetpos [(getpos FreeCamera select 0)+100, (getpos FreeCamera select 1),     (getpos FreeCamera select 2)]; FreeCamera camCommit CAM_FreecamMoveTime;};
	case 31: {FreeCamera camsetpos [(getpos FreeCamera select 0),     (getpos FreeCamera select 1)-100, (getpos FreeCamera select 2)]; FreeCamera camCommit CAM_FreecamMoveTime;};
	case 33: {FreeCamera camsetpos (getpos FreeCamera); FreeCamera camCommit 0;};

	};

};

'];

buttonSetAction [21, format["FreeCamera camsetpos [(getpos FreeCamera select 0)-100, (getpos FreeCamera select 1),     (getpos FreeCamera select 2)]; FreeCamera camCommit CAM_FreecamMoveTime;"] ];
buttonSetAction [22, format["FreeCamera camsetpos [(getpos FreeCamera select 0),     (getpos FreeCamera select 1)+100, (getpos FreeCamera select 2)]; FreeCamera camCommit CAM_FreecamMoveTime;"] ];
buttonSetAction [23, format["FreeCamera camsetpos [(getpos FreeCamera select 0),     (getpos FreeCamera select 1)-100, (getpos FreeCamera select 2)]; FreeCamera camCommit CAM_FreecamMoveTime;"] ];
buttonSetAction [24, format["FreeCamera camsetpos [(getpos FreeCamera select 0)+100, (getpos FreeCamera select 1),     (getpos FreeCamera select 2)]; FreeCamera camCommit CAM_FreecamMoveTime;"] ];
buttonSetAction [25, format["camUseNVG true;"] ];
buttonSetAction [26, format["camUseNVG false;"] ];
buttonSetAction [27, format["FreeCamera camsetpos (getpos FreeCamera); FreeCamera camCommit 0;"] ];
buttonSetAction [28, format["
	terminate timer_handle;
	missionnamespace setvariable[""GC_Timer_current"",nil];
	missionnamespace setvariable[""GC_Timer_done"",true];
	[] spawn GC_CloseTimer;
	closeDialog 0;
"]];
sliderSetRange [10, 175, 1500];
sliderSetSpeed [10, 100, 250];
sliderSetRange [11, 0, 200];
sliderSetSpeed [11, 0.05, 20];

_slider1 = 0;
_slider2 = 0;

while {(ctrlVisible 1029)} do

{

if ( (round(sliderPosition 10)) != _slider1 ) then

	{

	_slider1 = (round(sliderPosition 10));
	FreeCamera camsetpos [(getpos FreeCamera select 0), (getpos FreeCamera select 1), _slider1]; FreeCamera camCommit CAM_FreecamMoveTime;

	};

if ( (sliderPosition 11) != _slider2 ) then

	{

	_slider2 = (sliderPosition 11);
	if (_slider2 < 600) then {setAperture _slider2;} else {setAperture -1;};

	};

sleep 0.1;

};

setAperture -1;
CAM_FreeCamActive = false;
FreeCamera cameraEffect ["terminate", "back"];
titleCut [" ","Black in",1];
camDestroy FreeCamera;

