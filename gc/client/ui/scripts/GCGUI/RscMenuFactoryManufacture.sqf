//DOA <imagotrigger@gmail.com> for Chaos Life
private ["_mode","_params","_action"];
_mode = _this select 0;
_params = _this select 1;

switch _mode do {
	case "onLoad": {
		with missionnamespace do {
			_params spawn {
				private ["_display"];
				scriptname "RscMenuFactoryManufacture_onLoad";
				disableserialization;
				_display = _this select 0;
				(_display displayctrl 1) ctrlAddEventHandler ["LBDblClick", "with uinamespace do {['fac_action',['mfg'],''] call RscMenuFactoryManufacture_script};"];
			};
		};
	};
	case "fac_action": {
		with missionnamespace do {
			_action = _params select 0;
			_facnum = uinamespace getvariable "GC_facnum";
			if (_action == "mfg") then {
				[(lbData [1, (lbCurSel 1)]),_facnum, "mani"] execVM "createfacitem.sqf";
			};
		};
	};	
};