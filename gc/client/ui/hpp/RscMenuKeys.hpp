class RscMenuKeys {
  idd = -1;
  movingEnable = true;
  objects[] = {};
  controls[]=
  {
    RscMenuKeysBackground,
    schluesselliste,
    submit2,
    button_wegwerfen,
    cancel,
    dummybutton,
    RscMenuKeysHeader,
    RscMenuKeysPlayerlist
  };
  class RscMenuKeysBackground: IGUIBack
  {
    idc = 1001;
    x = 7 * GUI_GRID_W + GUI_GRID_X;
    y = 7 * GUI_GRID_H + GUI_GRID_Y;
    w = 25.5 * GUI_GRID_W;
    h = 9.5 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class schluesselliste: RscListBox
  {
    idc = 1;
    style = 0;

    x = 7.4 * GUI_GRID_W + GUI_GRID_X;
    y = 7.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 16.4 * GUI_GRID_W;
    h = 8.7 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
  class submit2: RscButton
  {
    idc = 5;

    text = "Give to player";
    x = 24.5 * GUI_GRID_W + GUI_GRID_X;
    y = 9 * GUI_GRID_H + GUI_GRID_Y;
    w = 7.34286 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_wegwerfen: RscButton
  {
    idc = 4;

    text = "Destroy Key";
    x = 24.5 * GUI_GRID_W + GUI_GRID_X;
    y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 7.34286 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class cancel: RscButtonMenu
  {
    idc = 3;
    action = "closedialog 0";

    text = "Cancel";
    x = 7 * GUI_GRID_W + GUI_GRID_X;
    y = 16.7 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.74286 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1013;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class RscMenuKeysHeader: IGUIHeader
  {
    idc = 1002;
    text = "Key Management";
    x = 7 * GUI_GRID_W + GUI_GRID_X;
    y = 5.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 25.5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscMenuKeysPlayerlist: RscCombo
  {
    idc = 2100;
    x = 24.5 * GUI_GRID_W + GUI_GRID_X;
    y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 7.3 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
};