_vcl = vehicle player;

//if bunny hop item used, apply upgrade
if (count _this > 1) exitWith {

  if(_vcl getVariable "bunnyhop") exitWith {player groupChat "this vehicle already has bunny-hop shocks installed"};
  if (!(_vcl isKindOf "bicycle")) exitWith {player groupChat "You can only use this on a bicycle";};

  ["bunnyhop", -1] call INV_AddInventoreItem;
  player groupChat "tuning bicycle...";

  sleep 10;

  _vcl setVariable ["bunnyhop", true, true];
  player groupChat "bicycle tuned, press space to bunny-hop!";
};

//otherwise, bunny hop
if (doingSomething) exitWith {};
doingSomething = true;

_vel = velocity _vcl;
_height = abs(speed _vcl) / 6.6;

if (_height > 7.4) then {_height = 7.4};

_vcl setVelocity [_vel select 0, _vel select 1, (_vel select 2)+_height];

sleep 1.3;
doingSomething = false;