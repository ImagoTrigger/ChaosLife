//DOA <imagotrigger@gmail.com> for Chaos Life
private ["_mode","_params","_action"];
_mode = _this select 0;
_params = _this select 1;

switch _mode do {
	case "onLoad": {
		with missionnamespace do {
			_params spawn {
				private ["_display"];
				scriptname "RscMenuPurchase_onLoad";
				disableserialization;
				_display = _this select 0;
				_storage = uinamespace getVariable "GC_Storage";
				if (!_storage) then {
					(_display displayctrl 1) ctrlAddEventHandler ["LBDblClick", "with uinamespace do {['shop_action',['buy'],''] call RscMenuPurchase_script};"];
					(_display displayctrl 101) ctrlAddEventHandler ["LBDblClick", "with uinamespace do {['shop_action',['sell'],''] call RscMenuPurchase_script};"];
				} else {
					(_display displayctrl 1) ctrlAddEventHandler ["LBDblClick", "with uinamespace do {['storage_action',['take'],''] call RscMenuPurchase_script};"];
					(_display displayctrl 101) ctrlAddEventHandler ["LBDblClick", "with uinamespace do {['storage_action',['put'],''] call RscMenuPurchase_script};"];				
				};
			};
		};
	};
	case "shop_action": {
		with missionnamespace do {
			_action      = _params select 0;
			if (_action == "buy") then {
				["itemkauf",    lbCurSel 1,  ctrlText 2,   lbData [101, (lbCurSel 1)  ], INV_ActiveBuyShopArray select (lbCurSel 1)]    execVM "shoptransactions.sqf";	
			} else {
				["itemverkauf", lbCurSel 101, ctrlText 102, lbData [101, (lbCurSel 101)], INV_ActiveSellShopArray select (lbCurSel 101)] execVM "shoptransactions.sqf";			
			};
		};
	};	
	case "storage_action": {
		with missionnamespace do {
			_action      = _params select 0;
			_arrname = uinamespace getVariable "GC_Storage_arrname";
			_extra = uinamespace getVariable "GC_Storage_extra";
			_public = uinamespace getVariable "GC_Storage_public";
			if (_action == "take") then {
				["nehmen",  _arrname, ctrlText 2, (lbData [1, (lbCurSel 1)]),_public,_extra] execVM "addstorage.sqf";
				ctrlEnable [3, false];
				ctrlEnable [103, false];
				ctrlEnable [500, false];
				ctrlEnable [501, false];
			} else {
				["ablegen", _arrname, ctrlText 102, (lbData [101, (lbCurSel 101)]), _public, _extra] execVM "addstorage.sqf";
				ctrlEnable [3, false];
				ctrlEnable [103, false];
				ctrlEnable [500, false];
				ctrlEnable [501, false];
			};
		};	
	};
};