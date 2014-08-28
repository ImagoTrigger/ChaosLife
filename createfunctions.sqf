INV_CreateGunboxLocal = {};

INV_DialogPlayers =

{

private ["_c","_Fid","_Fname","_Fingame","_Findex","_Flistlen","_Feigenenum","_Fpname","_Fspieler","_unit"];
_Fid        = _this select 0;
_Fname      = _this select 1;
_Fingame    = _this select 2;
_Findex     = 0;
_Flistlen   = 0;
_Feigenenum = -1;

for [{_c=0}, {_c < (count INV_PLAYERSTRINGLIST)}, {_c=_c+1}] do

	{

	_Fspieler = INV_PLAYERSTRINGLIST select _c;
	_unit = (call compile _Fspieler);
	_Fpname = nil;
	if (!alive _unit) then {
		_Fpname = _unit getVariable "deadname";
	} else {
		_Fpname = name _unit;
	};

	if ( ((_Fingame) or (_Fspieler call ISSE_UnitExists)) ) then

		{

		if (_Fname and _Fpname != "ChaosBot") then

			{

			_Findex = lbAdd [_Fid, format ["%1 - (%2)", _Fspieler, _Fpname]];

			}
			else
			{

			_Findex = lbAdd [_Fid, _Fspieler];

			};

			lbSetData [_Fid, _Findex, format["%1", _c]];
			if (_Fspieler == INV_ROLESTRING) then {_Feigenenum = _Flistlen;};
			_Flistlen = _Flistlen + 1;

		};

	};

[_Flistlen, _Feigenenum]

};

