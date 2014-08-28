class RscMenuBail
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuBailBackground,
    button_paybail,
    cancel,
    bail_eingabe,
    dummybutton,
    RscMenuBailHeader
  };
  class RscMenuBailBackground: IGUIBack
  {
    idc = 1000;
    x = 15 * GUI_GRID_W + GUI_GRID_X;
    y = 10 * GUI_GRID_H + GUI_GRID_Y;
    w = 10 * GUI_GRID_W;
    h = 3.5 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class button_paybail: RscButton
  {
    action = "[ctrlText 2] execVM ""bail.sqf""; closeDialog 0";

    idc = 1600;
    text = "Pay bail";
    x = 16 * GUI_GRID_W + GUI_GRID_X;
    y = 12 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class cancel: RscButtonMenu
  {
    action = "closedialog 0";

    idc = 1601;
    default = 1;
    text = "Cancel";
    x = 15 * GUI_GRID_W + GUI_GRID_X;
    y = 13.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class bail_eingabe: RscEdit
  {
    idc = 2;

    text = "1000";
    x = 16 * GUI_GRID_W + GUI_GRID_X;
    y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 7.9 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1008;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class RscMenuBailHeader: IGUIHeader
  {
    idc = 1001;
    text = "Bail";
    x = 15 * GUI_GRID_W + GUI_GRID_X;
    y = 8.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 10 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};