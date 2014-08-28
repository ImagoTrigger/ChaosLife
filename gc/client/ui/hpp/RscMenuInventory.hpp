class RscMenuInventory {
  idd = 12001;
  movingEnable = true;
  objects[] = { };
  onLoad = "[""onLoad"",_this,""RscMenuInventory"",'GCGUI'] call compile preprocessfilelinenumbers ""gc\client\GC_initDisplay.sqf""";
  controls[]=
  {
    RscMenuInventoryBackground,
    ItemlistBackground,
    RscMenuInventoryHeader,
    CapacityBar,
    button_use,
    button_cancel,
    button_drop,
    TransferButton,
    UseAmounteingabe,
    playerlist,
    InfoAnzahl,
    Itemlist,
    dummybutton,
    TotalWeight,
    RscMenuInventoryKeys,
    RscMenuInventoryPhone
  };
  class RscMenuInventoryBackground: IGUIBack
  {
    idc = 1012;

    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 4 * GUI_GRID_H + GUI_GRID_Y;
    w = 28 * GUI_GRID_W;
    h = 11.5 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuInventoryHeader: IGUIHeader
  {
    idc = 101;

    text = "Inventory";
    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 2.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 28 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class CapacityBar: RscProgress
  {
    idc = 502;

    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 14.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 27.3 * GUI_GRID_W;
    h = 0.9 * GUI_GRID_H;
  };
  class button_use: RscButton
  {
    idc = 3;

    text = "Use";
    x = 24 * GUI_GRID_W + GUI_GRID_X;
    y = 8.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 9.5 * GUI_GRID_W;
    h = 1.1 * GUI_GRID_H;
  };
  class button_cancel: RscButtonMenu
  {
    idc = 1601;

    text = "Close";
    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 15.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.8};
  };
  class button_drop: RscButton
  {
    idc = 4;

    text = "Drop";
    x = 24 * GUI_GRID_W + GUI_GRID_X;
    y = 6.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 4.5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class TransferButton: RscButton
  {
    idc = 246;

    text = "Give";
    x = 29.1 * GUI_GRID_W + GUI_GRID_X;
    y = 6.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 4.5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class UseAmounteingabe: RscEdit
  {
    idc = 501;

    text = "1";
    x = 24.1 * GUI_GRID_W + GUI_GRID_X;
    y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class playerlist: RscCombo
  {
    idc = 99;

    x = 24 * GUI_GRID_W + GUI_GRID_X;
    y = 4.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 9.7 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
  class InfoAnzahl: RscText
  {
    idc = 61;
    text = "QTY";
    x = 29.4 * GUI_GRID_W + GUI_GRID_X;
    y = 5.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 4.1 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class Itemlist: RscListNBox
  {
    idc = 1;
    columns[] = {-0.01,0.05,0.7};

    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 4.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 17.4 * GUI_GRID_W;
    h = 9.8 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.8};
  };
  class ItemlistBackground: RscText
  {
    idc = -11;

    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 4.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 17.4 * GUI_GRID_W;
    h = 9.8 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.8};
  };
  class dummybutton: RscDummy
  {
    idc = 1001;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class TotalWeight: RscText
  {
    idc = 64;

    x = 16 * GUI_GRID_W + GUI_GRID_X;
    y = 14.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 9 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    sizeEx = BIGGER_TEXT;
  };
  class RscMenuInventoryKeys: RscButton
  {
    idc = 503;

    text = "Keys";
    x = 24 * GUI_GRID_W + GUI_GRID_X;
    y = 13 * GUI_GRID_H + GUI_GRID_Y;
    w = 4.5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuInventoryPhone: RscButton
  {
    idc = 504;

    text = "Phone";
    x = 29.1 * GUI_GRID_W + GUI_GRID_X;
    y = 13 * GUI_GRID_H + GUI_GRID_Y;
    w = 4.5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};