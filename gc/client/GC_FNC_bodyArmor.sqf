//Imago <imagotrigger@gmail.com> for Global Chaos

lasthitsfx = time;

GC_PlayArmorSFX = {
	if (lasthitsfx - time >= 2) then {
		call compile format['SFXPvEh_%1 = ["%2","armorsfx",0.5];',rolenumber,rolestring];
		publicVariable format["SFXPvEh_%1", rolenumber];					
		vehicle player say ["armorsfx",50];
		lasthitsfx = time;
	};
		
true;
};

GC_DamageModifier = {
	private ["_vs","_damage","_hitcount","_selection","_ammo"];
	_selection = _this select 0;
	_damage = _this select 1;
	_ammo = _this select 2;
	if (_selection != "head_hit" and _damage > 0.01) then {
		if (('HeavyArmor' call INV_GetItemAmount) > 0) then {
			_hitcount = player getvariable "bodyarmorhits";
			if (isnil "_hitcount") then {player setvariable ["bodyarmorhits",0,false];};
			_vs = false;
			if (_damage >= 1 and _selection != "Hands" and _selection != "Legs" and _hitcount == 0) then {
				player setvariable ["bodyarmorhits",(_hitcount + 10),false];
				call GC_PlayArmorSFX;
				_damage = 0.75;
			} else {
				if (_ammo in armor_big) then {
					_vs = true;
					_damage = _damage - (_damage * 0.25);
					if (_selection == "body") then {
						player setvariable ["bodyarmorhits",(_hitcount + 4),false];
						call GC_PlayArmorSFX;							
					};					
				};
				if (_ammo in armor_small) then {
					_vs = true;
					_damage = _damage - (_damage * 0.50);
					if (_selection == "body") then {
						player setvariable ["bodyarmorhits",(_hitcount + 2),false];
						call GC_PlayArmorSFX;						
					};					
				};
				if (!_vs) then {
					_damage = _damage - (_damage * 0.50);
					call GC_PlayArmorSFX;
				};
			};
			_hitcount = player getvariable "bodyarmorhits";
			if (_hitcount >= 10) then {
				['HeavyArmor', (-1)] call INV_SetItemAmount;
				player setvariable ["bodyarmorhits",0,false];
				player GroupChat "Your heavy body armor has been depleted!";
			};				
		} else {
			if (('LightArmor' call INV_GetItemAmount) > 0) then {
				_hitcount = player getvariable "bodyarmorhits";
				if (isnil "_hitcount") then {player setvariable ["bodyarmorhits",0,false];};
				_vs = false;
				if (_ammo in armor_big) then {
					_vs = true;
					_damage = _damage - (_damage * 0.10);
					if (_selection == "body") then {
						player setvariable ["bodyarmorhits",(_hitcount + 10),false];
						call GC_PlayArmorSFX;
					};					
				};
				if (_ammo in armor_small) then {
					_vs = true;
					_damage = _damage - (_damage * 0.25);
					if (_selection == "body") then {
						player setvariable ["bodyarmorhits",(_hitcount + 5),false];
						call GC_PlayArmorSFX;						
					};					
				};
				if (!_vs) then {
					_damage = _damage - (_damage * 0.25);
					call GC_PlayArmorSFX;
				};
				_hitcount = player getvariable "bodyarmorhits";
				if (_hitcount >= 10) then {
					['LightArmor', (-1)] call INV_SetItemAmount;
					player setvariable ["bodyarmorhits",0,false];
					player GroupChat "Your light body armor has been depleted!";
				};			
			};
		};
	};
_damage;
};