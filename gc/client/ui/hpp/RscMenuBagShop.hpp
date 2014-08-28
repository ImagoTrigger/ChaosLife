class RscMenuBagShop
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuBagShopBackground,
    RscMenuBagShopHeader,
    info4,
    info1,
    info2,
    info3,
    info5,
    info6,
    button1,
    button2,
    button3,
    button4,
    button5,
    RscMenuBagShopClose,
    RscMenuBagShopBackpacks
  };

  class RscMenuBagShopBackground: IGUIBack
  {
    idc = 1000;

    x = 11 * GUI_GRID_W + GUI_GRID_X;
    y = 6 * GUI_GRID_H + GUI_GRID_Y;
    w = 18 * GUI_GRID_W;
    h = 8.5 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuBagShopHeader: IGUIHeader
  {
    idc = 1005;

    text = "Trade for Bags / Backpack Shop";
    x = 11 * GUI_GRID_W + GUI_GRID_X;
    y = 4.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 18 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class info4: RscText
  {
    idc = 45;

    text = "Inventory increases do not stack.";
    x = 11.5 * GUI_GRID_W + GUI_GRID_X;
    y = 6.1 * GUI_GRID_H + GUI_GRID_Y;
    w = 17 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class info1: RscMediumText
  {
    idc = 20;

    text = "10kg Plastic Bag:";
    x = 11.5 * GUI_GRID_W + GUI_GRID_X;
    y = 7.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class info2: RscMediumText
  {
    idc = 30;

    text = "30kg Rabbit Pelt Bag:";
    x = 11.5 * GUI_GRID_W + GUI_GRID_X;
    y = 8.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class info3: RscMediumText
  {
    idc = 40;

    text = "60kg Snake Skin Bag:";
    x = 11.5 * GUI_GRID_W + GUI_GRID_X;
    y = 10.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class info5: RscMediumText
  {
    idc = 45;

    text = "90kg Leather Bag:";
    x = 11.5 * GUI_GRID_W + GUI_GRID_X;
    y = 11.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class info6: RscMediumText
  {
    idc = 46;

    text = "140kg Shell Case:";
    x = 11.5 * GUI_GRID_W + GUI_GRID_X;
    y = 13 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button1: RscButton
  {
    idc = 50;
    action = "[1] execVM ""bagshop.sqf"";";

    text = "$100000 Cash";
    x = 20 * GUI_GRID_W + GUI_GRID_X;
    y = 7.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 8.6 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button2: RscButton
  {
    idc = 60;
    action = "[2] execVM ""bagshop.sqf"";";

    text = "5 Rabbit Pelt";
    x = 20 * GUI_GRID_W + GUI_GRID_X;
    y = 8.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 8.6 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button3: RscButton
  {
    idc = 70;
    action = "[3] execVM ""bagshop.sqf"";";

    text = "5 Snake Skin";
    x = 20 * GUI_GRID_W + GUI_GRID_X;
    y = 10.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 8.6 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button4: RscButton
  {
    idc = 74;
    action = "[4] execVM ""bagshop.sqf"";";

    text = "5 Sheep Hide";
    x = 20 * GUI_GRID_W + GUI_GRID_X;
    y = 11.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 8.6 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button5: RscButton
  {
    idc = 75;
    action = "[5] execVM ""bagshop.sqf"";";

    text = "5 Turtle Shell";
    x = 20 * GUI_GRID_W + GUI_GRID_X;
    y = 13 * GUI_GRID_H + GUI_GRID_Y;
    w = 8.6 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuBagShopClose: RscButtonMenu
  {
    idc = 2400;
    action = "closedialog 0;";
    default = 0;

    text = "Close";
    x = 23.8 * GUI_GRID_W + GUI_GRID_X;
    y = 14.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 5.5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.8};
  };
  class RscMenuBagShopBackpacks: RscButtonMenu
  {
    idc = 2401;
    action = "[0, 0, 0, [(bagshop call INV_getshopnum)]] execVM ""shopdialogs.sqf"";";
    default = 1;

    text = "Backpacks";
    x = 11 * GUI_GRID_W + GUI_GRID_X;
    y = 14.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 6 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.8};
  };
};