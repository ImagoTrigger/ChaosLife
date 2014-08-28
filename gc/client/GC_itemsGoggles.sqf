_art = _this select 0;
_item   = _this select 1;
_infos    = _item call INV_getitemArray;
_name = (_infos call INV_getitemName);
if (_art == "use") then {
	player addGoggles _item;
	[_item, (-1)] call INV_AddInventoreItem;
	_string = format["You put on your %1",_name];
	["GC_Goggles",["CHAOS LIFE GOGGLES",_string]] spawn bis_fnc_showNotification;
};