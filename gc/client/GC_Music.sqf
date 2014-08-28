//DOA <imagotrigger@gmail.com> For Chaos Life by GC
private ["_on","_player","_class","_duration","_trackList","_current","_durationList","_args","_radio","_stop","_action","_path","_pathCount"];
_args = _this select 3;
_radio = _args select 0;
_stop = _args select 1;
_action = _this select 2;
_on = _radio getvariable "on";
if (isnil "_on") then {_on = 0;};

if (_stop == 1) exitWith {
	if (!isnil "radio_handle") then {terminate radio_handle};
	3 fademusic 0;
	playmusic "";
	_radio setvariable["on",0,true];
	_radio setvariable["track",nil,true];
	_radio setvariable["player",nil,true];
	_radio setvariable["duration",nil,true];
	_radio setvariable["elapsed",nil,true];
	if (!isnil "_action") then {player removeaction _action;};
};

if (_stop == 2) exitWith {
	if (!isnil "radio_handle") then {terminate radio_handle};
	_player = _radio getvariable "player";
	(format['if (name player == "%1") then {[0,0,nil,[%2,1]] execVM "gc\client\GC_Music.sqf"};',_player,_radio]) call broadcast;
	3 fademusic 0;
	playmusic "";
	_radio setvariable["on",0,true];
	_radio setvariable["track",nil,true];
	_radio setvariable["player",nil,true];
	_radio setvariable["duration",nil,true];
	_radio setvariable["elapsed",nil,true];
	if (!isnil "_action") then {player removeaction _action;};
};

_trackList = [];
_path = configfile >> "cfgMusic";
_pathCount = count _path;

for "_i" from 0 to (_pathCount - 1) do {
	_current = _path select _i;
	if (isclass _current) then {
		_class = configname _current;
		_duration = getnumber (_current >> "duration");
		_trackList = _trackList + [_class];
	};
};
_durationList = [];
{
	_duration = getnumber (configfile >> "cfgMusic" >> _x >> "duration");
	if (_duration == 0) then {
		if (_x == "Ambient01_Cold_Wind") then {_duration = 153;};
		if (_x == "Ambient02_Vague_Shapes") then {_duration = 219;};
		if (_x == "Ambient03_Indian_Summer") then {_duration = 102;};
		if (_x == "Ambient04_Electronic_Warfare") then {_duration = 76;};
		if (_x == "Ambient05_Cobalt") then {_duration = 43;};
		if (_x == "Ambient06_Khe_Sanh_Riff") then {_duration = 211;};
		if (_x == "Ambient07_Manhattan") then {_duration = 101;};
		if (_x == "Ambient08_Reforger") then {_duration = 155;};
		if (_x == "Short01_Defcon_Three") then {_duration = 38;};
		if (_x == "Track01_Dead_Forest") then {_duration = 64;};
		if (_x == "Track02_Insertion") then {_duration = 105;};
		if (_x == "Track03_First_To_Fight") then {_duration = 119;};
		if (_x == "Track04_Reinforcements") then {_duration = 88;};
		if (_x == "Track05_Warpath") then {_duration = 143;};
		if (_x == "Track06_Abandoned_Battlespace") then {_duration = 111;};
		if (_x == "Track07_Last_Men_Standing") then {_duration = 63;};
		if (_x == "Track08_Harvest_Red") then {_duration = 78;};
		if (_x == "Track09_Movement_To_Contact") then {_duration = 81;};
		if (_x == "Track10_Logistics") then {_duration = 148;};
		if (_x == "Track11_Large_Scale_Assault") then {_duration = 42;};
		if (_x == "Track12_The_Movement") then {_duration = 72;};
		if (_x == "Track13_Sharping_Knives") then {_duration = 180;};
		if (_x == "Track14_Close_Quarter_Combat") then {_duration = 188;};
		if (_x == "Track15_Morning_Sortie") then {_duration = 55;};
		if (_x == "Track16_Valentine") then {_duration = 86;};
		if (_x == "Track17_Marauder_Song") then {_duration = 68;};
		if (_x == "Track18_Ghost_Waltz") then {_duration = 113;};
		if (_x == "Track19_Debriefing") then {_duration = 104;};
		if (_x == "Track20_Badlands") then {_duration = 137;};
		if (_x == "Track21_Rise_Of_The_Fallen") then {_duration = 89;};
		if (_x == "Track22_Chernarussian_Anthem") then {_duration = 129;};
		if (_x == "Track26_Organ_Works") then {_duration = 69;};
		if (_x == "Track27_Killing_Machines") then {_duration = 200;};

		//dont know exact length of these ones yet
		//this one is really more suitable for cop base ;-) if (_x == "City_Ambient") then {_duration = 69;};		
		if (_x == "Intro_Music") then {_duration = 69;};
		if (_x == "CE8_music") then {_duration = 69;};
		if (_x == "CE0_driving_music") then {_duration = 30;};
		if (_x == "CE0_execFailMusic") then {_duration = 69;};  //play when dead?
		if (_x == "MAD") then {_duration = 69;};
		if (_x == "Fallout") then {_duration = 69;};
		if (_x == "ToWar") then {_duration = 69;};
		if (_x == "Defcon") then {_duration = 69;};
		if (_x == "Wasteland") then {_duration = 69;};
		if (_x == "AllHelllBreaksLoose") then {_duration = 69;};
	};
	_durationList = _durationList + [_duration];
} foreach _trackList;

