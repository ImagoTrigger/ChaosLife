class RscMenuGangCreate
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuGangCreateBackground,
    submit,
    GangName,
    cancel,
    text_name,
    dummybutton,
    info,
    RscMenuGangCreateHeader
  };
  class RscMenuGangCreateBackground: IGUIBack
  {
    idc = 1000;

    x = 10 * GUI_GRID_W + GUI_GRID_X;
    y = 8 * GUI_GRID_H + GUI_GRID_Y;
    w = 20 * GUI_GRID_W;
    h = 5.2 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class submit: RscButtonMenu
  {
    idc = 2;
    action = "[0, 0, 0, [""create"",ctrlText 11111]] execVm ""gangs.sqf"";";

    text = "Create!";
    x = 21.9 * GUI_GRID_W + GUI_GRID_X;
    y = 13.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.8};
  };
  class GangName: RscEdit
  {
    idc = 11111;
    x = 17.1 * GUI_GRID_W + GUI_GRID_X;
    y = 8.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 12.5 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class cancel: RscButtonMenu
  {
    idc = 3;
    action = "closedialog 0;";

    default = 1;
    text = "Cancel";
    x = 10 * GUI_GRID_W + GUI_GRID_X;
    y = 13.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.8};
  };
  class text_name: RscText
  {
    idc = 4;

    text = "Gang Name:";
    x = 10.5 * GUI_GRID_W + GUI_GRID_X;
    y = 8.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1019;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class info: RscText
  {
    style = 16;
    idc = 1002;

    text = "Creation fee is $250,000. If you leave and rejoin the game you must rejoin the gang (there is no join fee). The gang will be deleted after 15 minutes if there are no members in the gang.";
    x = 10.4 * GUI_GRID_W + GUI_GRID_X;
    y = 9.7 * GUI_GRID_H + GUI_GRID_Y;
    w = 19.2 * GUI_GRID_W;
    h = 3.1 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
  class RscMenuGangCreateHeader: IGUIHeader
  {
    idc = 1003;

    text = "Create Gang";
    x = 10 * GUI_GRID_W + GUI_GRID_X;
    y = 6.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 20 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};