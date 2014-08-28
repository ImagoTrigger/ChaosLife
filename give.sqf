_art         = _this select 0;
_item        = _this select 1;
_menge       = _this select 2;
_itemanzeige = (_item call INV_getitemName);

if (_art == "uebergabe") then  {

	//only do animations when not in a vehicle and not in water
	if (player == vehicle player and !(surfaceIsWater position player)) then {
		if (primaryweapon player == "" and secondaryweapon player == "") then {
			player playmove "AmovPercMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon";
		} else {
			player playmove "AinvPknlMstpSlayWrflDnon";
		};
	};

	_spielernum   = call compile (_this select 3);
	_spieler      = INV_PLAYERSTRINGLIST select _spielernum;
	_playerobject = INV_PLAYERLIST       select _spielernum;

	if (!(_spieler call ISSE_UnitExists))                exitWith {player groupChat localize "STRS_inv_not_ingame";};
	if (_playerobject == player)                         exitWith {player groupChat localize "STRS_inv_inventar_uebergabe_self";};
	if (player distance _playerobject > 20)              exitWith {player groupChat localize "STRS_inv_inventar_uebergabe_distance";};
	if (!(_item call INV_getitemGiveable))               exitWith {player groupChat localize "STRS_inv_inventar_uebergabe_verbot";};
	if (!([_item, -(_menge)] call INV_AddInventoreItem)) exitWith {player groupChat localize "STRS_inv_inventar_uebergabe_zuwenig";};

	format ["if (player == %1) then {[""bekommen"", ""%2"", %3, %4] execVM ""give.sqf"";};", _playerobject, _item, _menge, player] call broadcast;

	playsound "notifysfx";
	_string = format [localize "STRS_inv_inventar_uebergabe_success_self", name _playerobject, (_menge call ISSE_str_IntToStr), _itemanzeige];
	["GC_Hand",["CHAOS ITEM GIVEN",_string]] spawn bis_fnc_showNotification;

};

if (_art == "bekommen") then  {
	_spieler = _this select 3;

	if ([_item, _menge] call INV_AddInventoreItem) then  {

		playsound "notifysfx";
		_string = format[localize "STRS_inv_inventar_gotfromotherplayer", (_menge call ISSE_str_IntToStr), _itemanzeige, name _spieler];
		["GC_Hand",["CHAOS ITEM RECEIVED",_string]] spawn bis_fnc_showNotification;
	} else {
		format ["if (player == %1) then {[""%2"", %3] call INV_AddInventoreItem;};", _spieler, _item, _menge] call broadcast;
	};
};
