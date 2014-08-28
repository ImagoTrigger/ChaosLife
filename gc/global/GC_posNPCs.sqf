diag_log format["%1 %2",__FILE__,diag_ticktime];
//keep npcs and crates in right spot
{
	(_x select 2) setPosASL (_x select 0);
	if (!((_x select 2) in sitNPCs)) then {
		(_x select 2) setDir (_x select 1);
	};
	{
		_x allowdamage false;
		if (_x isKindOf "House") then {
			for "_i" from 1 to 22 do
			{
				_x animate [("Door_"+str(_i)+"_rot"),1]; //open doors
			};		
		};
	} foreach nearestobjects[(_x select 2),["House","Building","Structure"],15];
} forEach life_objects;
diag_log format["%1 %2 %3",__FILE__,count life_objects,diag_ticktime];