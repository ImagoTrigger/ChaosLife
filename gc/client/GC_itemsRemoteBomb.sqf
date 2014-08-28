private ["_item","_art","_ctime","_bomb","_exp","_exp2","_posx","_posy","_posz","_obj","_rocket","_rocket2"];
_art = _this select 0;
_item   = _this select 1;
if (_art == "use") then {
	if (_item == "remote_bomb") then {
		if (bombplanted) exitWith {
			["GC_Bad2",["CHAOS LIFE BOMBS","You can only plant one bomb at a time!"]] spawn bis_fnc_showNotification;
		};		
		if (player != vehicle player) exitWith {
			["GC_Bad2",["CHAOS LIFE BOMBS","You can't use this in a vehicle!"]] spawn bis_fnc_showNotification;
		};																						   
		if (call GC_PlayerInCrimeFree) exitWith {
			["GC_Bad2",["CHAOS LIFE BOMBS","You can't plant a bomb inside the No Crime Zone!"]] spawn bis_fnc_showNotification;
		};
		_ctime = round(time);
		format ["%1 switchmove ""AinvPknlMstpSlayWrflDnon_medic"";", player] call broadcast;
		sleep 4;
		waituntil {sleep 0.1; animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};
		call compile format['
			bomb_%1_%2 = "Land_Suitcase_F" createVehicle getPosATL %1;
			bomb_%1_%2 setVehicleVarName "bomb_%1_%2";
			exp_%1_%2 = "DemoCharge_Remote_Ammo" createVehicle getPosATL %1;
			exp_%1_%2 setVehicleVarName "exp_%1_%2";
			exp2_%1_%2 = "DemoCharge_Remote_Ammo" createVehicle getPosATL %1;			
			exp2_%1_%2 setVehicleVarName "exp2_%1_%2";
		',player,_ctime];
		_code = format['bomb_%1_%2 setvariable["bomber",%1,true];',player,_ctime];
		call compile format['[[[bomb_%1_%2,"bomb_%1_%2",''%3''],"gc\global\GC_onVehicleCreated.sqf"],"BIS_fnc_execVM",true,true] call BIS_fnc_MP;',rolestring, _ctime,_code];
		call compile format['
			exp_%1_%2 attachto [bomb_%1_%2,[-0.02,-0.09,-0.1]];
			exp2_%1_%2 attachto [bomb_%1_%2,[-0.02,-0.001,-0.1]];
			bomb_%1_%2 setposATL getposATL %1;
		',player,_ctime];
		[_item, (-1)] call INV_AddInventoreItem;
		["remote_bomb_detonator", (+1)] call INV_AddInventoreItem;
		player setvariable["bomb_ctime",_ctime,false];
		player GroupChat "You have planted a remote time bomb.";
		player GroupChat "Use your detonator to make it explode!";
		bombplanted = true;
		_class	 = _item call INV_getitemClassName;
		(format ["publicarbeiterarctionarray = publicarbeiterarctionarray + [ [%1%2%3, %1] ];", player, _class, _ctime]) call broadcast_srv;
		if (([player, (civarray + coparray), 40] call INV_Seen) and !iscop) then {
			format [" [""Bomb"", %1] spawn Isse_AddCrimeLogEntry; if(!(""planted a bomb"" in %1_reason))then{%1_reason = %1_reason + [""planted a bomb""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 10000;", player] call broadcast;
		};		
	};
	if (_item == "remote_bomb_detonator") then {
		_ctime = player getvariable "bomb_ctime";
		_bomb = "";
		call compile format["_bomb = bomb_%1_%2;",player,_ctime];
		if (!alive _bomb) exitWith {
			player GroupChat "Your remote time bomb no longer exists.";
			[_item, (-1)] call INV_AddInventoreItem;
			bombplanted = false;
		};
		if (vehicle player distance _bomb > 300) exitWith {
			player GroupChat "Your remote time bomb is too far away.";
		};		
		[_bomb,10,false] execVM "ammo_burn.sqf";
		call compile format['SFXPvEh_%1 = ["%2","bombbeepsfx"];',rolenumber,_bomb];
		publicVariable format["SFXPvEh_%1", rolenumber];          
		_bomb say ["bombbeepsfx",100];
		call compile format['SFXPvEh_%1 = ["%2","bombscreamsfx"];',rolenumber,rolestring];
		publicVariable format["SFXPvEh_%1", rolenumber];          
		vehicle player say ["bombscreamsfx",100];
		sleep 6;
		_posx = getPosATL _bomb select 0;
		_posy = getPosATL _bomb select 1;
		_posz = getPosATL _bomb select 2;
		_obj = nearestObject[_bomb,"DemoCharge_Remote_Ammo"];
		deletevehicle _obj;
		"Grenade" createvehicle (getPos _obj);		
		sleep 0.25;
		_rocket = "R_60mm_HE" createvehicle [_posx,_posy,_posz+1];
		[_rocket, -90, 0] call setPitchBank;
		_rocket2 = "R_80mm_HE" createvehicle [_posx,_posy,_posz+1];
		[_rocket2, -90, 0] call setPitchBank;		
		_bomb setdammage 1;
		sleep 2;	
		_obj2 = nearestObject[_bomb,"DemoCharge_Remote_Ammo"];
		deletevehicle _obj2;		
		_bomb spawn {sleep 0.5; deletevehicle _this;}; //allow time for victims to find bomb owner
		[_item, (-1)] call INV_AddInventoreItem;
		bombplanted = false;
		if (([player, (civarray + coparray), 40] call INV_Seen) and !iscop) then {
			format [" [""Bomb"", %1] spawn Isse_AddCrimeLogEntry; if(!(""detonated a bomb"" in %1_reason))then{%1_reason = %1_reason + [""detonated a bomb""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + 50000;", player] call broadcast;
		};		
	};
};
