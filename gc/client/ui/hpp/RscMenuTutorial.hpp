class RscMenuTutorial {
  idd = -1;
  movingEnable = true;
  objects[] = {};
  controls[]=
  {
    TutorialBackground,
    InfoText,
    button_cancel,
    dummybutton,
    TutorialHeader
  };

  class TutorialBackground: IGUIBack
  {
    idc = 1002;
    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 3 * GUI_GRID_H + GUI_GRID_Y;
    w = 28 * GUI_GRID_W;
    h = 16 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class InfoText: RscText
  {
    idc = 1;
    style = 16;
    font = "EtelkaMonospaceProBold";

    x = 7.3 * GUI_GRID_W + GUI_GRID_X;
    y = 4.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 24.6 * GUI_GRID_W;
    h = 13.7 * GUI_GRID_H;
  };
  class button_cancel: RscButtonMenu
  {
    action = "closedialog 0; [""Settings""] execVM ""settings.sqf"";";

    idc = 1600;
    text = "Back";
    default = 1;
    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 19.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1035;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class TutorialHeader: IGUIHeader
  {
    idc = 1000;
    text = "Tutorial";
    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 2 * GUI_GRID_H + GUI_GRID_Y;
    w = 28 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};