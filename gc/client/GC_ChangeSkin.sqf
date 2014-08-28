private ["_becomingTerrorist","_uniform","_side"];
_uniform = _this;
_side = side (group player);
_becomingTerrorist = false;

GC_Strip = {
	removeUniform player;
	//removeVest player;
	//removeHeadgear player;
};

GC_Dress_Terrorist = {
	if (headgear player == "") then { player addHeadgear "H_HelmetO_ocamo";};
	if (vest player == "" or vest player == "V_Rangemaster_belt") then {player addVest "V_TacVest_khk";};
};

GC_Dress_Civ = {
	//NYI
};

GC_Dress_Sniper = {
	//NYI
};

if (_side == CIVILIAN or _side == Resistance) then {
 	if (_uniform == "U_B_CombatUniform_mcam") then {
		_becomingTerrorist = true;
		diag_log "changeskin -> terrorist";
		call GC_Strip;
		call GC_Dress_Terrorist;
	} else {
		diag_log "changeskin -> civ";
		call GC_Strip;
		call GC_Dress_Civ;	
	};
} else {
	//NYI
	diag_log "changeskin -> cop";
	call GC_Strip;	
	call GC_Dress_Sniper;

};

player setVariable["terrorist", _becomingTerrorist];
call compile format['[[[%1,%2,"%3"],"gc\global\GC_onChangeSkin.sqf"],"BIS_fnc_execVM",true,true] call BIS_fnc_MP;',player, _becomingTerrorist,_uniform];