INV_CreateVehicle = {
	private ["_classname","_mastername","_code","_code2","_logic","_ctime"];
	_mastername = _this select 0;
	_logic	   = _this select 1;
	_classname = _mastername call INV_getitemClassName;
	_code = "";
	_code2 = "";
	_ctime = round(time);
	if (_classname == "C_Offroad_01_F") then {
		//all offroads in cop spawn are cop offroads
		if (_logic == ccarspawn_0 or _logic == ccarspawn_1 or _logic == ccarspawn_2 or _logic == ccarspawn_3) then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'images\gc_offroad_c.jpg'];vehicle_%1_%2 animate ['HidePolice', 0];vehicle_%1_%2 animate ['HideServices', 1];vehicle_%1_%2 animate ['HideBackpacks', 0];vehicle_%1_%2 animate ['HideBumper1', 0];vehicle_%1_%2 animate ['HideBumper2', 0];vehicle_%1_%2 animate ['HideConstruction', 1];vehicle_%1_%2 animate ['HideDoor1', 0];vehicle_%1_%2 animate ['HideDoor2', 0];vehicle_%1_%2 animate ['HideDoor3', 0];",rolestring, _ctime];
		} else {
			//otherwise determine texture color from master name
			if (_mastername == "C_Offroad_01_F_maroon") then {
				_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE04_CO.paa'];",rolestring, _ctime];
			};
			if (_mastername == "C_Offroad_01_F_blue") then {
				_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE05_CO.paa'];",rolestring, _ctime];
			};
			if (_mastername == "C_Offroad_01_F_teal") then {
				_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE03_CO.paa'];",rolestring, _ctime];
			};
			if (_mastername == "C_Offroad_01_F_white") then {
				_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE02_CO.paa'];",rolestring, _ctime];
			};
			if (_mastername == "C_Offroad_01_F_tan") then {
				_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_F\Offroad_01\Data\Offroad_01_ext_BASE01_CO.paa'];",rolestring, _ctime];
			};
			if (_mastername == "C_Offroad_01_F_red") then {
				_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_F\Offroad_01\Data\offroad_01_ext_co.paa'];",rolestring, _ctime];
			};
		};
	};
	if (_classname == "C_Quadbike_01_F") then {
		if (_mastername == "C_Quadbike_01_F_red") then {
			_code = format["vehicle_%1_%2 setobjecttexture[1,'\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_wheel_CIVRED_CO.paa'];vehicle_%1_%2 setobjecttexture[0,'\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_CIV_RED_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Quadbike_01_F_white") then {
			_code = format["vehicle_%1_%2 setobjecttexture[1,'\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_wheel_CIVWHITE_CO.paa'];vehicle_%1_%2 setobjecttexture[0,'\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_CIV_WHITE_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Quadbike_01_F_black") then {
			_code = format["vehicle_%1_%2 setobjecttexture[1,'\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_wheel_CIVBLACK_CO.paa'];vehicle_%1_%2 setobjecttexture[0,'\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_CIV_BLACK_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Quadbike_01_F_blue") then {
			_code = format["vehicle_%1_%2 setobjecttexture[1,'\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_wheel_CIVBLUE_CO.paa'];vehicle_%1_%2 setobjecttexture[0,'\A3\Soft_F_Beta\Quadbike_01\Data\Quadbike_01_CIV_BLUE_CO.paa'];",rolestring, _ctime];
		};
	};
	if (_classname == "I_G_Quadbike_01_F") then {
		if (_mastername == "I_G_Quadbike_01_F_hunting") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\Soft_F_Gamma\Quadbike_01\data\quadbike_01_indp_hunter_co.paa'];vehicle_%1_%2 setobjecttexture[1,'\A3\Soft_F_Gamma\Quadbike_01\data\quadbike_01_wheel_indp_hunter_co.paa'];",rolestring, _ctime];
		};
	};	
	if (_classname == "C_Hatchback_01_F") then {
		if (_mastername == "C_Hatchback_01_F_white") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_F_cream") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_BASE01_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_F_green") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_BASE02_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_F_nblue") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_BASE03_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_F_blue") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_BASE04_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_F_shit") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_BASE05_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_F_yellow") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_BASE06_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_F_lgrey") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_BASE07_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_F_dgrey") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_BASE08_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_F_black") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_BASE09_CO.paa'];",rolestring, _ctime];
		};		
	};	
	if (_classname == "C_Hatchback_01_sport_F") then {
		if (_mastername == "C_Hatchback_01_sport_F_red") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_SPORT01_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_sport_F_blue") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_SPORT02_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_sport_F_orange") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_SPORT03_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_sport_F_gc") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_SPORT04_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_sport_F_grey") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_SPORT05_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Hatchback_01_sport_F_green") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\Hatchback_01\data\Hatchback_01_ext_SPORT06_CO.paa'];",rolestring, _ctime];
		};		
	};
	if (_classname == "C_SUV_01_F") then {
		if (_mastername == "C_SUV_01_F_red") then {
				_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\Soft_F_Gamma\SUV_01\Data\SUV_01_ext_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_SUV_01_F_black") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\Soft_F_Gamma\SUV_01\Data\SUV_01_ext_02_CO.paa'];",rolestring, _ctime];
		};	
		if (_mastername == "C_SUV_01_F_grey") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\Soft_F_Gamma\SUV_01\Data\SUV_01_ext_03_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_SUV_01_F_orange") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\Soft_F_Gamma\SUV_01\Data\SUV_01_ext_04_CO.paa'];",rolestring, _ctime];
		};		
	};
	if (_classname == "C_Van_01_fuel_F") then {
		if (_mastername == "C_Van_01_fuel_F_white") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\van_01\Data\van_01_ext_CO.paa'];vehicle_%1_%2 setobjecttexture[1,'\A3\soft_f_gamma\van_01\Data\van_01_tank_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Van_01_fuel_F_red") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\van_01\Data\van_01_ext_red_CO.paa'];vehicle_%1_%2 setobjecttexture[1,'\A3\soft_f_gamma\van_01\Data\van_01_tank_red_CO.paa'];",rolestring, _ctime];
		};		
	};
	if (_classname == "C_Van_01_box_F") then {
		if (_mastername == "C_Van_01_box_F_white") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\van_01\Data\van_01_ext_CO.paa'];vehicle_%1_%2 setobjecttexture[1,'\A3\soft_f_gamma\van_01\Data\van_01_tank_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Van_01_box_F_red") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\van_01\Data\van_01_ext_red_CO.paa'];vehicle_%1_%2 setobjecttexture[1,'\A3\soft_f_gamma\van_01\Data\van_01_tank_red_CO.paa'];",rolestring, _ctime];
		};	
	};
	if (_classname == "C_Van_01_transport_F") then {
		if (_mastername == "C_Van_01_transport_F_white") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\van_01\Data\van_01_ext_CO.paa'];vehicle_%1_%2 setobjecttexture[1,'\A3\soft_f_gamma\van_01\Data\van_01_tank_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Van_01_transport_F_red") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\van_01\Data\van_01_ext_red_CO.paa'];vehicle_%1_%2 setobjecttexture[1,'\A3\soft_f_gamma\van_01\Data\van_01_tank_red_CO.paa'];",rolestring, _ctime];
		};	
	};	
	if (_classname == " I_G_Van_01_fuel_F") then {
		if (_mastername == "I_G_Van_01_fuel_F_white") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\van_01\Data\van_01_ext_CO.paa'];vehicle_%1_%2 setobjecttexture[1,'\A3\soft_f_gamma\van_01\Data\van_01_tank_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "I_G_Van_01_fuel_F_red") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\van_01\Data\van_01_ext_red_CO.paa'];vehicle_%1_%2 setobjecttexture[1,'\A3\soft_f_gamma\van_01\Data\van_01_tank_red_CO.paa'];",rolestring, _ctime];
		};	
	};
	if (_classname == "I_G_Van_01_transport_F") then {
		if (_mastername == "I_G_Van_01_transport_F_white") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\van_01\Data\van_01_ext_CO.paa'];vehicle_%1_%2 setobjecttexture[1,'\A3\soft_f_gamma\van_01\Data\van_01_tank_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "I_G_Van_01_transport_F_red") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\soft_f_gamma\van_01\Data\van_01_ext_red_CO.paa'];vehicle_%1_%2 setobjecttexture[1,'\A3\soft_f_gamma\van_01\Data\van_01_tank_red_CO.paa'];",rolestring, _ctime];
		};	
	};	
	if (_classname == "C_Rubberboat") then {
		if (_mastername == "C_Rubberboat_sea") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\boat_F\Boat_Transport_01\data\Boat_Transport_01_indp_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Rubberboat_black") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\boat_F\Boat_Transport_01\data\Boat_Transport_01_CO.paa'];",rolestring, _ctime];
		};
		if (_mastername == "C_Rubberboat_camo") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\A3\boat_F\Boat_Transport_01\data\Boat_Transport_01_opfor_CO.paa'];",rolestring, _ctime];
		};
	};
	if (_classname == "B_Boat_Armed_01_minigun_F") then {
		_code = format["vehicle_%1_%2 setobjecttexture[1,'images\gc_boat_o.jpg'];vehicle_%1_%2 setobjecttexture[2,'images\gc_boat_p.jpg'];vehicle_%1_%2 setobjecttexture[0,'images\gc_boat_c.jpg'];",rolestring, _ctime];
	};
	if (_classname == "B_MRAP_01_F") then {
		if (_mastername == "B_MRAP_01_F_gc") then {
			_code = format["vehicle_%1_%2 setobjecttexture[1,'images\gc_hunter_1.jpg'];vehicle_%1_%2 setobjecttexture[0,'images\gc_hunter_0.jpg'];",rolestring, _ctime];
		};
		if (_mastername == "B_MRAP_01_F_cop") then {
			_code = format["vehicle_%1_%2 setobjecttexture[1,'images\gc_hunter_p.jpg'];vehicle_%1_%2 setobjecttexture[0,'images\gc_hunter_c.jpg'];",rolestring, _ctime];
		};
		if (_mastername == "B_MRAP_01_F_cr") then {
			_code = format["vehicle_%1_%2 setobjecttexture[1,'images\mrap_01_adds_co.jpg'];vehicle_%1_%2 setobjecttexture[0,'images\mrap_01_base_co.jpg'];",rolestring, _ctime];
		};		
		
	};
	if (_classname == "B_MRAP_01_hmg_F" or _classname == "B_MRAP_01_gmg_F") then {
		if (_logic == scarspawn1 or _logic == scarspawn1_1) then {
			_code = format["vehicle_%1_%2 setobjecttexture[2,'images\gc_hunter_o.jpg'];vehicle_%1_%2 setobjecttexture[1,'images\gc_hunter_p.jpg'];vehicle_%1_%2 setobjecttexture[0,'images\gc_hunter_c.jpg'];",rolestring, _ctime];
		};
	};
	if (_classname == "O_Quadbike_01_F") then {
		if (_logic == ccarspawn_0 or _logic == ccarspawn_1 or _logic == ccarspawn_2 or _logic == ccarspawn_3) then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'images\gc_atv_c.jpg'];",rolestring, _ctime];
		};
	};
	if (_classname == "B_Heli_Transport_01_F") then {
		if (_logic == cairspawn_0 or _logic == cairspawn_1) then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'images\gc_heli_p.jpg'];",rolestring, _ctime];
		};
	};
	if (_classname == "B_Heli_Light_01_F") then {
		if (_mastername == "B_Heli_Light_01_F_blue") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'images\gc_heli_c.jpg'];",rolestring, _ctime];
		};
		if (_mastername == "B_Heli_Light_01_F_red") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_co.paa'];",rolestring, _ctime];
		};
		if (_mastername == "B_Heli_Light_01_F_black") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\a3\air_f\Heli_Light_01\Data\heli_light_01_ext_ion_co.paa'];",rolestring, _ctime];
		};
	};
	if (_classname == "O_Heli_Light_02_unarmed_F") then {
		if (_mastername == "O_Heli_Light_02_unarmed_F_civ") then {
			_code = format["vehicle_%1_%2 setobjecttexture[0,'\a3\Air_F\Heli_Light_02\Data\heli_light_02_ext_civilian_co.paa'];",rolestring, _ctime];
		};
	};

	if (iscop) then {
		_code2 = format["vehicle_%1_%2 setvariable ['customhorn','airhornsfx',true];",rolestring, _ctime];
	};
	if (_code != "") then {
		_morecode = format["vehicle_%1_%2 setvariable ['customskin',{%3},true];",rolestring, _ctime,_code];
		_code = _code + _morecode;
	};
	call compile format ['
		vehicle_%1_%2 = _classname createVehicle %4;
		{ vehicle_%1_%2 disableCollisionWith _x; } foreach nearestobjects [getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition"), ["Fin_random_F","Alsatian_Random_F","Hen_random_F","Cock_Random_F"], 20000];
		vehicle_%1_%2 setVehicleVarName "vehicle_%1_%2";
		vehicle_%1_%2 addEventHandler ["GetIn", {_this call onGetIn;}];
		vehicle_%1_%2 setpos %4;
		vehicle_%1_%2 setdir %5;
		vehicle_%1_%2 setVariable["created",time,true];
		vehicle_%1_%2 lock 2;
	', rolestring, _ctime, INV_CALL_CREATVEHICLE, getpos _logic, getdir _logic];
	call compile format['[[[vehicle_%1_%2,"vehicle_%1_%2","%3","%4"],"gc\global\GC_onVehicleCreated.sqf"],"BIS_fnc_execVM",true,true] call BIS_fnc_MP;',rolestring, _ctime,_code,_code2];
	sleep 0.5;
	call compile format['
		if (vehicle_%1_%2 iskindof "Air") then {
			vehicle_%1_%2 say "createairsfx";
			SFXPvEh_%3 = ["vehicle_%1_%2","createairsfx"];
			publicVariable "SFXPvEh_%3";
		} else {
			vehicle_%1_%2 say "createlandsfx";
			SFXPvEh_%3 = ["vehicle_%1_%2","createlandsfx"];
			publicVariable "SFXPvEh_%3";
		};
		if (vehicle_%1_%2 iskindof "UAV_01_base_F" || vehicle_%1_%2 iskindof "UAV_02_base_F" || vehicle_%1_%2 iskindof "UGV_01_base_F") then {
			CreateVehicleCrew vehicle_%1_%2;
			{ 
				diag_log text "Creating a civ drone! - TODO change the crew for civs!!! --Imago";
				diag_log [_x, faction _x, side _x, side group _x]; 
			} forEach crew vehicle_%1_%2;			
		};
	',player, _ctime, rolenumber];
	sleep 0.5;
	call compile format['INV_VehicleArray = INV_VehicleArray + [vehicle_%1_%2];',rolestring, _ctime];
	format['INV_ServerVclArray = INV_ServerVclArray + [vehicle_%1_%2];vehicle_%1_%2_storage = [];',rolestring, _ctime] call broadcast;
	
	if (_mastername == "I_G_Quadbike_01_F_hunting") then {
		if (!("huntinglicense" in INV_LizenzOwner)) then {
			INV_LizenzOwner = INV_LizenzOwner + ["huntinglicense"];
			["INV_LizenzOwner", INV_LizenzOwner] call ClientSaveVar;
			player groupchat "You now have a hunting license, this quadbike came with one!";
		};
	};
	if (_mastername == "B_MRAP_01_F_cr") then {
		call compile format ['
			vehicle_%1_%2 setvariable["tuning",5,true];
			vehicle_%1_%2 setvariable["radar",1,true];
			vehicle_%1_%2 execVM "gc\client\GC_Radar.sqf";
			vehicle_%1_%2 setvariable["brakes",1,true];
			vehicle_%1_%2 setvariable["satcam",3,true];
			vehicle_%1_%2 setvariable ["caralarm", 1, true];
			vehicle_%1_%2 setVariable ["nextalarmtime", %3, true];
			vehicle_%1_%2 setVariable ["rolenum",%4,true];
			vehicle_%1_%2 addEventHandler ["Dammaged", {[_this] call onHit;}];			
		',player, _ctime,time,rolenumber];
		player groupchat "Criminal response upgrades (5.0L engine, brakes, car alarm, sat cam and speed radar) pre-installed!";
	};
};

INV_CreateWeapon = {
	private["_class", "_menge", "_crate"];
	_class = _this select 0;
	_menge = _this select 1;
	_crate = _this select 2;
	_crate setDamage 0;
	_crate addWeaponCargoGlobal [_class,_menge];
};

INV_CreateMag =

{

private["_class", "_menge", "_crate"];
_class = _this select 0;
_menge = _this select 1;
_crate = _this select 2;
_crate setDamage 0;

_crate addmagazineCargoGlobal [_class,_menge];

};

INV_CreateA3Item = {
	private["_class", "_count", "_crate"];
	_class = _this select 0;
	_count = _this select 1;
	_crate = _this select 2;
	_crate setDamage 0;
	_crate addItemCargoGlobal [_class,_count];
};
INV_CreateBackpack = {
	private["_class", "_count", "_crate"];
	_class = _this select 0;
	_count = _this select 1;
	_crate = _this select 2;
	_crate setDamage 0;
	_crate addBackpackCargoGlobal [_class,_count];
};
INV_CreateItem =

{

private["_class", "_menge", "_stor"];
_class = _this select 0;
_menge = _this select 1;
_stor  = _this select 2;
[_class, _menge, _stor] call INV_AddItemStorage;

};
