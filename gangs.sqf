_vars        = _this select 3;
_art         = _vars select 0;
_prostitutes = false;
_valid_gangname_characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_ .!=$,";

if (_art == "create") then {
  _new_gang_name = ctrlText 11111;
  _new_gang_name = format["%1", [_new_gang_name, _valid_gangname_characters] call BIS_fnc_filterString];
  _name          = name player;
  _cash          = 'cash' call INV_getitemamount;
  _exitvar       = false;
  closedialog 0;

  if (_new_gang_name == "cops") exitwith {player groupchat "You cannot use that name!"};
  if (gangmember) exitwith {player groupchat "You are already in a gang!"};

  for "_c" from 0 to (count gangsarray - 1) do {
    if (((gangsarray select _c) select 0) == _new_gang_name) exitWith {_exitvar = true;};
  };
  if (_exitvar) exitwith {player groupchat "A gang with the same name already exists!"};

  if ((_new_gang_name call ISSE_str_Length) > 30 or (_new_gang_name call ISSE_str_Length) < 3) exitWith {player groupChat "Name is either too long or too short!";};

  if (_cash < gangcreatecost) exitwith {player groupchat "Not enough money!"};

  {if (!isPlayer _x) then {_x setDamage 1; _prostitutes = true;};} forEach units group player;
  if (_prostitutes) then {player groupChat "You cannot have prostitutes in a gang! Your prostitutes have been killed."};

  ['cash', -gangcreatecost] call INV_AddInventoreItem;

  format['gangsarray = gangsarray + [["%1", ["%2"], true]]', _new_gang_name, _name] call broadcast;

  player groupchat format["You've created a new gang called %1!", _new_gang_name];

  gangmember = true;
  gangleader = true;
};

if(_art == "join") then {
  _gang = _vars select 1;
  _name = name player;
  _id   = -1;

  if(gangmember)exitwith{player groupchat "You're already in a gang!"};

  for "_c" from 0 to (count gangsarray - 1) do {
  if (((gangsarray select _c) select 0) == _gang) exitWith {_id = _c;};
  };

  if (_id == -1) exitwith {player groupchat "This gang no longer exists!"};

  _gangarray = gangsarray select _id;
  _members   = _gangarray select 1;
  _canjoin   = _gangarray select 2;

  if (!_canjoin) exitwith {player groupchat "The leader of this gang is currently not recruiting."};

  if (count _members > 6) exitwith{player groupchat "The gang is full, please try again later."};

  {if (!isPlayer _x) then {_x setDamage 1; _prostitutes = true;};} forEach units group player;

  if (_prostitutes) then {player groupChat "You cannot have prostitutes in a gang! Your prostitutes have been killed."};

  _members   = _members + [_name];
  _gangarray set[1, _members];

  format['gangsarray set[%1, %2]', _id, _gangarray] call broadcast;

  player groupchat format["You've joined %1!", _gang];

	_leader = _members select 0;
	_lunit  = [_leader, civarray] call INV_findunit;
	_oldgroup = group player;
	[player] joinsilent group _lunit;
	deleteGroup _oldgroup;
	_oldgroup = grpNull;
	_oldgroup = nil;

	gangmember = true;

};

if(_art == "leave") then {
  if (!gangmember) exitwith {player groupchat "You're not in a gang!"};

  for "_c" from 0 to (count gangsarray - 1) do {
    _gangarray = gangsarray select _c;
    _gang      = _gangarray select 0;
    _members   = _gangarray select 1;
    _name      = name player;

    if (_name in _members) then {
      _members = _members - [_name];
      _gangarray set[1, _members];
      format['gangsarray set[%1, %2]', _c, _gangarray] call broadcast;

      [player] joinsilent grpNull;

      player groupchat "You left your gang!";
      gangmember=false;
      gangleader=false;
      takingFlag = false;
    };
  };

};

if(_art == "kick") then {
  if ((_vars select 1) == "notingame") exitwith {player groupchat "You cannot kick members unless they are in-game!"};
  _civ = call compile format["%1", _vars select 1];

  if(player == _civ)exitwith{player groupchat "You cannot kick yourself!"};

  for "_c" from 0 to (count gangsarray - 1) do {
    _gangarray = gangsarray select _c;
    _gang      = _gangarray select 0;
    _members   = _gangarray select 1;
    _name      = name player;

    if (_name in _members) then {
      _members = _members - [(name _civ)];
      _gangarray set[1, _members];
      format['if(!isServer and (player == %3))then{player groupchat "You were kicked out of your gang!"; [player] joinsilent grpNull; gangmember = false; takingFlag = false;}; gangsarray set[%1, %2];', _c, _gangarray, _civ] call broadcast;
    };

    player groupchat format["You kicked %1 from your gang!", name _civ];

  };
};

if (_art == "allowjoin") then {
  if(_vars select 1 == "")exitwith{player groupchat "You must select either yes or no!"};
  _bool = call compile format["%1", _vars select 1];

  for "_c" from 0 to (count gangsarray - 1) do {
    _gangarray = gangsarray select _c;
    _gang      = _gangarray select 0;
    _members   = _gangarray select 1;
    _name      = name player;

    if (_name in _members) then {
      _gangarray set[2, _bool];
      format['gangsarray set[%1, %2]', _c, _gangarray] call broadcast;
      if (_bool) then {
        player groupchat "Civilians can now join your gang";
      } else {
        player groupchat "Civilians can no longer join your gang";
      };
    };
  };
};