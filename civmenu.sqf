private ["_didnotpay","_strafe1","_strafe2","_cash","_strafe","_cop","_didpay","_copplayernumber","_copticket","_i","_amount","_preis","_item","_infos","_checkcop","_class","_uniform","_gangFlagUser","_INVrmv","_BNKrmv","_playercaught","_exitart","_tur","_minutes","_seconds","_released","_bounty","_frac","_timetotake","_sec","_remain","_bail","_counter","_copobj","_prisondauer","_civkopfcash","_tBounty","_aktionsStarter","_amounttosteal","_option"];
_option = _this select 0;
_cash    = 'cash' call INV_GetItemAmount;

if (_option == "disarm") then
  {
    call INV_RemoveIllegalItems;
    player groupChat localize "STRS_civmenucheck_beendisarmed";
  };

if (_option == "ticket") then
  {
    _strafe = _this select 1;
    _cop    = _this select 2;
    _didpay = 0;
    _copplayernumber = playersNumber west;
    _copticket = round(_strafe/_copplayernumber);

    if (!(createDialog "RscMenuYesNo")) exitWith {hint "Dialog Error!"};

    ctrlSetText [1, format["%1 gave you a ticket of $%2. Do you want to pay?", _cop, (_strafe call ISSE_str_IntToStr)]];

    waitUntil{(not(ctrlVisible 1023))};

    if (Antwort == 1) then
      {
        if ((_cash + kontostand) < _strafe) exitwith
          {
            (format ["server globalChat format [localize ""STRS_civmenu_didnotpayticket"", name %2, %3];", _cop, player, (_strafe call ISSE_str_IntToStr)]) call broadcast;
          };

        false call TurnWantedFunc;
        player groupChat format [localize "STRS_civmenucheck_ticketself", (_strafe call ISSE_str_IntToStr)];
        (format ["server globalChat format [localize ""STRS_civmenu_didpayticket"", name %2, %3];[""Ticket"", %2, %3, %1] spawn Isse_AddCrimeLogEntry;if (iscop) then{player groupChat ""You got $%4 because the %2 paid the ticket."";[""cash"", %4] call INV_AddInventoreItem;};kopfcash_%2 = kopfcash_%2 - %3; if(kopfcash_%2 < 0)then{kopfcash_%2 = 0};", _cop, player, (_strafe call ISSE_str_IntToStr), (_copticket call ISSE_str_IntToStr)]) call broadcast;

        if(_cash > _strafe) exitwith {['cash', -(_strafe)] call INV_AddInventoreItem;};
        if (kontostand > _strafe) exitwith {kontostand = kontostand - _strafe;};

        if ((_cash + kontostand) > _strafe) exitwith
          {
            _strafe1 = _cash;
            _strafe2 = _strafe - _strafe1;
            ['cash', -(_strafe1)] call INV_AddInventoreItem;
            kontostand = kontostand - _strafe2;
          };
      };

    if (Antwort == 2) then
      {
        (format ["server globalChat format [localize ""STRS_civmenu_didpaynothing"", name %2];", _cop, player, (_strafe call ISSE_str_IntToStr)]) call broadcast;
        player groupChat localize "STRS_civmenu_youdidnotpay";
      };
  };


if (_option == "drugs") then
  {
    _checkcop = _this select 1;
    drugsvalue = 0;

    if (["INV", "drug"] call INV_StorageHasKindOf) then
      {
        for [{_i=0}, {_i < (count INV)}, {_i=_i+1}] do
          {
            _item   = ((INV select _i) select 0);
            _infos  = _item call INV_getitemArray;

            if(_item call INV_getitemKindOf == "drug") then
              {
                _amount = (_item call INV_GetItemAmount);
                _preis  = (_infos call INV_getitemBuyCost);
                drugsvalue = drugsvalue + (_preis*_amount);
              };

          };

        ["INV", "drug"] call INV_StorageRemoveKindOf;

        (format ["[""DrugPossession"", %1, %3] spawn Isse_AddCrimeLogEntry;if(!(""trafficking drugs"" in %1_reason))then{%1_reason = %1_reason + [""trafficking drugs""]}; %1_wanted = 1; kopfcash_%1 = kopfcash_%1 + (%3); if (player == %2) then {player groupChat format[localize ""STRS_civmenu_hasdrugs"", %1, %4, (%3/2)];}; titletext [format[localize ""STRS_civmenucheck_haddrugs"", %1, %3], ""plain""];", player, _checkcop, drugsvalue, ceil(drugsvalue/25000)]) call broadcast;

        player groupChat localize "STRS_civmenucheck_beendrugsearched";

      } else {
        (format ["if (player == %2) then {player groupChat localize ""STRS_civmenu_hasnodrugs"";};", player, _checkcop]) call broadcast;};
      };

