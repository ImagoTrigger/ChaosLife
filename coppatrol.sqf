private ["_newmarker","_markerlocation","_plocation","_distance","_moneyearned","_markerobj","_markername","_selection"];
_selection = ((_this select 3)select 0);

_moneyearned = 0;
_distance = 0;


if (_selection == "start") then
{

pmissionactive = true;
deleteMarkerLocal "patrolmarker";


_newmarker = (floor(random(count coppatrolarray)));
_markerlocation = (coppatrolarray select _newmarker);
		
_markerobj = createmarkerlocal ["patrolmarker",[0,0]];
_markername = "patrolmarker";
_markerobj setmarkershapelocal "Icon";
//"patrolmarker" setMarkerBrushLocal "solid";
"patrolmarker" setmarkertypelocal "mil_warning";
"patrolmarker" setmarkercolorlocal "coloryellow";
"patrolmarker" setmarkersizelocal [1, 1];
"patrolmarker" setmarkertextlocal "Patrol point";
_markername Setmarkerposlocal _markerlocation;
        
player sidechat "Your patrol mission will be available shortly, simply get to the patrol point, time is not a factor in how large the payment is.";

sleep 2;
_plocation = getpos player;
_distance = _plocation distance _markerlocation;
[player,"GC_Patrol",["Get to the patrol point, time is not a factor in how large the payment is.","Reach the patrol point","PATROL POINT"],"patrolmarker",true] call GC_createLocalTask;
while {pmissionactive} do

	{

	if (player distance _markerlocation <= 30) then 
		{
		["GC_Patrol", "SUCCEEDED"] call BIS_fnc_taskSetState;
		deleteMarkerLocal "patrolmarker";
		_moneyearned = (ceil(_distance * patrolmoneyperkm));
		Kontostand = Kontostand + _moneyearned;
		player sidechat format["You earned $%1 for patroling", _moneyearned];		
		player sidechat "please wait a moment for a new patrol point";
	
		sleep 5;
	
		_newmarker = (floor(random(count coppatrolarray)));
		_markerlocation = (coppatrolarray select _newmarker);
		_plocation = getpos player;
		_distance = _plocation distance _markerlocation;
		while {_distance <= 150} do {
			_newmarker = (floor(random(count coppatrolarray)));
			_markerlocation = (coppatrolarray select _newmarker);
			_plocation = getpos player;
			_distance = _plocation distance _markerlocation;		
		};
		
		_markerobj = createmarkerlocal ["patrolmarker",[0,0]];
		_markername = "patrolmarker";
		_markerobj setmarkershapelocal "icon";
		//"patrolmarker" setMarkerBrushLocal "solid";
		"patrolmarker" setmarkertypelocal "mil_warning";
		"patrolmarker" setmarkercolorlocal "coloryellow";
		"patrolmarker" setmarkersizelocal [1, 1];
		"patrolmarker" setmarkertextlocal "Patrol point";
		_markername Setmarkerposlocal _markerlocation;
		[player,"GC_Patrol",["Get to the patrol point, time is not a factor in how large the payment is.","Reach the patrol point","PATROL POINT"],"patrolmarker",true] call GC_createLocalTask;
		player sidechat "New Patrol point added";
		

		
	
		};

	sleep 5;
	};
deleteMarkerLocal "patrolmarker";



};

if (_selection == "end") then
{
["GC_Patrol", "CANCELED"] call BIS_fnc_taskSetState;
pmissionactive = false;	
deleteMarkerLocal "patrolmarker";
player sidechat "Patrol mission ended you must wait 60 seconds to get a new one.";
patrolwaittime = true;
sleep 60;
patrolwaittime = false;

};


