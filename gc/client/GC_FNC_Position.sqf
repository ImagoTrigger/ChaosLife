GC_PlayerInCrimeFree = {
  (vehicle player in list CrimeFreeTrigger) || (vehicle player in list graveyardCrimeFree);
};

GC_PlayerInCopBase = {
  vehicle player in list CopBaseTrigger;
};

GC_InCopBase = {
  _this in list CopBaseTrigger;
};

GC_PlayerNotInBorder = {
  private["_pos", "_x", "_y"];

  _pos = getPosATL (vehicle player);
  _x = _pos select 0;
  _y = _pos select 1;
  !((_y > (((-12.476) * _x) + 36064)) and (_y < (((-0.0487) * _x) + 5578)) and (_y < (((-12.417) * _x) + 73214)) and (_y > (((-0.0118) * _x) + 2462)))
};

GC_NearbyCheckpoint = {
	private ["_nearest","_Ncp","_Wcp","_SWcp","_SEcp","_ret","_unsorted","_sorted","_pos","_posx","_posy"];
	_nearest = "";
	_pos = getposATL vehicle player;
	_posx = (_pos select 0);
	_posy = (_pos select 1);
	_Ncp =  [_posx,_posy] distance copgate2;
	_Wcp = [_posx,_posy] distance copgate3;
	_SWcp = [_posx,_posy] distance copgate4;
	_SEcp = [_posx,_posy] distance copgate5;
	_unsorted = [[_Wcp,"WEST",copgate3],[_Ncp,"NORTH",copgate2],[_SWcp,"SOUTH WEST",copgate4],[_SEcp,"SOUTH EAST",copgate5]];
	_sorted = [_unsorted,0] call CBA_fnc_sortNestedArray;
	_nearest = _sorted select 0;
	_ret = ["",objnull];
	if ((_nearest select 0) <= 100) then {
		_ret = [(_nearest select 1),(_nearest select 2)];
	};
	_ret
};

GC_isInFrontOf = {
	private["_obj", "_obj2", "_pos1", "_dirV", "_pos2"];
	_obj = _this select 0;
	_pos1 = position _obj;
	_dirV = vectorDir _obj;
	_obj2 = _this select 1;
	_pos2 = position _obj2;
	if (!(_obj2 in _obj) && ((_pos1 select 0)*(_dirV select 0)+(_pos1 select 1)*(_dirV select 1)+(_this select 2) < (_pos2 select 0)*(_dirV select 0)+(_pos2 select 1)*(_dirV select 1))) then [{true},{false}]
};

GC_DirTo = {
	private ["_pos1","_pos2","_ret"];

	_pos1 = _this select 0;
	_pos2 = _this select 1;

	//if objects, not positions, were passed in, then get their positions
	if(typename _pos1 == "OBJECT") then {_pos1 = getpos _pos1};
	if(typename _pos2 == "OBJECT") then {_pos2 = getpos _pos2};

	//get compass heading from _pos1 to _pos2
	_ret = ((_pos2 select 0) - (_pos1 select 0)) atan2 ((_pos2 select 1) - (_pos1 select 1));
	_ret = _ret % 360; //ensure return is 0-360
	_ret
};