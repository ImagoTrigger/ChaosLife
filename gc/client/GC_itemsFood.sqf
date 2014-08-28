_item = _this select 1;
_count = _this select 2;
_feed = -1;
_randomChance = floor random 10000;
_foodPoisonChance = 0;
_foodPoisonDamage = 0;
_healthIncrease   = 0;

if ((_item == "boar") or
	(_item == "turtle") or
	(_item == "fish") or
	(_item == "snake") or
	(_item == "cow") or
	(_item == "sheep") or
	(_item == "trout") or
	(_item == "walleye") or
	(_item == "perch") or
	(_item == "bass")) then {
	_feed = 6;
	_foodPoisonChance = 20;
	_foodPoisonDamage = .2;
	_healthIncrease   = 0.002;
	hint "Tastes raw. Your stamina is restored.";
};

if (_item == "taco") then {
	_feed = 30;
	_foodPoisonChance = 10;
	_foodPoisonDamage = .4;
	_healthIncrease   = 0.004;
	hint "Tasty. Your stamina is restored for 30 seconds.";
};

if (_item == "burger") then {
	_feed = 60;
	_foodPoisonChance = 5;
	_foodPoisonDamage = .5;
	_healthIncrease   = 0.006;
	hint "Tastes good! Your stamina is restored for 60 seconds.";
};

if (_item == "pizza") then {
	_feed = 120;
	_foodPoisonChance = 1;
	_foodPoisonDamage = .7;
	_healthIncrease   = 0.09;
	hint "Tastes great! Your stamina is restored for 2 minutes.";
};

if ((_randomChance <= _foodPoisonChance) && (_randomChance > 0)) then {
	fedUntil = time;
	player setFatigue 1;
	player setDammage ((getDammage player) + _foodPoisonDamage); //TODO: Make sure kill messages let the world know they died of food poisoning.
	hint format["That %1 was bad and made you sick.\n\nIt might even kill you!", _item];
} else {
	if (time > fedUntil) then {
		fedUntil = time + _feed;
	} else {
		fedUntil = fedUntil + _feed;
	};

	if (getDammage player > 0) then {
		player setDammage ((getDammage player) - _healthIncrease);
	};
};

if (time > fedUntil) then {
	hint "You ate it, but I'm not sure it was edible...";
};

[_item, -1] call INV_addInventoreItem;