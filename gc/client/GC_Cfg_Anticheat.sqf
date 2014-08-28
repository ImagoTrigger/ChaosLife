if ((isClass (configFile >> "CfgPatches" >> "Ribalion"))) exitWith { [] execVM "nc.sqf"; };
if ((isClass (configFile >> "CfgPatches" >> "ACCPack"))) exitWith { [] execVM "nc.sqf"; };
if ((isClass (configFile >> "CfgPatches" >> "Schleiflshackpack"))) exitWith { [] execVM "nc.sqf"; };
if ((isClass (configFile >> "CfgPatches" >> "awk_ch34tsDevString_ak"))) exitWith { [] execVM "nc.sqf"; };
if ((isClass (configFile >> "CfgPatches" >> "loki_lk"))) exitWith { [] execVM "nc.sqf"; };
if ((isClass (configFile >> "CfgPatches" >> "zump"))) exitWith { [] execVM "nc.sqf"; };
if ((isClass (configFile >> "CfgPatches" >> "water"))) exitWith { [] execVM "nc.sqf"; };
if ((isClass (configFile >> "CfgPatches" >> "gerk"))) exitWith { [] execVM "nc.sqf"; };
if ((isClass (configFile >> "CfgPatches" >> "mors_anygear"))) exitWith { [] execVM "nc.sqf"; };
if ((isClass (configFile >> "CfgPatches" >> "CHN_TroopMon"))) exitWith { [] execVM "nc.sqf"; };
if ((isClass (configFile >> "CfgPatches" >> "AlexanderPack"))) exitWith { [] execVM "nc.sqf"; };
if ((isClass (configFile >> "CfgPatches" >> "MRMEDIC_TroopMon"))) exitWith { [] execVM "nc.sqf"; };
if (count (configFile / "CfgVehicles" / "Car" / "UserActions") > 0 or count (configFile / "CfgVehicles" / "Motorcycle" / "UserActions") > 0 or count (configFile / "CfgVehicles" / "Tank" / "UserActions") > 0 or count (configFile / "CfgVehicles" / "Man" / "UserActions") > 0 or count (configFile / "CfgVehicles" / "Air" / "UserActions") > 0 or count (configFile / "CfgVehicles" / "Ship" / "UserActions") > 0) exitWith {
  [] execVM "nc.sqf";
};
