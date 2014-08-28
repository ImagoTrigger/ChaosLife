class RscDialogCasinoTable
{
  idd = 13001;
  movingEnable = 1;
  objects[] = { };
  controls[]=
  {
    RscDialogCasinoBackground,
    RscDialogCasinoClose,
    RscDialogCasinoHeader
  };
  class RscDialogCasinoBackground: RscText
  {
    idc = 1000;
    style = 48;

    text = "images\table2.paa";
    x = -3.5 * GUI_GRID_W + GUI_GRID_X;
    y = -5.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 47.5 * GUI_GRID_W;
    h = 35 * GUI_GRID_H;
  };
  class RscDialogCasinoClose: RscActiveText
  {
    idc = 2;
    type = 11;
    style = 48;
    text = "\A3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_exit_cross_ca.paa";
    x = 36.8 * GUI_GRID_W + GUI_GRID_X;
    y = 2.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 1.2 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorText[] = {1,1,1,0.7};
    color[] = {1,1,1,0.7};
    colorActive[] = {1,1,1,1};
    action = "closedialog 0";
    tooltip = "Close";
  };
  class RscDialogCasinoHeader: IGUIHeader
  {
    idc = 1001;
    text = "Global Chaos Casino";
    x = 2 * GUI_GRID_W + GUI_GRID_X;
    y = 2.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 36 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};