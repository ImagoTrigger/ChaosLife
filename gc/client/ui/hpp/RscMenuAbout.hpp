class RscMenuAbout {
  idd = -1;
  movingEnable = true;
  objects[] = {};
  controls[]=
  {
    AboutDialogBackground,
    InfoText,
    button_cancel,
    dummybutton,
    AboutDialogHeader
  };
  class AboutDialogBackground: IGUIBack
  {
    idc = 1000;
    x = 5 * GUI_GRID_W + GUI_GRID_X;
    y = 3 * GUI_GRID_H + GUI_GRID_Y;
    w = 30.1 * GUI_GRID_W;
    h = 16 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class InfoText: RscText
  {
    idc = 1;
    style = 16;

    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 4 * GUI_GRID_H + GUI_GRID_Y;
    w = 28.1 * GUI_GRID_W;
    h = 14 * GUI_GRID_H;
    colorBackground[] = {0,0,0,1};
  };
  class button_cancel: RscButtonMenu
  {
    action = "closedialog 0; [""Settings""] execVM ""settings.sqf"";";
    default = 1;
    idc = 1600;
    text = "Back";
    x = 5 * GUI_GRID_W + GUI_GRID_X;
    y = 19.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1037;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class AboutDialogHeader: IGUIHeader
  {
    idc = 1002;
    text = "About Chaos Life";
    x = 5 * GUI_GRID_W + GUI_GRID_X;
    y = 2 * GUI_GRID_H + GUI_GRID_Y;
    w = 30.1 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};
