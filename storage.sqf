uinamespace setVariable ["GC_Storage", true];
if (!(createDialog "RscMenuPurchase")) exitWith {hint "Dialog Error!";};
if (isNil "INV_StorageDialoge") then {INV_StorageDialoge = 0;} else {INV_StorageDialoge = INV_StorageDialoge + 1;};
private ["_veh"];
_this     = _this select 3;
_arrname  = _this select 0;
_public   = _this select 1;
_arr      = call compile _arrname;
_extra    = [];
_vclStore = false;
_vclClass = "";
_weight   = _arrname call INV_GetStorageWeight;


ctrlSetText [100, ""];
if (count _this > 2) then {
	_extra = _this select 2;
	if (count _extra > 0) then {
		if (_extra select 0 == "vcl") then {
			_vclStore = true;
			_vclClass = _extra select 1;
			_maxweight = _vclClass call INV_getvehmaxkg;
			CtrlSetText [100,format ["Storage: %1/%2kg", _weight, _maxweight]];
		};
	};
};

if (!isnil "_arr") then {
	for [{_i=0}, {_i < (count _arr)}, {_i=_i+1}] do {
		_item   = ((_arr select _i) select 0);
		_anzahl = ((_arr select _i) select 1);
		_infos  = _item call INV_getitemArray;

		if (_anzahl > 0) then {
			_index  = lbAdd [1, (format ["%1 (%2x, %3kg)", (_infos call INV_getitemName), (_anzahl call ISSE_str_IntToStr), (_infos call INV_getitemTypeKg)])];
			lbSetData [1, _index, (format ["%1", _item])];
		};
	};
};

for [{_i=0}, {_i < (count INV)}, {_i=_i+1}] do {
	_item   = ((INV select _i) select 0);
	_anzahl = (_item call INV_GetItemAmount);
	_infos  = _item call INV_getitemArray;

	if ( (_anzahl > 0) and (_infos call INV_getitemDropable) ) then {

		_index = lbAdd [101, (format ["%1 (%2x, %3kg)", (_infos call INV_getitemName), (_anzahl call ISSE_str_IntToStr), (_infos call INV_getitemTypeKg)])];
		lbSetData [101, _index, (format ["%1", _item])];
	};
};

uinamespace setVariable ["GC_Storage_arrname", _arrname];
uinamespace setVariable ["GC_Storage_extra", _extra];
uinamespace setVariable ["GC_Storage_public", _public];

_action2 = format['if ((lbCurSel 1) >= 0) then {["nehmen",  "%1", ctrlText 2, (lbData [1, (lbCurSel 1)]),"%3", %2] execVM "addstorage.sqf";ctrlEnable [3, false];ctrlEnable [103, false];ctrlEnable [500, false];ctrlEnable [501, false];};', _arrname, _extra, _public];
buttonSetAction [3,_action2];

_action1 = format['if ((lbCurSel 101) >= 0) then {["ablegen", "%1", ctrlText 102, (lbData [101, (lbCurSel 101)]), "%3", %2] execVM "addstorage.sqf";ctrlEnable [3, false];ctrlEnable [103, false];ctrlEnable [500, false];ctrlEnable [501, false];};', _arrname, _extra, _public];
buttonSetAction [103, _action1];


//----------------------------REFRESH--------------------------------------------------------------------------------------
disableSerialization;
_display = findDisplay 13000;
_submit  = _display displayCtrl 3;
_submit2 = _display displayCtrl 103;
_inventoryCash = _display displayCtrl 100;
_header = _display displayCtrl 1000;

while {ctrlVisible 1015} do {
	_header ctrlSetText "Storage";

	_cursel = (lbCurSel 1);
	if (_cursel >= 0) then {
		_item   = lbData [1, (lbCurSel 1)];
    	_anzahl = ((_arr select _cursel) select 1);
		_infos  = _item call INV_getitemArray;
		_slider = ctrlText 2;
		if (!(_slider call ISSE_str_isInteger)) then {_slider = 0;};
		_slider      = _slider call ISSE_str_StrToInt;
		if (_slider < 0) then {_slider = 0;};
		_selectedWeight = ((_slider*(_infos call INV_getitemTypeKg)) call ISSE_str_IntToStr);

		_submit ctrlSetText format [localize "STRS_inv_storagedialog_take", (_slider call ISSE_str_IntToStr), _selectedWeight];
		_submit ctrlSetTooltip format ["Retrieving: %1kg", _selectedWeight];
		_submit ctrlEnable true;
		_submit ctrlCommit 0;
	} else {
		_submit ctrlSetText "No Item";
		_submit ctrlSetTooltip "Select an item to retrieve.";
		_submit ctrlEnable false;
		_submit ctrlCommit 0;
	};

	_cursel = (lbCurSel 101);
	if (_cursel >= 0) then {
		_item   = lbData [101, (lbCurSel 101)];
		_anzahl = _item call INV_GetItemAmount;
		_infos  = _item call INV_getitemArray;
		_slider = ctrlText 102;
        if (!(_slider call ISSE_str_isInteger)) then {_slider = "0";};
		_slider = _slider call ISSE_str_StrToInt;
		if (_slider < 0) then {_slider = 0;};
		_selectedWeight = ((_slider*(_infos call INV_getitemTypeKg)) call ISSE_str_IntToStr);

		_submit2 ctrlSetText format [localize "STRS_inv_storagedialog_drop", (_slider call ISSE_str_IntToStr), _selectedWeight];
		_submit2 ctrlEnable true;
		_submit2 ctrlSetTooltip format ["Storing: %1kg", _selectedWeight];
		_submit2 ctrlCommit 0;
	} else {
		_submit2 ctrlSetText "No Item";
		_submit2 ctrlSetTooltip "Select an item to store.";
		_submit2 ctrlEnable false;
		_submit2 ctrlCommit 0;
	};

	sleep 0.3;
	if (INV_StorageDialoge > 1) exitWith {};
};

INV_StorageDialoge = INV_StorageDialoge - 1;