// mount_vcl.sqf
// © JUNE 2009 - norrin (norrin@iinet.net.au)
//modified by DOA for GC Chaos Life 2013 <imagotrigger@gmail.com>
_vcl 			= _this select 0;
_caller			= _this select 1;
_typeOfVcl		= _this select 3;
_dir			= getdir _vcl;
_mountVcl 		= objNull; 
_blogs			= 0; 
_c				= 0;

if (count nearestObjects [player, _typeOfVcl, 12] > 0) then
{
	_mountVcl = nearestObjects [player, _typeOfVcl, 12] select 0;
}; 

if (vehicle _caller != _caller) then {_caller action ["GetOut", vehicle _caller]; sleep 1;};

format ["%1 switchmove ""AinvPknlMstpSlayWrflDnon_medic"";", player] call broadcast;
sleep 4;
waituntil {sleep 0.1; animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};


if (!((_vcl getVariable "mount") select 0)) then {
	_pos = [0.0,-1.65,0.80];
	if (_mountVcl iskindof "Quadbike_01_base_F") then {
		_pos = [0.0,-1.45,0.80];
	};
	if (_mountVcl iskindof "Bicycle") then {
		_pos = [0.0,-1.4,0.27];
	};
	_mountVcl attachTo [_vcl,_pos]; 
	
	sleep 0.1;
	_vcl setVariable ["mount", [true, _mountVcl], true];
	_mountVcl setvariable["mountedon",_vcl,true];
};

if (true) exitWith {};
