class RscMenuMain {
  idd = -1;
  movingEnable = true;
  controls[]=
  {
    RscText_1000,
    dummybutton,
    button_iteminfo,
    button_about,
    button_faq,
    button_tutorial,
    button_texts,
    button_graphics,
    button_cancel,
    RscPicture_1200
  };

  class RscText_1000: RscText
  {
    idc = 1000;

    text = "Main Menu";
    x = 14 * GUI_GRID_W + GUI_GRID_X;
    y = 3 * GUI_GRID_H + GUI_GRID_Y;
    w = 12 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorBackground[] = {0,0,0,8};
  };
  class dummybutton: RscDummy
  {
    idc = 1033;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class button_iteminfo: RscButtonMenu
  {
    idc = 2404;
    action = "closedialog 0; [""ItemList""] execVM ""settings.sqf"";";

    text = "Item Info";
    x = 14 * GUI_GRID_W + GUI_GRID_X;
    y = 9.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 12 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_about: RscButtonMenu
  {
    idc = 2403;
    action = "closedialog 0; [""About""] execVM ""settings.sqf"";";

    text = "About";
    x = 14 * GUI_GRID_W + GUI_GRID_X;
    y = 8.7 * GUI_GRID_H + GUI_GRID_Y;
    w = 12 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_faq: RscButtonMenu
  {
    idc = 2405;
    action = "closedialog 0; [""FAQ""] execVM ""settings.sqf"";";

    text = "Chaos Keys";
    x = 14 * GUI_GRID_W + GUI_GRID_X;
    y = 7.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 12 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_tutorial: RscButtonMenu
  {
    idc = 2402;
    action = "closedialog 0; [""Tutorial""] execVM ""settings.sqf"";";

    text = "Tutorial";
    x = 14 * GUI_GRID_W + GUI_GRID_X;
    y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 12 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_texts: RscButtonMenu
  {
    idc = 2401;
    action = "closedialog 0; [""TextsSettings"", ""open""] execVM ""settings.sqf"";";

    text = "Say Texts";
    x = 14 * GUI_GRID_W + GUI_GRID_X;
    y = 5.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 12 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_graphics: RscButtonMenu
  {
    idc = 2400;
    action = "closedialog 0; [""GraphicsSettings""] execVM ""settings.sqf"";";

    text = "Graphics";
    x = 14 * GUI_GRID_W + GUI_GRID_X;
    y = 4.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 12 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_cancel: RscButtonMenu
  {
    idc = 2406;
    action = "closedialog 0;";
    default = 1;

    text = "CLOSE";
    x = 14 * GUI_GRID_W + GUI_GRID_X;
    y = 11.1 * GUI_GRID_H + GUI_GRID_Y;
    w = 5.2 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscPicture_1200: RscPicture
  {
    idc = 1200;
    text = "images\cl.paa";
    x = 13.2 * GUI_GRID_W + GUI_GRID_X;
    y = 0.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 13.6 * GUI_GRID_W;
    h = 2.5 * GUI_GRID_H;
  };

};