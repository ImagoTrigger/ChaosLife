class RscMenuGang
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuGangBackground,
    RscMenuGangHeader,
    button_join,
    button_leave,
    button_manage,
    button_create,
    listbox_gilden,
    dummybutton,
    RscMenuGangClose
  };
  class RscMenuGangBackground: IGUIBack
  {
    idc = 1000;

    x = 9 * GUI_GRID_W + GUI_GRID_X;
    y = 6 * GUI_GRID_H + GUI_GRID_Y;
    w = 22 * GUI_GRID_W;
    h = 8.2 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuGangHeader: IGUIHeader
  {
    idc = 1002;

    text = "Gangs";
    x = 9 * GUI_GRID_W + GUI_GRID_X;
    y = 4.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 22 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_join: RscButton
  {
    action = "[0, 0, 0, [""join"", (lbData [202, (lbCurSel 202)])]] execVm ""gangs.sqf""; closedialog 0;";
    idc = 1600;

    text = "Join";
    x = 9.5 * GUI_GRID_W + GUI_GRID_X;
    y = 12.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_leave: RscButton
  {
    action = "[0, 0, 0, [""leave""]] execVm ""gangs.sqf""; closedialog 0;";
    idc = 1601;

    text = "Leave";
    x = 14 * GUI_GRID_W + GUI_GRID_X;
    y = 12.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_manage: RscButton
  {
    action = "[0, 0, 0, [""gildenverwaltung""]] execVm ""maindialogs.sqf""; closedialog 0;";
    idc = 1602;

    text = "Manage";
    x = 25.9 * GUI_GRID_W + GUI_GRID_X;
    y = 12.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 4.8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class button_create: RscButton
  {
    action = "closedialog 0; createDialog ""RscMenuGangCreate"";";
    idc = 1603;

    text = "Create";
    x = 21 * GUI_GRID_W + GUI_GRID_X;
    y = 12.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 4.7 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class listbox_gilden: RscListBox
  {
    idc = 202;

    x = 9.3 * GUI_GRID_W + GUI_GRID_X;
    y = 6.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 21.4 * GUI_GRID_W;
    h = 6.5 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.8};
    sizeEx = MEDIUM_TEXT;
  };
  class dummybutton: RscDummy
  {
    idc = 1018;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class RscMenuGangClose: RscButtonMenu
  {
    idc = 2404;
    action = "closedialog 0;";

    text = "Close";
    x = 9 * GUI_GRID_W + GUI_GRID_X;
    y = 14.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.8};
  };
};