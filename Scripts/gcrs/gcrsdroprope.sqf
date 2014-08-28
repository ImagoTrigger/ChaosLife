// GeneralCarver Repel Script
// Drop Rope Script
// Version: v1, 8/3/09
if (!isnil "gcrsrope0") then {deletevehicle gcrsrope0;};
for "_c" from 0 to 100 do {
	call compile format['if (!isnil "gcrsrope%1") then {deletevehicle gcrsrope%1;};',_c];
};
gcrsropedeployed = "false";
gcrsplayerveharray = [vehicle player];
gcrsrapelheloarray = gcrsrapelheloarray - gcrsplayerveharray;
publicvariable "gcrsrapelheloarray";
format['if (vehicle player == %1) then {hint "Rapel Ropes Dropped";};',gcrsrepelvehicle] call broadcast;
