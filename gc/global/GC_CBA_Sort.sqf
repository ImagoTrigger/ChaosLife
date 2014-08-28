//set up a function for recursion
private "_sort";
_sort =
{
private ["_h","_i","_j","_a","_lo","_hi","_x","_id"];

_a = _this select 0; //array to be sorted
_id = _this select 1; //array item index to be compared
_lo = _this select 2; //lower index to sort from
_hi = _this select 3; //upper index to sort to

_h = nil; //used to make a do-while loop below
_i = _lo;
_j = _hi;
if (count _a == 0) exitWith {};
_x = (_a select ((_lo+_hi)/2)) select _id;

// partition
while {isnil "_h" || _i <= _j} do
{
//find first and last elements within bound that are greater / lower than _x
while {(_a select _i) select _id < _x} do {_i=_i+1};
while {(_a select _j) select _id > _x} do {_j=_j-1};

if (_i <=_j) then
{
//swap elements _i and _j
_h = _a select _i;
_a set [_i, _a select _j];
_a set [_j, _h];

_i=_i+1;
_j=_j-1;
};
};

// recursion
if (_lo<_j) then {[_a, _id, _lo, _j] call _sort};
if (_i<_hi) then {[_a, _id, _i, _hi] call _sort};
};

// and start it off
[_this select 0, _this select 1, 0, 0 max ((count (_this select 0))-1)] call _sort;

// array is already modified by reference, but return the modified array anyway
_this select 0