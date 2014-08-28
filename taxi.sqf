_art = ((_this select 3) select 0);

if (isNil "INV_LocalTaxiKunde" ) then {INV_LocalTaxiKunde = player};
if (isNil "workplacejob_taxi_sperre") then {workplacejob_taxi_sperre = false};
if (isNil "workplacejob_taxi_kundebeginn") then {workplacejob_taxi_kundebeginn = false};
if (isNil "workplacejob_taxi_kundeactive") then {workplacejob_taxi_kundeactive = false};
if (isNil "workplacejob_taxi_active") then {workplacejob_taxi_active = false};

if (_art == "getajob_taxi") then {
	if (workplacejob_taxi_sperre) exitWith {
		player groupChat format [localize "STRS_workplacemission_taxi_alreadyinuse",workplacejob_taxi_sperrzeit];
	};

	workplacejob_taxi_active = true;
	workplacejob_taxi_sperre = true;

	while {true} do {
		_startzahl 		= (floor(random(count workplacejob_taxi_zielarray)));
		_zielzahl 		= (floor(random(count workplacejob_taxi_zielarray)));
		_start    		= (workplacejob_taxi_zielarray select _startzahl);
		_ziel 			= (workplacejob_taxi_zielarray select _zielzahl);
		_spielerstart     	= getPos (vehicle player);

		while {true} do {
			_startzahl 		= (floor(random(count workplacejob_taxi_zielarray)));
			_zielzahl 		= (floor(random(count workplacejob_taxi_zielarray)));
			_start    		= (workplacejob_taxi_zielarray select _startzahl);
			_ziel 			= (workplacejob_taxi_zielarray select _zielzahl);

			if (_zielzahl != _startzahl and ((_spielerstart distance _start)+(_start distance _ziel)) < taximaxdistance and ((_spielerstart distance _start)+(_start distance _ziel)) > taximindistance) exitWith {};
		};

		_taxizeit = time;
		_civ 	    = civprostitutearray select round random(count civprostitutearray - 1);

		call compile format ["'%1' createUnit [[(_start select 0),(_start select 1),0], group player, ""%2taxikunde = this; removeVest this; removeHeadgear this; removeGoggles this; removeallitems this; removeallweapons this; this unassignitem ""NVGoggles""; this setVehicleVarName """"%2taxikunde""""; this disableAI """"MOVE""""; this disableAI """"TARGET"""";""]; [%2taxikunde] join grpNull;", _civ, player];

		format["workplacejob_taxi_serverarray + [%1, %1taxikunde];", player] call broadcast;

		_markerobj = createMarkerLocal ["taxikundenmarker",[0,0]];
		_markername= "taxikundenmarker";
		_markerobj setMarkerShapeLocal "ICON";
		"taxikundenmarker" setMarkerTypeLocal "mil_marker";
		"taxikundenmarker" setMarkerColorLocal "ColorYellow";
		"taxikundenmarker" setMarkerTextLocal localize "STRS_workplacemission_taxi_marker_kunde";
		_markername SetMarkerPosLocal _start;
		[player,"GC_Taxi",["A Passenger waits for you. Drive up to him and he'll get in automatically.","Pickup your fare","PICKUP FARE"],"taxikundenmarker",true] call GC_createLocalTask;
		player groupChat localize "STRS_workplacemission_taxi_begin";

		while {true} do {
			sleep 1;
			INV_LocalTaxiKunde = player;
			call compile format["INV_LocalTaxiKunde = %1taxikunde", player];

			if ((player != (vehicle player)) and (((vehicle player)) distance INV_LocalTaxiKunde < 30) and ((speed ((vehicle player))) < 2) and (not(workplacejob_taxi_kundeactive))) then {
				player groupChat localize "STRS_workplacemission_taxi_wannagetin";
				if (((vehicle player) emptyPositions "cargo") > 0) then {
					format["%1 assignAsCargo %2; [%1] orderGetIn true;", INV_LocalTaxiKunde, (vehicle player) ] call broadcast;

					workplacejob_taxi_kundeactive = true;
					_warte = time;
					waitUntil {(INV_LocalTaxiKunde in vehicle player) or ((_warte+10)<time) or (INV_LocalTaxiKunde distance (vehicle player) <3)};

					if ((not(INV_LocalTaxiKunde in vehicle player)) and (player != (vehicle player))) then {
						format["%1 moveInCargo %2",INV_LocalTaxiKunde, (vehicle player)] call broadcast;
						["GC_Taxi", "SUCCEEDED"] call BIS_fnc_taskSetState;
					};

					if (not(workplacejob_taxi_kundebeginn)) then {
						player groupChat localize "STRS_workplacemission_taxi_target";
						workplacejob_taxi_kundebeginn = true;
						_markername setMarkerPosLocal _ziel;
						"taxikundenmarker" setMarkerTextLocal localize "STRS_workplacemission_taxi_marker_ziel";
						[player,"GC_Taxi2",["Bring your fare to the position marked on the map!","Deliver your fare","DELIVER FARE"],"taxikundenmarker",true] call GC_createLocalTask;
						
					};

				} else {
					player groupChat localize "STRS_workplacemission_taxi_nospace";
				};
			};

			if (player == vehicle player and workplacejob_taxi_kundeactive) then {
				format["%1 action [""getOut"", (%2)]; unassignVehicle %1;",INV_LocalTaxiKunde,(vehicle player)] call broadcast;
				workplacejob_taxi_kundeactive = false;
			};

			if (player != vehicle player and vehicle player distance _ziel < 30 and speed vehicle player < 2 and workplacejob_taxi_kundeactive and INV_LocalTaxiKunde in vehicle player) exitWith {
				_cash = ((500 max(round((((_spielerstart distance _start)+(_start distance _ziel))*workplacejob_taxi_multiplikator)-(time-_taxizeit))))min workplacejob_taxi_maxmoney);
				if (_cash < 0) then {_cash = 0};
				['cash', _cash] call INV_AddInventoreItem;
				player groupChat format [localize "STRS_workplacemission_taxi_success",_cash];
				format["%1 action [""getOut"", (%2)]; unassignVehicle %1;",INV_LocalTaxiKunde,(vehicle player)] call broadcast;
				sleep 5;
				format["%1 doMove [(%2 select 0),(%2 select 1),0];", INV_LocalTaxiKunde, _ziel] call broadcast;
				["GC_Taxi2", "SUCCEEDED"] call BIS_fnc_taskSetState;
				sleep ((random 10)+5);
			};

			if (!alive player or !alive INV_LocalTaxiKunde) exitWith {
				player groupChat localize "STRS_workplacemission_taxi_failure";
				["GC_Taxi", "FAILED"] call BIS_fnc_taskSetState;
				["GC_Taxi2", "FAILED"] call BIS_fnc_taskSetState;
				sleep 5;
			};

			if (!workplacejob_taxi_active) exitWith {
				player groupChat localize "STRS_workplacemission_taxi_canceled";
				["GC_Taxi", "CANCELED"] call BIS_fnc_taskSetState;
				["GC_Taxi2", "CANCELED"] call BIS_fnc_taskSetState;
				sleep 10;
			};

			if (!workplacejob_taxi_kundebeginn) then {
				_markername SetMarkerPosLocal getPos INV_LocalTaxiKunde;
			};
		};

		deleteVehicle INV_LocalTaxiKunde;
		deleteMarkerLocal _markername;
		workplacejob_taxi_kundeactive = false;
		workplacejob_taxi_kundebeginn = false;
		if (isNull(INV_LocalTaxiKunde)) exitWith {};
		if (!alive player or !workplacejob_taxi_active)exitWith{};
	};

	sleep ((workplacejob_taxi_sperrzeit)*60);
	workplacejob_taxi_active = false;
	workplacejob_taxi_sperre = false;
};

if (_art == "canceljob_taxi") then {workplacejob_taxi_active = false};