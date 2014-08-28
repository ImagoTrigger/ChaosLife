class RscMenuList
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuListBackground,
    header,
    spielerliste,
    close,
    dummybutton
  };

  class RscMenuListBackground: IGUIBack
  {
    idc = 1002;
    x = 8 * GUI_GRID_W + GUI_GRID_X;
    y = 2 * GUI_GRID_H + GUI_GRID_Y;
    w = 24 * GUI_GRID_W;
    h = 19 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };

  class header: IGUIHeader
  {
    idc = 696969;
    style = 0;
    moving = 1;

    text = "Stats";
    x = 8 * GUI_GRID_W + GUI_GRID_X;
    y = 1.1 * GUI_GRID_H + GUI_GRID_Y;
    w = 24 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };

  class spielerliste: RscListBox
  {
    idc = 1;
    RowHeight = 0.03;
    sizeEx = 0.02;

    x = 8.5 * GUI_GRID_W + GUI_GRID_X;
    y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 23 * GUI_GRID_W;
    h = 18 * GUI_GRID_H;
  };

  class close: RscButtonMenu
  {
    idc = 2;
    action = "closedialog 0;";

    default = 1;
    text = "Close";
    x = 8 * GUI_GRID_W + GUI_GRID_X;
    y = 21.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };

  class dummybutton: RscDummy
  {
    idc = 1017;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
};