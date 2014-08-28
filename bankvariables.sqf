Startcash              = 50000;
maxcopbonus            = 40000;
maxcivbonus            = 30000;
robb_timeSperre        = 1200;
local_useBankPossible  = true;
maxinsafe              = 300000;
BankRaubKontoverlust   = 4000;
ShopRaubKontovershop   = 0;
ShopRaubProzentVershop = 0;
rblock                 = 0;
stolencash             = 0;
Maxbankrobpercentlost  = 0.1;
bank_steuer            = 5;
zinsen_prozent         = 5;
interest_minutes       = 20;
robenable              = true;
Kontostand             = Startcash;

shopflagarray          = [shop1,shop2,shop3,shop4];
bankflagarray          = [mainbank, copbank, atm1, atm1_1, atm2, atm3, atm4, atm5, atm6, atm7, atm8, atmpf, atmt];
speedcamarray          = [
	[speed1,"north of Police Base"],
	[speed2,"near Main Gas Station"],
	[speed3,"near Northeast Gas Station"],
	[speed4,"near Marina Gas Station"],
	[speed5,"near South Checkpoint"],
	[speed6,"south of Police Base"]
];
drugsellarray          = [mdrugsell,cdrugsell,ldrugsell,hdrugsell,huntshop1];
TankstellenArray       = [
	(nearestobject[getpos fuelshop1,"Land_FuelStation_Feed_F"]),
	(nearestobject[getpos fuelshop2,"Land_FuelStation_Feed_F"]),
	(nearestobject[getpos fuelshop3,"Land_FuelStation_Feed_F"]),
	(nearestobject[getpos fuelshop4,"Land_FuelStation_Feed_F"]),
	(nearestobject[getpos fuelshop5,"Land_FuelStation_Feed_F"]),
	(nearestobject[getpos fuelshop6,"Land_FuelStation_Feed_F"]),
	(nearestobject[getpos fuelshop7,"Land_FuelStation_Feed_F"])
];

GC_BoatRefuel = [
	[[2710.38,6059.06,0.572085],133.834],
	[[2733.53,6073.64,0.576705],313.268],
	[[2769.28,6107.33,0.586606],332.978],
	[[2838.64,6080.07,0.5368],94.7251],
	[[2793.08,6119.4,0.576705],332.978],
	[[2000.84,5291.02,0.731],103.701],
	[[1971.44,5169.75,0.731],103.701]
];

if (debug and !isServer) then {['cash', 999999] call INV_AddInventoreItem};