// Amerine <mark@amerine.net> for Chaos Life

#define IDC_GC_MENU_INVENTORY_PLAYERLIST 99
#define IDC_GC_MENU_INVENTORY_ITEMLIST 1
#define IDC_GC_MENU_INVENTORY_BUTTON_CLOSE 1601
#define IDC_GC_MENU_INVENTORY_BUTTON_DROP 4
#define IDC_GC_MENU_INVENTORY_BUTTON_KEYS 503
#define IDC_GC_MENU_INVENTORY_BUTTON_PHONE 504
#define IDC_GC_MENU_INVENTORY_BUTTON_TRANSFER 246
#define IDC_GC_MENU_INVENTORY_BUTTON_USE 3
#define IDC_GC_MENU_INVENTORY_ENTRY_AMOUNT 501
#define IDC_GC_MENU_INVENTORY_CAPACTIY_BAR 502
#define IDC_GC_MENU_INVENTORY_CAPACTIY_TEXT 64

disableserialization;
_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {
  case "onLoad": {
    _display = _params select 0;
    with missionnamespace do {
      _params spawn {
        scriptname "RscMenuInventory_onLoad";
        disableserialization;
        _display = _this select 0;

        uinamespace setVariable ["GC_CurrentDisplay", _display];

        _useButton      = _display displayCtrl IDC_GC_MENU_INVENTORY_BUTTON_USE;
        _transferButton = _display displayCtrl IDC_GC_MENU_INVENTORY_BUTTON_TRANSFER;
        _dropButton     = _display displayCtrl IDC_GC_MENU_INVENTORY_BUTTON_DROP;
        _closeButton    = _display displayCtrl IDC_GC_MENU_INVENTORY_BUTTON_CLOSE;
        _phoneButton    = _display displayCtrl IDC_GC_MENU_INVENTORY_BUTTON_PHONE;
        _keysButton     = _display displayCtrl IDC_GC_MENU_INVENTORY_BUTTON_KEYS;
        _capacitySlider = _display displayCtrl IDC_GC_MENU_INVENTORY_CAPACTIY_BAR;
        _capacityText   = _display displayctrl IDC_GC_MENU_INVENTORY_CAPACTIY_TEXT;
        _itemList       = _display displayCtrl IDC_GC_MENU_INVENTORY_ITEMLIST;
        _playerList     = _display displayCtrl IDC_GC_MENU_INVENTORY_PLAYERLIST;
        _amountEntry    = _display displayCtrl IDC_GC_MENU_INVENTORY_ENTRY_AMOUNT;

        _itemcounter = 0;
        {
          _item   = _x select 0;
          _amount = _item call INV_GetItemAmount;

          if (_amount > 0) then {
            _index = _itemList lnbAddRow ["", format["%1", (_item call INV_getitemName)], (str _amount)];
            //_index = _itemList lbAdd format ["%1", (_item call INV_getitemName)];
            _itemList lnbSetData [[_index, 0], _item];
            _itemcounter = _itemcounter + 1;
          };
        } forEach INV;

        {
          if (_x call ISSE_UnitExists and _x != "ChaosBot") then {
            _index = _playerList lbAdd format ["%1 - (%2)", _x, name (call compile _x)];
            _playerList lbSetData [_index, format["%1", _forEachIndex]];
          };
        } forEach INV_PLAYERSTRINGLIST;

        // Set default list selections.
        _itemList lnbSetCurSelRow 0;
        _playerList lbSetCurSel 0;

        _closeButton ctrlAddEventHandler ["buttonclick", "closedialog 0;"];
        _useButton ctrlAddEventHandler ["buttonclick", "with uinamespace do {['item_action',['use'],''] call RscMenuInventory_script};"];
        _itemList ctrlAddEventHandler ["LBDblClick", "with uinamespace do {['item_action',['use'],''] call RscMenuInventory_script};"];
        _dropButton ctrlAddEventHandler ["buttonclick", "with uinamespace do {['item_action',['drop'],''] call RscMenuInventory_script};"];
        _transferButton ctrlAddEventHandler ["buttonclick", "with uinamespace do {['item_action',['give'],''] call RscMenuInventory_script};"];
        _phoneButton ctrlAddEventHandler ["buttonclick",  "with uinamespace do {['phone','',''] call RscMenuInventory_script};"];
        _keysButton ctrlAddEventHandler ["buttonclick",  "with uinamespace do {['keys','',''] call RscMenuInventory_script};"];

        // Set focus on close button.
        ctrlSetFocus _closeButton;

        waituntil {
          _item   = _itemList lnbData [(lnbCurSelRow _itemList), 0];
          _anzahl = _item call INV_GetItemAmount;
          _array  = _item call INV_getitemArray;

          // Set Progressbar.
          _currentCapacity = (call INV_GetOwnWeight) / INV_Tragfaehigkeit;
          _progressBar = _display displayctrl 502;
          _progressBar progressSetPosition _currentCapacity;

          //ctrlSetText [62,  format ["%1", (_anzahl call ISSE_str_IntToStr)]]; TODO: Add to Tooltips. -Amerine
          //ctrlSetText [72,  format ["%1", _array call INV_getitemDescription1]]; TDDO: Add to Tooltips. -Amerine
          //ctrlSetText [7,  format ["%1", _array call INV_getitemDescription2]]; TODO: Add to Tooltips. -Amerine
          //ctrlSetText [202, format ["%1/%2kg", (_array call INV_getitemTypeKg), (((_array call INV_getitemTypeKg)*(_anzahl)) call ISSE_str_IntToStr)]]; TODO: Add to Tooltips. -Amerine
          _capacityText ctrlSetText format ["Capacity: %1/%2kg", (call INV_GetOwnWeight), INV_Tragfaehigkeit];
          sleep 0.1;
          isnull _display
        };
        uinamespace setVariable ["GC_CurrentDisplay", nil];
      };
    };
  };

  case "item_action": {
    with missionnamespace do {
      _display     = uinamespace getVariable "GC_CurrentDisplay";
      _action      = _params select 0;
      _itemList    = _display displayCtrl IDC_GC_MENU_INVENTORY_ITEMLIST;
      _amountEntry = _display displayCtrl IDC_GC_MENU_INVENTORY_ENTRY_AMOUNT;
      _playerList  = _display displayCtrl IDC_GC_MENU_INVENTORY_PLAYERLIST;

      _selectedItem   = _itemList lnbData [(lnbCurSelRow _itemList), 0];
      _selectedAmount = ctrlText _amountEntry;
      _selectedPlayer = _playerList lbData (lbCurSel _playerList);

      [_action, _selectedItem, _selectedAmount, _selectedPlayer] execVM "INVactions.sqf";
      closedialog 0;
    };
  };

  case "phone": {
    with missionnamespace do {
      ["use"] execVM "handy.sqf";
      closedialog 0;
    };
  };

  case "keys": {
    with missionnamespace do {
      ["use"] execVM "keys.sqf";
      closedialog 0;
    };
  };
};