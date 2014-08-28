class RscMenuDistribute
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuDistributeBackground,
    RscMenuDistributeHeader,
    itemlist,
    submit,
    cancel
  };
  class RscMenuDistributeBackground: IGUIBack
  {
    idc = 1000;
    x = 12 * GUI_GRID_W + GUI_GRID_X;
    y = 5.1 * GUI_GRID_H + GUI_GRID_Y;
    w = 16 * GUI_GRID_W;
    h = 7.4 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuDistributeHeader: RscText
  {
    idc = 1002;
    text = "Select a vehicle";
    x = 12 * GUI_GRID_W + GUI_GRID_X;
    y = 4 * GUI_GRID_H + GUI_GRID_Y;
    w = 16 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class itemlist: RscListBox
  {
    idc = 1;
    sizeEx = MEDIUM_TEXT;
    x = 12.5 * GUI_GRID_W + GUI_GRID_X;
    y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 15 * GUI_GRID_W;
    h = 5.2 * GUI_GRID_H;
  };
  class submit: RscButton
  {
    idc = 2;

    text = "Select";
    x = 16 * GUI_GRID_W + GUI_GRID_X;
    y = 11 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class cancel: RscButtonMenu
  {
    action = "closedialog 0;";

    idc = 1601;
    text = "Close";
    default = 1;
    x = 12 * GUI_GRID_W + GUI_GRID_X;
    y = 12.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};