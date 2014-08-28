// Play Animations from the Animationsarray and when neccessary call the approriate script
// animplay.sqf
// edited by eddie vedder

if ((_this select 0) == -1) exitWith {player groupChat localize "STRS_anim_noselect"};
_animnumber       = _this select 0;
_animScriptName   = _this select 1; 
_animname         = ((ANIM_AllAnimationArray select _animnumber) select 0);
_animart          = ((ANIM_AllAnimationArray select _animnumber) select 2);
_withWeapon       = ((ANIM_AllAnimationArray select _animnumber) select 4);
_callScript       = ((ANIM_AllAnimationArray select _animnumber) select 5);
/*_hasweapon  = false;
if ( count((weapons player) - ["Binocular"] - ["NVGoggles"]) > 0) then {_hasweapon = true;};
if ((not(_hasweapon)) and (_withWeapon == 1)) exitWith {player groupChat localize "STRS_anim_nur_mit_waffe";};
if ((_hasweapon) and (_withWeapon == 0)) exitWith {player groupChat localize "STRS_anim_nur_ohne_waffe";};
if (_callScript != "") exitWith {[_animnumber, _animScriptName] execVM _callScript;};
*/
if (_animart == "anim") then {					
	if (vehicle player == player) then {
		(format ["if (!isServer) then {%1 switchmove ""%2"";};", player, _animname]) call broadcast;
	};
};

if (_animart == "dance") then {	
	if (vehicle player == player) then {
		(format ["if (!isServer) then {%1 playMove ""%2"";};", player, _animname]) call broadcast;
	};
};

if (_animart == "stopdancing") then {	
	if (vehicle player == player) then {
		(format ["if (!isServer) then {%1 playMoveNow ""%2"";};", player, _animname]) call broadcast;
	};
};