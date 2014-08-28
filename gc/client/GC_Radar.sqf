private ["_veh","_hasradar","_tag","_dbest","_tagbest","_getspeed1","_dfast","_tagfast","_getspeed2","_best1","_best2","_best3","_fast1","_fast2","_fast3","_besttext1","_besttext2","_besttext3","_fasttext1","_fasttext2","_fasttext3","_speederid","_speederspeed","_dir","_eyepa","_eyepb","_adj","_updatebest","_test","_updated","_resetbest","_my3","_my1","_my2","_mytext1","_mytext2","_mytext3"];
_veh = _this;
_speederspeed = 0;
_updated = 0;
_hasradar = _veh getvariable "radar";
if (isNil "_hasradar") then {
	_hasradar = 0;
};

_veh setvariable ["radartarget","<t shadow='1' shadowColor='#cc0000' size='1' font='PuristaBold' align='center' valign='top'>Initializing...</t>",false];
_veh setvariable ["radardigits","<img size='0.9' image='images\digits\g0.pac'/><img size='0.9' image='images\digits\g0.pac'/><img size='0.9' image='images\digits\g0.pac'/> <img size='0.9' image='images\digits\g0.pac'/><img size='0.9' image='images\digits\g0.pac'/><img size='0.9' image='images\digits\g0.pac'/> <img size='0.9' image='images\digits\g0.pac'/><img size='0.9' image='images\digits\g0.pac'/><img size='0.9' image='images\digits\g0.pac'/>", false];
sleep 0.35;
_veh setvariable ["radardigits","<img size='0.9' image='images\digits\g1.pac'/><img size='0.9' image='images\digits\g2.pac'/><img size='0.9' image='images\digits\g3.pac'/> <img size='0.9' image='images\digits\g4.pac'/><img size='0.9' image='images\digits\g5.pac'/><img size='0.9' image='images\digits\g6.pac'/> <img size='0.9' image='images\digits\g7.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g9.pac'/>", false];
sleep 0.35;
_veh setvariable ["radardigits","<img size='0.9' image='images\digits\g9.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g7.pac'/> <img size='0.9' image='images\digits\g6.pac'/><img size='0.9' image='images\digits\g5.pac'/><img size='0.9' image='images\digits\g4.pac'/> <img size='0.9' image='images\digits\g3.pac'/><img size='0.9' image='images\digits\g2.pac'/><img size='0.9' image='images\digits\g1.pac'/>", false];
sleep 0.35;
_veh setvariable ["radartarget"," ",false];
_veh setvariable ["radardigits","<img size='0.9' image='images\digits\g0.pac'/><img size='0.9' image='images\digits\g0.pac'/><img size='0.9' image='images\digits\g0.pac'/> <img size='0.9' image='images\digits\g0.pac'/><img size='0.9' image='images\digits\g0.pac'/><img size='0.9' image='images\digits\g0.pac'/> <img size='0.9' image='images\digits\g0.pac'/><img size='0.9' image='images\digits\g0.pac'/><img size='0.9' image='images\digits\g0.pac'/>", false];
diag_log text format ["%1 %2 %3",__LINE__,__FILE__,_veh];
while {alive _veh && _hasradar == 1} do {
	_hasradar = _veh getvariable "radar";
	if (!IsNull driver _veh) then {
		if (driver _veh == player) then {
			_tag = objnull;
			{
				_eyepa = eyepos driver _veh;
				_eyepb = eyepos _x;
				_dir = [_veh,_x] call GC_DirTo;
				if (_dir < 0) then { _dir = _dir + 360 };
				_adj = abs (_dir - (getdir _veh));
				if (_adj < 15 and driver _x != driver _veh) then {
					if ([_veh,_x,1] call GC_isInFrontOf) then {
						if (!terrainintersectasl [_eyepa, _eyepb]) exitWith {
							_tag = _x;
						};
					};
				}
			} foreach nearestObjects [getPos _veh,["LandVehicle"],200];
			if (!isNull driver _tag) then {
				_dbest = driver _tag;
				_getspeed1 = speed _tag;
				_tagbest = ceil(_getspeed1);
				_dfast =  driver _tag;
				_getspeed2 = speed _tag;
				_tagfast = ceil(_getspeed2);
				_updatebest = 0;
				_resetbest = 0;
				if (_tagfast >= _speederspeed) then {
					_speederspeed = _tagfast;
					_speederid = _dfast;
					_updatebest = 1;
				} else {
					_speederid = objnull;
					if (!isNull _dfast and !isNull _speederid) then {
						if (_dfast != _speederid) then {
							_resetbest = 1;
						};
					};
				};

				if (isNull _dbest) then {_dbest = "";_tagbest = 0};
				if (_tagfast > 1) then {
					_best1 = 0;
					_best2 = 0;
					_best3 = _tagbest;
					_fast1 = 0;
					_fast2 = 0;
					_fast3 = _tagfast;
					while {_best3 > 9} do {_best3 = _best3 - 10; _best2 = _best2 + 1; if (_best2 > 9) then { _best1 = _best1 + 1; _best2 = 0}};
					while {_fast3 > 9} do {_fast3 = _fast3 - 10; _fast2 = _fast2 + 1; if (_fast2 > 9) then { _fast1 = _fast1 + 1; _fast2 = 0}};
					_fasttext1 = format ["images\digits\g%1.pac", _fast1];
					_fasttext2 = format ["images\digits\g%1.pac", _fast2];
					_fasttext3 = format ["images\digits\g%1.pac", _fast3];
					_test = _veh getvariable "radartarget";
					if(_updatebest == 1 or isnil "_test") then {
						_besttext1 = format ["images\digits\g%1.pac", _best1];
						_besttext2 = format ["images\digits\g%1.pac", _best2];
						_besttext3 = format ["images\digits\g%1.pac", _best3];
					};
					if (_resetbest == 1) then {
						_besttext1 = format ["images\digits\g%1.pac", 0];
						_besttext2 = format ["images\digits\g%1.pac", 0];
						_besttext3 = format ["images\digits\g%1.pac", 0];
						_speederspeed = 0;
						_dfast = driver _tag;
						_speederid = _dfast;
					};
					_veh setvariable ["radartarget",format["<t shadow='1' shadowColor='#cc0000' size='1' font='PuristaBold' align='center' valign='top'>%1</t>",name driver _tag],false];
					_updated = 1;
				} else {
					_fasttext1 = format ["images\digits\g%1.pac", 0];
					_fasttext2 = format ["images\digits\g%1.pac", 0];
					_fasttext3 = format ["images\digits\g%1.pac", 0];
				};
			} else {
				_fasttext1 = format ["images\digits\g%1.pac", 0];
				_fasttext2 = format ["images\digits\g%1.pac", 0];
				_fasttext3 = format ["images\digits\g%1.pac", 0];
				_besttext1 = format ["images\digits\g%1.pac", 0];
				_besttext2 = format ["images\digits\g%1.pac", 0];
				_besttext3 = format ["images\digits\g%1.pac", 0];
				_veh setvariable ["radartarget","",false];
			};
			_my1 = 0;
			_my2 = 0;
			_my3 = ceil(speed _veh);
			if (_my3 <= 0 or _my3 == -0) then {_my3 = 0};
			while {_my3 > 9} do {_my3 = _my3 - 10; _my2 = _my2 + 1; if (_my2 > 9) then { _my1 = _my1 + 1; _my2 = 0}};
			_mytext1 = format ["images\digits\g%1.pac", _my1];
			_mytext2 = format ["images\digits\g%1.pac", _my2];
			_mytext3 = format ["images\digits\g%1.pac", _my3];
			if (_updated == 0) then {
				_fasttext1 = format ["images\digits\g%1.pac", 0];
				_fasttext2 = format ["images\digits\g%1.pac", 0];
				_fasttext3 = format ["images\digits\g%1.pac", 0];
				_besttext1 = format ["images\digits\g%1.pac", 0];
				_besttext2 = format ["images\digits\g%1.pac", 0];
				_besttext3 = format ["images\digits\g%1.pac", 0];
			};
			_veh setvariable ["radardigits",format ["<img size='0.9' image='%1'/><img size='0.9' image='%2'/><img size='0.9' image='%3'/> <img size='0.9' image='%4'/><img size='0.9' image='%5'/><img size='0.9' image='%6'/> <img size='0.9' image='%7'/><img size='0.9' image='%8'/><img size='0.9' image='%9'/>", _fasttext1,_fasttext2,_fasttext3,_besttext1,_besttext2,_besttext3,_mytext1,_mytext2,_mytext3], false];
			sleep 0.5;
		} else {
			_fasttext1 = format ["images\digits\g%1.pac", 0];
			_fasttext2 = format ["images\digits\g%1.pac", 0];
			_fasttext3 = format ["images\digits\g%1.pac", 0];
			_besttext1 = format ["images\digits\g%1.pac", 0];
			_besttext2 = format ["images\digits\g%1.pac", 0];
			_besttext3 = format ["images\digits\g%1.pac", 0];
			_mytext1 = format ["images\digits\g%1.pac", 0];
			_mytext2 = format ["images\digits\g%1.pac", 0];
			_mytext3 = format ["images\digits\g%1.pac", 0];
			_veh setvariable ["radartarget","",false];
			_veh setvariable ["radardigits",format ["<img size='0.9' image='%1'/><img size='0.9' image='%2'/><img size='0.9' image='%3'/> <img size='0.9' image='%4'/><img size='0.9' image='%5'/><img size='0.9' image='%6'/> <img size='0.9' image='%7'/><img size='0.9' image='%8'/><img size='0.9' image='%9'/>", _fasttext1,_fasttext2,_fasttext3,_besttext1,_besttext2,_besttext3,_mytext1,_mytext2,_mytext3], false];
			_speederid = "";
			_speederspeed = 0;
			diag_log text format ["%1 %2 %3",__LINE__,__FILE__,_veh];
			'format["if (!isServer && (player == driver %1)) then {%1 execVM ""gc\client\GC_Radar.sqf"";};",_veh];' call broadcast;
			sleep 3;
			_hasradar = _veh getvariable "radar";
		};
	} else {
		_fasttext1 = format ["images\digits\g%1.pac", 0];
		_fasttext2 = format ["images\digits\g%1.pac", 0];
		_fasttext3 = format ["images\digits\g%1.pac", 0];
		_besttext1 = format ["images\digits\g%1.pac", 0];
		_besttext2 = format ["images\digits\g%1.pac", 0];
		_besttext3 = format ["images\digits\g%1.pac", 0];
		_mytext1 = format ["images\digits\g%1.pac", 0];
		_mytext2 = format ["images\digits\g%1.pac", 0];
		_mytext3 = format ["images\digits\g%1.pac", 0];
		_veh setvariable ["radartarget","",false];
		_veh setvariable ["radardigits",format ["<img size='0.9' image='%1'/><img size='0.9' image='%2'/><img size='0.9' image='%3'/> <img size='0.9' image='%4'/><img size='0.9' image='%5'/><img size='0.9' image='%6'/> <img size='0.9' image='%7'/><img size='0.9' image='%8'/><img size='0.9' image='%9'/>", _fasttext1,_fasttext2,_fasttext3,_besttext1,_besttext2,_besttext3,_mytext1,_mytext2,_mytext3], false];
		_speederid = "";
		_speederspeed = 0;
		sleep 3;
		_hasradar = _veh getvariable "radar";
	};
};
_veh setvariable ["radar","",true];