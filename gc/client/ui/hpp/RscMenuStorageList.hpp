class RscMenuStorageList
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuStorageListbackground,
    liste,
    close,
    dummybutton,
    RscMenuStorageListHeader
  };

  class RscMenuStorageListbackground: IGUIBack
  {
    idc = 1002;
    x = 8.5 * GUI_GRID_W + GUI_GRID_X;
    y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 20.8 * GUI_GRID_W;
    h = 19.1 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class liste: RscListBox
  {
    idc = 1;
    RowHeight = 0.03;

    x = 9 * GUI_GRID_W + GUI_GRID_X;
    y = 3.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 19.8 * GUI_GRID_W;
    h = 18.25 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.8};
    sizeEx = 0.02;
  };
  class close: RscButtonMenu
  {
    idc = 2;
    action = "closedialog 0;";

    text = "Close";
    x = 8.5 * GUI_GRID_W + GUI_GRID_X;
    y = 22.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 2017;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class RscMenuStorageListHeader: IGUIHeader
  {
    idc = 1000;
    text = "List";
    x = 8.5 * GUI_GRID_W + GUI_GRID_X;
    y = 2.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 20.8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};