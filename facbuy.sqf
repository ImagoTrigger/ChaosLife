_num     = ((_this select 3) select 0);
_fabname = ((INV_ItemFabriken select _num) select 1);
_cost    = ((INV_ItemFabriken select _num) select 6);
_cash    = 'cash' call INV_GetItemAmount;

if (_fabname in INV_Fabrikowner) exitWith {player groupChat localize "STRS_inv_alreadygotshop";};
if (_cash < _cost) 		 exitWith {player groupChat localize "STRS_inv_kein_cash";};

INV_Fabrikowner = INV_Fabrikowner + [ _fabname ];
['cash', -(_cost)] call INV_AddInventoreItem;
["INV_Fabrikowner", INV_Fabrikowner] call ClientSaveVar;

player groupChat format[localize "STRS_inv_gotshop", player, (_cost call ISSE_str_IntToStr)];
