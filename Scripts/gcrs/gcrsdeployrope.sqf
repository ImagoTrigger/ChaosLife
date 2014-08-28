// GeneralCarver Repel Script
// Deploy Rope Script
// Version: v1, 10/14/09
// Description: This script deploys the rappeling rope from the chopper. It creates a series of flag poles attached to the chopper depending on its class. Safe guards are put it to ensure the chopper is within the limits to deploy the ropes.




// ======================================================================================
// Define Variables
// ======================================================================================


private ["_playervehclass","_vehiclepos"];
gcrsrepelvehicle = vehicle player;
_playervehclass = typeof gcrspilotvehicle;
_vehiclepos = getpos vehicle player;




// ======================================================================================
// Check is the player's chopper is within the limits for deploying the rope
// ======================================================================================

if (velocity vehicle player select 0 > 5) exitWith
	{
	hint "Unable to deploy rapel ropes. Your vehicle is not stationary.";
	};
	
if (velocity vehicle player select 0 < -5) exitWith
	{
	hint "Unable to deploy rapel ropes. Your vehicle is not stationary.";
	};

if (velocity vehicle player select 1 > 5) exitWith
	{
	hint "Unable to deploy rapel ropes. Your vehicle is not stationary.";
	};
	
if (velocity vehicle player select 1 < -5) exitWith
	{
	hint "Unable to deploy rapel ropes. Your vehicle is not stationary.";
	};
	
if (velocity vehicle player select 2 > 5) exitWith
	{
	hint "Unable to deploy rapel ropes. Your vehicle is not stationary.";
	};

if (velocity vehicle player select 2 < -5) exitWith
	{
	hint "Unable to deploy rapel ropes. Your vehicle is not stationary.";
	};

if (_vehiclepos select 2 > 100) exitWith
	{
	hint "Unable to deploy rapel ropes. Your vehicle is not between 25 and 100 feet altitude above the surface below you.";
	};

if (_vehiclepos select 2 < 25) exitWith
	{
	hint "Unable to deploy rapel ropes. Your vehicle is not between 25 and 100 feet altitude above the surface below you.";
	};
	
	

	
_alt = _vehiclepos select 2;
_poles = round(_alt / 2.18);
gcrsrope0 = createVehicle ["Pole_F", [0,0,0], [], 0, "NONE"];
gcrsrope0 attachto [gcrsrepelvehicle,[0,0,-1]];		
gcrsrope0 enablesimulation false;
for "_c" from 1 to _poles do {
	_zmod = (_c * 2.2) *-1;
	call compile format['
		gcrsrope%1 = createVehicle ["Pole_F", [0,0,0], [], 0, "NONE"];
		gcrsrope%1 attachto [gcrsrepelvehicle,[0,0,_zmod]];		
		gcrsrope%1 enablesimulation false;
	',_c,_zmod];
	sleep 0.08;
};

gcrsropedeployed = "true";
format['if (vehicle player == %1) then {hint "Rapel Rope Deployed";};',gcrsrepelvehicle] call broadcast;
	
	
	
// ======================================================================================
// Rope is deployed. Add player vehicle to global variable containing list of choppers with rope deployed and publically transmist across network.
// ======================================================================================

gcrsplayerveharray = [vehicle player];
gcrsrapelheloarray = gcrsrapelheloarray + gcrsplayerveharray;
publicvariable "gcrsrapelheloarray";