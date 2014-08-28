class RscMenuFactoryManufacture
{

  idd = 2002;
  movingEnable = true;
  onLoad = "[""onLoad"",_this,""RscMenuFactoryManufacture"",'GCGUI'] call compile preprocessfilelinenumbers ""gc\client\GC_initDisplay.sqf""";
  objects[] = { };
  controls[]=
  {
    RscMenuFactoryManufactureBackground,
    RscMenuFactoryManufactureHeader,
    list_manifacture,
    list_needed,
    create,
    export,
    manifacture,
    close,
    dummybutton
  };
  class RscMenuFactoryManufactureBackground: IGUIBack
  {
    idc = 1000;

    x = 4 * GUI_GRID_W + GUI_GRID_X;
    y = 3 * GUI_GRID_H + GUI_GRID_Y;
    w = 32.1 * GUI_GRID_W;
    h = 11 * GUI_GRID_H;
  };
  class RscMenuFactoryManufactureHeader: IGUIHeader
  {
    idc = 1003;

    text = "Manufacture - Items";
    x = 4 * GUI_GRID_W + GUI_GRID_X;
    y = 1.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 32.1 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class list_manifacture: RscListBox
  {
    idc = 1;

    x = 4.5 * GUI_GRID_W + GUI_GRID_X;
    y = 3.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 20.3 * GUI_GRID_W;
    h = 10.25 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.8};
    sizeEx = MEDIUM_TEXT;
  };
  class list_needed: RscListBox
  {
    idc = 2;

    x = 25.7 * GUI_GRID_W + GUI_GRID_X;
    y = 3.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 10 * GUI_GRID_W;
    h = 6.55 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.8};
    sizeEx = MEDIUM_TEXT;
  };
  class create: RscButton
  {
    idc = 4;

    text = "Create";
    x = 25.7 * GUI_GRID_W + GUI_GRID_X;
    y = 10.1 * GUI_GRID_H + GUI_GRID_Y;
    w = 10 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class export: RscButton
  {
    idc = 5;

    text = "Export";
    x = 25.7 * GUI_GRID_W + GUI_GRID_X;
    y = 11.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 10 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class manifacture: RscButton
  {
    idc = 3;

    text = "Manufacture";
    x = 25.7 * GUI_GRID_W + GUI_GRID_X;
    y = 12.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 10 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class close: RscButtonMenu
  {
    action = "closeDialog 0;";
    idc = 1603;

    text = "Close";
    x = 4 * GUI_GRID_W + GUI_GRID_X;
    y = 14.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 6 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.8};
  };
  class dummybutton: RscDummy
  {
    idc = 1030;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
};