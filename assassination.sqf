// new version of assassin mission with vip and guards armed, car,  new spawn locations, bug fixes and more stability by Scripter Eddie Vedder
_secondcounter = 0;
_minutecounter = 0;
_art = (_this select 3) select 0;

if (isNil "workplacejob_assassin_serverarray") then {workplacejob_assassin_serverarray = []};

if (_art == "getajob_assassin") then

{

if(workplacejob_assassin_active)exitWith{player groupChat "There are currently no targets that require assassination.";};
if(workplacejob_assassion_failed)exitWith{player groupChat "You have failed an assassination recently, maybe you'll be hired again later.";};

_array  = [[VIPspawn1, 10], [VIPspawn2, 10], [VIPspawn3, 10], [VIPspawn4, 10], [VIPspawn5, 10]];
_city   = (floor(random(count _array)));
_pos    = (_array select _city) select 0;
_radius = (_array select _city) select 1;
_a1	= 0;

//delete any left overs from last time this ran
deletemarker "targetmarker";
deletevehicle VIPtarget;
'assveh removeaction ass_action;' call broadcast;
deletevehicle assveh;
deletevehicle VIPbodyguard1;
deletevehicle VIPbodyguard2;

//creating VIP
_group = createGroup RESISTANCE;
VIPtarget = _group createUnit ["I_Soldier_TL_F", _pos, [], _radius, "FORM"];
VIPtarget setVehicleVarName "VIPtarget";
VIPtarget setskill 1;
publicVariable "VIPtarget";

//creating body guards
VIPbodyguard1 = _group createUnit ["I_Soldier_F", _pos, [], _radius, "FORM"];
 VIPbodyguard1 setVehicleVarName "VIPbodyguard1";
VIPbodyguard1 setskill 1;

VIPbodyguard2 = _group createUnit ["I_Soldier_F", _pos, [], _radius, "FORM"];
VIPbodyguard2 setVehicleVarName "VIPbodyguard2";
VIPbodyguard2 setskill 1;


// make viptargets car
assveh = createVehicle ["I_Truck_02_covered_F", _pos, [] , 3, "NONE"];
assveh setVehicleVarName "assveh";
assveh setVehicleLock "locked";
assveh setAmmoCargo 0;
publicvariable "assveh";
// put vip inside the car
if ((!(VIPtarget in assveh)) and (alive VIPtarget))
	then{
		VIPtarget moveInDriver assveh;
		VIPbodyguard1 doFollow VIPtarget;
		VIPbodyguard2 doFollow VIptarget;

		//VIPtarget assignAsDriver assveh;
		VIPbodyguard1 moveInCargo assveh;
		//VIPbodyguard1 assignAsCargo assveh;
		VIPbodyguard2 moveInCargo assveh;
		//VIPbodyguard2 assignAsCargo assveh;


	};



assveh spawn {
	sleep 0.35;
	format['
		ass_action = %1 addaction ["Escort VIP", "gc\client\GC_FNC_noScript.sqf", "[VIPtarget] join (group player); player groupchat ""Escort the VIP to the police base before he is assassinated!"";",1,false,true,"","_this distance VIPtarget < 5"];
	',_this] call broadcast;
};

format["workplacejob_assassin_serverarray = workplacejob_assassin_serverarray + [[%1, VIPtarget]];", player] call broadcast;

_markerobj = createMarker ["targetmarker",[0,0]];
_markername= "targetmarker";
_markerobj setMarkerShape "ICON";
"targetmarker" setMarkerType "mil_marker";
"targetmarker" setMarkerColor "ColorRed";
"targetmarker" setMarkerText "Assassination target";
_markername SetMarkerPos getpos VIPtarget;

workplacejob_assassin_active = true; publicvariable "workplacejob_assassin_active";

[player,"GC_VIP",["Kill the VIP before the police can take him to safety.","Kill the VIP","KILL VIP"],[VIPtarget,true],true] call GC_createLocalTask;
[WEST,"GC_VIP_cop",["Someone is trying to kill a government VIP.  Reach the target before its too late!","Escort the VIP","ESCORT VIP"],[VIPtarget,true],true] call BIS_fnc_taskCreate;

player groupChat "The VIP target has been marked on the map. Kill him before the police can take him to safety.";

"if (iscop) then {player sideChat ""Someone is trying to kill a government VIP. The target has been marked on the map. Rescue the target before its too late!""};" call broadcast;

player groupchat "The police are on to you and the VIP knows your coming, hurry up!";
(format['["AssassinAttempt", %1] spawn Isse_AddCrimeLogEntry;if(!("Assassin" in %1_reason))then{%1_reason = %1_reason + ["Assassin"]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 50000;', player]) call broadcast;
VIPtarget domove getmarkerpos "policebase";
_group setSpeedMode "LIMITED";
while {true} do

	{

	/* removed this so the mission keeps going even if assassin dies
	if(!alive player)exitwith
		{
		deletevehicle VIPtarget;
		deletemarker "targetmarker";

		};
	*/
	"if(alive player and isciv and player distance (vehicle VIPtarget) <= 90)then{titleText [""The Government is operating in this area! Turn back or you will be shot!"", ""plain down""]};" call broadcast;
	"targetmarker" setmarkerpos getpos VIPtarget;
	if (_secondcounter >= 15) then
		{
		_group setBehaviour "AWARE";
		_group setSpeedMode "LIMITED";
		VIPtarget domove getmarkerpos "policebase";
		_secondcounter = 0;
		};

	if (_minutecounter >= 1800) exitWith

		{
		["AssassinFail", player, "expired"] spawn Isse_AddCrimeLogEntry;
		"server globalchat ""Assassination mission not completed within 30 minutes, the mission has ended."";" call broadcast;
		sleep 3;
		deletevehicle VIPtarget;
		deletemarker "targetmarker";
		'assveh removeaction ass_action;' call broadcast;
		deletevehicle assveh;
		deletevehicle VIPbodyguard1;
		deletevehicle VIPbodyguard2;
		_minutecounter = 0;
		["GC_VIP", "CANCELLED"] call BIS_fnc_taskSetState;
		["GC_VIP_cop", "CANCELLED"] call BIS_fnc_taskSetState;	
		};

	if (!alive VIPtarget and alive player) exitWith

		{

		kontostand = kontostand + 100000;
		player groupchat "Well done. Target elimated. $100000 has been transfered to your account.";
		sleep 10;
		"server globalchat ""The VIP target has been killed!"";" call broadcast;
		(format['["AssassinSuccess", %1] spawn Isse_AddCrimeLogEntry; if(!("Assassinated VIP" in %1_reason))then{%1_reason = %1_reason + ["Assassinated VIP"]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 25000;', player]) call broadcast;
		deletevehicle VIPtarget;
		deletemarker "targetmarker";
		'assveh removeaction ass_action;' call broadcast;
		deletevehicle assveh;
		deletevehicle VIPbodyguard1;
		deletevehicle VIPbodyguard2;
		["GC_VIP", "SUCCEEDED"] call BIS_fnc_taskSetState;
		["GC_VIP_cop", "FAILED"] call BIS_fnc_taskSetState;
		};

	if(vehicle VIPtarget in list CopBaseTrigger) exitwith

		{
		["AssassinFail", player, "rescued"] spawn Isse_AddCrimeLogEntry;
		"
		server globalchat ""The VIP target has been rescued!"";
		_copplayernumber = playersNumber west;
		_copbonus = 40000;
		if (iscop) then {Kontostand = (Kontostand + _copbonus); player sidechat format[""you received $%1 for the successful rescue of the VIP"", _copbonus];};
		" call broadcast;
		sleep 2;
		player groupchat "The vip was rescued, mission failed!";
		workplacejob_assassion_failed = true;
		deletevehicle VIPtarget;
		deletemarker "targetmarker";
		'assveh removeaction ass_action;' call broadcast;
		deletevehicle assveh;
		deletevehicle VIPbodyguard1;
		deletevehicle VIPbodyguard2;
		["GC_VIP_cop", "SUCCEEDED"] call BIS_fnc_taskSetState;
		["GC_VIP", "FAILED"] call BIS_fnc_taskSetState;		

		};
	_minutecounter = _minutecounter + 1;
	_secondcounter = _secondcounter + 1;
	sleep 1;

	};
deletevehicle VIPtarget;
deletemarker "targetmarker";
'assveh removeaction ass_action;' call broadcast;
deletevehicle assveh;
deletevehicle VIPbodyguard1;
deletevehicle VIPbodyguard2;
sleep ((workplacejob_assassin_break)*60);
workplacejob_assassin_active = false;
publicvariable "workplacejob_assassin_active";

if (workplacejob_assassion_failed) then

	{

	sleep ((workplacejob_assassin_break)*60);
	workplacejob_assassion_failed = false;

	};

};








// written by eddie vedder
