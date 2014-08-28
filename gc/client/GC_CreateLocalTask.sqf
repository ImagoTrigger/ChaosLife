private ["_target","_params","_desc","_dest","_state","_priority"];

_target = [_this,0,true,[true,sideunknown,grpnull,objnull,[]]] call BIS_fnc_param;
_params = [_this,1,"",["",[]]] call BIS_fnc_param;
_desc = [_this,2,["","",""],[[]],3] call BIS_fnc_param;
_dest = [_this,3,objNull,[objNull,[],""]] call BIS_fnc_param;
_state = [_this,4,false,["",false,0]] call BIS_fnc_param;
_priority = [_this,5,-1,[0]] call BIS_fnc_param;

if (typename _dest == typename "") then {_dest = markerpos _dest;};
if (typename _state == typename 0) then {_state = _state > 0;};

[_params,_target,_desc,_dest,_state,_priority,true,false] call bis_fnc_setTask;