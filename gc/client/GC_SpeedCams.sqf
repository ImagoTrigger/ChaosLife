private ["_penalty","_infos","_license","_obj","_speed","_veh","_ticket1","_ticket2","_alreadytagged","_ticket","_cash"];
_veh = _this;
while {alive _veh and _veh != player and player == driver _veh} do {
	_speed = speed _veh;
	{
		_obj = _x select 0;
		if (_veh distance _obj < 30 and _speed >= 77 and !(_veh iskindof "Air")) then {
			if (iscop and siren_is_on) exitWith {sleep 1;};
			pip_thread = _obj spawn {
				_nv = 0;
				if (SunOrMoon == 0) then {_nv = 1};
				[_this,vehicle player,player,_nv] call BIS_fnc_liveFeed;
				sleep 3.5;
				[] call BIS_fnc_liveFeedTerminate;			
			};
			call compile format['SFXPvEh_%1 = ["%2","speedcamsfx"];',rolenumber,_obj];
			publicVariable format["SFXPvEh_%1", rolenumber];          
			_obj say ["speedcamsfx",100];		
			titleCut [" ","white in",1];
			player groupchat format["Slow down! You've just been busted speeding (%1) by a traffic camera.", round _speed];
			_penalty = 0;
			if(_speed >= 77  and _speed < 110) then {_penalty = 1};
			if(_speed >= 110 and _speed < 130) then {_penalty = 2};
			if(_speed >= 130 and _speed < 150) then {_penalty = 3};
			if(_speed >= 150 and _speed < 170) then {_penalty = 6};
			if(_speed >= 170 		 ) then {_penalty = 7};	
			_ticket = _penalty * 1000;
			if (iscop) then {_ticket = _ticket * 3;};
			_cash    = 'cash' call INV_GetItemAmount;
			if ((_cash + kontostand) < _ticket) then {
				demerits = 1;
				player groupchat "You don't have enough money to pay the fine!";
				if (iscop) then {
					_veh setvelocity [0,0,0];
					_veh lock 0;
					{
						_x Action ["eject", _veh];
						_x Action ["getout", _veh];
					} forEach (crew _veh);
					[_veh, "impound"] execVM "impound.sqf";
					player setpos getpos _obj;
				};
			} else {
				if(_cash >= _ticket) then {
					['cash', -(_ticket)] call INV_AddInventoreItem;
				} else {
					if (kontostand >= _ticket) then {
						kontostand = kontostand - _ticket;
					} else {
						if ((_cash + kontostand) >= _ticket) then {
							_ticket1 = _cash;
							_ticket2 = _ticket - _ticket1;
							['cash', -(_ticket1)] call INV_AddInventoreItem;
							kontostand = kontostand - _ticket2;
						};
					};
				};	
				player groupchat "You've paid the fine.";
			};
			sleep 2;
			if (iscop) exitWith {};
			_infos   = (typeof _veh) call INV_getitemArray;
			_license = (_infos select 4) select 1;
			_alreadytagged = false;
			call compile format['if ("excessive speeding" in %1_reason) then {_alreadytagged = true;}',player];
			if (!(_license call INV_HasLicense) and !_alreadytagged) then {
				format['server globalchat "%1 was photographed %2 speeding without a license!";',name player, (_x select 1)] call broadcast;
				format [" [""Speed"", %1] spawn Isse_AddCrimeLogEntry; if(!(""excessive speeding"" in %1_reason))then{%1_reason = %1_reason + [""excessive speeding""]; kopfcash_%1 = kopfcash_%1 + 10000;}; %1_wanted = 1;", player] call broadcast;
				_alreadytagged = true;
			};
			if(demerits == 0 or _license == "bomb")exitwith{};
			demerits = demerits - _penalty;
			if(demerits < 0)then{demerits = 0};
			player groupchat format["You have %1 points remaining on your license!", demerits];
			if(demerits == 0) then {
				format['server globalchat "%1 has lost his %2 license on %3!";',name player,_license, (_x select 1)] call broadcast;
				INV_LizenzOwner = INV_LizenzOwner - [_license]; 
				["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;
				format [" [""Speed"", %1] spawn Isse_AddCrimeLogEntry; if(!(""excessive speeding"" in %1_reason))then{%1_reason = %1_reason + [""excessive speeding""]; kopfcash_%1 = kopfcash_%1 + 10000;}; %1_wanted = 1;", player] call broadcast;
			};
		};
	} foreach speedcamarray;
	sleep 0.5;
};
