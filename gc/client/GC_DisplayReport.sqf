if (!isnil "DisplayReports" and DisplayReports) then {  //NYI allow players to toggle this on/off and save the toggle
	_this spawn {	
		private ["_report","_fps","_gangs","_weps","_cases","_parked","_date","_month","_day","_hour","_min","_groups","_infotxt","_lines1","_mrt","_rt","_pcount","_accounts","_lines2","_vehcnt","_type"];
		_type = _this select 0;
		if (_type == 0) then {
			_report = _this select 1;
			_groups = _report select 0;
			_gangs = _report select 1;
			_weps = _report select 2;
			_cases = _report select 3;
			_parked = _report select 4;
			_date = _this select 2;
			_month = _date select 1;
			_day = _date select 2;
			_hour = _date select 3;
			_min = _date select 4;	
			_infotxt = [] spawn {};
			call compile format['
				_infotxt = ["Saved %1/%2 %3:%4","%5 Groups","%6 Gangs"] spawn GC_infoText;
			',_month,_day,_hour,_min,_groups,_gangs];
			waituntil{sleep 0.1; (scriptDone _infotxt)};
			call compile format['
				["%1 Weapon/Ammo piles","%2 Dropped suitcases","%3 Parked vehicles"] spawn GC_infoText;
			',_weps,_cases,_parked];	
		};
		if (_type == 1 and chaos) then {
			_lines1 = _this select 1;
			_lines2 = _this select 2;
			_mrt = _lines1 select 0;
			_rt = _lines1 select 1;
			_pcount = _lines1 select 2;
			_accounts = _lines2 select 0;
			_vehcnt = _lines2 select 1;
			_fps = _lines2 select 2;
			_infotxt = [] spawn {};
			call compile format['
				_infotxt = ["%1 Min. runtime actual","%2 Min. mission time","%3 Players on"] spawn GC_infoText;
			',_mrt,_rt,_pcount];
			waituntil{sleep 0.1; (scriptDone _infotxt)};
			call compile format['
				["%1 Memorized accounts","%2 Created vehicles","%3 Average FPS"] spawn GC_infoText;
			',_accounts,_vehcnt,_fps];		
		};
	};
};