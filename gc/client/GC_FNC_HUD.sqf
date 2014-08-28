private ["_ui","_uiradar","_playerIsWanted","_hasradar","_digits","_target","_radardigits","_radartarget","_bounty","_starCount","_text","_loopcount","_typestr","_armorstr","_arr","_unsorted","_iswanted","_mybounty","_mwdata","_mw","_sorted","_mwlist","_Status_Hud","_health","_armor","_light","_heavy","_cash","_currentFatigue","_starsui","_wtextui","_healthui","_armorui","_cashui","_wantedui","_staminaGoodui","_staminaWarnui","_staminaFedui","_maskstr","_mask"];
sleep 1;
disableSerialization;

_loopcount = 0;
("GCHUD_Status" call BIS_fnc_rscLayer) cutRsc ["GCHUD_Status", "PLAIN"];
_ui            = uiNameSpace getVariable "GCHUD_Status";
_starsui       = _ui displayCtrl 63302; _starsui ctrlShow false;
_wtextui       = _ui displayCtrl 63303; _wtextui ctrlShow false;
_healthui      = _ui displayCtrl 63307; _healthui ctrlShow false;
_armorui       = _ui displayCtrl 63308; _armorui ctrlShow false;
_cashui        = _ui displayCtrl 63309; _cashui ctrlShow false;
_wantedui      = _ui displayCtrl 63310; _wantedui ctrlShow false;
_staminaGoodui = _ui displayCtrl 63311; _staminaGoodui ctrlShow false;
_staminaWarnui = _ui displayCtrl 63312; _staminaWarnui ctrlShow false;
_staminaFedui  = _ui displayCtrl 63313; _staminaFedui ctrlShow false;
_Status_Hud = false;

