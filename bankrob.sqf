_this = _this select 3;
_option  = _this select 0;
_safe = _this select 1;

if (_option == "ausrauben") then {
	_safe setvariable["Robbed",0,true];
	call compile format["local_cash = robpool%1", _safe];

	if (local_cash < 30000)exitwith{player groupchat "This safe has recently been stolen from and is empty."};

	if (!robenable)exitwith{player groupchat "You're already robbing the bank!"};
	if (!(call INV_isArmed) and !debug)exitWith{player groupChat localize "STRS_bank_rob_noweapon";};
	robenable = false;
	call compile format["robpool%1 = 0;publicvariable ""robpool%1"";", _safe];

	_sleep = round(bankrobdelay - (SKILL_ROBBERY));

	format['[0,1,2,["opfer", %1, %2, %3]] execVM "bankrob.sqf";', _safe, local_cash,_sleep] call broadcast;
	["Bank", player, local_cash] spawn Isse_AddCrimeLogEntry;

	for [{_i=0},{_i<4},{_i=_i+1}] do {
		if (alive player && player distance _safe >= 20 && !(player distance _safe > 30)) then {player groupchat "You are too far away from the safe you need to stay within 20m!"};
		if (alive player && player distance _safe > 30) then{
			player groupchat "You are too far away from the safe! You failed the robbery!";
			_i=4;
		} else {
			if (_i==0)then{player groupchat "You tripped the alarm!"};
			if (_i==1)then{player groupchat "Cracking safe..."};
			if (_i==2)then{player groupchat "Opening safe..."};
			if (_i==3)then{player groupchat "Stuffing pockets with cash..."};
			sleep (_sleep / 4);
			if (_i==3)then{player groupchat "The safe has been emptied!"};
		};
	};

	if (alive player && player distance _safe < 20) then {
		_safe setvariable["Robbed",1,true];
		_addskill = ((local_cash / 250) * 0.00015);
		["SKILL_ROBBERY",_addskill] call GC_addSkill;
		local_cash = local_cash + round(2500 * _addskill);
		['cash', local_cash] call INV_AddInventoreItem;
	} else {
		_safe setvariable["Robbed",2,true];
		player groupchat "You failed to rob the bank!";
	};

	stolencash = stolencash + local_cash;
	local_useBankPossible = false;
	robenable = true;
	rblock = rblock + ((local_cash/30000)*60);
	_rblock = rblock;

	sleep 2;

	if (_rblock != rblock)exitwith{};
	for [{rblock}, {rblock > -1}, {rblock=rblock-1}] do {sleep 1;};

	local_useBankPossible = true;
	stolencash = 0;
	rblock	   = 0;
};

if (_option == "opfer") then {
	_robpool = _this select 2;
	_sleep = _this select 3;

	titleText [localize "STRS_bank_rob_titlemsg", "plain"];
	if (alive player and deadcam == 0 and isdead == 0) then {
		_safe say "Bank_alarm";
		copbase1 say "Bank_alarm2";
	};

	for [{_i=0},{_i<4},{_i=_i+1}] do {
		sleep (_sleep/4);
		if ((_safe getvariable["Robbed",0])==2)then{_i=4;}; //Robbed Variable -----> 0 - No Robbery in Progress,  1 - Successful Robbery, 2 - Failed Robbery
	};

	sleep 2;

	if ((_safe getvariable["Robbed",0])==1) then {
		server globalchat format["The thief stole $%1!", _robpool];
		_percentlost = _robpool/1000000;
		_verlust = round(Kontostand*_percentlost);
		_insurance_count = 'bankversicherung' call INV_GetItemAmount;
		_player_has_no_insurace = _insurance_count == 0;

		if (_verlust > _robpool)then{_verlust = _robpool};

		if ((Kontostand <= _verlust) and (Kontostand >= 1) and (('bankversicherung' call INV_GetItemAmount) == 0)) then {
			Kontostand = 0;
			player groupchat localize "STRS_bank_rob_allmoneylost";
		};
		if ((Kontostand >  _verlust) and _player_has_no_insurace) then {
			Kontostand = Kontostand - _verlust;
			player groupchat format[localize "STRS_bank_rob_somemoneylost", (_verlust call ISSE_str_IntToStr), (Kontostand call ISSE_str_IntToStr)];
		};
		if (('bankversicherung' call INV_GetItemAmount) > 0) then {
			player groupchat localize "STRS_bank_rob_lostnomoney";
			['bankversicherung', -(1)] call INV_AddInventoreItem;
		};
	};
	if ((_safe getvariable["Robbed",0])==2) then {
		server globalchat "The thief failed the bank robbery! All the bank funds have been recovered!";
		_safe setvariable["Robbed",0,true];
	};
};