_civmenuciv  = civmenuciv;
_civmenu_civ = civmenu_civ;
_option      = _this select 0;
_cash        = 'cash' call INV_GetItemAmount;

if ((player distance _civmenuciv >= 25) or (!(alive _civmenuciv))) exitWith {
  player groupChat format[localize "STRS_civmenu_distance"];
};

// Heal
if (_option == 5) exitWith {
  (format ["%1 setdamage 0; if (%1 == player) then {player Groupchat ""You were healed by %2."";}", _civmenuciv,name player]) call broadcast;
  player groupChat format [localize "STRS_civmenu_heal", _civmenu_civ];
  ["Heal", player, _civmenuciv, ""] spawn Isse_AddCrimeLogEntry;
};

if ((count (weapons player)) == 0) exitWith {	
  player groupChat localize "STRS_civmenu_copnotarmed";
};

// Check Inventory
if (_option == 6) exitWith {
  if (!(_civmenuciv call ISSE_IsVictim)) exitwith {hint localize "STRS_inventory_checknohands"};		
  (format ["if (rolestring == ""%1"") then {[""inventcheck"", ""%2""] execVM ""civmenu.sqf"";}", _civmenu_civ, rolestring]) call broadcast;
};

// Steal Money
if (_option == 20) exitWith {
  if ([player, coparray, 40] call ISSE_ArrayIsNear and !(_civmenuciv in coparray)) exitWith {player groupChat localize "STRS_civmenu_stehlen_copzunah";};
  if (!(_civmenuciv call ISSE_IsVictim)) exitwith {hint localize "STRS_inventory_checknohands"};
  (format ["if (rolestring == ""%1"") then {[""stealmoney"", ""%2""] execVM ""civmenu.sqf"";};", _civmenu_civ, rolestring]) call broadcast;
};

// Drugs
if (_option == 1) exitWith {
  (format ["if (player == %1) then {[""drugs"", %2] execVM ""civmenu.sqf"";};", _civmenuciv, player]) call broadcast;
};

// Disarm
if (_option == 2) exitWith {
  _weapons = weapons _civmenuciv - nonlethalweapons;
  if (count _weapons > 0) then {{_civmenuciv removeWeapon _x} forEach _weapons;};
  if (count _weapons == 0) exitwith {player groupchat "this civ is not armed!"};
  (format ["if (player == %1) then {[""disarm""] execVM ""civmenu.sqf"";};", _civmenuciv]) call broadcast;
  player groupChat format [localize "STRS_civmenu_disarm", _civmenu_civ];
  ["Disarm", player, _civmenuciv, _weapons] spawn Isse_AddCrimeLogEntry;
};

// Arrest
if (_option == 3) exitWith {
  _duration = round(_this select 1);
  format ["if (player == %1) then {[""arrest"", %2, %3] execVM ""civmenu.sqf"";};", _civmenu_civ, _duration, player] call broadcast;
  player groupChat format[localize "STRS_civmenu_arrested", _civmenu_civ];
};

// Ticket
if (_option == 4) exitWith {
  _fine = _this select 1;
  if (!(_fine call ISSE_str_isInteger)) exitWith {player groupChat localize "STRS_inv_no_valid_number";};
 
  _fine = _fine call ISSE_str_StrToInt;
  if (_fine <= 0) exitWith {};
 
  (format ["if (player == %1) then {[""ticket"", %2, %3] execVM ""civmenu.sqf"";}; server globalchat format[localize ""STRS_civmenu_ticket_globalchat"", name %1, %2, name %3];", _civmenuciv, _fine, player]) call broadcast;
};
