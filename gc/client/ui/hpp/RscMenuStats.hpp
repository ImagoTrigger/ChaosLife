class RscMenuStats
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuStatsBackground,
    header,
    spielerliste,
    close,
    dummybutton,
    RscMenuStatsSkillsButton
  };
  class RscMenuStatsBackground: IGUIBack
  {
    idc = 1002;

    x = 8 * GUI_GRID_W + GUI_GRID_X;
    y = 2 * GUI_GRID_H + GUI_GRID_Y;
    w = 24 * GUI_GRID_W;
    h = 19 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class header: IGUIHeader
  {
    idc = 696969;

    text = "Stats";
    x = 8 * GUI_GRID_W + GUI_GRID_X;
    y = 1.1 * GUI_GRID_H + GUI_GRID_Y;
    w = 24 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class spielerliste: RscListBox
  {
    idc = 1;
    RowHeight = 0.03;
    sizeEx = 0.02;

    x = 8.5 * GUI_GRID_W + GUI_GRID_X;
    y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 23 * GUI_GRID_W;
    h = 16.4 * GUI_GRID_H;
  };
  class close: RscButtonMenu
  {
    idc = 2;
    action = "closedialog 0;";
    default = 1;

    text = "Close";
    x = 8 * GUI_GRID_W + GUI_GRID_X;
    y = 21.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.8};
  };
  class dummybutton: RscDummy
  {
    idc = 1017;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class RscMenuStatsSkillsButton: RscButton
  {
    idc = 1601;
    text = "Skills";
    action = "[0, 0, 0, [""skills""]] execVm ""maindialogs.sqf""; closedialog 0;";
    x = 8.4 * GUI_GRID_W + GUI_GRID_X;
    y = 19.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 5.5 * GUI_GRID_W;
    h = 1.5 * GUI_GRID_H;
  };
};