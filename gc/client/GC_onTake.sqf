//Imagotrigger@gmail.com - Chaos Life 1.3 by GC
GC_RemoveAttachments = {
	private ["_class","_parents"];
	_class = [_this] call BIS_fnc_classWeapon;
	_parents = [_class,true] call BIS_fnc_returnParents;
	if ("Pistol" in _parents) then {
		removeAllHandgunItems player;
	};
	if ("Rifle" in _parents) then {
		removeAllPrimaryWeaponItems player;		
	};
};

private ["_box","_item"];
diag_log text format["%1: %2",__FILE__,_this];
_box = _this select 1;
_item = _this select 2;
if (_box in gc_boxes) then {
	_item call GC_RemoveAttachments;
} else {
	if ((typeof _box) == "GroundWeaponHolder") then {
		{
			if (player distance _x <= 10) then {
				_item call GC_RemoveAttachments;
			};
		} foreach gc_boxes;
	};
};