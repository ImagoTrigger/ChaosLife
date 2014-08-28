class RscMenuItemInfo
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
    controls[]=
  {
    ItemListBackground,
    Itemlist,
    InfoText,
    InfoGewicht,
    list_needed,
    button_cancel,
    dummybutton,
    ItemListHeader
  };
  class ItemListBackground: IGUIBack
  {
    idc = 1000;

    x = 3 * GUI_GRID_W + GUI_GRID_X;
    y = 2 * GUI_GRID_H + GUI_GRID_Y;
    w = 34 * GUI_GRID_W;
    h = 19 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class Itemlist: RscListBox
  {
    idc = 1;

    x = 3.5 * GUI_GRID_W + GUI_GRID_X;
    y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 12 * GUI_GRID_W;
    h = 17.5 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class InfoText: RscText
  {
    idc = 2;
    style = 16;

    x = 16.1 * GUI_GRID_W + GUI_GRID_X;
    y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 20.5 * GUI_GRID_W;
    h = 8.4 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class InfoGewicht: RscText
  {
    idc = 3;

    x = 16.2 * GUI_GRID_W + GUI_GRID_X;
    y = 11.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 10 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class list_needed: RscListBox
  {
    idc = 4;

    x = 16.2 * GUI_GRID_W + GUI_GRID_X;
    y = 12.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 20.4 * GUI_GRID_W;
    h = 7.15 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class button_cancel: RscButtonMenu
  {
    idc = 5;
    action = "closedialog 0;";

    text = "Back";
    x = 3 * GUI_GRID_W + GUI_GRID_X;
    y = 21.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1038;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class ItemListHeader: IGUIHeader
  {
    idc = 1005;

    text = "Item Information";
    x = 3 * GUI_GRID_W + GUI_GRID_X;
    y = 1 * GUI_GRID_H + GUI_GRID_Y;
    w = 34 * GUI_GRID_W;
    h = 1.1 * GUI_GRID_H;
  };
};