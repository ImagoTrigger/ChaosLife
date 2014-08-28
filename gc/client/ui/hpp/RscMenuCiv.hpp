class RscMenuCiv
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
    controls[]=
  {
    RscText_1003,
    RscMenuCivBackground2,
    RscMenuCivBackground1,
    RscMenuCivHeader,
    button_disarm,
    button_drugs,
    arrest_slider,
    button_arrest,
    button_restrain,
    ticket_eingabe,
    button_ticket,
    cancel,
    button_heal,
    button_inventarsearch,
    dummybutton,
    RscMenuCivArrestDuration
  };
  class RscText_1003: RscText
  {
    idc = 1004;

    x = 18.2 * GUI_GRID_W + GUI_GRID_X;
    y = 9 * GUI_GRID_H + GUI_GRID_Y;
    w = 9.9 * GUI_GRID_W;
    h = 3.8 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuCivBackground2: IGUIBack
  {
    idc = 1004;

    x = 18.2 * GUI_GRID_W + GUI_GRID_X;
    y = 13 * GUI_GRID_H + GUI_GRID_Y;
    w = 9.9 * GUI_GRID_W;
    h = 2.8 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuCivBackground1: IGUIBack
  {
    idc = 1003;

    x = 8 * GUI_GRID_W + GUI_GRID_X;
    y = 9 * GUI_GRID_H + GUI_GRID_Y;
    w = 10 * GUI_GRID_W;
    h = 6.8 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuCivHeader: IGUIHeader
  {
    idc = 1000;

    text = "Civilian Actions";
    x = 8 * GUI_GRID_W + GUI_GRID_X;
    y = 7.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 20.1 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_disarm: RscButton
  {
    idc = 1;
    action = "[2] execVM ""civmenuinit.sqf""; closedialog 0";

    text = "Disarm";
    x = 9 * GUI_GRID_W + GUI_GRID_X;
    y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_drugs: RscButton
  {
    idc = 2;
    action = "[1] execVM ""civmenuinit.sqf""; closedialog 0";

    text = "Drug Search";
    x = 9 * GUI_GRID_W + GUI_GRID_X;
    y = 10.7 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class arrest_slider: RscSlider
  {
    idc = 3;

    x = 19 * GUI_GRID_W + GUI_GRID_X;
    y = 10.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_arrest: RscButton
  {
    idc = 5;
    action = "[3, sliderPosition 3] execVM ""civmenuinit.sqf""; closedialog 0";

    text = "Arrest";
    x = 19 * GUI_GRID_W + GUI_GRID_X;
    y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_restrain: RscButton
  {
    idc = 6;
    action = "[] execVM ""Restrain.sqf""; closedialog 0";

    text = "Restrain/Release";
    x = 9 * GUI_GRID_W + GUI_GRID_X;
    y = 13.1 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class ticket_eingabe: RscEdit
  {
    idc = 11;

    text = "1000";
    x = 19 * GUI_GRID_W + GUI_GRID_X;
    y = 13.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 0.75 * GUI_GRID_H;
  };
  class button_ticket: RscButton
  {
    action = "[4, ctrlText 11] execVM ""civmenuinit.sqf""; closedialog 0";
    idc = 1604;

    text = "Ticket";
    x = 19 * GUI_GRID_W + GUI_GRID_X;
    y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class cancel: RscButtonMenu
  {
    action = "closedialog 0";
    idc = 1605;

    default = 1;
    text = "Cancel";
    x = 8 * GUI_GRID_W + GUI_GRID_X;
    y = 15.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 5.5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_heal: RscButton
  {
    idc = 13;
    action = "[5] execVM ""civmenuinit.sqf""; closedialog 0";

    text = "Heal this Civ";
    x = 9 * GUI_GRID_W + GUI_GRID_X;
    y = 14.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_inventarsearch: RscButton
  {
    idc = 14;
    action = "[6] execVM ""civmenuinit.sqf""; closedialog 0";

    text = "Check Inventory";
    x = 9 * GUI_GRID_W + GUI_GRID_X;
    y = 11.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
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
  class RscMenuCivArrestDuration: RscMediumText
  {
    idc = 4;
    style = ST_CENTER;
    text = "0";
    x = 19.2 * GUI_GRID_W + GUI_GRID_X;
    y = 9.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 7.6 * GUI_GRID_W;
    h = 0.7 * GUI_GRID_H;
  };
};