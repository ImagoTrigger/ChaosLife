// Amerine <mark@amerine.net> for Chaos Life

#define IDC_GC_MENUCOP_FOOT_PRISON_WANTED 1600
#define IDC_GC_MENUCOP_FOOT_CRIMELOG 1601
#define IDC_GC_MENUCOP_FOOT_COPMARKERS 1602
#define IDC_GC_MENUCOP_FOOT_JAILCAM 1603
#define IDC_GC_MENUCOP_FOOT_CIVCAM 1604
#define IDC_GC_MENUCOP_FOOT_SATCAM 1605
#define IDC_GC_MENUCOP_FOOT_CLOSE 2400

disableserialization;
_mode = _this select 0;
_params = _this select 1;
_class = _this select 2;

switch _mode do {
  case "onLoad": {
    _params spawn {
      scriptname "RscMenuCop_onLoad";
      disableserialization;
      _display = _this select 0;
      _inCar = (vehicle player != player);
      _satCamInstalled = false;

      if (_inCar) then {
        _vcl = vehicle player;
        _satCam = _vcl getVariable ["satcam", nil];
        if (isNil "_satCam") then {
          _satCamInstalled = false;
        } else {
          _satCamInstalled = true;
        };
      };

      _ctrlPrisonWanted = _display displayctrl IDC_GC_MENUCOP_FOOT_PRISON_WANTED;
      _ctrlCrimeLog     = _display displayctrl IDC_GC_MENUCOP_FOOT_CRIMELOG;
      _ctrlCloseButton  = _display displayctrl IDC_GC_MENUCOP_FOOT_CLOSE;
      _ctrlCopMarkers   = _display displayctrl IDC_GC_MENUCOP_FOOT_COPMARKERS;
      _ctrlCopJailCam   = _display displayctrl IDC_GC_MENUCOP_FOOT_JAILCAM;
      _ctrlCopCivCam    = _display displayctrl IDC_GC_MENUCOP_FOOT_CIVCAM;
      _ctrlCopSatCam    = _display displayctrl IDC_GC_MENUCOP_FOOT_SATCAM;

      _ctrlPrisonWanted ctrlAddEventHandler ["buttonclick", "closedialog 0; [0,1,2,['wantedrelease']] execVM 'maindialogs.sqf';"];
      _ctrlCrimeLog ctrlAddEventHandler ["buttonclick", "closedialog 0; [0,1,2,['coplog']] execVM 'maindialogs.sqf';"];
      _ctrlCopMarkers ctrlAddEventHandler ["buttonclick", "with uinamespace do {['copmarkers',_display,''] call RscMenuCop_script};"];
      _ctrlCloseButton ctrlAddEventHandler ["buttonclick", "closedialog 0;"];
      _ctrlCopCivCam ctrlAddEventHandler ["buttonclick", "closedialog 0; [0,1,2,['civcam']] execVM 'maindialogs.sqf';"];
      _ctrlCopJailCam ctrlAddEventHandler ["buttonclick", "closedialog 0; [0,1,2,['jailcam']] execVM 'copcams.sqf';"];
      _ctrlCopSatCam ctrlAddEventHandler ["buttonclick", "closedialog 0; [ [(getPos player select 0), (getPos player select 1), 200] ] execVM 'satcam.sqf';"];

      // SET Default Cop Markers State.
      copmarker_on = missionnamespace getVariable "copmarker_on";


      if (_inCar) then {
        _ctrlCopJailCam ctrlEnable true;
        _ctrlCopJailCam ctrlSetTooltip "";

        _ctrlCopCivCam ctrlEnable true;
        _ctrlCopCivCam ctrlSetTooltip "";

        if (_satCamInstalled) then {
          _ctrlCopSatCam ctrlEnable true;
          _ctrlCopSatCam ctrlSetTooltip "";
        } else {
          _ctrlCopSatCam ctrlEnable false;
          _ctrlCopSatCam ctrlSetTooltip "Sat Cam Not Installed";
        };
      } else {
        _ctrlCopJailCam ctrlEnable false;
        _ctrlCopJailCam ctrlSetTooltip "Jail Cam Unavailable. Not in Vehicle";

        _ctrlCopCivCam ctrlEnable false;
        _ctrlCopCivCam ctrlSetTooltip "Civ Cam Unavailable. Not in Vehicle";

        _ctrlCopSatCam ctrlEnable false;
        _ctrlCopSatCam ctrlSetTooltip "Sat Cam Unavailable. Not in Vehicle";
      };
      _ctrlCopCivCam ctrlCommit 0;
      _ctrlCopJailCam ctrlCommit 0;
      _ctrlCopSatCam ctrlCommit 0;

      // Set Focus onto close button.
      ctrlSetFocus _ctrlCloseButton;

      waituntil {
        if (copmarker_on == 1) then {
          _ctrlCopMarkers ctrlSetText "Cop Markers: On";
          _ctrlCopMarkers ctrlCommit 0;
        } else {
          _ctrlCopMarkers ctrlSetText "Cop Markers: Off";
          _ctrlCopMarkers ctrlCommit 0;
        };

        sleep 0.01;
        isnull _display
      };
    };
  };

  case "copmarkers": {
    copmarker_on = (copmarker_on + 1) % 2;
    missionnamespace setvariable ["copmarker_on", copmarker_on];
  };
};