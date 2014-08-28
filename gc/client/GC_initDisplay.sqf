// Amerine <mark@amerine.net> for Chaos Life
// Ported from ArmA IIIs initDisplay.

private ["_mode","_params","_class"];

with uinamespace do {

  _mode = [_this,0,"",[""]] call bis_fnc_param;
  _params = [_this,1,[]] call bis_fnc_param;
  _class = [_this,2,"",[""]] call bis_fnc_param;
  _path = [_this,3,"default",[""]] call bis_fnc_param;

  _varDisplays = _path + "_displays";
  _varClasses = _path + "_classes";

  switch _mode do {
    case "onLoad": {
      _displays = uinamespace getvariable [_varDisplays,[]];
      _classes = uinamespace getvariable [_varClasses,[]];

      //--- Remove null displays
      {
        if (isnull _x) then {
          _displays set [_foreachindex,-1];
          _classes set [_foreachindex,-1];
        };
      } foreach _displays;
      _displays = _displays - [-1];
      _classes = _classes - [-1];
      _classes resize (count _displays);

      //--- Register current display
      _display = _params select 0;
      _displays set [count _displays,_display];
      _classes set [count _classes,_class];


      //--- Store variables
      uinamespace setvariable [_varDisplays,_displays];
      uinamespace setvariable [_varClasses,_classes];
      uinamespace setVariable [_class, _params select 0];
    };

    case "onUnload": {
      diag_log format["Unhandled GC Display Unload: %1", _class];
    };
  };

  //--- Register script for the first time
  _fncName = _class + "_script";
  if (isnil _fncName) then {
    _scriptPath = gettext (missionconfigfile >> "cfgGCScripts" >> _path);

    //--- Execute
    _fncFile = preprocessfilelinenumbers format [_scriptPath + "%1.sqf",_class];
    _fncFile = format ["scriptname '%1_%2'; _fnc_scriptName = '%1_%2';",_class,_mode] + _fncFile;
    uinamespace setvariable [
      _fncName,
      compile _fncFile
    ];
  };
  [_mode,_params,_class] call (uinamespace getvariable _fncName);
};