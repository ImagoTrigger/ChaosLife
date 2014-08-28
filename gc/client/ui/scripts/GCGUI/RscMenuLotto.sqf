// Amerine <mark@amerine.net> for Chaos Life

#define IDC_GC_MENU_LOTTO_LIST 1
#define IDC_GC_MENU_LOTTO_SUBMIT 2
#define IDC_GC_MENU_LOTTO_CANCEL 1601

disableserialization;
_mode   = _this select 0;
_params = _this select 1;
_class  = _this select 2;

switch _mode do {
  case "onLoad": {
    with missionnamespace do {
      _params spawn {
        scriptname "RscMenuLotto_onLoad";
        disableserialization;

        _display = _this select 0;

        _cancelButton = _display displayCtrl IDC_GC_MENU_LOTTO_CANCEL;
        _submitButton = _display displayCtrl IDC_GC_MENU_LOTTO_SUBMIT;
        _lottoList    = _display displayCtrl IDC_GC_MENU_LOTTO_LIST;

        {
          _index = _lottoList lbAdd format["%1 ($%2)", (_x select 1), (_x select 2)];
          _lottoList lbSetdata [_index, _x select 0];
        } forEach LottoArray;

        // Disable purchasing if already playing.
        if (playing_lotto == 1) then {
          _lottoList ctrlEnable false;
          _submitButton ctrlEnable false;
          _submitButton ctrlSetTooltip "Already playing lotto. Please wait.";
        };

        // Control actions
        _cancelButton ctrlAddEventHandler ["buttonclick", "closedialog 0;"];
        _submitButton ctrlAddEventHandler ["buttonclick", "[lbData[1, (lbCurSel 1)]] execVM 'gc\client\GC_Lotto.sqf'; closeDialog 0;"];

        // Set Default Lotto Seleciton
        _lottoList lbSetCurSel 0;
      };
    };
  };
};