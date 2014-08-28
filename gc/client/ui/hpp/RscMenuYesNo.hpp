class RscMenuYesNo
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuYesNoBackground,
    infotext,
    button1,
    button2,
    dummybutton,
    RscMenuYesNoHeader
  };

  class RscMenuYesNoBackground: IGUIBack
  {
    idc = 1002;
    x = 10 * GUI_GRID_W + GUI_GRID_X;
    y = 9 * GUI_GRID_H + GUI_GRID_Y;
    w = 20 * GUI_GRID_W;
    h = 6.5 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class infotext: RscText
  {
    idc = 1;
    style = 16;

    x = 10.5 * GUI_GRID_W + GUI_GRID_X;
    y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 18.9 * GUI_GRID_W;
    h = 5.6 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.8};
    sizeEx = MEDIUM_TEXT;
  };
  class button1: RscButtonMenu
  {
    action = "Antwort = 1; closeDialog 0;";

    idc = 1600;
    text = "Yes";
    x = 12 * GUI_GRID_W + GUI_GRID_X;
    y = 16 * GUI_GRID_H + GUI_GRID_Y;
    w = 5 * GUI_GRID_W;
    h = 2 * GUI_GRID_H;
  };
  class button2: RscButtonMenu
  {
    action = "Antwort = 2; closeDialog 0;";

    idc = 1601;
    text = "No";
    x = 23 * GUI_GRID_W + GUI_GRID_X;
    y = 16 * GUI_GRID_H + GUI_GRID_Y;
    w = 4.9 * GUI_GRID_W;
    h = 2 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1023;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class RscMenuYesNoHeader: IGUIHeader
  {
    idc = 1000;
    text = "Confirm";
    x = 10 * GUI_GRID_W + GUI_GRID_X;
    y = 7.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 20 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};