diag_log text format["killer: %1",_this];
_killer 		= _this select 0;
_killedbyvehicle 	= _this select 1;
_license 		= _this select 2;
_self			= player;
_drown = false;
if (player == _killer and !iscop and !suicided) exitWith {wipewanted = false;};

if (underwater player and getOxygenRemaining player <= 0) then {_drown = true};

if (player == _killer and !iscop and suicided and !_drown) exitWith {
	player groupChat localize "STRS_handlerdeadpub_suicide";
	SelfKilled = SelfKilled + 1;
	extradeadtime = extradeadtime + suicidepenalty;
	["extradeadtime", extradeadtime] call ClientSaveVar;
	(format ['server globalChat "%1 committed suicide!";', name player]) call broadcast;
	wipewanted = false;
};
if (player == _killer and !iscop and suicided and _drown) exitWith {
	player groupChat localize "You have drowned.";
	SelfKilled = SelfKilled + 1;
	extradeadtime = extradeadtime + suicidepenalty;
	["extradeadtime", extradeadtime] call ClientSaveVar;
	(format ['server globalChat "%1 drowned!";', name player]) call broadcast;
	wipewanted = false;
};


if (player == _killer and iscop) exitWith {};

if (_killer in civarray) then {
	CivsKilled = CivsKilled + 1;
	if (iscop) then {
		_civkopfcash = call compile format ["kopfcash_%1", _killer];
		_civkopfcash = ceil(_civkopfcash / 3);

		if (_civkopfcash != 0) then {
			kontostand = kontostand + _civkopfcash;
			player groupChat format["You got 1/3 of the criminal's bounty totaling $%1.",_civkopfcash];
			RewardsCollected = RewardsCollected + _civkopfcash;
		};
		_playerIsWanted = call compile format ["%1_wanted", _killer];
		if (_playerIsWanted != 1) then {
			player groupChat format [localize "STRS_handlerdeadpub_civkilled", _killer];
		};

	} else {
		if (_killer getVariable "terrorist" or side (group _killer) == EAST) exitWith {};

		extradeadtime = extradeadtime + killedplayerinc;
		["extradeadtime", extradeadtime] call ClientSaveVar;
		true call TurnWantedFunc;

		if(_killedbyvehicle)then

			{

			INV_LizenzOwner = INV_LizenzOwner - ["car","truck"];
			["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;
			player groupchat "You have lost your vehicle license for reckless driving!";
			demerits = 0;

			}else{

			player groupchat "You are now wanted, and lost your gun licenses!";
			INV_LizenzOwner = INV_LizenzOwner - ["Pistollicense","Riflelicense","automatic","shotgun"];
			["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;

			};
	};

sleep 1;
//revisit - save victim name in crime log
if (_killedbyvehicle) then
	{
	(format ["[""KilledCiv"", %1] spawn Isse_AddCrimeLogEntry; if(%1 in civarray)then{if(!(""Hit and Run"" in %1_reason))then{%1_reason = %1_reason + [""Hit and Run""]}; kopfcash_%1 = kopfcash_%1 + 30000};", player]) call broadcast;
	}
	else
	{
	(format ["[""KilledCiv"", %1] spawn Isse_AddCrimeLogEntry; if(%1 in civarray)then{if(!(""murder"" in %1_reason))then{%1_reason = %1_reason + [""murder""]}; kopfcash_%1 = kopfcash_%1 + 30000};", player]) call broadcast;
	};


};



if (_killer in coparray) then

{

CopsKilled = CopsKilled + 1;

if (iscop) then

	{

	extradeadtime = extradeadtime + killedplayerinc;
	["extradeadtime", extradeadtime] call ClientSaveVar;
	player groupChat format [localize "STRS_handlerdeadpub_copkilledbycop", _killer];

	if ( (call GC_PlayerInCopBase) or (_killer in list CopBaseTrigger) or (CopsKilled > 5) ) then

		{

		[] execVM "copprison.sqf";

		};

	}
	else
	{

	extradeadtime = extradeadtime + killedplayerinc;
	["extradeadtime", extradeadtime] call ClientSaveVar;
	player groupChat format [localize "STRS_handlerdeadpub_copkilled", _killer];
	true call TurnWantedFunc;

	if(_killedbyvehicle)then

		{

		INV_LizenzOwner = INV_LizenzOwner - ["car","truck"];
		["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;
		player groupchat "You have lost your vehicle licenses for reckless driving!";
		demerits = 0;

		}else{

		player groupchat "You are now wanted, and lost your gun licenses!";
		INV_LizenzOwner = INV_LizenzOwner - ["Pistollicense","Riflelicense","automatic","shotgun"];
		["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;

		};

	};

sleep 1;
//revisit - save victim name in crime log
if (_killedbyvehicle) then
	{
	(format ["[""KilledCop"", %1, ""%2""] spawn Isse_AddCrimeLogEntry; if(%1 in civarray)then{if(!(""Hit and run on a cop"" in %1_reason))then{%1_reason = %1_reason + [""Hit and run on a cop""]}; kopfcash_%1 = kopfcash_%1 + 50000};", player,  _killer]) call broadcast;
	}
	else
	{
	(format ["[""KilledCop"", %1, ""%2""] spawn Isse_AddCrimeLogEntry; if(%1 in civarray)then{if(!(""cop murder"" in %1_reason))then{%1_reason = %1_reason + [""cop murder""]}; kopfcash_%1 = kopfcash_%1 + 50000};", player,  _killer]) call broadcast;
	};


};

