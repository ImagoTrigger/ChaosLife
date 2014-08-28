_fuel              = fuel (vehicle player);
_fuelstartposition = getpos(vehicle player);
_exitvar           = 0;

if (_fuel >= 0.99) exitWith {
  player groupChat localize "STRS_gasstation_already_fueled";
};

while {((fuel (vehicle player)) < 0.99)} do {
  player removeaction action_refuel;

  if (refuelCost < maxPetrolPrice) then { refuelCost = refuelCost + petrolIncrement };

  _currentVehicle = vehicle player;

  if (not(['cash', -(refuelCost)] call INV_AddInventoreItem)) exitWith {
    player groupChat localize "STRS_gasstation_refuel_not_enough_cash";
    _exitvar = 1;
  };

  if (_currentVehicle == player) exitWith {
    player groupChat localize "STRS_gasstation_refuel_left_vehicle";
    _exitvar = 1;
  };

  if (vehicle player distance _fuelstartposition > 3) exitWith {
    player groupChat localize "STRS_gasstation_refuel_moved_vehicle";
    _exitvar = 1;
  };

  _currentVehicle setFuel ((fuel _currentVehicle)+0.1);
  titleText [ format[localize "STRS_gasstation_refuel_message",round(fuel _currentVehicle * 100)], "PLAIN DOWN"];

  sleep 1;
};

publicvariable "refuelCost";

if (_exitvar == 1) exitWith {};

player groupChat localize "STRS_gasstation_refuel_finished";