_option = ((_this select 3) select 0);

if (_option == "getajob_search") then {
	if (alreadygotaworkplacejob == 2) exitWith {
		player groupChat localize "STRS_workplacemission_already";
	};

	if (alreadygotaworkplacejob == 1) exitWith {
		player groupChat localize "STRS_workplacemission_already";
	};

	if (workplacejob_search_cancel == 1) exitWith {
		player groupchat "You cannot start another search mission so soon after failing one!";
	};

	alreadygotaworkplacejob = 2;
	_searchjob      = floor(random(count workplacejob_searchmessages));
	_searchmsg      = (workplacejob_searchmessages select _searchjob);
	_searchobj      = (workplacejob_searchobjects  select _searchjob);
	searchname      = (workplacejob_searchnamearray select _searchjob);
	_objposarray    = workplacejob_searchpos select (floor(random(count workplacejob_searchpos)));
	_objectlogic    = _objposarray select 0;
	_objectposition = getpos (_objectlogic);
	_objectradius   = _objposarray select 1;
	_objectradius2  = _objposarray select 2;
	_searchobject   = _searchobj createVehicleLocal [((_objectposition select 0)+(random(_objectradius)-random(_objectradius))), ((_objectposition select 1)+(random(_objectradius2)-random(_objectradius2))), _objectposition select 2];

	player groupChat _searchmsg;

	_action            = 0;
	_action2	         = 0;
	_distancenachricht = 0;
	_money             = searchjobsuccess;
	cash               = searchjobsuccess;
	timetaken          = 0;
	inf		             = 0;

	searchmarker = createMarkerLocal["searchareamarker",getpos searchlogic];
	"searchareamarker" setMarkerShapeLocal "ELLIPSE";
	"searchareamarker" setMarkerSizeLocal [250, 250];
	"searchareamarker" setMarkerBrushLocal "SolidBorder";
	"searchareamarker" setMarkerAlphaLocal 0.5;

	searchmarker2 = createMarkerLocal["searchareamarker2",getpos searchlogic];
	"searchareamarker2" setMarkerTypeLocal "mil_dot";
	"searchareamarker2" setMarkerTextLocal searchname;
	"searchareamarker2" setMarkerShapeLocal "ICON";
	
	[player,"GC_Search",[_searchmsg,"Find the object","SEARCH AREA"],"searchareamarker2",true] call BIS_fnc_taskCreate;

	veh = vehicle player;
	workplace_searchaction_cancel = -1;
	searchinfoaction = -1;

	while {true} do {
		if (((player distance workplace_getjobflag_1 <= 5) or (player distance workplace_getjobflag_2 <= 5) or (player distance workplace_getjobflag_3 <= 5)) and (alreadygotaworkplacejob == 2 and _action == 0)) then {
			workplace_searchaction_cancel = player addAction [localize "STRS_workplacemission_addaction_searchjob_cancel", "search.sqf", ["canceljob_search", _searchobject,searchmarker,searchmarker2]];
			_action = 1;
		};

		if (player distance workplace_getjobflag_1 > 8 and player distance workplace_getjobflag_2 > 8 and player distance workplace_getjobflag_3 > 8) then {
			player removeAction workplace_searchaction_cancel;
			_action = 0;
		};

		if (alreadygotaworkplacejob == 0 and _action == 1) then {
			player removeAction workplace_searchaction_cancel;
			_action = 0;
		};

		if (vehicle player != player and _action2 == 1) then {
			player removeaction searchinfoaction;
			veh = vehicle player;
			searchinfoaction = veh addAction ["Toggle search mission info", "search.sqf", ["info"]];
			_action2 = 0;
		};

		if (vehicle player == player and _action2 == 0) then {
			veh removeaction searchinfoaction;
			searchinfoaction = player addAction ["Toggle search mission info", "search.sqf", ["info"]];
			_action2 = 1;
		};

		if ((player distance _searchobject < 15) and (_distancenachricht == 0)) then {
			player groupChat localize "STRS_workplacemission_searchjob_targetreached";
			_distancenachricht = 1;
		};

		if (player distance _searchobject >= 15) then {
			_distancenachricht = 0;

		};

		if ((player distance _searchobject) < 7) exitWith {
			player removeaction finishsearchjobaction;

			veh removeaction searchinfoaction;
			player removeaction searchinfoaction;

			deletevehicle _searchobject;

			player groupChat format[localize "STRS_workplacemission_search_finish", (_money call ISSE_str_IntToStr)];

			['cash', _money] call INV_AddInventoreItem;

			alreadygotaworkplacejob = 0;
			deleteMarkerLocal "searchareamarker";
			deleteMarkerLocal "searchareamarker2";
			["GC_Search", "SUCCEEDED"] call BIS_fnc_taskSetState;

		};

		if (_money > searchjobmin and player distance searchlogic < 200) then {_money = _money - 100; cash = _money};

		if (alreadygotaworkplacejob == 0) exitWith {
			deleteMarkerLocal "searchareamarker";
			deleteMarkerLocal "searchareamarker2";
		};

		if(player distance searchlogic < 250)then{timetaken = timetaken + 1};

		sleep 0.5;
		deleteMarkerLocal "searchareamarker";
		deleteMarkerLocal "searchareamarker2";
		sleep 0.5;
		markerstr = createMarkerLocal["searchareamarker",getpos searchlogic];
		"searchareamarker" setMarkerShapeLocal "ELLIPSE";
		"searchareamarker" setMarkerSizeLocal [250, 250];
		"searchareamarker" setMarkerBrushLocal "SolidBorder";
		"searchareamarker" setMarkerAlphaLocal 0.5;
		markerstr2 = createMarkerLocal["searchareamarker2",getpos searchlogic];
		"searchareamarker2" setMarkerTypeLocal "mil_dot";
		"searchareamarker2" setMarkerTextLocal searchname;
		"searchareamarker2" setMarkerShapeLocal "ICON";
	};
};

if (_option == "canceljob_search") then {
	veh removeaction searchinfoaction;
	player removeaction searchinfoaction;
	deletevehicle ((_this select 3) select 1);
	player groupChat "You have quit your search job!";
	alreadygotaworkplacejob = 0;
	player REMOVEACTION workplace_searchaction_cancel;
	deleteMarkerLocal ((_this select 3) select 2);
	deleteMarkerLocal ((_this select 3) select 3);
	deleteMarkerLocal searchmarker2;
	deleteMarkerLocal "searchareamarker";
	deleteMarkerLocal "searchareamarker2";
	["GC_Search", "CANCELED"] call BIS_fnc_taskSetState;
	workplacejob_search_cancel = 1;
	sleep (workplacejob_search_cancel*60);
	workplacejob_search_cancel = 0;
};

if (_option == "info") then {
	if(inf == 0)then{inf=1}else{inf=0; hint "";};

	while{inf == 1 and alreadygotaworkplacejob == 2 and alive player} do {
		hintsilent format["Find: %1\nTime taken: %2 seconds\nPay: $%3", searchname, timetaken, cash];
		sleep 1;
	};

	inf=0;
};