/*
    File: AEG_init_zargabad.sqf
    Version: 1.01
    Author: Loyalguard

    Description:
    A script to initalize and store information necessary for the AEG simulation on this world.

    Parameters:
    None.

    Execution:
    Executed from AEG_init.sqf.  Will only run when the mission is on Zargabad due to conditions checked in AEG_init.sqf.
 */

 //DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_init_zargabad.sqf: Thread started."] call LGD_fnc_debugMessage;};

// Create a global array to store information necessary to create all the different objects and logical components required by the AEG simulation.  This array will be used by AEG_server.sqf, AEG_client.sqf, AEG_common.sqf, and AEG_JIP.sqf.  The array elements are as follows: ["Type_Name_Location", [Object Position Subarray], Object "Class" or ID, addAction?, "EffectType", [Supplied Nodes Subarray]]
AEG_objects =
[
    ["V_Zarg", [2041.05,5208.99,5.83451], 25972, false, "none", [["D_Zarg_C", 1],["D_Zarg_N", 1],["D_Zarg_S", 1],["D_Zarg_V", 1],["D_Zarg_B", 1]]], // Virtual Object.
    ["D_Zarg_C", [4071.71,4123.21,8.06923], 8493, true, "XFMR", []],
    ["D_Zarg_N", [4037.1799,5653.9902,8.0702496], 84431, true, "XFMR", []],
    ["D_Zarg_S", [4140.9302,3779.5701,8.0697403], 2065, true, "XFMR", []],
    ["D_Zarg_V", [4788.6899,4572.1802,8.0742798], 293, true, "XFMR", []],
    ["D_Zarg_B", [4793.71,6092.6499,8.0700102], 84602, true, "XFMR", []]
];

 // Initialize a function use to determine which power plant or transformer bus on this world is being affected by a power related event.  The function will later be called in AEG_events.sqf in case of a power-related event.
_nul = execVM "scripts\AEG\Functions\AEG_fnc_zargabad.sqf";

//DEBUG
if (!isNil "AEG_DEBUG") then {_debug = ["AEG_init_zargabad.sqf: Thread finished."] call LGD_fnc_debugMessage;};