if (_option == "arrest") then
  {
    _copobj      = _this select 2;


    if (!(player call ISSE_IsVictim)) exitwith {(format ["if (rolestring == ""%1"") then {player groupchat localize ""STRS_inventory_checknohands""};", _copobj]) call broadcast;};
    	_prisondauer = (_this select 1)*60;
    	_civkopfcash = call compile format ["kopfcash_%1", player];
    	_copobj      = _this select 2;
	if ("bomb" in INV_LizenzOwner) then {
		_class = player getvariable "uniform";
		_class call GC_ChangeSkin;
		INV_LizenzOwner = INV_LizenzOwner - ["bomb"];
		["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;
		last_terror_time = time;
		["TerroristArrested", player, _copobj, _civkopfcash] spawn Isse_AddCrimeLogEntry;
	};
	_exitart     = "";
    player setVariable ["releasetime",(time + _prisondauer), false];
    if (_civkopfcash != 0) then
      {
        //record a sucessful arrest of a wanted criminal
        (format['
        	if(rolestring == "%1")then{
        		kontostand = kontostand + %2;
        		player groupChat "This civ had a bounty of $%2! You got that bounty!";
        		CivsBusted = CivsBusted + 1;
        		RewardsCollected = RewardsCollected + %2;
        	};
        	', _copobj, _civkopfcash]) call broadcast;
      };
    if (impersonating) then {
    	impersonating = false;
    	_uniform = player getvariable "uniform";
    	format['%1 addUniform "%2";',rolestring,_uniform] call broadcast;
    };
    (format ["server GLOBALCHAT format [localize ""STRS_civmenucheck_arrested_global"", name %1, name %3, %2]; [""PrisonIn"", %1, %3, %2] spawn Isse_AddCrimeLogEntry; kopfcash_%1 = (%2*30000);%1_wanted = 0;%1_arrest = 1;", player, ((_prisondauer/60) call ISSE_str_IntToStr), _copobj]) call broadcast;

    local_arrest    = 1;
    ["local_arrest", local_arrest] call ClientSaveVar;
	takingFlag = false;
	if (!isnil "flagCancel") then { player removeAction flagCancel; };
	{
		_gangFlagUser = _x getVariable ["mover", objNull];
		if (player == _gangFlagUser) then {
			_x setVariable["mover", nil, true];
		};
	} forEach gangAreas;

    player setpos getmarkerpos "prisonspawn";
    (format ["%1 playmovenow ""%2"";", player, "AmovPercMstpSnonWnonDnon"]) call broadcast;

    call INV_RemoveIllegalItems;

    INV_hunger      = 0;
    CivTimeInPrison = (_this select 1);

    player groupChat format [localize "STRS_civmenucheck_arrested_self", (CivTimeInPrison call ISSE_str_IntToStr)];

    stolencash = 0;
    player setdamage 0;
    _counter = 0;
    _tBounty = (_prisondauer/60)*30000;

    while {true} do
      {
        _released     = call compile format ["%1_arrest", player];
        _bounty       = call compile format["kopfcash_%1", player];
        _frac         = _bounty/_tBounty;
        _timetotake   = round(_prisondauer*_frac);

        call compile format["kopfcash_%1 = kopfcash_%1 - (30000/60)", player];

	_sec = (player getVariable "releasetime");
        if (isNil "_sec") exitWith {_exitart = "free"};

        _remain = _sec - time;
	_minutes = 0;
	_seconds = round(_remain);
	_tur = "";
	if (_remain > 59) then {
		_minutes = floor (_remain / 60);
		_seconds = _seconds - (_minutes * 60);
		if (_seconds == 0) then {
			_tur = format["%1 min",_minutes];
		} else {
			_tur = format["%1 min, %2 seconds",_minutes,_seconds];
		};
	} else {
        	_tur = format["%1 seconds",_seconds];
        };
        _bail = _remain * 500;
        if (time >= _sec)           exitWith {_exitart = "free"};
	if (_counter >= _prisondauer)           exitWith {_exitart = "free"};
	hintsilent parseText format["<t shadow='1' shadowColor='#cc0000' underline='1' size='1.1' font='PuristaBold' align='center' valign='top'>Remaining sentence</t><br/><t align='center' valign='bottom' font='LucidaConsoleB'>%1</t><br/><t shadow='1' shadowColor='#cc0000' underline='1' size='1.1' font='PuristaBold' align='center' valign='top'>Remaining bail</t><br/><t align='center' valign='bottom' font='LucidaConsoleB'>$%2</t>", _tur, round(_bail)];

        if (isNull(player))                     exitWith {_exitart = ""};
        if (!(alive player))                    exitWith {_exitart = "tot"};
        if (_counter >= _prisondauer)           exitWith {_exitart = "free"};
        if (_released == 0)                     exitWith {_exitart = "released"};
        if (player Distance prison_logic >= 40) exitWith {_exitart = "escape"};
        if (_bounty <= 0)                       exitwith {_exitart = "released"};
        if (_bail <= 0)                       	exitwith {_exitart = "released"};

        _counter = _counter + 1;
        sleep 1;
      };
      hintsilent "";
    if ((_exitart == "free") or (_exitart == "released")) then
      {
        player setPos getMarkerPos "jail_freemarker";	player setdamage 0;
        (format ["if (player == %1) then {local_arrest = 0; [""local_arrest"", local_arrest] call ClientSaveVar; player groupChat localize ""STRS_civmenucheck_free_self"";}; server GLOBALCHAT format [localize ""STRS_civmenucheck_free_global"", name %1]; [""PrisonOut"", %1] spawn Isse_AddCrimeLogEntry; %1_reason = []; kopfcash_%1 = 0; %1_arrest = 0;", player]) call broadcast;
      };

    if (_exitart == "escape") then
      {
        (format ["if (player == %1) then {local_arrest = 0; [""local_arrest"", local_arrest] call ClientSaveVar;}; %1_arrest = 0; if(!(""escaping from jail"" in %1_reason))then{%1_reason = %1_reason + [""escaping from jail""]}; %1_wanted = 1; kopfcash_%1 = 20000; server GLOBALCHAT format [localize ""STRS_civmenucheck_breakout"", name %1]; [""PrisonEsc"", %1] spawn Isse_AddCrimeLogEntry;", player]) call broadcast;
      };
  };

if (_option == "inventcheck") then
  {
    _aktionsStarter = _this select 1;
    (format ['if (rolestring == "%1") then {[0, 0, 0, ["inventorycheck", %2, %3, %4]] execVM "maindialogs.sqf";};',_aktionsStarter, INV_LizenzOwner, INV, player]) call broadcast;
  };

if (_option == "stealmoney") then
  {
    _aktionsStarter = _this select 1;
    if(stolenfromtimeractive) exitwith
      {
        (format ['if (rolestring == "%1") then {hint "%2 has been stolen from recently";};', _aktionsStarter, player]) call broadcast;
      };
    _cash  = 'cash' call INV_GetItemAmount;
    _amounttosteal = (floor(random _cash));
    ["cash", -(_amounttosteal)] call INV_AddInventoreItem;
    (format ['if (rolestring == "%1") then {["cash", %2] call INV_AddInventoreItem;["SKILL_ROBBERY",0.010] call GC_addSkill;};hint "%1 stole %2 from %3"; ["Stole", %1, %3, %2] spawn Isse_AddCrimeLogEntry;',_aktionsStarter, _amounttosteal, player]) call broadcast;
    stolenfromtimeractive = true;
    sleep stolenfromtime;
    stolenfromtimeractive = false;
  };