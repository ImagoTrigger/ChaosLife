// dismount_vcl.sqf
// © JUNE 2009 - norrin (norrin@iinet.net.au)

_vcl 			= _this select 0;
_caller			= _this select 1;
_mountVcl		= (_vcl getVariable "mount") select 1;
_vclDir			= getDir _vcl;


if (vehicle player == player) then {
	format ["%1 switchmove ""AinvPknlMstpSlayWrflDnon_medic"";", player] call broadcast;
	sleep 4;
	waituntil {sleep 0.1; animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};	
	detach _mountVcl;
	_mountVcl setPos [(getPos _vcl select 0) - (5 * sin _vclDir), (getPos _vcl select 1) - (5 * cos _vclDir), 0];
	_vcl setVariable ["mount", [false, objNull], true];
	_mountVcl setvariable["mountedon",nil,true];
};

if (true) exitWith {};