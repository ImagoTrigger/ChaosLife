class RscMenuGangManagement
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuGangManagementBackground,
    RscMenuGangManagementHeader,
    kicking_playerlist,
    kicking_header,
    cancel,
    kicking_submit,
    lock_list,
    lock_header,
    lock_submit,
    dummybutton
  };
  class RscMenuGangManagementBackground: IGUIBack
  {
    idc = 1000;
    x = 9 * GUI_GRID_W + GUI_GRID_X;
    y = 6 * GUI_GRID_H + GUI_GRID_Y;
    w = 23 * GUI_GRID_W;
    h = 9.1 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuGangManagementHeader: IGUIHeader
  {
    idc = 1005;
    text = "Gang Management";
    x = 9 * GUI_GRID_W + GUI_GRID_X;
    y = 4.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 23 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class kicking_playerlist: RscListBox
  {
    idc = 102;

    x = 9.5 * GUI_GRID_W + GUI_GRID_X;
    y = 7.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 13.1 * GUI_GRID_W;
    h = 4.95 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.8};
    sizeEx = MEDIUM_TEXT;
  };
  class kicking_header: RscText
  {
    idc = 101;
    style = 2;

    text = "Kick Member";
    x = 9.5 * GUI_GRID_W + GUI_GRID_X;
    y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class cancel: RscButtonMenu
  {
    action = "closedialog 0;";

    idc = 1600;
    text = "Close";
    default = 1;
    x = 9 * GUI_GRID_W + GUI_GRID_X;
    y = 15.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class kicking_submit: RscButton
  {
    idc = 103;
    action = "[0, 0, 0, [""kick"", (lbData [102, (lbCurSel 102)]), (lbCurSel 102)]] execVm ""gangs.sqf""; closedialog 0;";

    text = "Kick";
    x = 12 * GUI_GRID_W + GUI_GRID_X;
    y = 13.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class lock_list: RscListBox
  {
    idc = 201;

    x = 23.5 * GUI_GRID_W + GUI_GRID_X;
    y = 7.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 2.5 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.8};
  };
  class lock_header: RscText
  {
    idc = 202;
    style = 2;

    text = "Join allowed?";
    x = 23.4 * GUI_GRID_W + GUI_GRID_X;
    y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class lock_submit: RscButton
  {
    idc = 203;
    action = "[0,0,0,[""allowjoin"", (lbData [201, (lbCurSel 201)]), (lbCurSel 201)]] execVM ""gangs.sqf""; closedialog 0;";

    text = "Update";
    x = 23.5 * GUI_GRID_W + GUI_GRID_X;
    y = 10.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1022;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
};