class RscMenuCivInteraction
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuCivInteractionBackground,
    button_steal,
    button_inventarsearch,
    button_ziptie,
    cancel,
    dummybutton,
    RscMenuCivInteractionHeader
  };

  class RscMenuCivInteractionBackground: IGUIBack
  {
    idc = 1000;

    x = 15.6 * GUI_GRID_W + GUI_GRID_X;
    y = 7 * GUI_GRID_H + GUI_GRID_Y;
    w = 8.8 * GUI_GRID_W;
    h = 4.1 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class button_steal: RscButton
  {
    idc = 1;
    action = "[20] execVM ""civmenuinit.sqf""; closedialog 0";

    text = "Rob Inventory";
    x = 16 * GUI_GRID_W + GUI_GRID_X;
    y = 7.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_inventarsearch: RscButton
  {
    idc = 14;
    action = "[6] execVM ""civmenuinit.sqf""; closedialog 0";

    text = "Check Inventory";
    x = 16 * GUI_GRID_W + GUI_GRID_X;
    y = 8.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_ziptie: RscButton
  {
    idc = 200;
    action = "[""Use""] execVM ""gc\client\GC_itemsZiptie.sqf""; closedialog 0";

    text = "Ziptie/Unzip";
    x = 16 * GUI_GRID_W + GUI_GRID_X;
    y = 9.7 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class cancel: RscButtonMenu
  {
    action = "closedialog 0";
    idc = 1602;
    default = 1;

    text = "Cancel";
    x = 15.6 * GUI_GRID_W + GUI_GRID_X;
    y = 11.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 4.4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1006;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class RscMenuCivInteractionHeader: IGUIHeader
  {
    idc = 1001;

    text = "Interact";
    x = 15.6 * GUI_GRID_W + GUI_GRID_X;
    y = 5.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 8.8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};