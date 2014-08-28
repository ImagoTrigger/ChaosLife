_option = _this select 0;
_textsOption = "";
if ((count _this)>1) then {_textsOption = _this select 1;};

if (_option == "Settings") then {if (!(createDialog "RscMenuMain")) exitWith {hint "Dialog Error!";};};

if (_option == "GraphicsSettings") then {["closedialog 0; [""Settings""] execVM ""settings.sqf"";"] execVM "gfxbutton.sqf";};

if (_option == "TextsSettings") then {
  if (_textsOption == "open") then {
    if (!(createDialog "RscMenuSayTexts")) exitWith {hint "Dialog Error!";};

    for [{_i=1}, {_i <= 4}, {_i=_i+1}] do {
      call compile format["ctrlSetText[%1, RadioTextMsg_%1];", _i];
      call compile format["_index = lbAdd [1%1, 'Global'];lbSetData [1%1, _index, 'global'];if(RadioTextArt_%1 == 'global')then{lbSetCurSel [1%1, 0]};", _i];
      call compile format["_index = lbAdd [1%1, 'Side'  ];lbSetData [1%1, _index, 'side'  ];if(RadioTextArt_%1 == 'side'  )then{lbSetCurSel [1%1, 1]};", _i];
      call compile format["_index = lbAdd [1%1, 'Direct'];lbSetData [1%1, _index, 'direct'];if(RadioTextArt_%1 == 'direct')then{lbSetCurSel [1%1, 2]};", _i];
    };
  };

  if ( (_textsOption == "save") and (ctrlVisible 1034) ) then {
    for [{_i=1}, {_i <= 4}, {_i=_i+1}] do {
      call compile format["RadioTextMsg_%1 = (ctrlText %1);", _i];
      call compile format["RadioTextArt_%1 = lbText[1%1, (lbCurSel 1%1)];", _i];
    };

    player groupChat "Saved!";
  };
};

if (_option == "Tutorial") then {
  if (!(createDialog "RscMenuTutorial")) exitWith {hint "Dialog Error!";};
  ctrlSetText[1, localize "STRS_mainmenu_MissionTutorial"];
};

if (_option == "FAQ") then {
  if (!(createDialog "RscMenuFAQ")) exitWith {hint "Dialog Error!";};
  ctrlSetText[1, "images\chaos-keys.jpg"];
};

if (_option == "About") then {
  if (!(createDialog "RscMenuAbout")) exitWith {hint "Dialog Error!";};
  ctrlSetText[1, localize "STRS_mainmenu_AboutThisMission"];
};

if (_option == "ItemList") then {
  _handler = ["closedialog 0; [""Settings""] execVM ""settings.sqf"";", "Back"] execVM "gc\client\itemlist.sqf";
  waitUntil {scriptDone _handler};
};
