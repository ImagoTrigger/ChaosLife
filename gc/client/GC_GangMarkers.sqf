if (count _this == 0) exitWith 
{
	onMapSingleClick 
	"
		if(_shift and gangmember) then
		{
			_markingMember = player;
			format[""if (!isServer) then {[%1, %2] execVM """"gc\client\GC_GangMarkers.sqf"""";};"", _markingMember, _pos] call broadcast;
		};
		false;		
	"
};

_markingMember = _this select 0;
_pos = _this select 1;
_gang = group _markingMember;

if (player in units _gang) then
{
	_markerName = format["%1Marker", _markingMember];
	deleteMarkerLocal _markerName;
	_marker = createMarkerLocal [_markerName, _pos];
	_marker setMarkerShapeLocal "ICON";
	_markerName setMarkerTypeLocal "hd_warning";
	_markerName setMarkerTextLocal format["%1's Gang Mark", name _markingMember];
	_markerName setMarkerColorLocal "ColorOrange";
}