_civ = civmenuciv;

//=====================================UNRESTRAIN=========================================

if(animationstate _civ == "inbasemoves_handsbehindback1") exitwith

{

(format ["[%1, 0, 0] call setPitchBank;%1 switchmove ""%2""; ", _civ, "amovppnemstpsnonwnondnon"]) call broadcast;
player groupchat "You released the civilian!";

};

//==================================RESTRAIN=========================================

if(vehicle _civ != _civ)exitwith{player groupchat "The civ is in a vehicle!"};

if (!(_civ call ISSE_IsVictim)) exitwith {player groupchat localize "STRS_inventory_checknohands"}; 
call compile format['SFXPvEh_%1 = ["%2","restrainsfx"];',rolenumber,rolestring];
publicVariable format["SFXPvEh_%1", rolenumber];   
vehicle player say ["restrainsfx",100];
(format ["%1 switchmove ""%2"";[%1, -82, 0] call setPitchBank;", _civ, "inbasemoves_handsbehindback1"]) call broadcast;

_wanted = call compile format ["%1_wanted", _civ];
if (_wanted == 1) then {
	(format['server globalchat "%3 ~WANTED~ was restrained by %2";if (rolestring == "%1") then {execVM "Unrestrain.sqf";}', _civ, name player, name _civ]) call broadcast;
} else {
	(format['server globalchat "%3 was restrained by %2";if (rolestring == "%1") then {execVM "Unrestrain.sqf";}', _civ, name player, name _civ]) call broadcast;
};

