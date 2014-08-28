_option = _this select 0;
_breakChance = floor random 10000;

if (_option == "use") then {
  if (working) exitWith {};
  working = true;
  _surface = surfaceType getPos player;
  _foundTree = false;
  _treeType = "";

  {
    switch true do {
      case (!(_foundTree) && ["t_ficus", str(_x)] call BIS_fnc_inString) : {_foundTree = true; _treeType = "ficus";};
      case (!(_foundTree) && ["t_fraxinus", str(_x)] call BIS_fnc_inString) : {_foundTree = true; _treeType = "ash";};
      case (!(_foundTree) && ["t_olea", str(_x)] call BIS_fnc_inString) : {_foundTree = true; _treeType = "olive";};
      case (!(_foundTree) && ["t_phoenix", str(_x)] call BIS_fnc_inString) : {_foundTree = true; _treeType = "date_palm";};
      case (!(_foundTree) && ["t_pinus", str(_x)] call BIS_fnc_inString) : {_foundTree = true; _treeType = "pine";};
      case (!(_foundTree) && ["t_populus", str(_x)] call BIS_fnc_inString) : {_foundTree = true; _treeType = "poplar";};
    };
  } forEach nearestObjects [player, [], 8];;

  if (_foundTree) then {
    // Play chopping sound.
    // TODO: This same chunk of code is copied all over the place and should
    //       be extracted out to it's own function.
    call compile format['SFXPvEh_%1 = ["%2","chopsfx"];',rolenumber,rolestring];
    publicVariable format["SFXPvEh_%1", rolenumber];
    vehicle player say ["chopsfx",100];

    (format ["%1 switchmove ""%2"";", player, "AwopPercMstpSgthWnonDnon_end"]) call broadcast;
    sleep 1.5;
    (format ["%1 switchmove ""%2"";", player, "AwopPercMstpSgthWnonDnon_end"]) call broadcast;
    sleep 1.7;
    (format ["%1 switchmove ""%2"";", player, "AwopPercMstpSgthWnonDnon_end"]) call broadcast;
    sleep 1;

    hint format["Gathered 1 wood from the %1 tree", _treeType];
    ["wood", 1] call INV_AddInventoreItem;

    // Slight chance 1:500 to break your axe.
    if ((_breakChance <= 20) and (_breakChance > 0)) then {
      ["woodaxe", -1] call INV_AddInventoreItem;
      ["GC_HandBad", ["ITEM BROKE", "You broke your axe. It has been removed."]] spawn bis_fnc_showNotification;
    };
  } else {
    hint "No trees found";
  };
  working = false;
};