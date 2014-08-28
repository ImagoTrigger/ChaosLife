// Amerine <mark@amerine.net> for Chaos Life
#define IDC_GC_MENU_SKILLS_FISHING_PROGRESS 600
#define IDC_GC_MENU_SKILLS_FISHING_LEVEL 1003
#define IDC_GC_MENU_SKILLS_HUNTING_PROGRESS 1005
#define IDC_GC_MENU_SKILLS_HUNTING_LEVEL 1006
#define IDC_GC_MENU_SKILLS_GATHERING_PROGRESS 1008
#define IDC_GC_MENU_SKILLS_GATHERING_LEVEL 1009
#define IDC_GC_MENU_SKILLS_MINING_PROGRESS 1011
#define IDC_GC_MENU_SKILLS_MINING_LEVEL 1012
#define IDC_GC_MENU_SKILLS_MANUFACTURING_PROGRESS 1014
#define IDC_GC_MENU_SKILLS_MANUFACTURING_LEVEL 1015
#define IDC_GC_MENU_SKILLS_LOCKPICKING_PROGRESS 1017
#define IDC_GC_MENU_SKILLS_LOCKPICKING_LEVEL 1018
#define IDC_GC_MENU_SKILLS_ROBBERY_PROGRESS 1020
#define IDC_GC_MENU_SKILLS_ROBBERY_LEVEL 1021
#define IDC_GC_MENU_SKILLS_CANCEL 1601

disableserialization;
_mode   = _this select 0;
_params = _this select 1;
_class  = _this select 2;

switch _mode do {
  case "onLoad": {
    with missionnamespace do {
      _params spawn {
        scriptname "RscMenuSkills_onLoad";
        disableserialization;

        _display = _this select 0;
        uinamespace setVariable ["GC_CurrentDisplay", _display];

        _cancelButton             = _display displayCtrl IDC_GC_MENU_SKILLS_CANCEL;
        _fishingProgressBar       = _display displayCtrl IDC_GC_MENU_SKILLS_FISHING_PROGRESS;
        _fishingLevel             = _display displayCtrl IDC_GC_MENU_SKILLS_FISHING_LEVEL;
        _huntingProgressBar       = _display displayCtrl IDC_GC_MENU_SKILLS_HUNTING_PROGRESS;
        _huntingLevel             = _display displayCtrl IDC_GC_MENU_SKILLS_HUNTING_LEVEL;
        _gatheringProgressBar     = _display displayCtrl IDC_GC_MENU_SKILLS_GATHERING_PROGRESS;
        _gatheringLevel           = _display displayCtrl IDC_GC_MENU_SKILLS_GATHERING_LEVEL;
        _miningProgressBar        = _display displayCtrl IDC_GC_MENU_SKILLS_MINING_PROGRESS;
        _miningLevel              = _display displayCtrl IDC_GC_MENU_SKILLS_MINING_LEVEL;
        _manufacturingProgressBar = _display displayCtrl IDC_GC_MENU_SKILLS_MANUFACTURING_PROGRESS;
        _manufacturingLevel       = _display displayCtrl IDC_GC_MENU_SKILLS_MANUFACTURING_LEVEL;
        _lockpickingProgressBar   = _display displayCtrl IDC_GC_MENU_SKILLS_LOCKPICKING_PROGRESS;
        _lockpickingLevel         = _display displayCtrl IDC_GC_MENU_SKILLS_LOCKPICKING_LEVEL;
        _robberyProgressBar       = _display displayCtrl IDC_GC_MENU_SKILLS_ROBBERY_PROGRESS;
        _robberyLevel             = _display displayCtrl IDC_GC_MENU_SKILLS_ROBBERY_LEVEL;

        // Control actions
        _cancelButton ctrlAddEventHandler ["buttonclick", "closedialog 0;"];

        waituntil {
          // Set Progressbars.
          _fishingLevelProgress = SKILL_FISHING mod 1;
          _fishingProgressBar progressSetPosition _fishingLevelProgress;
          _fishingProgressBar ctrlSetTooltip format["Progress to next level: %1/100", (_fishingLevelProgress * 100)];
          _fishingLevel ctrlSetText format["%1/100", floor SKILL_FISHING];
          _fishingLevel ctrlCommit 0;

          _huntingLevelProgress = SKILL_HUNTING mod 1;
          _huntingProgressBar progressSetPosition _huntingLevelProgress;
          _huntingProgressBar ctrlSetTooltip format["Progress to next level: %1/100", (_huntingLevelProgress * 100)];
          _huntingLevel ctrlSetText format["%1/100", floor SKILL_HUNTING];
          _huntingLevel ctrlCommit 0;

          _gatheringLevelProgress = SKILL_GATHERING mod 1;
          _gatheringProgressBar progressSetPosition _gatheringLevelProgress;
          _gatheringProgressBar ctrlSetTooltip format["Progress to next level: %1/100", (_gatheringLevelProgress * 100)];
          _gatheringLevel ctrlSetText format["%1/100", floor SKILL_GATHERING];
          _gatheringLevel ctrlCommit 0;

          _miningLevelProgress = SKILL_MINING mod 1;
          _miningProgressBar progressSetPosition _miningLevelProgress;
          _miningProgressBar ctrlSetTooltip format["Progress to next level: %1/100", (_miningLevelProgress * 100)];
          _miningLevel ctrlSetText format["%1/100", floor SKILL_MINING];
          _miningLevel ctrlCommit 0;

          _manufacturingLevelProgress = SKILL_MANUFACTURING mod 1;
          _manufacturingProgressBar progressSetPosition _manufacturingLevelProgress;
          _manufacturingProgressBar ctrlSetTooltip format["Progress to next level: %1/100", (_manufacturingLevelProgress * 100)];
          _manufacturingLevel ctrlSetText format["%1/100", floor SKILL_MANUFACTURING];
          _manufacturingLevel ctrlCommit 0;

          _lockpickingLevelProgress = SKILL_LOCKPICKING mod 1;
          _lockpickingProgressBar progressSetPosition _lockpickingLevelProgress;
          _lockpickingProgressBar ctrlSetTooltip format["Progress to next level: %1/100", (_lockpickingLevelProgress * 100)];
          _lockpickingLevel ctrlSetText format["%1/100", floor SKILL_LOCKPICKING];
          _lockpickingLevel ctrlCommit 0;

          _robberyLevelProgress = SKILL_ROBBERY mod 1;
          _robberyProgressBar progressSetPosition _robberyLevelProgress;
          _robberyProgressBar ctrlSetTooltip format["Progress to next level: %1/100", (_robberyLevelProgress * 100)];
          _robberyLevel ctrlSetText format["%1/100", floor SKILL_ROBBERY];
          _robberyLevel ctrlCommit 0;

          sleep 0.1;
          isnull _display
        };
        uinamespace setVariable ["GC_CurrentDisplay", nil];
      };
    };
  };
};