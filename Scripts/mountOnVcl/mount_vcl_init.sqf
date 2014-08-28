// mount_vcl_init.sqf
// © JUNE 2009 - norrin (norrin@iinet.net.au)
/*
	Name playable units and vehicle in the editor
	Put this in the init line of the vehicle in the editor: nul = [this] execVM "scripts\mountOnVcl\mount_vcl_init.sqf";
*/
//modified by DOA for GC Chaos Life 2013 <imagotrigger@gmail.com>
//

_vcl 		= _this select 0;
_c 		= _this select 1;

 //A3 NYI TODO
_typeOfVcl	= ["Motorcycle","Bicycle","Quadbike_01_base_F"];
_exitarray = [
	"C_Offroad_01_F",
	"B_Truck_01_transport_F",
	"O_Truck_02_transport_F",
	"I_Truck_02_transport_F",
	"I_G_Van_01_transport_F",
	"C_Van_01_transport_F",
	"B_Truck_01_transport_F"
];
if (!((typeof _vcl) in _exitarray)) exitWith {};
_toAttach 	= objNull;
diag_log format["%1 %2",__FILE__,_this];
if (isServer and _c == 0) exitWith {_vcl setVariable ["mount", [false, _toAttach], true];};

_load = _vcl addAction ["<t color=""#ED2744"">Load into truck</t>", "scripts\mountOnVcl\mount_vcl.sqf", _typeOfVcl, 0, false, true];
_unload = _vcl addAction ["<t color=""#ED2744"">Unload truck</t>", "scripts\mountOnVcl\dismount_vcl.sqf","", 0, false, true];

_vcl removeAction _load;
_vcl removeAction _unload;


while {alive _vcl} do
{
	if (!((_vcl getVariable "mount") select 0) && _c == 0 && count (nearestObjects [_vcl, ["man"], 10]) > 0 && count (nearestObjects [_vcl, _typeOfVcl, 10]) > 0) then
	{
		_load = _vcl addAction ["<t color=""#ED2744"">Load into truck</t>", "scripts\mountOnVcl\mount_vcl.sqf", _typeOfVcl, 0, false, true];
		_vcl removeAction _unload;
		_c = 1;
	};

	if (((_vcl getVariable "mount") select 0) && _c == 1) then
	{
		_unload = _vcl addAction ["<t color=""#ED2744"">Unload truck</t>", "scripts\mountOnVcl\dismount_vcl.sqf","", 0, false, true];
		_vcl removeAction _load;
		_c = 0;
	};
	if (count (nearestObjects [_vcl, ["man"], 10]) == 0 || count (nearestObjects [_vcl, _typeOfVcl, 10]) == 0) then
	{
		_vcl removeAction _load;
		_vcl removeAction _unload;
		if (!((_vcl getVariable "mount") select 0)) then {_c = 0};
		if ((_vcl getVariable "mount") select 0) then {_c = 1};
	};
	//hint format ["%1", (_vcl getVariable "mount")];
	sleep 2;
};
if (!alive _vcl) exitWith {};



