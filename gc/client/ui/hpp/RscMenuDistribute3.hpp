class RscMenuDistribute3
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuDistribute3Background,
    RscMenuDistribute3Header,
    firstbutton,
    secondbutton,
    thirdbutton,
    RscButtonMenuCancel_2700
  };
  class RscMenuDistribute3Background: IGUIBack
  {
    idc = 1000;

    x = 15 * GUI_GRID_W + GUI_GRID_X;
    y = 8 * GUI_GRID_H + GUI_GRID_Y;
    w = 12 * GUI_GRID_W;
    h = 4.2 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuDistribute3Header: RscText
  {
    idc = 1001;

    text = "Sell To";
    x = 15 * GUI_GRID_W + GUI_GRID_X;
    y = 6.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 12 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class firstbutton: RscButton
  {
    idc = 3;

    x = 15.4 * GUI_GRID_W + GUI_GRID_X;
    y = 8.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 11.2 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class secondbutton: RscButton
  {
    idc = 4;

    x = 15.4 * GUI_GRID_W + GUI_GRID_X;
    y = 9.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 11.2 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class thirdbutton: RscButton
  {
    idc = 5;

    x = 15.4 * GUI_GRID_W + GUI_GRID_X;
    y = 10.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 11.2 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscButtonMenuCancel_2700: RscButtonMenuCancel
  {
    action = "closedialog 0;";

    x = 15 * GUI_GRID_W + GUI_GRID_X;
    y = 12.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.8};
  };
};