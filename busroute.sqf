// Original cop patrol script by eddiev223 and cobra//additions by Gman
// Bus route by Durandal of Global Chaos www.globalchaosgaming.net

_selection = (_this select 3) select 0;
_moneyearned = 0;
_distance = 0;

_busRouteMoneyPerKM = 14.00;

_busStops = [
	getMarkerPos "busstop1",
	getMarkerPos "busstop2",
	getMarkerPos "busstop3",
	getMarkerPos "busstop4",
	getMarkerPos "busstop5",
	getMarkerPos "busstop6",
	getMarkerPos "busstop7",
	getMarkerPos "busstop8",
	getMarkerPos "busstop9",
	getMarkerPos "busstop10",
	getMarkerPos "busstop11",
	getMarkerPos "busstop12",
	getMarkerPos "busstop13",
	getMarkerPos "busstop14",
	getMarkerPos "busstop15",
	getMarkerPos "busstop16",
	getMarkerPos "busstop17",
	getMarkerPos "busstop18"
];

_createNewMarker = {
	_markerlocation = _this;
	_markerobj = createMarkerlocal ["busStopMarker",[0,0]];
	_markername = "busStopMarker";
	_markerojb setMarkershapelocal "icon";
	//"busStopMarker" setMarkerBrushLocal "solid";
	"busStopMarker" setMarkertypelocal "mil_warning";
	"busStopMarker" setMarkercolorlocal "colorblue";
	"busStopMarker" setMarkersizelocal [1, 1];
	"busStopMarker" setMarkertextlocal "Bus Stop";
	_markername SetMarkerposlocal _markerlocation;
};

if (_selection == "start") then {

	busrouteactive = true;
	deleteMarkerLocal "busStopMarker";

	_newMarker = floor(random(count _busStops));
	_markerlocation = _busStops select _newMarker;

	_markerlocation call _createNewMarker;

	player sideChat "Your bus route will be available shortly.";

	sleep 2;
	_plocation = getpos player;
	_distance = _plocation distance _markerlocation;
	[player,"GC_Bus",["Take your bus along it's route!  Goto the marker on the map.","Reach the bus stop","BUS STOP"],"busStopMarker",true] call GC_createLocalTask;
	player sideChat "Bus Stop added!";

	while {busrouteactive} do {

		if (player distance _markerlocation <= 30) then {
			deleteMarkerLocal "busStopMarker";
			_moneyearned = ceil(_distance * _busRouteMoneyPerKM);
			['cash', (_moneyearned)] call INV_AddInventoreItem;
			player sideChat format["You earned $%1 for your bus route.", _moneyearned];
			player sideChat "Unlock the bus and wait 15 sec for passengers to enter/exit.";
			["GC_Bus", "SUCCEEDED"] call BIS_fnc_taskSetState;
			sleep 15;

			_newMarker = floor(random(count _busStops));
			_markerlocation = _busStops select _newMarker;
			_plocation = getpos player;
			_distance = _plocation distance _markerlocation;
			while {_distance <= 150} do {
				_newMarker = floor(random(count _busStops));
				_markerlocation = _busStops select _newMarker;
				_plocation = getpos player;
				_distance = _plocation distance _markerlocation;			
			};
			_markerlocation call _createNewMarker;
			[player,"GC_Bus",["Take your bus to the next stop!  Goto the marker on the map.","Reach the bus stop","BUS STOP"],"busStopMarker",true] call GC_createLocalTask;
			player sideChat "next stop marked!";

		};
		sleep 5;
	};

	deleteMarkerLocal "busStopMarker";
};

if (_selection == "end") then {
	busrouteactive = false;
	deleteMarkerLocal "busStopMarker";
	player sidechat "Bus route canceled. You must wait 60 seconds to get a new one.";
	["GC_Bus", "CANCELED"] call BIS_fnc_taskSetState;
	busRouteWaiting = true;
	sleep 60;
	busRouteWaiting = false;
};


