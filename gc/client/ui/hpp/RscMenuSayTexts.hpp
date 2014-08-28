class RscMenuSayTexts {
  idd = -1;
  movingEnable = true;
  objects[] = {};
  controls[]=
  {
    SayTextsBackground,
    SayTextsHeader,
    eingabefenster_1,
    eingabelist_1,
    eingabefenster_2,
    eingabelist_2,
    eingabefenster_3,
    eingabelist_3,
    eingabefenster_4,
    eingabelist_4,
    button_cancel,
    button_save,
    dummybutton
  };

  class SayTextsBackground: IGUIBack
  {
    idc = 1000;

    x = 5 * GUI_GRID_W + GUI_GRID_X;
    y = 6 * GUI_GRID_H + GUI_GRID_Y;
    w = 30 * GUI_GRID_W;
    h = 9 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class SayTextsHeader: IGUIHeader
  {
    idc = 1001;

    text = "Modify Say Texts";
    x = 5 * GUI_GRID_W + GUI_GRID_X;
    y = 5 * GUI_GRID_H + GUI_GRID_Y;
    w = 30 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class eingabefenster_1: RscEdit
  {
    idc = 1;
    onChar = "[_this, 1] call TastenDruck;";

    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 7 * GUI_GRID_H + GUI_GRID_Y;
    w = 20 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class eingabelist_1: RscCombo
  {
    idc = 11;

    x = 27 * GUI_GRID_W + GUI_GRID_X;
    y = 7 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class eingabefenster_2: RscEdit
  {
    idc = 2;
    onChar = "[_this, 1] call TastenDruck;";

    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 9 * GUI_GRID_H + GUI_GRID_Y;
    w = 20 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class eingabelist_2: RscCombo
  {
    idc = 12;

    x = 27 * GUI_GRID_W + GUI_GRID_X;
    y = 9 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class eingabefenster_3: RscEdit
  {
    idc = 3;
    onChar = "[_this, 1] call TastenDruck;";

    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 11 * GUI_GRID_H + GUI_GRID_Y;
    w = 20 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class eingabelist_3: RscCombo
  {
    idc = 13;

    x = 27 * GUI_GRID_W + GUI_GRID_X;
    y = 11 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class eingabefenster_4: RscEdit
  {
    idc = 4;
    onChar = "[_this, 1] call TastenDruck;";

    x = 6 * GUI_GRID_W + GUI_GRID_X;
    y = 13 * GUI_GRID_H + GUI_GRID_Y;
    w = 20 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class eingabelist_4: RscCombo
  {
    idc = 14;

    x = 27 * GUI_GRID_W + GUI_GRID_X;
    y = 13 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_cancel: RscButtonMenu
  {
    action = "closedialog 0; [""Settings""] execVM ""settings.sqf"";";
    idc = 1600;

    text = "Back";
    x = 5 * GUI_GRID_W + GUI_GRID_X;
    y = 15.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 8.4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_save: RscButtonMenu
  {
    action = "[""TextsSettings"", ""save""] execVM ""settings.sqf"";";
    idc = 1601;
    default = 1;

    text = "Save";
    x = 26.6 * GUI_GRID_W + GUI_GRID_X;
    y = 15.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 8.4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1034;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
};