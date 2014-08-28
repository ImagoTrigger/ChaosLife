//DOA <imagotrigger@gmail.com> for Chaos Life 1.3 by GC
private ["_vel","_loopcount","_veh","_tuned","_dir","_power","_roll","_zmod","_topout","_antiroll","_sm","_vel2","_maxspeed","_speed","_minspeed","_delay","_bship","_pm","_boost","_boatmagic","_rollcut"];
_loopcount = 1;
bow_handle = [] spawn {};
while {_loopcount <= 144000} do {
	_loopcount = _loopcount + 1;
	_veh = vehicle player;
	_tuned = _veh getvariable["tuning",0];
	_bship = _veh getvariable["ship",false];
	_boatmagic = 0.021; //;-)
	//we're in a vehicle
	if (player != _veh) then {
		//we have an upgrade
		if (_tuned > 0) then {
			//defaults
			_power = _veh getvariable["enginepower",200];
			_roll = _veh getvariable["rollspeed",80];
			_maxspeed = _veh getvariable["maxspeed",100];				
			_minspeed = _veh getvariable["minspeed",10];				
			_delay = _veh getvariable["delay",0.5];
			if (_maxspeed <= _roll) then { _maxspeed = (_roll + 25);}; //normalize speeds
			_rollcut = false;
			//we're driving and the engine is on
			if (player == driver _veh and isEngineon _veh) then {				
				//what's currently happening
				_speed = speed _veh;
				_vel = velocity _veh;	
				_dir = getdir _veh;
				//magic #s
				_zmod = 0.999 - (_speed / 1000);
				_topout = (0.35 + (_tuned *0.15));
				_antiroll = (0.4  + (_tuned *0.15));
				_boost = 4;
				_pm = (_speed * 0.001); //defy laws of physics!!1!1
				if (_topout > 1) then {_topout = 1;};
				if (_antiroll > 1) then {_antiroll = 1;};
				//ahoy!
				if (_bship) then {
					_zmod = -1;
					_boost = 10;
					_vel = [(_vel select 0),(_vel select 1),0.34];
					_boatmagic = 0.022;
				};
				if (_power > 1200) then {_power = (_power - (_power - 1200));};				
				//weak engine voodoo (rubber boat, atv)
				if (_power < 200) then {
					_power = (_power + (200 - _power)) * _boost;
					_boatmagic = 0.0235;
					_rollcut = true; //cut velocity effects if turning above roll speed for this power class
				};
				_sm = ((_power * 0.00065) + (_tuned * 0.015));  //moar power!!!1
				diag_log text format["readying speed upgrade %5 on %1! -  power:%2 roll:%3 max:%4 min:%6 delay:%7 modifier:%8 pitch:%9",_veh,_power,_roll,_maxspeed,_tuned,_minspeed,_delay,_sm,_pm];
				if (inputAction "MoveForward" > 0 or inputAction "VehicleTurbo" > 0 or inputAction "CarForward" > 0) then {
					if ((isTouchingGround _veh or (_bship and surfaceIsWater (position _veh)))) then {
						//insanity
						if (_speed >= _minspeed and _speed <= maxspeed) then {			
							_vel2 = [];
							_vel2 = [(_vel select 0) + (_sm*(sin _dir)), (_vel select 1) + (_sm*(cos _dir)), (_vel select 2) * _zmod ];
							//high end
							if (_speed >= (_maxspeed - 10)) then {
								_sm = _sm * _topout;
								_vel2 = [(_vel select 0) + (_sm*(sin _dir)), (_vel select 1) + (_sm*(cos _dir)), (_vel select 2)  * _zmod ];
								_veh setfuel ((fuel _veh) - 0.0003);
								diag_log text format["topping out (%2) sm changed to: %1",_sm,_topout];
							} else {							
								//low end
								if (_speed >= (_roll - 5)) then {
									_sm = _sm * _antiroll;
									_vel2 = [(_vel select 0) + (_sm*(sin _dir)), (_vel select 1) + (_sm*(cos _dir)), (_vel select 2) * _zmod ];
									diag_log text format["anti rolling (%2) sm changed to: %1",_sm,_antiroll];
								};
							};
							
							//cut boost if needed
							if (_rollcut and (_speed >= (_minspeed + 10)) and (inputAction "MoveLeft" > 0 or inputAction "MoveRight" > 0 or inputAction "CarLeft" > 0 or inputAction "CarRight" > 0)) then {
								diag_log text format["roll cut: %1 from %2",(speed _veh),__FILE__];
							} else {
								diag_log text format["speed: %3 - setting velocity from:%1 to %2",_vel,_vel2,_speed];  
								_veh setVelocity _vel2;
								diag_log text format["speed: %1 from %2",(speed _veh),__FILE__];
							};
							
							//fireball effect
							if (_speed >= (_maxspeed - 5) and !gc_fireballed) then {
								format['[%1,%2] spawn GC_Fireball;',_veh,(_maxspeed - 10)] call broadcast;
							};
						
						} else {
							sleep _delay;
						};
					} else {
						sleep (_delay + 1); //airborne penalty!
					};
				} else {
					if ((inputAction "MoveBack" > 0 or inputAction "CarHandBrake" > 0 or inputAction "CarBack" > 0) and _speed > _minspeed and  (isTouchingGround _veh or (_bship and surfaceIsWater (position _veh))) and (_veh getvariable["brakes",0]) > 0) then {
						_vel2 = [(_vel select 0) - (_sm*(sin _dir)), (_vel select 1) - (_sm*(cos _dir)), (_vel select 2) * _zmod ];
						_veh setVelocity _vel2;
						diag_log text format["brakes: %1 from %2",(speed _veh),__FILE__];
					} else {;
						sleep _delay;
					};
				};
			} else {
				sleep (_delay + 1); //engine is off
			};
			_veh limitspeed maxspeed; //200km/h  global chaos limit
		} else {
			sleep 2; //vehicle not tuned
		};
	} else {
		sleep 2; //no vehicle
	};
	if (_bship) then {
		sleep (0.165 - (_tuned * _boatmagic));  //more magic #s
	} else {
		sleep (0.245 - (_tuned * 0.03)); //don't race this script
	};
};

diag_log text format["flushing %1",__FILE__];

tune_handle = [] execvm "gc\client\GC_Tuning.sqf";
