// Animations Dialog
// animDlgOpen.sqf

private["_distance_from_jail"];
_distance_from_jail = player distance getMarkerPos "jailarea";

if (_distance_from_jail <= 30) exitWith { hint "You cannot use animations in jail."; };
if (!(createDialog "RscMenuAnimations")) exitWith { hint "Dialog Error!"; };

{
  _index = lbAdd [1, (_x select 3)];
  lbSetData [1, _index, (_x select 1)];
} forEach ANIM_AllAnimationArray;

buttonSetAction [2, "[lbCurSel 1, (lbData [1, (lbCurSel 1)])] execVM ""animplay.sqf""; closedialog 0;"];