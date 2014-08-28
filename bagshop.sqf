if (count _this == 4) exitWith
{
	closedialog 0;
	_bagShopDialog = createDialog "RscMenuBagShop";
	switch INV_Tragfaehigkeit do
	{
		case 70:
		{
			ctrlEnable [50, false];
		};
		case 90:
		{
			ctrlEnable [50, false];
			ctrlEnable [60, false];
		};
		case 120:
		{
			ctrlEnable [50, false];
			ctrlEnable [60, false];
			ctrlEnable [70, false];
		};
	};
};

_bagType = _this select 0;

switch _bagType do
{
	case 1:
	{
		if("cash" call INV_GetItemAmount >= 100000) then
		{
			ctrlEnable [50, false];
			player groupChat "You can now hold 70kg!";
			["cash", -100000] call INV_AddInventoreItem;
			INV_Tragfaehigkeit = 70;
		}
		else
		{
			player groupChat "You do not have enough money!";
		};
	};
	case 2:
	{
		if("boarpelt" call INV_GetItemAmount >= 5) then
		{
			ctrlEnable [50, false];
			ctrlEnable [60, false];
			player groupChat "You can now hold 90kg!";
			["boarpelt", -5] call INV_AddInventoreItem;
			INV_Tragfaehigkeit = 90;
		}
		else
		{
			player groupChat "You do not have enough rabbit pelts!";
		};
	};
	case 3:
	{
		if("snakeskin" call INV_GetItemAmount >= 5) then
		{
			ctrlEnable [50, false];
			ctrlEnable [60, false];
			ctrlEnable [70, false];
			player groupChat "You can now hold 120kg!";
			["snakeskin", -5] call INV_AddInventoreItem;
			INV_Tragfaehigkeit = 120;
		}
		else
		{
			player groupChat "You do not have enough snake skins!";
		};
	};
	case 4:
	{
		if("sheepskin" call INV_GetItemAmount >= 5) then
		{
			ctrlEnable [50, false];
			ctrlEnable [60, false];
			ctrlEnable [70, false];
			ctrlEnable [74, false];
			player groupChat "You can now hold 150kg!";
			["sheepskin", -5] call INV_AddInventoreItem;
			INV_Tragfaehigkeit = 150;
		}
		else
		{
			player groupChat "You do not have enough sheep hides!";
		};
	};
	case 5:
	{
		if("turtleshell" call INV_GetItemAmount >= 5) then
		{
			ctrlEnable [50, false];
			ctrlEnable [60, false];
			ctrlEnable [70, false];
			ctrlEnable [74, false];
			ctrlEnable [75, false];
			player groupChat "You can now hold 200kg!";
			["turtleshell", -5] call INV_AddInventoreItem;
			INV_Tragfaehigkeit = 200;
		}
		else
		{
			player groupChat "You do not have enough turtle shells!";
		};
	};	
};