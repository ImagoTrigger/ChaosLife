_secondcounter = 0;
_minutecounter = 0;
_art = (_this select 3) select 0;

if (isNil "workplacejob_hostage_serverarray") then {workplacejob_hostage_serverarray = []};

if (_art == "getajob_hostage") then

{

if(workplacejob_hostage_active)exitWith{player groupChat "There are currently no more hostages.";};
if(workplacejob_hostage_failed)exitWith{player groupChat "You have failed a hostage mission recently, maybe you can do it again later.";};

_array  = [[Hostagespawn1, 10]];
_city   = (floor(random(count _array)));
_pos    = (_array select _city) select 0;
_radius = (_array select _city) select 1;
_a1	= 0;

//delete any left overs from last time this ran
deletemarker "htargetmarker";
'hostage1 removeaction hostageaction;' call broadcast;
deletevehicle hostage1;


//creating VIP
_group = createGroup CIVILIAN;
hostage1 = _group createUnit ["C_man_1", _pos, [], _radius, "FORM"];
hostage1 setVehicleVarName "hostage1";

removebackpack hostage1;
removeVest hostage1;
removeHeadgear hostage1;
removeGoggles hostage1;
PublicVariable "hostage1";
sleep 1;

format["workplacejob_hostage_serverarray = workplacejob_hostage_serverarray + [[%1, hostage1]];", player] call broadcast;

_markerobj = createMarker ["htargetmarker",[0,0]];
_markername= "htargetmarker";
_markerobj setMarkerShape "ICON";
"htargetmarker" setMarkerType "mil_marker";
"htargetmarker" setMarkerColor "ColorRed";
"htargetmarker" setMarkerText "Hostage target";
_markername SetMarkerPos position player;

workplacejob_hostage_active = true; publicvariable "workplacejob_hostage_active";

[player,"GC_Hostage",["Don't let the police get you or the hostage for 10 minutes.","Protect your hostage","YOUR HOSTAGE"],[hostage1,true],true] call GC_createLocalTask;
[WEST,"GC_Hostage_cop",["Take the hostage to safety before it's too late!  You have 10 minutes.","Rescue the hostage","RESCUE HOSTAGE"],[hostage1,true],true] call BIS_fnc_taskCreate;

player groupChat "The Hostage is marked on the map, don't let the police get you.";

"if (iscop) then {player sideChat ""Someone is trying to take a hostage. The hostage has been marked on the map. Arrest the hostage taker before its too late!""};" call broadcast;

player groupchat "The police are on to you, hurry up!";
(format['["HostageAttempt", %1] spawn Isse_AddCrimeLogEntry; if(!("Hostage Taker" in %1_reason))then{%1_reason = %1_reason + ["Hostage Taker"]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 50000;', player]) call broadcast;
hostage1 spawn {
	sleep 0.35;
	format['
		hostageaction = %1 addaction ["Take hostage", "gc\client\GC_FNC_noScript.sqf", "[%1] join (group player); [""GC_Good2"",[""CHAOS LIFE HOSTAGE TAKER"",""Keep the hostage close or you will fail!""]] spawn bis_fnc_showNotification;",1,false,true,"","_this distance hostage1 < 5 and !(hostage1 in units group _this)"];
	',_this] call broadcast;
};

while {true} do {
	"htargetmarker" setmarkerpos getpos hostage1;
	if (_minutecounter >= 500 and alive player) exitWith
		{
		kontostand = kontostand + 250000;
		player groupchat "Well done, you kept the hostage for 10 minutes, $250000 has been transfered to your account.";
		["HostageSuccess", player] spawn Isse_AddCrimeLogEntry;
		sleep 10;
		"server globalchat ""Hostage Taker WINS, he kept the hostage for 10 minutes."";" call broadcast;
		sleep 1;
		'hostage1 removeaction hostageaction;' call broadcast;
		deletevehicle hostage1;
		deletemarker "htargetmarker";
		_minutecounter = 0;
		["GC_Hostage", "SUCCEEDED"] call BIS_fnc_taskSetState;
		["GC_Hostage_cop", "FAILED"] call BIS_fnc_taskSetState;		
		};

	if (!alive hostage1 and alive player) exitWith

		{
		["HostageKilled", player] spawn Isse_AddCrimeLogEntry;
		player groupchat "Hostage has been killed, No one WINS!!";
		sleep 5;
		"server globalchat ""The Hostage has been Killed, No one WINS!"";" call broadcast;
		//(format['if(!("Assassinated VIP" in %1_reason))then{%1_reason = %1_reason + ["Assassinated VIP"]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 25000;', player]) call broadcast;
		'hostage1 removeaction hostageaction;' call broadcast;
		deletevehicle hostage1;
		deletemarker "htargetmarker";
		["GC_Hostage", "CANCELED"] call BIS_fnc_taskSetState;
		["GC_Hostage_cop", "CANCELED"] call BIS_fnc_taskSetState;
		};

	if(hostage1 distance getmarkerpos "hostagezone" > 50) exitwith

		{
		["HostageFled", player] spawn Isse_AddCrimeLogEntry;
		"
		server globalchat ""The Hostage taker has fled the area! Cops get $10000"";
		_copplayernumber = playersNumber west;
		_copbonus = 10000;
		if (iscop) then {Kontostand = (Kontostand + _copbonus); player sidechat format[""you received $%1 for hostage taker fleeing the area"", _copbonus];};" call broadcast;
		sleep 2;
		player groupchat "You fled the area with the hostage, stay in the zone next time, mission failed!";
		workplacejob_hostage_failed = true;
		'hostage1 removeaction hostageaction;' call broadcast;
		deletevehicle hostage1;
		deletemarker "htargetmarker";
		["GC_Hostage_cop", "SUCCEEDED"] call BIS_fnc_taskSetState;
		["GC_Hostage", "FAILED"] call BIS_fnc_taskSetState;	
		};


	if(player distance hostage1 > 50) exitwith

		{
		["HostageFail", player] spawn Isse_AddCrimeLogEntry;
		"
		server globalchat ""The Hostage taker has lost!"";
		_copplayernumber = playersNumber west;
		_copbonus = 100000;
		if (iscop) then {Kontostand = (Kontostand + _copbonus); player sidechat format[""you received $%1 for the successful rescue of the hostage"", _copbonus];};" call broadcast;
		sleep 2;
		player groupchat "The Hostage was rescued, mission failed!";
		workplacejob_hostage_failed = true;
		'hostage1 removeaction hostageaction;' call broadcast;
		deletevehicle hostage1;
		deletemarker "htargetmarker";
		["GC_Hostage_cop", "SUCCEEDED"] call BIS_fnc_taskSetState;
		["GC_Hostage", "FAILED"] call BIS_fnc_taskSetState;
		};

	_minutecounter = _minutecounter + 1;
	_secondcounter = _secondcounter + 1;
	sleep 1;

	};
'hostage1 removeaction hostageaction;' call broadcast;
deletevehicle hostage1;
deletemarker "htargetmarker";

sleep ((workplacejob_hostage_break)*60);
workplacejob_hostage_active = false;
publicvariable "workplacejob_hostage_active";

if (workplacejob_hostage_failed) then

	{

	sleep ((workplacejob_hostage_break)*60);
	workplacejob_hostage_failed = false;

	};

};