while {_loopcount <= 7200} do {
	_loopcount = _loopcount + 1;
	if (alive player and isdead == 0 and deadcam == 0) then {
		if (isCop) then {
			if (player == driver vehicle player) then {
				_hasradar = vehicle player getvariable "radar";
				if (isNil "_hasradar") then {
					_hasradar = 0;
				};
				if (_hasradar == 1) then {
					4 cutRsc ["GCHUD_CopRadar", "PLAIN"];
					_digits = vehicle player getvariable "radardigits";
					if (isNil "_digits") then {
						_digits = "<img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/> <img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/> <img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/>";
					};
					_target = vehicle player getvariable "radartarget";
					if (isNil "_target") then {
						_target = " ";
					};
					_uiradar = uiNameSpace getVariable "GCHUD_CopRadar";
					_radardigits = _uiradar displayCtrl 63305;
					_radartarget = _uiradar displayCtrl 63306;
					_radardigits ctrlSetStructuredText parseText _digits;
					_radartarget ctrlSetStructuredText parseText _target;
				};
			};
		  } else {
			_playerIsWanted = call compile format ["%1_wanted", player];
			if (_playerIsWanted == 1) then {
				_bounty = call compile format ["kopfcash_%1", player];
				_starCount = switch (true) do {
					case (_bounty >= 200000) : { 5 };
					case (_bounty >= 150000) : { 4 };
					case (_bounty >= 100000) : { 3 };
					case (_bounty >= 50000) : { 2 };
					default { 1 };
				};
				_text = [];
				for "_i" from 0 to (_starCount - 1) do {
					_text set [_i, "<img size='.5' image='images\wanted_star.paa'/>"];
				};
				_wtextui ctrlSetText "W A N T E D";
				_starsui ctrlSetStructuredText parseText format["<t align='center'>%1</t>", _text call ISSE_str_ArrToStr];
			} else {
				_wtextui ctrlSetText "";
				_starsui ctrlSetStructuredText parseText "";
			};
		};
			
		_health = round((1 - damage player) * 100);
		_armor = player getvariable "bodyarmorhits";
		_armorstr = "";
		_light = 'LightArmor' call INV_GetItemAmount;
		_heavy = 'HeavyArmor' call INV_GetItemAmount;
		_mask = 'GasMask' call INV_GetItemAmount;
		
		_typestr = "None";

		if (_light >= 1) then {
			_typestr = "Light";
		};			
		if (_heavy >= 1) then {
			_typestr = "Heavy";
		};			
		if (_heavy >= 1 or _light >= 1) then {
			if (isnil "_armor") then {
				_armorstr = format["<t shadow='1' shadowColor='#cc0000' font='PuristaBold' align='right' size='0.6' valign='middle'>%1</t><img size='0.8' align='right'  image='images\armor_full.paa'/>",_typestr];
			} else {
				if (_armor <= 4) then {
					_armorstr = format["<t shadow='1' shadowColor='#cc0000' font='PuristaBold' align='right' size='0.6' valign='middle'>%1</t><img size='0.8' align='right'  image='images\armor_full.paa'/>",_typestr];
				} else {
					if (_armor > 4) then {
						_armorstr = format["<t shadow='1' shadowColor='#cc0000' font='PuristaBold' align='right' size='0.6' valign='middle'>%1</t><img size='0.8' align='right'  image='images\armor_half.paa'/>",_typestr];
					};
					if (_armor >= 7) then {
						_armorstr = format["<t shadow='1' shadowColor='#cc0000' font='PuristaBold' align='right' size='0.6' valign='middle'>%1</t<img size='0.8' align='right'  image='images\armor_one.paa'/>",_typestr];
					};						
				};
			};
		} else {
			_armorstr = "<t shadow='1' shadowColor='#cc0000' font='PuristaBold' align='right' size='0.6' valign='middle'>None</t><img size='0.8' align='right'  image='images\armor_none.paa'/>";
		};
		if (_mask >= 1) then {
			_maskstr = "<img size='0.8' align='right' image='images\gasmask.paa'/>";
			_armorstr = _maskstr + _armorstr;
			if (goggles player != "G_Combat") then {
				player setvariable["goggles",goggles player,false];
				player addgoggles "G_Combat";
			};
		};		
		_cash = 'cash' call INV_GetItemAmount;
		//NYI flash health green when gettign healed, red when taking damage - glow when injured?
		_healthui ctrlSetStructuredText parseText format["<t shadow='1' shadowColor='#cc0000' font='PuristaBold' align='right' size='0.6' valign='middle'>%1</t><img size='0.8' align='right'  image='images\health.paa'/>",_health];
		_armorui ctrlSetStructuredText parseText _armorstr;
		//NYI flash cash green when gettign money, red when losing money
		_cashui ctrlSetStructuredText parseText format["<t shadow='1' shadowColor='#cc0000' font='PuristaBold' align='right' size='0.6' valign='middle'>%1</t><img size='0.8' align='right' image='images\dollarsign.paa'/>",[_cash,","] call format_integer];

		_currentFatigue = (getFatigue player);
		_staminaGoodui progressSetPosition 1 - (_currentFatigue);
		_staminaWarnui progressSetPosition 1 - (_currentFatigue);
		_staminaFedui progressSetPosition 1 - (_currentFatigue);

		if (iscop) then {
			_unsorted = [];
			{
				if (side _x == CIVILIAN or side _x == EAST or side _x == Resistance) then {
					_iswanted = call compile format ["%1_wanted", _x];
					_bounty = call compile format ["kopfcash_%1", _x];
					if (_iswanted == 1) then {
						_arr = [(round(_bounty / 1000) * -1),name _x];
						_unsorted = _unsorted + [_arr];
					};
				};
			} foreach playableunits;
			_sorted = [_unsorted,0] call CBA_fnc_sortNestedArray;
			_mwdata = "";
			{
				_mybounty = _x select 0;
				_mwdata = _mwdata + format["%2: $%1K<br/>",abs(_mybounty),_x select 1];
			} foreach _sorted;
			_mwlist = format["<t shadow='1' shadowColor='#000000' font='EtelkaMonospaceProBold' align='right' size='0.5' valign='middle'>%1</t>",_mwdata];			
			_mw = "";
			if (count _sorted > 0) then {
				_mw = "<t shadow='1' underline='true' shadowColor='#cc0000' font='PuristaBold' align='right' size='0.6' valign='middle'>Most Wanted</t><img size='0.8' align='right'  image='images\wanted_star.paa'/><br/>" + _mwlist;
			};
			_wantedui ctrlSetStructuredText parseText _mw;
		};
		if (_currentFatigue >= 0.5) then {
			_staminaGoodui ctrlShow false;
			_staminaFedui ctrlShow false;
			_staminaWarnui ctrlShow true;
		} else {
			if (time < fedUntil) then {
			  _staminaWarnui ctrlShow false;
			  _staminaGoodui ctrlShow false;
			  _staminaFedui ctrlshow true;
			} else {
			  _staminaWarnui ctrlShow false;
			  _staminaFedui ctrlshow false;
			  _staminaGoodui ctrlShow true;
			};
		};
		if (!_Status_Hud) then {
			_healthui ctrlShow true;	
			_armorui ctrlShow true;	
			_cashui ctrlShow true;
			_wantedui ctrlShow true;
			_wtextui ctrlShow true;
			_starsui ctrlShow true;
			_Status_Hud = true;
		};


			//display weight ??
			
			//display lethal non lethal??
			

	} else {
		_healthui ctrlShow false;	
		_armorui ctrlShow false;	
		_cashui ctrlShow false;	
		_wantedui ctrlShow false;	
		_staminaWarnui ctrlShow false;
		_staminaFedui ctrlshow false;
		_staminaGoodui ctrlShow false;
		_Status_Hud = false;
		waituntil{sleep 1; (alive player and isdead == 0)};
	};
  sleep 0.50;
};
diag_log text format["flushing %1",__FILE__];

hud_handle = [] spawn GC_HUD;
