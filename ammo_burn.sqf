    // *****************************************************
    // ammo_burn.sqf
    //  
    // By:       Johnnyboy
    // Version:  1.2
    // Other Credit:  Thanks to Bardosy for suggesting I make this
    //                script work for any object (like ammo trucks and
    //                strykers).
    //
    // This script causes secondary explosions once an object
    // is destroyed.  Explosions at heights greater than zero
    // are achieved by first creating a generic "bomb" object
    // at desired height, which acts as an invisible platform
    // for the subsequent projectile type created at same height.
    // Script also burns longer than an ammobox, by replacing
    // original box with a new burning one periodically.
    //
    // To use, copy these two scripts to your mission folder:
    //=======================================================
    //   ammo_burn.sqf
    //   ammo_burn_replace.sqf
    //
    // Place this line in the ammo box init:
    //
    //  dummy = [this, 90, true] execvm "ammo_burn.sqf";
    //
    // Or, put this in a vehicle init (an ammo truck or stryker for example):
    //
    //  dummy = [this, 90, false] execvm "ammo_burn.sqf";
    //
    // Input parameters:
    // -  object ==> ammobox or vehicle from which secondary explosions occur.
    // -  duration ==> number of seconds to have secondary explosions occur.
    // -  disappear_boolean ==> If true, object will be removed at end of burning.
    //                          Set true for ammo boxes, so you don't see perfect
    //                          looking boxes remaining after all the explosions.
    //                          Set false for trucks, so you wreck remains.
    //
    // The script waits until the ammo box dammage is 1, so I recommend
    // you also setdammage the ammobox to .9 in the init field, to make
    // it easier to ignite the ammo:
    //
    //  this setdammage .9;
    // *****************************************************
     
    private ["_ammo", "_dur"];
    _ammo     = _this select 0;
    _dur      = _this select 1;
    _disappear = _this select 2;
    // Following line insures the script only runs once in Multi-player
    if (!local _ammo) exitWith {};
     
    //hint "start new ammo_burn script";
    //player sidechat format ["object type: %1", typeof afire];
     
    while {alive _ammo} do
    {
      sleep 0.5;
    };
    _start_time = time;
    _end_time   = _start_time + _dur;
    _sleep      = 0;
    // Since we replace the ammo crate objects with new burning ones
    // periodically, we need a placeholder object there so we know where
    // to center the explosions around.
    _orig_pos = getpos _ammo;
    _marker = "Land_HelipadEmpty_F" createvehicle _orig_pos;
    //flag1 setpos getpos _marker;
     
    // Ammo boxes only burn for about 15 seconds, so to keep the burning effect
    // going longer, set the 3rd parameter to true, and ammo_burn_replace is
    // called to replace the box every 15 seconds to keep fire going.
    // Trucks burn longer, and don't need this feature.
    if (_disappear) then
    {
       dummy = [_ammo, (_dur + 60)] execvm "ammo_burn_replace.sqf";
    };
     
    // Use bounding box to determine max height of object.  Then add .5 meters to
    // that for the height where we want AA rockets launched from.  We do this
    // so the rockets clear the object, rather than exploding immediately when spawned
    // within bounding box.
    _boxDim = boundingBox _ammo;
    _boxArray2 = _boxDim select 1;
    _maxZ = _boxArray2 select 2;
    _launchZ = _maxZ + .5;
     
    _interval_max = 1;
    while {time <= _end_time} do
    {
       _rand = floor (random 10);
     
      switch (_rand) do {
      case 0:  {
               _pos = _marker modelToWorld [-3 + floor (random 6), -3 + floor(random 6),.2];
               _obj="Grenade" createvehicle _pos;        
               };
      case 1:  {
               _pos = _marker modelToWorld [-5 + floor (random 10), -5 + floor(random 10),.2];
               _obj="B_20mm_Tracer_Red" createvehicle _pos;    
               _pos = _marker modelToWorld [-5 + floor(random 10), -5 + floor(random 10),1 + floor(random 9)];  
              _b2 = "Bomb" createVehicle _pos;
              _b2 setPos _pos;
              comment "_g = ASFlash1 createVehicle _pos;";
              _g = "Grenade" createVehicle _pos;
              if (_ammo isKindOf "LandVehicle" or _ammo isKindOf "Ship" or _ammo isKindOf "Air") then
              {
                 _ammo setVelocity [0+ ((random 10)), 0+ ((random 10) ), 0+ ((random 10) )];
                 sleep .3;    
                 _marker setpos getpos _ammo;
              } else
              {
                 sleep .3;
              };
              deleteVehicle _b2;
              _pos = _marker modelToWorld [-5 + floor(random 10), -5 + floor(random 10),1 + floor(random 9)];  
              _b2 = "Bomb" createVehicle _pos;
              _b2 setPos _pos;
              _g = "Grenade" createVehicle _pos;
              sleep .2;
              deleteVehicle _b2;
               };
      case 2:  {
               _pos = _marker modelToWorld [-5 + random 10, -5 + random 10,.2];
               _obj="B_20mm_Tracer_Red" createvehicle _pos;
               _pos = _marker modelToWorld [-5 + random 10, -5 + random 10,1 + random 4];  
               _b2 = "Bomb" createVehicle _pos;
               _b2 setPos _pos;
               _g = "Grenade" createVehicle _pos;
               if (_ammo isKindOf "LandVehicle" or _ammo isKindOf "Ship" or _ammo isKindOf "Air") then
               {
                  _ammo setVelocity [0+ ((random 10)), 0+ ((random 10) ), 0+ ((random 10) )];
                  sleep .3;    
                  _marker setpos getpos _ammo;
               } else
               {
                  sleep .3;
               };
               _g = "Grenade" createVehicle _pos;
               sleep .4;
               _g = "Grenade" createVehicle _pos;
               sleep .2;
               deleteVehicle _b2;
               _pos = _marker modelToWorld [-5 + floor(random 10), -5 + floor(random 10),1 + floor(random 9)];  
               _b2 = "Bomb" createVehicle _pos;
               _b2 setPos _pos;_g = "Grenade" createVehicle _pos;
               _g = "Grenade" createVehicle _pos;    
               sleep .05;
               deleteVehicle _b2;
           };
      case 3:  {
               _pos = _marker modelToWorld [-5 + random 10, -5 + random 10,.2];
               _obj="B_20mm_Tracer_Red" createvehicle _pos;  
               _pos = _marker modelToWorld [-5 + random 10, -5 + random 10,1 + random 4];  
              _b2 = "Bomb" createVehicle _pos;
              _b2 setPos _pos;
              _g = "Grenade" createVehicle _pos;
               if (_ammo isKindOf "LandVehicle" or _ammo isKindOf "Ship" or _ammo isKindOf "Air") then
              {
                 _ammo setVelocity [0+ ((random 10)), 0+ ((random 10) ), 0+ ((random 10) )];
                 sleep .5;    
                 _marker setpos getpos _ammo;
              } else
              {
                 sleep .5;
              };
              deleteVehicle _b2;
              _pos = _marker modelToWorld [-5 + floor(random 10), -5 + floor(random 10),1 + floor(random 9)];  
              _b2 = "Bomb" createVehicle _pos;
              _b2 setPos _pos;_g = "Grenade" createVehicle _pos;
              _g = "Grenade" createVehicle _pos;
              sleep .2;
              _g = "Grenade" createVehicle _pos;
              sleep .6;
              deleteVehicle _b2;
               };
      case 4:  {
               _pos = _marker modelToWorld [-5 + random 10, -5 + random 10,.2];
               _obj="B_20mm_Tracer_Red" createvehicle _pos;        
               };
      case 5:  {
               _pos = _marker modelToWorld [0,0,_launchZ];
               _obj="M_Air_AA" createvehicle _pos;
               _obj setdir random 359;
               _obj setvectorup  [-1 + random 2,-1 + random 2, 0.3 + random 1];
               _obj setvectordir [-1 + random 2,-1 + random 2, 0.3 + random 1];
               };
      case 6:  {
               _pos = _marker modelToWorld [0,0,_launchZ];
               _obj="M_Air_AA" createvehicle _pos;
               _obj setdir random 359;
               _obj setvectorup  [-1 + random 2,-1 + random 2, 0.3 + random 1];
               _obj setvectordir [-1 + random 2,-1 + random 2, 0.3 + random 1];
               };
      case 7:  {
               _pos = _marker modelToWorld [0,0,_launchZ];
               _obj="M_Air_AA" createvehicle _pos;
               _obj setdir random 359;
               _obj setvectorup  [-1 + random 2,-1 + random 2, 0.3 + random 1];
               _obj setvectordir [-1 + random 2,-1 + random 2, 0.3 + random 1];
               };
      default  {
               _pos = _marker modelToWorld [-6 + random 12, -6 + random 12,1];
               _obj="B_762x51_Tracer_Red" createvehicle _pos;
               };
      };
      { _x setdammage 0; } foreach (_orig_pos nearObjects ["House",50]);
      sleep (_sleep + floor (random _interval_max));
      _interval_max = _interval_max + .2;
    // End while loop
    };
     
    deleteVehicle _marker;
    // Slight up angle follows
    //   _obj setvectorup [0.001,.3,-1];
    // setting 3rd value from -1 to 1 made it somewhat steeper, I think
    //   _obj setvectorup [0.001,.3,1];
    // setting 2nd value from .3 to 1 made it much more steeper up.!!!!!!!!!!!
    //   _obj setvectorup [0.001,1,1];
    //   _obj setvectorup [0 + random 1,0 + random 1, 0 + random 1];
    //hint "end of ammo_burn script";
