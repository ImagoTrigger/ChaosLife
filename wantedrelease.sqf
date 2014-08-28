private ["_bounty","_civnumber","_reason","_deletekopfcash","_civ","_civvar","_civarrestedvar"];
_civnumber      = _this select 0;
_reason         = _this select 1; 
_deletekopfcash = _this select 2;
_civnumber      = _civnumber+1;
_civ            = format["civ%1", _civnumber];
_civvar		= call compile format["%1", _civ];
_civarrestedvar = 0;

if (_civ == rolestring) exitWith {player groupChat localize "STRS_kopfcash_notself";};
if (not(_civ call ISSE_UnitExists)) exitWith {role groupChat localize "STRS_player_not_ingame";};

if (_deletekopfcash == 1) exitWith 

{
_bounty = call compile format['kopfcash_%1',_civ];
format["[""Unwanted"", %2, %3, %4] spawn Isse_AddCrimeLogEntry; kopfcash_%1 = 0; %1_wanted = 0; %1_reason = [];", _civ,_civvar,player,_bounty] call broadcast;	
(format["server globalchat ""The bounty of %1 was removed by %2. He is no longer wanted."";", name _civvar, name player]) call broadcast;

};
                
if (_reason == "Description of crime") exitWith {player groupChat "You must enter a description of the crime!";};
if ([_reason,'"'] call ISSE_str_IsInStr) exitWith {player groupChat 'You cannot use a double-quote (") in the description of the crime!';};
call compile format ["_civarrestedvar = civ%1_arrest;",_civnumber];

if ((!(alive _civvar)) or (_civarrestedvar == 1)) exitWith {role groupChat format [localize "STRS_kopfcash_nokopfcash", _civ];};
format ["[""Wanted"", %2, %5, ""%4""] spawn Isse_AddCrimeLogEntry;%2_wanted = 1; if(!(""%4"" in %2_reason))then{%2_reason = %2_reason + [""%4""]};server globalchat ""%3 is wanted for %4 by %1"";", name player, _civvar, name _civvar, _reason, player] call broadcast;
