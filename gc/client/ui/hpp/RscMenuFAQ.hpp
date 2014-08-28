class RscMenuFAQ {
  idd = -1;
  movingEnable = 1;
  controls[]=
  {
    FaqDialogBackground,
    InfoText,
    button_cancel,
    dummybutton,
    FaqDialogHeader
  };

  class FaqDialogBackground: IGUIBack
  {
    idc = 1000;
    x = 0 * GUI_GRID_W + GUI_GRID_X;
    y = 1 * GUI_GRID_H + GUI_GRID_Y;
    w = 40 * GUI_GRID_W;
    h = 20 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class InfoText: RscPicture
  {
    idc = 1;

    text = "#(argb,8,8,3)color(1,1,1,1)";
    x = 1.1 * GUI_GRID_W + GUI_GRID_X;
    y = 2 * GUI_GRID_H + GUI_GRID_Y;
    w = 37.9 * GUI_GRID_W;
    h = 18 * GUI_GRID_H;
  };
  class button_cancel: RscButtonMenu
  {
    action = "closedialog 0; [""Settings""] execVM ""settings.sqf"";";

    idc = 1600;
    default = 1;
    text = "Back";
    x = 0 * GUI_GRID_W + GUI_GRID_X;
    y = 21.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1036;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class FaqDialogHeader: RscText
  {
    idc = 1001;
    text = "Chaos Keys -- Default Layout";
    x = 0 * GUI_GRID_W + GUI_GRID_X;
    y = 0 * GUI_GRID_H + GUI_GRID_Y;
    w = 40 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};