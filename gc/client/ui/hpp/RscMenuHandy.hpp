class RscMenuHandy {
  idd = -1;
  movingEnable = true;
  objects[] = {};
  controls[]=
  {
    RscMenuHandyBackground,
    eingabefeld,
    kosten,
    submit,
    cancel,
    spielerliste,
    dummybutton,
    RscMenuHandyHeader
  };
    class RscMenuHandyBackground: IGUIBack
  {
    idc = 1000;
    x = 5 * GUI_GRID_W + GUI_GRID_X;
    y = 8 * GUI_GRID_H + GUI_GRID_Y;
    w = 29.5 * GUI_GRID_W;
    h = 3 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class eingabefeld: RscEdit
  {
    idc = 1;

    x = 5.5 * GUI_GRID_W + GUI_GRID_X;
    y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 28.5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
  class kosten: RscText
  {
    idc = 4;

    text = "Cost: $%1";
    x = 19.6 * GUI_GRID_W + GUI_GRID_X;
    y = 9.7 * GUI_GRID_H + GUI_GRID_Y;
    w = 5.6 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class submit: RscButton
  {
    idc = 3;

    text = "Send";
    x = 26 * GUI_GRID_W + GUI_GRID_X;
    y = 9.7 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class cancel: RscButtonMenu
  {
    idc = 5;
    action = "closedialog 0;";

    text = "Cancel";
    x = 5 * GUI_GRID_W + GUI_GRID_X;
    y = 11.1 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class spielerliste: RscCombo
  {
    idc = 2;

    x = 5.5 * GUI_GRID_W + GUI_GRID_X;
    y = 9.7 * GUI_GRID_H + GUI_GRID_Y;
    w = 13.3 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
  class dummybutton: RscDummy
  {
    idc = 1016;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class RscMenuHandyHeader: IGUIHeader
  {
    idc = 1002;
    text = "Send SMS";
    x = 5 * GUI_GRID_W + GUI_GRID_X;
    y = 6.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 29.5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};