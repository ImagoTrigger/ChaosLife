class RscMenuLotto {
  idd = -1;
  movingEnable = true;
  onLoad = "[""onLoad"",_this,""RscMenuLotto"",'GCGUI'] call compile preprocessfilelinenumbers ""gc\client\GC_initDisplay.sqf""";
  objects[] = {};
  controls[]=
  {
    RscMenuLottoBackground,
    ticketlist,
    submit,
    cancel,
    dummybutton,
    RscMenuLottoHeader
  };

  class RscMenuLottoBackground: IGUIBack
  {
    idc = 1000;
    x = 13 * GUI_GRID_W + GUI_GRID_X;
    y = 8 * GUI_GRID_H + GUI_GRID_Y;
    w = 15 * GUI_GRID_W;
    h = 3.5 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class ticketlist: RscCombo
  {
    idc = 1;

    x = 13.5 * GUI_GRID_W + GUI_GRID_X;
    y = 8.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 14.1 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
  class submit: RscButton
  {
    idc = 2;

    text = "Buy Ticket";
    x = 15.4 * GUI_GRID_W + GUI_GRID_X;
    y = 10 * GUI_GRID_H + GUI_GRID_Y;
    w = 10.5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class cancel: RscButtonMenu
  {
    idc = 1601;
    text = "Cancel";
    x = 13 * GUI_GRID_W + GUI_GRID_X;
    y = 11.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 5.8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1005;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class RscMenuLottoHeader: IGUIHeader
  {
    idc = 1001;
    text = "Lotto";
    x = 13 * GUI_GRID_W + GUI_GRID_X;
    y = 6.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 15 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};
