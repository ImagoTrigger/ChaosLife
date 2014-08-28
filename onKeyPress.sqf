private ["_handled","_vcls","_vcl","_i","_id","_script","_range","_dirV","_pos","_posFind","_men","_atms","_atm","_firstWhistle","_horn","_key","_shift","_alt","_ctrl"];


_key     = _this select 1;
_shift   = _this select 2;
_ctrl   = _this select 3;
_alt   = _this select 4;
_handled = false;

if (isstunned) exitwith {
  if(_key == 50)then{_handled = true};
  if(_key == 11)then{_handled = true};

  _handled
};

switch _key do {
  //y key
  case 21:
  {
  if(dialog)exitwith{closeDialog 0;};
  if(!INV_shortcuts)exitwith{};
  if(chairaction != -1)exitwith{};
  _handled=true;
  [] execVM "animdlgopen.sqf";

  };


  //TAB key
  case 15: {
    if (INV_shortcuts) then {
      INV_shortcuts = false;
      titletext ["Chaos keys off", "PLAIN DOWN"];
      call removeActions;
    }else{
      INV_shortcuts = true;
      titletext["Chaos keys on", "PLAIN DOWN"];
      call addActions;
    };
  };

  //L key
  case 38: {
    if(!INV_shortcuts)exitwith{};

    _vcls = nearestobjects [vehicle player, ["LandVehicle", "Air", "ship","Tank"], 7];
    if (count _vcls < 1)exitwith{["GC_Vehicle_Bad",["CHAOS LIFE KEY CHAIN","You're not close enough to any vehicle!"]] spawn bis_fnc_showNotification;_handled=true;};
    _vcl = _vcls select 0;

    if(!(_vcl in INV_VehicleArray))exitwith{["GC_Vehicle_Bad",["CHAOS LIFE KEY CHAIN","You do not have keys to this vehicle!"]] spawn bis_fnc_showNotification;_handled=true;};
    ["schluessel", _vcl, 0] execVM "keys.sqf";
    _handled=true;
  };

  //T key
  case 20: {
    if(_shift and chaos) exitWith {[] execVM "\dev\test.sqf"};
    if(_ctrl and chaos) exitWith {[] execVM "\dev\test2.sqf"};
    if(_alt and chaos) exitWith {[] execVM "\dev\test3.sqf"};
    if(chairaction != -1)exitwith{};
    if(!INV_shortcuts)exitwith{};

    if(dialog)exitwith{closeDialog 0;};

    _vcls = nearestobjects [vehicle player, ["LandVehicle", "Air", "ship", "Tank"], 7];
    _vcl = _vcls select 0;

    //if(!(_vcl in INV_VehicleArray) and typeof _vcl == "TKOrdnanceBox_EP1")exitwith{player groupchat "You do not have the keys to this hideout.";};
    if(!(_vcl in INV_VehicleArray))exitwith{["GC_Vehicle_Bad",["CHAOS LIFE KEY CHAIN","You do not have keys to this vehicle!"]] spawn bis_fnc_showNotification;};

    if (!isnull _vcl) then {
      call compile format['[0,0,0,["%3", "public", ["vcl", "%2", %1]]] execVM "storage.sqf";', _vcl, (typeOf _vcl), format["%1_storage", _vcl]];
    };
  };

  //E key
  case 18: {
    if(chairaction != -1)exitwith{};
    if(isstunned) exitwith{};
    if(!INV_shortcuts)exitwith{};
    if(keyblock)exitwith{};
    if(dialog)exitwith{closeDialog 0;};
    if(local_arrest == 1)exitwith{};

    private ["_civ"];

    for [{_i=1}, {_i < 3}, {_i=_i+1}] do {
      if(vehicle player != player) exitwith{};

      _range   = _i;
      _dirV    = vectorDir vehicle player;
      _pos     = player modelToWorld [0,0,0];
      _posFind = [(_pos select 0)+(_dirV select 0)*_range,(_pos select 1)+(_dirV select 1)*_range,(_pos select 2)+(_dirV select 2)*_range];
      _men     = nearestobjects [_posFind,["Man", "B_supplyCrate_F", "Box_NATO_Support_F"], 1] - [player];
      _atms    = nearestObjects [_posFind,["Man", "Land_CashDesk_F"],2];
      _civ     = _men select 0;
      _atm     = _atms select 0;

      if(iscop and !(isnull _civ) and _civ in civarray) exitwith {
        _i = 4;
        call compile format['[0,0,0, ["civmenu", "%1", %1]] execVM "interact.sqf";', _civ];
        _handled=true;
      };

      if(isciv and !(isnull _civ) and _civ in playerarray) exitwith {
        _i = 4;
        call compile format['[0,0,0, ["civinteraktion", "%1", %1]] execVM "interact.sqf";', _civ];
        _handled=true;
      };

      if(!(isnull _civ) and _civ in shopusearray) exitwith {
        _i = 4;

        if(iscop and _civ in drugsellarray)exitwith{_civ execVM "drugsearch.sqf"};

        _id     = _civ call INV_getshopnum;
        _id     = _id call INV_ItemShopAltStoreNum;
        _script = _civ call INV_getItemShopScript;

        [0, 0, 0, [_id]] execVM format["%1", _script];
        _handled=true;
      };

      if(!(isnull _atm) and _atm in bankflagarray) exitwith {
        _i = 4;
        if(!local_useBankPossible)exitwith{playsound"warnsfx";["GC_MoneyBad",["FIRST BANK OF STRATIS","The ATM rejected your card!"]] spawn bis_fnc_showNotification;};
        [] execVM "atm.sqf";
        _handled=true;
      };
    };

    if(_handled)exitwith{};

    if(vehicle player == player) exitwith {
      private ["_vcl"];
      for [{_i=1}, {_i < 3}, {_i=_i+1}] do {
        _range   = _i;
        _dirV    = vectorDir vehicle player;
        _pos     = player modelToWorld [0,0,0];
        _posFind = [(_pos select 0)+(_dirV select 0)*_range,(_pos select 1)+(_dirV select 1)*_range,(_pos select 2)+(_dirV select 2)*_range];
        _vcls    = nearestobjects [_posFind,["LandVehicle", "Air", "Ship","Tank"], 6];
        _vcl     = _vcls select 0;

        if(!(isnull _vcl))exitwith{_i = 4};
      };

      if(locked _vcl != 0)exitwith{};
      if (_vcl iskindof "UGV_01_base_F") then {
		if(_vcl emptyPositions "Cargo" > 0)exitwith  {player action ["getInCargo", _vcl]};
      } else {
	      if(_vcl emptyPositions "Driver" > 0)exitwith   {player action ["getInDriver", _vcl]};
	      if(_vcl emptyPositions "Gunner" > 0)exitwith   {player action ["getInGunner", _vcl]};
	      if(_vcl emptyPositions "Commander" > 0)exitwith{player action ["getInCommander", _vcl]};
	      if(_vcl emptyPositions "Cargo" > 0)exitwith  {player action ["getInCargo", _vcl]};
	     };
    };

    _vcl  = vehicle player;

    if(_vcl != player) exitwith {
      if(locked _vcl != 0)exitwith{player groupchat "The vehicle is locked."};
      if(speed _vcl > 30)exitwith{player groupchat "The vehicle is moving too fast!"};
      player action ["getOut", _vcl];
    };
  };

  //F key
  case 33: {
    if(!INV_shortcuts)exitwith{};

    if (!_shift and (player == vehicle player)) then {
      if (("flashlight" call INV_getItemAmount) > 0) exitWith {
        format ['
          if (isNil "%1flashLight") then {
            %1flashLight = "#lightpoint" createVehicle (position %1);
            %1flashLight setLightAmbient [1, 1, 0.9];
            %1flashLight setLightBrightness %2;
            %1flashLight lightAttachObject [%1, [0, 4, 0]];
          } else {
            deleteVehicle %1flashLight;
            %1flashLight = nil;
          };
        ', player, flashlightStrength] call broadcast;
        _handled=true;
      };
    };

    if(iscop and (vehicle player != player)) then {
      [0,0,0,["activate",2]] execVM "siren.sqf";
      _handled=true;
    };

    if(_shift and (vehicle player == player) and call INV_isArmed) then {
      if (unholstering) exitWith{player groupChat "Unholstering, please wait..."};
      _men = nearestobjects [player, ["Man"], 2] - [player];
      _men spawn {
	private ["_civ"];
	(format ["%1 switchmove ""%2"";", player, "AwopPercMstpSgthWnonDnon_end"]) call broadcast;
        sleep 0.2;

        if(count _this > 0) then {
          _civ = _this select 0;
          if(_civ distance player > 2 or !isPlayer _civ)exitwith{};

          if ( call GC_PlayerInCrimeFree ) exitWith {
          	playsound "buzzersfx";
		["GC_Bad2",["CHAOS LIFE RULE VIOLATION","You're not allowed to melee in the crime free zone!"]] spawn bis_fnc_showNotification;
          };

          if(iscop and (call GC_PlayerInCopBase) ) exitWith {
          	playsound "buzzersfx";
		["GC_Bad2",["CHAOS LIFE RULE VIOLATION","You're not allowed to melee in the cop base!"]] spawn bis_fnc_showNotification;
          };

          (format ["if (player == %1) then {[%2, ""Melee"", 1] spawn onStun;};", _civ, player]) call broadcast;

          player groupchat format["You knocked out %1 (%2)!",name _civ,_civ];
        };
      };

      _handled=true;
    };
  };

  //tilde key
  case 41: {
    if(!INV_shortcuts)exitwith{};

    if (_shift) exitWith {
      ["Settings"] execVM "settings.sqf";
      if(dialog)exitwith{closeDialog 0;_handled=true;};
    };
  };

  //1 key
  case 2: {
    if(!INV_shortcuts)exitwith{};
    _handled=true;
    if(dialog)exitwith{closeDialog 0;};

    [0,0,0,["spielerliste"]] execVM "maindialogs.sqf";
  };

  //2 key
  case 3: {
    if(chairaction != -1)exitwith{};
    if(!INV_shortcuts)exitwith{};

    if(dialog)exitwith{closeDialog 0;_handled=true;};
    [0,0,0,["inventory"]] execVM "maindialogs.sqf";
    _handled=true;
  };

  //3 key
  case 4: {
    if(!INV_shortcuts)exitwith{};
    if(chairaction != -1)exitwith{};
    if(keyblock or vehicle player != player)exitwith{};

    keyblock=true;
    [] spawn {sleep 2; keyblock=false;};
    _handled=true;

    if (animationstate player == "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon") then {
      player playmovenow "AmovPercMstpSnonWnonDnon";
    } else {
      player playmove "TestSurrender";
      player playmovenow "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon";
      player playmove "TestSurrender";
    };
  };

  //5 key
  case 6: {
    if(!INV_shortcuts)exitwith{};
    if(dialog)exitwith{closeDialog 0;_handled=true;};

    [0,0,0,["gangmenu"]] execVM "maindialogs.sqf";
    _handled = true;
  };

  //6 key
  case 7: {
    if(!INV_shortcuts)exitwith{};
    if(dialog)exitwith{closeDialog 0;_handled=true;};

    if (iscop) then {
      [0,0,0,["copmenu"]] execVM "maindialogs.sqf";
      _handled = true;
    };
  };

  //V
  case 47: {
  	//jump
  	if (!_shift) exitWith {};
  	_jaildist = player distance getMarkerPos "jailarea";
  	if (_jaildist <= 30) exitWith {["GC_Bad2",["JUMP","No jumping in jail!"]] spawn bis_fnc_showNotification;};
  	[] spawn {

private ["_height","_vel"];
if ((!doingSomething) and (vehicle player == player)) then {
			  doingSomething = true;
			  _vel = velocity player;
			  _height = abs(speed player) / (3.6 / jumpMod);

			  if (_height > (5.0 * jumpMod)) then {_height = (5.0 * jumpMod)};

			  player setVelocity [_vel select 0, _vel select 1, (_vel select 2)+_height];

			  format['%1 switchMove "AovrPercMrunSrasWrflDf";', player] call broadcast;
			  sleep 1.3;
			  doingSomething = false;
			};
		};
  	/*
    _vcl = vehicle player;

    if(_vcl getVariable "bunnyhop") then {
      [] execVM "gc\client\GC_itemsBunnyhop.sqf";
    };
    */
    _handled = true;
  };

  //Semicolon (;)
  case 39: {
    if(keyblock)exitwith{};
    if(call isprone)exitwith{};
    if(player call ISSE_IsVictim)exitwith{};
    if(chairaction != -1)exitwith{};
    if(underwater player) exitWith{};
    if (player distance getMarkerPos "jailarea" <= 30) exitWith { playsound "buzzersfx";["GC_Bad2",["CHAOS LIFE RULE VIOLATION","You're not allowed to melee in the crime free zone!"]] spawn bis_fnc_showNotification;    	};

    _firstWhistle = prevWhistles select 0;
    if (time > _firstWhistle + 60) then {
      if (vehicle player == player) then {
        format["%1 switchMove ""AmovPercMstpSnonWnonDnon_SaluteOut"";", player] call broadcast;
      };

      call compile format['SFXPvEh_%1 = ["%2","whistlesfx",2];',rolenumber,rolestring];

      publicVariable format["SFXPvEh_%1", rolenumber];

      keyblock=true;
      [] spawn {
        player say "whistlesfx";
        sleep 2;
        keyblock=false;
      };

      for "_i" from 0 to 4 do {
        prevWhistles set [_i, prevWhistles select (_i + 1)];
      };

      prevWhistles set [5, time];
    } else {
      [] execVM "gc\client\GC_shh.sqf";
    };
  };

  //H Key (Horn)
  case 35: {
    if ((vehicle player != player) and (driver vehicle player == player)) then {
      _horn = vehicle player getvariable "customhorn";
      if (!isnil "_horn") then {
        call compile format['SFXPvEh_%1 = ["%2","%3",4];',rolenumber,rolestring,_horn];
        publicVariable format["SFXPvEh_%1", rolenumber];
        keyblock=true;
        _horn spawn {
          player say _this;
          sleep 3;
          keyblock=false;
        };

        _handled=true;
      };
    };
  };
};

_handled;
