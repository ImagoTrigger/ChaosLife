private ["_i","_queue","_list","_loopcount"];
fqueue = nil;
_loopcount = 0;
sleep 5; //wait to ensure we get all stats first
while {true} do {
	if (count factory_busy_array == 0 and _loopcount >= 3600) exitWith {};
	_loopcount = _loopcount + 1;
	//factory work
	{
		_queue = (_x select 8);
		_list  = _x select 5;
		call compile format['if (count %1 > 0) then { fqueue = %1; };', _queue];
		if (!isNil "fqueue") then {
			if ((count fqueue) > 0) then {
				call compile format['
					if ((factory_busy_array select _forEachIndex) == 0 and %3workers > 0) then {
						%1prod = %1prod + 1;
						%1pend = %1pend - 1;
						%1eta = %2;
						if (%1eta > maxmanitime) then {%1eta = maxmanitime};
						%1eta = %1eta/(%3workers/5);
						if (%1eta > maxmanitime) then {%1eta = maxmanitime};
						factory_busy_array set [_forEachIndex,1];
					} else {
						if (%3workers > 0) then {
							%1eta = %1eta - 1;
							if(%1eta <= 0) then {
								%1eta = 0;
								%1prod = %1prod - 1;
								%1avail = %1avail + 1;
								["%1pend", %1pend] call ClientSaveVar;
								%3 set [0, 0];
								%3 = %3 - [0];
								factory_busy_array set [_forEachIndex,0];
								["%3", %3] call ClientSaveVar;
								["%1avail", %1avail] call ClientSaveVar;
								player groupchat "A %4 is now available at one of your factories!";
							};
						};
					};
				', (fqueue select 0), round(((fqueue select 0) call INV_getitemBuyCost)*.01125), _queue, ((fqueue select 0) call INV_getitemname)];
			};
		};
		fqueue = nil;
	} forEach INV_ItemFabriken;
	sleep 1;
};
diag_log text format["flushing %1",__FILE__];
execVM "gc\client\GC_Work.sqf";