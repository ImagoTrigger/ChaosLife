// GeneralCarver Repel Script
// Rappel Script
// Version: v1, 10/14/09
// Description: This script rappels the player from the chopper. First it checks the vehicle class of the player's helocopter to determine their decent position. Next it ejects the player and rapel's him. Finally, it checks if the player as AI subordinates and rapels them also.


// ======================================================================================
// Define inital variables
// ======================================================================================


private ["_i","_vehclass","_xpos","_ypos","_initheight","_initheightasl","_endingheight","_parachute"];
_vehclass = typeof vehicle player;
_xpos = getpos vehicle player select 0;
_ypos = getpos vehicle player select 1;
	

	
	
// ======================================================================================
// Rappel Player
// ======================================================================================

_initheight = getpos vehicle player select 2;
_initheightasl = getposasl vehicle player select 2;
_endingheight = _initheightasl - _initheight;
player action ["getout", vehicle player];
moveOut player;
//waitUntil {vehicle player iskindof "ParachuteBase"};
//_parachute = vehicle player;
//deletevehicle _parachute;
	
// Set position outside chopper on rope. Dependent on vehicle type.  A3 NYI TODO B_Heli_Transport_01_F","O_Heli_Light_02_unarmed_F"


player setpos [(getpos vehicle player select 0), (getpos vehicle player select 1), (getpos vehicle player select 2) - 4];
	


format['%1 switchmove "Crew"',player] call broadcast;
_i = getpos player select 2;
waitUntil {_i = getpos player select 2; _i <= 5};
player setvelocity [0,0,0];

// Set player on surface. X and Y depend on vehicle class. // A3 NYI TODO

player setposasl [_xpos, _ypos, _endingheight];

	
format['%1 switchmove "Stand"',player] call broadcast;



/*
// Below is partially working code for rapeling out a player's A.I. squad.
// All efforts during development to get this feature working failed, so it has been disabled on this release.
// However, the code is left for your reference, use or modification. Feel free to get it working if you know how.
// Code works fine tested in the editor. However, on a dedicated server the A.I. in rappel will stop in air, and sometimes die.
 
// ======================================================================================
// Rapel player's squad.
// ======================================================================================

if (leader group player == player) then
	{
	{
	if (!(isplayer _x) && (alive _x) && (vehicle _x == _veh)) then
		{
		_x action ["eject", vehicle _x];
		waitUntil {vehicle _x iskindof "ParachuteBase"};
		_parachute = vehicle _x;
		deletevehicle _parachute;
			
		// Set position outside chopper on rope. Dependent on vehicle type.

		if (_vehclass == "MH6J_EP1") then 
			{
			_x setpos [(getpos vehicle _x select 0) - 1.25, (getpos vehicle _x select 1) + 2, (getpos vehicle _x select 2) - 4];
			};
			
		if (_vehclass == "UH1H_TK_GUE_EP1") then 
			{
			_x setpos [(getpos vehicle _x select 0) - 1.25, (getpos vehicle _x select 1) - 3, (getpos vehicle _x select 2) - 4];
			};
			
		
			
		_x switchmove "Crew";
		while {getpos _x select 2 > 5} do 
			{
			_x setpos [_xpos, _ypos, (getpos _x select 2) - 1];
			sleep 0.125;
			};
		_i = getpos _x select 2;
		waitUntil {_i = getpos _x select 2; _i <= 2};
		_x setvelocity [0,0,0];
		
		// Set A.I. on surface. X and Y depend on vehicle class.

		if (_vehclass == "MH6J_EP1") then 
			{
			_x setposasl [_xpos - 1.25, _ypos + 2, _endingheight];
			};
			
		if (_vehclass == "UH1H_TK_GUE_EP1") then 
			{
			_x setposasl [_xpos - 1.25, _ypos - 3, _endingheight];
			};
			
		
		
		_x switchmove "Stand";
		}
		else
		{
		// nothing
		};
	} forEach units group player;
	};
	
*/