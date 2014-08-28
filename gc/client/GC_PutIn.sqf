private ["_vcl","_target"];
_vcl = _this;
_target  = civmenuciv;
if (!alive _target) exitwith {player groupchat format["%1 is no longer alive!",_target getvariable "deadname"];};
if (!gc_tiedplayer) exitwith {player groupchat format["You need to ziptie %1 again before they'll get in!",name _target];};
if (!(_vcl in INV_VehicleArray)) exitWith {player groupchat "You need to have keys to the closest vehicle before they'll get in!"};
if (locked _vcl != 0) then {
    player groupchat "You need to unlock your car to put the person in!";
} else {
	(format["%1 moveincargo %2;",_target,_vcl]) call broadcast;
	_vcl lock 2;
	player groupchat format["You put %1 in your car!",_target];
	(format["if (player == %1) then {keyblock=true; player groupchat ""You have been taken hostage!""; };",_target]) call broadcast;
	gc_tiedplayer = false;
};