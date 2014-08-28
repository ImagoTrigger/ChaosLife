call compile format['SFXPvEh_%1 = ["%2","rapewhistlesfx",5];',rolenumber,rolestring];
publicVariable format["SFXPvEh_%1", rolenumber];          
vehicle player say ["rapewhistlesfx",400];
if (random 100 > 60) exitwith {
	['rapewhistle', (-1)] call INV_AddInventoreItem;
	player groupChat "You blew too hard into your rape whistle and it broke!";
};