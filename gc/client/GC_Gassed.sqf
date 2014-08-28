private ["_pos","_array","_bullet","_timenow"];
_bullet = _this;
_timenow = time;
_array = [];
_pos = getpos _bullet;
sleep 1; //allow smoke to come out a bit
while { (time < (_timenow + 29) && (!(isnull _bullet))) } do {
	_pos = getpos _bullet;
	{
		 //NYI another distance condition? (25m max only if downwind) Imago
		if (isPlayer _x and alive _x) then { 
			_x setVariable ["flashed",true, true];
			_array set [count _array,_x];			
		};
	} foreach nearestObjects [_pos, ["Man"], 25];
	sleep 1;
};
sleep 4;
{
	_x setVariable ["flashed",false, true];
	_array = _array - [_x];	
} foreach _array;