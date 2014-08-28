//DOA <imagotrigger@gmail.com> for Chaos Life
private ["_foundani","_foundveh","_foundobj","_loopcount","_nearby","_foundevi","_foundsla","_foundspi","_turtles","_players","_snakes","_rabbits","_sheep"];
_loopcount = 1;
_nearby = [
	"LandVehicle", "Air", "Ship",
	"Land_bagfence_corner_F","Land_bagfence_long_F","Land_bagfence_round_F","Land_BagBunker_small_F","Land_Sign_Mines_F",
	"O_HMG_01_F","O_GMG_01_F","O_Mortar_01_F","B_HMG_01_F","B_GMG_01_F","B_Mortar_01_F","I_static_AT_F","I_static_AA_F",
	"Snake_random_F","Sheep_random_F","Rabbit_F","Turtle_F"
] + fishtypes;
if (iscop) then {
	_nearby = _nearby + [
		"groundWeaponHolder",
		"Land_BarGate_F","Land_Crash_barrier_F","RoadCone_L_F","Land_HBarrier_5_F",
		"Land_Razorwire_F"
	];
	_nearby = _nearby + civprostitutearray;
};
while {_loopcount <= 3600} do {
	_foundveh = false;
	_foundani = false;
	_foundobj = false;
	_foundevi = false;
	_foundsla = false;
	_foundspi = false;
	if (alive player and isdead == 0 and deadcam == 0) then {
		{
			if (_x isKindOf "Animal") then {_foundani = true;};
			if (_x isKindOf "LandVehicle" or _x isKindOf "Air" or _x isKindOf "Ship") then {_foundveh = true;};
			if (_x isKindOf "Land_bagfence_F" or _x isKindOf "Land_BagBunker_small_F" or _x isKindof "Land_Sign_Mines_F") then {_foundobj = true;};
			if (iscop) then {
				if (_x isKindOf "groundWeaponHolder") then {_foundevi = true;};
				if (_x isKindOf "Land_BarGate_F" or _x isKindOf "Land_Crash_barrier_F" or _x isKindOf "RoadCone_L_F" or _x isKindOf "Land_HBarrier_5_F") then {_foundobj = true;};
				if (_x isKindOf "O_helipilot_F") then {_foundsla = true;};
				if (_x isKindOf "Land_Razorwire_F" and damage _x >= 0.9) then {_foundspi = true;};
			};
		} forEach nearestObjects [player,_nearby, 6];
	};
	if (_foundveh) then {near_vehicles = true;} else {near_vehicles = false;};
	if (_foundobj) then {near_objects = true;} else {near_objects = false;};
	if (_foundani) then {near_animals = true;} else {near_animals = false;};
	if (_foundevi) then {near_evidence = true;} else {near_evidence = false;};
	if (_foundsla) then {near_slaves = true;} else {near_slaves = false;};
	if (_foundspi) then {near_spikes = true;} else {near_spikes = false;};

	_loopcount = _loopcount + 1;
	sleep 1;
};
diag_log text format["flushing %1",__FILE__];
execVM "gc\client\GC_Nearby.sqf";