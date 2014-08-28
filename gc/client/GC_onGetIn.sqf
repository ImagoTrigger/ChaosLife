private ["_veh"];
_veh = _this select 0;
_veh setVariable["entered",time,true];
_veh setVariable["enginepower",([(configFile >> "CfgVehicles" >> typeOf _veh), "EnginePower"] call BIS_fnc_returnConfigEntry),false];
_veh setVariable["rollspeed",([(configFile >> "CfgVehicles" >> typeOf _veh), "antiRollbarSpeedMax"] call BIS_fnc_returnConfigEntry),false];
_veh setVariable["minspeed",([(configFile >> "CfgVehicles" >> typeOf _veh), "antiRollbarSpeedMin"] call BIS_fnc_returnConfigEntry),false];
_veh setVariable["maxspeed", ([(configFile >> "CfgVehicles" >> typeOf _veh), "maxspeed"] call BIS_fnc_returnConfigEntry),false];
_veh setVariable["delay", ([(configFile >> "CfgVehicles" >> typeOf _veh), "thrustDelay"] call BIS_fnc_returnConfigEntry),false];
_veh setVariable["ship", (_veh isKindOf "Ship"),false];