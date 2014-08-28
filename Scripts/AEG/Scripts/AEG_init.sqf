/*
    File: AEG_init.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to initialize required data and launch other scripts necessary for the AEG simulation.

    Parameters:
    _this select 0: Type of executing instance (string).

    Execution:
    Executed by a logic or other unit init line, Addon XEH, or other similar executing instance.
    This script will run on all machines (SP, MP Hosts, MP dedicated servers, and MP Clients).
    If AEG has already been initialized (by a previous instance of this script) then subsequent instances will abort to
    avoid conflicts.  This could occur if a mission maker implemented the script version of AEG in the mission and the
    player has the AEG addon version also installed.  Since the script version is executed by placing a logic or other
    unit in the editor and the addon version is executed by a PostInit XEH, the script version will execute BEFORE the
    addon version since mission.sqm init line code runs before PostInit XEHs.  This script will also abort if
    the current world is Chernarus AND both the CEG AND AEG are active in order to avoid conflicts
    and maintain backward compatibility with CEG.
*/

// Scope //
private ["_type", "_wName", "_world", "_supported"];

// Parameter(s) //
_type = (_this select 0);

 //DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_init.sqf: Thread started."] call LGD_fnc_debugMessage;};

// Check to see if the machine is a JIP MP client and store the result of the check in the global variable AEG_JIP.  Evaluate it later for action in AEG_client.sqf if the machine is a MP client.
if (isMultiplayer) then
{
    if ((!isDedicated) and (isNull player)) then
    {
        AEG_JIP = true;
    }
    else
    {
        AEG_JIP = false;
    };
    //DEBUG
    if (!isNil "AEG_DEBUG") then {_debug = ["AEG_init.sqf: MP JIP check completed. AEG_JIP =", AEG_JIP] call LGD_fnc_debugMessage;};
}
else
{
    //DEBUG
    if (!isNil "AEG_DEBUG") then {_debug = ["AEG_init.sqf: SP Detected - MP JIP check skipped."] call LGD_fnc_debugMessage;};
};

// If AEG has already been initialized (by a previous instance of this script) then abort this instance to avoid conflicts.
if (_type == "SCRIPT") then {diag_log text "AEG Script init started...";};
if (_type == "ADDON") then {diag_log text "AEG: Addon init started..."; sleep .01};
if (!isNil ("AEG_init")) exitWith {diag_log text format ["AEG: AEG %1 version is already initialized...aborting %2 version.", AEG_type, _type];};

// Record that AEG_init.sqf has been executed, the type of executing instance (MISSION or ADDON), and the version number.
AEG_init = true;
AEG_type = _type;
AEG_version = 1.01;

// Determine the currently loaded world and store it in a variable.
_wName = worldName;
_world = toUpper _wName;
_supported = true; //Default value

// Pause briefly in order to allow CEG to initialize first (if in use) in order to check for conflicts.  This pause does exist in the CEG version of this script so the CEG version will run first.
sleep 1;

// If the current world is Chernarus AND CEG is also in use, then abort and record results in the .RPT.
if ((_world == "CHERNARUS") and (!isNil "CEG_init")) exitWith
{
    diag_log text "AEG: The current world is Chernarus and CEG is already initializing/initialized...aborting AEG in order to avoid conflicts on Chernarus for this mission only.";
};

// If the world is supported by AEG, then execute the pertinent world init script that runs code necessary to create all the different objects and logical components required by the AEG simulation.   Otherwise record that the world is not supported in the .RPT file and abort.
switch (_world) do
{
    case "CHERNARUS":
    {
        _nul = [] execVM "scripts\AEG\Scripts\AEG_init_chernarus.sqf";
    };
    case "ZARGABAD":
    {
        _nul = [] execVM "scripts\AEG\Scripts\AEG_init_zargabad.sqf";
    };
    case "GC_ZARGABAD":
    {
        _nul = [] execVM "scripts\AEG\Scripts\AEG_init_zargabad.sqf";
    };
    case "UTES":
    {
        _nul = [] execVM "scripts\AEG\Scripts\AEG_init_utes.sqf";
    };
    case "TAKISTAN":
    {
        _nul = [] execVM "scripts\AEG\Scripts\AEG_init_takistan.sqf";
    };
    case "TUP_QOM":
    {
        _nul = [] execVM "scripts\AEG\Scripts\AEG_init_qom.sqf";
    };
    default
    {
      // If the current world is not listed above, then detemine that AEG does not support this world.
      _supported = false;
    };
};

// If the currently loaded world is not supported then abort AEG as it will only function on supported worlds.
if (!(_supported)) exitWith {diag_log text format ["AEG: The current mission is on %1, which is not a supported world. AEG will only function on supported worlds...aborting AEG for this mission only.", _wname];};

// Pause the script until the AEG_objects array is initialized via the pertinent world script executed above.
waitUntil {!(isNil "AEG_objects")};

// If this is SP or a server then validate that AEG is installed and initializing on the server for all machines.
if (isServer) then
{
    AEG_server = AEG_version;
    publicVariable "AEG_server";
};

// Pause briefly to allow sufficient time for the server to broadcast the status of AEG_server (if at all).
sleep 2;

// If AEG is NOT installed and initializing/initialized on the server OR the server and client versions do not match then exit immediately since AEG will not function  in MP without server components and version match.  Display a chat message for the player and record details in the .RPT file.
if ((isNil "AEG_server") or (AEG_server != AEG_version)) exitWith {player sideChat "AEG ADDON SERVER/CLIENT CONFLICT: ABORTING AEG CLIENT...YOU WILL NOT EXPERIENCE ANY OF THE EFFECTS OF AEG AS ALL AEG EFFECTS ARE LOCAL (SMOKE, SOUNDS, AND STREET LAMPS).  CHECK .RPT FOR DETAILS."; diag_log text format ["AEG: AEG must be installed on the server to function and server and client versions must match. Server version is %1, client version is %2...aborting AEG client.", AEG_server, AEG_version];};

// Add a public variable event handler to all machines that will fire when an arc flash explosion should occur as determined in AEG_actions.sqf.  When it fires, send the new PV value to the AEG_flash.sqf script.
"AEG_arc" addPublicVariableEventHandler {[(_this select 1)] execVM "scripts\AEG\Scripts\AEG_flash.sqf";};

// If the machine is SP, a MP host, or a MP dedicated server then execute AEG_server.sqf.  Otherwise it is a MP client and execute AEG_client.sqf instead.
if (isServer) then
{
    _nul = [] execVM "scripts\AEG\Scripts\AEG_server.sqf";
}
else
{
    _nul = [] execVM "scripts\AEG\Scripts\AEG_client.sqf";
};

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_init.sqf: Thread finished."] call LGD_fnc_debugMessage;};