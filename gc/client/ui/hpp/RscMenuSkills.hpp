class RscMenuSkills
{
  idd = 12500;
  movingEnable = true;
  onLoad = "[""onLoad"",_this,""RscMenuSkills"",'GCGUI'] call compile preprocessfilelinenumbers ""gc\client\GC_initDisplay.sqf""";
  objects[] = { };
    controls[]=
  {
    RscMenuSkillsBackground,
    RscMenuSkillsHeader,
    RscMenuSkillsFishingProgress,
    button_cancel,
    RscMenuSkillsFishingText,
    RscMenuSkillsFishingLevel,
    RscMenuSkillsHuntingText,
    RscMenuSkillsHuntingProgress,
    RscMenuSkillsHuntingLevel,
    RscMenuSkillsGatheringText,
    RscMenuSkillsGatheringProgress,
    RscMenuSkillsGatheringLevel,
    RscMenuSkillsMiningText,
    RscMenuSkillsMiningProgress,
    RscMenuSkillsMiningLevel,
    RscMenuSkillsManufacturingText,
    RscMenuSkillsManufacturingProgress,
    RscMenuSkillsManufacturingLevel,
    RscMenuSkillsLockpickingText,
    RscMenuSkillsLockpickingProgress,
    RscMenuSkillsLockpickingLevel,
    RscMenuSkillsRobberyText,
    RscMenuSkillsRobberyProgress,
    RscMenuSkillsRobberyLevel
  };

  class RscMenuSkillsBackground: IGUIBack
  {
    idc = 100;

    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 4 * GUI_GRID_H + GUI_GRID_Y;
    w = 28 * GUI_GRID_W;
    h = 11.5 * GUI_GRID_H;
  };
  class RscMenuSkillsHeader: IGUIHeader
  {
    idc = 101;

    text = "Skills";
    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 2.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 28 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsFishingProgress: RscProgress
  {
    idc = 600;

    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 5.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 13.5 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
  };
  class button_cancel: RscButtonMenu
  {
    idc = 1601;

    text = "Close";
    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 15.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.8};
  };
  class RscMenuSkillsFishingText: RscText
  {
    idc = 1002;

    text = "Fishing";
    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsFishingLevel: RscText
  {
    idc = 1003;
    style = 2;

    text = "";
    x = 11.15 * GUI_GRID_W + GUI_GRID_X;
    y = 5.85 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsHuntingText: RscText
  {
    idc = 1004;

    text = "Hunting";
    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 7.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsHuntingProgress: RscProgress
  {
    idc = 1005;

    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 8.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 13.5 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
  };
  class RscMenuSkillsHuntingLevel: RscText
  {
    idc = 1006;
    style = 2;

    text = "";
    x = 11.15 * GUI_GRID_W + GUI_GRID_X;
    y = 8.55 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsGatheringText: RscText
  {
    idc = 1007;

    text = "Gathering";
    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 9.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.3 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsGatheringProgress: RscProgress
  {
    idc = 1008;

    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 11 * GUI_GRID_H + GUI_GRID_Y;
    w = 13.5 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
  };
  class RscMenuSkillsGatheringLevel: RscText
  {
    idc = 1009;
    style = 2;

    text = "";
    x = 11.15 * GUI_GRID_W + GUI_GRID_X;
    y = 11.25 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsMiningText: RscText
  {
    idc = 1010;

    text = "Mining";
    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 12.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.3 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsMiningProgress: RscProgress
  {
    idc = 1011;

    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 13.7 * GUI_GRID_H + GUI_GRID_Y;
    w = 13.5 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
  };
  class RscMenuSkillsMiningLevel: RscText
  {
    idc = 1012;
    style = 2;

    text = "";
    x = 11.15 * GUI_GRID_W + GUI_GRID_X;
    y = 13.95 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsManufacturingText: RscText
  {
    idc = 1013;

    text = "Manufacturing";
    x = 20.2 * GUI_GRID_W + GUI_GRID_X;
    y = 4.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 7 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsManufacturingProgress: RscProgress
  {
    idc = 1014;

    x = 20.2 * GUI_GRID_W + GUI_GRID_X;
    y = 5.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 13.5 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
  };
  class RscMenuSkillsManufacturingLevel: RscText
  {
    idc = 1015;
    style = 2;

    text = "";
    x = 24.95 * GUI_GRID_W + GUI_GRID_X;
    y = 5.85 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsLockpickingText: RscText
  {
    idc = 1016;

    text = "Lockpicking";
    x = 20.2 * GUI_GRID_W + GUI_GRID_X;
    y = 7.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 7 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsLockpickingProgress: RscProgress
  {
    idc = 1017;

    x = 20.2 * GUI_GRID_W + GUI_GRID_X;
    y = 8.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 13.5 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
  };
  class RscMenuSkillsLockpickingLevel: RscText
  {
    idc = 1018;
    style = 2;

    text = "";
    x = 24.95 * GUI_GRID_W + GUI_GRID_X;
    y = 8.55 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsRobberyText: RscText
  {
    idc = 1019;

    text = "Robbery";
    x = 20.2 * GUI_GRID_W + GUI_GRID_X;
    y = 9.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 7 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuSkillsRobberyProgress: RscProgress
  {
    idc = 1020;

    x = 20.2 * GUI_GRID_W + GUI_GRID_X;
    y = 11 * GUI_GRID_H + GUI_GRID_Y;
    w = 13.5 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
  };
  class RscMenuSkillsRobberyLevel: RscText
  {
    idc = 1021;
    style = 2;

    text = "";
    x = 24.95 * GUI_GRID_W + GUI_GRID_X;
    y = 11.25 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};