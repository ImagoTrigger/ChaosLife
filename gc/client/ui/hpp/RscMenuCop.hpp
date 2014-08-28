class RscMenuCop
{
  idd = 12000;
  movingEnable = true;
  onLoad = "[""onLoad"",_this,""RscMenuCop"",'GCGUI'] call compile preprocessfilelinenumbers ""gc\client\GC_initDisplay.sqf""";
  objects[] = { };
  controls[]=
  {
    RscMenuCopBackground2,
    priswantbutton,
    crimelog,
    copmarkers,
    RscMenuCopHeader,
    RscMenuCopCloseButton,
    RscText_1002,
    RscMenuCopJailCam,
    RscMenuCopCivCam,
    RscMenuCopSatCam
  };
  class RscMenuCopBackground2: IGUIBack
  {
    idc = 1001;

    x = 10 * GUI_GRID_W + GUI_GRID_X;
    y = 8.1 * GUI_GRID_H + GUI_GRID_Y;
    w = 11 * GUI_GRID_W;
    h = 3.9 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class priswantbutton: RscButtonMenu
  {
    idc = 1600;

    text = "Prison/Wanted Menu";
    x = 10.5 * GUI_GRID_W + GUI_GRID_X;
    y = 8.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 10 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class crimelog: RscButtonMenu
  {
    idc = 1601;

    text = "Crime log";
    x = 10.5 * GUI_GRID_W + GUI_GRID_X;
    y = 9.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 10 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class copmarkers: RscButtonMenu
  {
    idc = 1602;

    x = 10.5 * GUI_GRID_W + GUI_GRID_X;
    y = 10.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 10 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuCopHeader: IGUIHeader
  {
    idc = 1000;

    text = "Cop Menu";
    x = 10 * GUI_GRID_W + GUI_GRID_X;
    y = 7 * GUI_GRID_H + GUI_GRID_Y;
    w = 20.2 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuCopCloseButton: RscButtonMenu
  {
    idc = 2400;

    text = "Close";
    x = 10 * GUI_GRID_W + GUI_GRID_X;
    y = 12.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscText_1002: IGUIBack
  {
    idc = 1001;

    x = 21.2 * GUI_GRID_W + GUI_GRID_X;
    y = 8.1 * GUI_GRID_H + GUI_GRID_Y;
    w = 9 * GUI_GRID_W;
    h = 3.9 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuCopJailCam: RscButtonMenu
  {
    idc = 1603;
    text = "Jail Cam";
    x = 21.7 * GUI_GRID_W + GUI_GRID_X;
    y = 8.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuCopCivCam: RscButtonMenu
  {
    idc = 1604;
    text = "Civilian Cam";
    x = 21.7 * GUI_GRID_W + GUI_GRID_X;
    y = 9.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuCopSatCam: RscButtonMenu
  {
    idc = 1605;
    text = "Sat Cam";
    x = 21.7 * GUI_GRID_W + GUI_GRID_X;
    y = 10.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};