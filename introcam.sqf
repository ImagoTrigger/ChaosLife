//DOA <imagotrigger@gmail.com>, Amerine <mark@amerine.net> for Chaos Life 1.3 -  Terror in Stratis
private ["_text","_label"];
_label = _this select 0;

preload_thread = [] spawn {};

if (_label == "basicintro") then {
	waituntil {diag_log text "Introcam Waiting for findDisplay"; sleep 0.1; !(IsNull (findDisplay 46))};
	sleep 3;
	preload_thread = [] spawn {
        	private ["_preload"];
		_preload = [			"dollarsign.paa",		
			"gcadv_R.jpg",
			"gcadv_L.jpg",
			"silver_R.jpg",
			"silver_L.jpg",		
			"checkpoint.paa",
			"storage2.jpg",
			"storage1.jpg",
			"cityhall_R.jpg",
			"cityhall_L.jpg",
			"copbase_L.jpg",
			"copbase_R.jpg",
			"gc_atv_c.jpg",
			"gc_offroad_c.jpg",
			"gc_hunter_c.jpg",
			"gc_heli_c.jpg",
			"gc_hunter_p.jpg",
			"gc_heli_p.jpg",
			"gc_hunter_0.jpg",
			"gc_hunter_1.jpg",
			"gc_hunter_o.jpg",
			"gc_boat_c.jpg",
			"gc_boat_o.jpg",
			"gc_boat_p.jpg",
			"coveralls_prisoner_co.jpg"
		];
		sleep 2;
		{hintsilent parseText format["<img size='0.0001' image='images\%1'/>Caching chaos life images<br/>%1",_x];sleep 0.25;} foreach _preload;
		hintsilent "";
	};
  intromusic_obj = "Land_HelipadEmpty_F" createVehicleLocal (getpos player);
  intromusic_obj setpos [(getpos player select 0),(getpos player select 1),-1];

  if (iscop) then {intromusic_obj say ["copmusic",1];};
  if (isciv) then {intromusic_obj say ["civmusic",1];};
  ["<img size='16' image='images\terror_in_stratis.paa' shadow='0'/>", -1, (safezoneH-2)/2, 5, 2] call GC_dynamicText;
  
	["Presented by<br/> <t size='2' color='#cc0000'>Global Chaos Gaming</t>",-1,-1,3,0.5] call GC_dynamicText;

	call compile format['["Welcome\n%1"] spawn GC_infoText;',name player];

	["This is a role playing game!",-1,-1,2,0.5] call GC_dynamicText;

	["Civilians killing unarmed civilians without reason is called Deathmatching!<br /> <t size='1.3' color='#cc0000' shadow='1' shadowColor='#c6c6c6'>DON'T DO IT</t>",-1,-1,3,0.5] call GC_dynamicText;

	["Cops should never fire lethal rounds unless their life is in danger!",-1,-1,3,0.5] call GC_dynamicText;


	["Game guide, rules and Teamspeak Info are located on the map tabs.<br /><br />Please play by the rules and in the spirit of the game!",-1,-1,3,0.5] spawn GC_dynamicText;
	["Have Fun!"] spawn GC_infoText;

  _text = "Welcome to<br /> <t color='#cc0000' shadow='1' size='1.2'>Global Chaos Gaming</t><br />
  <img size='10' image='images\gclogo.paa'/>
  <t size='2' color='#cc0000'>Chaos Life!</t><br/><br />
  Please read the rules found in the briefing (press M) before playing!<br/>
  <br />
  <t color='#FFFF00'>Please report any players, bugs or issues using the !report command or the Global Chaos website</t>
  <br /><br />
  <t underline='true' color='#cc0000'>Contact Info:</t><br/>
  -= Team Speak 3 =-<br /> ts.gcg.io<br /><br />
  -= Website =- <br />GlobalChaosGaming.net<br /><br />";

	waituntil {sleep 0.1; (scriptDone preload_thread)};
  hint parseText _text;

  if (showChaosKeys and isMultiplayer) then {
  	sleep 5;
  	["FAQ"] execVM "settings.sqf";
  	processDiaryLink gc_diarylink;
  };

  if (iscop) then {sleep 5;};

  deletevehicle intromusic_obj;
  intromusic_obj = objnull;
};
