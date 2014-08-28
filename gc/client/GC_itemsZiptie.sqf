private ["_selection","_civmenuciv"];
_selection = _this select 0;
_civmenuciv = civmenuciv;

if (_selection == "Use") then {
	if (iscop) exitwith {player groupchat "Cops are not permitted to use zipties!"};
	if (animationstate _civmenuciv == "inbasemoves_handsbehindback1") exitwith {
		(format ["[%1, 0, 0] call setPitchBank;%1 switchmove ""%2""; ", _civmenuciv, "amovppnemstpsnonwnondnon"]) call broadcast;
	};

	if ("ziptie" call INV_getitemAmount == 0) exitwith {gc_tiedplayer = false;player groupchat "You dont have any zipties!";};
	if (!(_civmenuciv call ISSE_IsVictim)) exitwith {gc_tiedplayer = false;hint localize "STRS_inventory_checknohands"};
	if (vehicle _civmenuciv != _civmenuciv)exitwith{gc_tiedplayer = false;player groupchat "The person is in a vehicle!";};

	call compile format['SFXPvEh_%1 = ["%2","restrainsfx"];',rolenumber,rolestring];
	publicvariable format["SFXPvEh_%1", rolenumber];
	vehicle player say ["restrainsfx",100];
	["ziptie",-1] call INV_AddInventoreItem;
	(format ["%1 switchmove ""%2"";[%1, -82, 0] call setPitchBank;", _civmenuciv, "inbasemoves_handsbehindback1"]) call broadcast;
	player groupchat format["You tied up %1",name _civmenuciv];
	(format['if(player == %1)then{player groupchat "You have been ziptied by %2!";};',_civmenuciv, name player]) call broadcast;
	gc_tiedplayer = true;
	_civmenuciv spawn {
		sleep 15;
		gc_tiedplayer = false;
	};
};