if (!isnil "radio_handle") then {terminate radio_handle};
_radio setvariable["player",name player,true];
_radio setvariable["duration",0,true];
_radio setvariable["elapsed",0,true];
_radio setvariable["track","Loading",true];
_radio setvariable["on",1,true];

//the local operator of the radio
radio_handle = [_trackList,_durationList,0,_radio] spawn {
	private ["_ran","_fade","_mod","_fadeamt","_dist","_n","_track","_durationFull","_oldRan","_duration","_lvl","_trackList","_trackCount","_durationList","_delay","_radio","_fadeTime","_newaction","_musicVolume"];
    _trackList = _this select 0;
	_trackCount = count _trackList;
	_durationList = _this select 1;
	_delay = _this select 2;
	_radio = _this select 3;

	_oldRan = -1;
	_ran = -1;
	_fadeTime = 3;
	_newaction = nil;
	_fadeamt = 0.9;
	_musicVolume = musicvolume;
	while {(_radio getvariable "on") == 1 and alive player} do {
		waituntil {
			_ran = floor random _trackCount;
			_ran != _oldRan || _trackCount == 1
		};
		_track = _trackList select _ran;
		_durationFull = _durationList select _ran;
		_radio setvariable["duration",_durationFull,true];
		_radio setvariable["track",_track,true];
		if (!isnil "_newaction") then {player removeAction _newaction;};
		call compile format['_newaction = player addaction ["Turn off %1", "gc\client\GC_Music.sqf", [%2,1], 1, false, true, "", "_track2 = %2 getvariable ""track"";player distance %2 <= 2 and ""%1"" == _track2"];',_track,_radio];
		playmusic _track;
		_oldRan = _ran;
		0.1 fadeMusic _fadeamt;
		_duration = _durationFull - _fadeTime;
		_fade = false;
		_n = 0;
		_lvl = (0.9*3/8);
        	_mod = 1;

		while {_n < _durationFull} do {
			if (!alive player) exitwith{};
			_dist = vehicle player distance _radio;
			sleep (0.5 * acctime);
			if (_n >= _duration && !_fade && _dist < 25) then {
				_musicVolume = musicvolume;
				(_fadeTime * acctime) fademusic 0;
				_fade = true;
			};
			_fadeamt = (10/_dist*_lvl) / _mod;
			if (_dist > 5) then {_mod = 2;} else {_mod = 1};
			if (_dist > 25) then {_mod = 3;} else {_mod = 1};
			if (_dist > 40) then {_mod = 4;} else {_mod = 1};
			if (_fadeamt > 0.9) then { _fadeamt = 0.9; };
			if (_dist > 80) then {0.1 fadeMusic 0; _mod = 1} else {0.1 fadeMusic _fadeamt;};
			_n = _n + 0.5;
			_radio setvariable["elapsed",_n,true];
		};
		0 fademusic _musicVolume;
		if (!isnil "_newaction") then {player removeAction _newaction;};
		sleep (_delay * acctime);
	};
	3 fademusic 0;
	playmusic "";
	if (!isnil "_newaction") then {player removeAction _newaction;};
};