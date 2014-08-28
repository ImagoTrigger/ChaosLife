private ["_fishingHole", "_resource", "_infos"];

_option = _this select 0;

if (_option == "use") then {
  if(working)exitwith{};

  working     = true;
  _item       = _this select 1;
  _isInArea   = false;
  _inWater    = surfaceIsWater position player;
  _waterDepth = abs (getTerrainHeightASL position player);

  // Figure out if player is in fishing hole.
  {
    if (player distance (getMarkerPos ((_x select 0) select 0)) < ((_x select 0) select 1)) then {
      _isInArea = true;
      _fishingHole = _x;
    };
  } forEach fishingHoles;

  // Is the player in water?
  if (!_inWater) exitwith {
    hint "You're not close enough to water to fish.";
    working = false;
  };

  // Grab the resource from the hole, or default to "fish".
  if (_isInArea) then {
    _resource = _fishingHole select 1;
    _max      = _fishingHole select 2;
  } else {
    _resource = "fish";
    _max      = 12;
  };

  _infos  = _resource call INV_getitemArray;
  _name   = (_infos call INV_getitemName);
  _weight = (_infos call INV_getitemTypeKg);

  if (_item == "fishingpole") then {
    totalamount=0;
    (format ["%1 switchmove ""%2"";", player, "AwopPercMstpSgthWnonDnon_end"]) call broadcast;

    for [{_i=0}, {_i < 4}, {_i=_i+1}] do {
      _amount = floor((random (5 + 1)) + (0.045 * SKILL_FISHING));
      titletext ["Fishing...", "PLAIN DOWN", 0.1];

      sleep 1.5;
      player switchmove "AmovPercMstpSnonWnonDnon";

      _avail = floor (INV_Tragfaehigkeit - (call INV_GetOwnWeight));

      totalamount = totalamount + _amount;

      if ((totalamount * _weight) >= _avail) exitwith {
        totalamount = (_avail/_weight);
        hint "Life Inventory Full";
        _i=6;
      };

      player groupchat format["You got %1 %2.", _amount, _name];
    };

    totalamount = (floor (totalamount));
    [_resource, totalamount] call INV_AddInventoreItem;

    _addskill = (totalamount / 100);
    ["SKILL_FISHING",_addskill] call GC_addSkill;
  };
  working=false;
};