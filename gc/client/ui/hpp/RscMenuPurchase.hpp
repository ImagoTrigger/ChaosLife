class RscMenuPurchase

{
	onLoad = "[""onLoad"",_this,""RscMenuPurchase"",'GCGUI'] call compile preprocessfilelinenumbers ""gc\client\GC_initDisplay.sqf""";
  idd = 13000;
  movingEnable = true;
  controls[]=
  {
    RscMenuPurchaseStorageBackground,
    RscMenuPurchaseStoreBackground,
    itemliste,
    itemeingabe,
    submit,
    cancel,
    weight,
    submit2,
    itemeingabe2,
    itemliste2,
    text_inventarcash,
    text_inventoryweight,
    dummybutton,
    RscMenuPurchaseHeader
  };

  class RscMenuPurchaseStorageBackground: IGUIBack
  {
    idc = 1008;
    x = 20.4 * GUI_GRID_W + GUI_GRID_X;
    y = 1.75 * GUI_GRID_H + GUI_GRID_Y;
    w = 18.4 * GUI_GRID_W;
    h = 15.75 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuPurchaseStoreBackground: IGUIBack
  {
    idc = 1007;
    x = 0.8 * GUI_GRID_W + GUI_GRID_X;
    y = 1.75 * GUI_GRID_H + GUI_GRID_Y;
    w = 18.6 * GUI_GRID_W;
    h = 15.7 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class itemliste: RscListBox
  {
    idc = 1;

    x = 1.6 * GUI_GRID_W + GUI_GRID_X;
    y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 16.8 * GUI_GRID_W;
    h = 12 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.8};
    sizeEx = MEDIUM_TEXT;
  };
  class itemeingabe: RscEdit
  {
    idc = 2;

    text = "1";
    x = 1.6 * GUI_GRID_W + GUI_GRID_X;
    y = 15 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class submit: RscButton
  {
    idc = 3;

    x = 10 * GUI_GRID_W + GUI_GRID_X;
    y = 15 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class cancel: RscButtonMenu
  {
    idc = 500;
    action = "closedialog 0";

    text = "Close";
    x = 0.7 * GUI_GRID_W + GUI_GRID_X;
    y = 17.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 8.1 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class weight: RscText
  {
    idc = 765;

    x = 1.6 * GUI_GRID_W + GUI_GRID_X;
    y = 16.25 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
  class submit2: RscButton
  {
    idc = 103;

    x = 29.6 * GUI_GRID_W + GUI_GRID_X;
    y = 15 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class itemeingabe2: RscEdit
  {
    idc = 102;

    text = "1";
    x = 21.2 * GUI_GRID_W + GUI_GRID_X;
    y = 15 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
  class itemliste2: RscListBox
  {
    idc = 101;

    x = 21.2 * GUI_GRID_W + GUI_GRID_X;
    y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 16.8 * GUI_GRID_W;
    h = 12 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.8};
    sizeEx = MEDIUM_TEXT;
  };
  class text_inventarcash: RscText
  {
    idc = 100;

    text = "Loading...";
    x = 1.6 * GUI_GRID_W + GUI_GRID_X;
    y = 16.25 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
  class text_inventoryweight: RscText
  {
    idc = 10;

    x = 21.2 * GUI_GRID_W + GUI_GRID_X;
    y = 16.25 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
  class dummybutton: RscDummy
  {
    idc = 1015;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class RscMenuPurchaseHeader: IGUIHeader
  {
    idc = 1000;
    text = "";
    x = 0.8 * GUI_GRID_W + GUI_GRID_X;
    y = 0.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 38 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};