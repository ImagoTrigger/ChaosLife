private ["_class","_pos","_posx","_posy","_posz","_object","_item","_amount"];
_item   = _this select 0;
_amount = _this select 1;
_class  = "Land_Suitcase_F";

if ((!INV_CanUseInventory) or (!INV_CanDropItem)) exitWith {player groupChat localize "STRS_inv_inventar_cannotdrop";};

if(!isnull (nearestobjects[getpos player,["Land_Suitcase_F", "Land_Money_F"], 1] select 0))exitwith{player groupchat "You cannot drop items on top of each other. move and try again."};

if (_amount <= 0) exitwith {format["hint ""%1 has dropped %2!"";", (name player), _amount] call broadcast;};

if (_item call INV_getitemDropable) then {
	if ([_item, -(_amount)] call INV_AddInventoreItem) then {
		["GC_Hand",["CHAOS ITEM DROPPED",localize "STRS_inv_inventar_weggeworfen"]] spawn bis_fnc_showNotification;

		//only do animations when not in a vehicle and not in water
		if (player == vehicle player and !(surfaceIsWater position player)) then {
			if(primaryweapon player == "" and secondaryweapon player == "") then {
				player playmove "AmovPercMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon";
			}else{
				player playmove "AinvPknlMstpSlayWrflDnon";
			};
			sleep 1.5;
		};

		//if item was flashlight, ensure light is off
		if (_item == "flashlight") then {
			format['
				if (!isNil "%1flashLight") then {
					deleteVehicle %1flashLight;
	    		%1flashLight = nil;
				};
			', player] call broadcast;
		};

		if (_item == "cash") then {
			_class = "Land_Money_F";
		} else {
			_class = "Land_Suitcase_F";
		};
		_pos = getposASL player;
		_posx = _pos select 0;
		_posy = _pos select 1;
		_posz = _pos select 2;
		_object = _class createvehicle _pos;
		{_object disableCollisionWith _x;} foreach playableUnits;
		_object setposASL [_posx, _posy, _posz];
		_object setvariable ["droparray", [_amount, _item], true];
		_object spawn {
			waituntil{sleep 0.1;(isTouchingGround _this or surfaceIsWater position _this)};
			_this enablesimulation false;
		};

	} else {
		["GC_Hand",["CHAOS LIFE INVENTORY",localize "STRS_inv_inventar_drop_zuwenig"]] spawn bis_fnc_showNotification;
	};
} else {
	["GC_Hand",["CHAOS ITEM INVENTORY",localize "STRS_inv_inventar_ablege_verbot"]] spawn bis_fnc_showNotification;
};