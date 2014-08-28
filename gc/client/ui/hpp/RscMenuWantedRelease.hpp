class RscMenuWantedRelease
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuWantedReleaseBackground2,
    RscMenuWantedReleaseBackground,
    RscMenuWantedReleaseHeader,
    civlist,
    kopfcash_eingabe,
    cost,
    header1,
    submit,
    header2,
    cancel,
    civlist2,
    submit2,
    set_unwanted,
    dummybutton
  };
  class RscMenuWantedReleaseBackground2: IGUIBack
  {
    idc = 1006;

    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 6.25 * GUI_GRID_H + GUI_GRID_Y;
    w = 13.6 * GUI_GRID_W;
    h = 6 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuWantedReleaseBackground: IGUIBack
  {
    idc = 1006;

    x = 20.4 * GUI_GRID_W + GUI_GRID_X;
    y = 6.25 * GUI_GRID_H + GUI_GRID_Y;
    w = 14 * GUI_GRID_W;
    h = 3.8 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuWantedReleaseHeader: IGUIHeader
  {
    idc = 1000;

    text = "Crimes & Punishment";
    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 5.16 * GUI_GRID_H + GUI_GRID_Y;
    w = 28 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class civlist: RscCombo
  {
    idc = 1;

    x = 6.8 * GUI_GRID_W + GUI_GRID_X;
    y = 7.65 * GUI_GRID_H + GUI_GRID_Y;
    w = 12.2 * GUI_GRID_W;
    h = 0.9 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
  class kopfcash_eingabe: RscEdit
  {
    idc = 2;

    text = "Description of crime";
    x = 6.8 * GUI_GRID_W + GUI_GRID_X;
    y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 12.4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
  class cost: RscText
  {
    idc = 3;

    text = "Reason:";
    x = 6.5 * GUI_GRID_W + GUI_GRID_X;
    y = 8.45 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class header1: RscText
  {
    style = 2;
    idc = 1002;

    text = "Set Wanted Menu";
    x = 6.5 * GUI_GRID_W + GUI_GRID_X;
    y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 12.4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class submit: RscButton
  {
    action = "[(call compile lbData [1, lbCurSel 1]), (ctrlText 2), 0] execVM ""wantedrelease.sqf""; closeDialog 0";
    idc = 1600;

    text = "Submit";
    x = 6.8 * GUI_GRID_W + GUI_GRID_X;
    y = 10.75 * GUI_GRID_H + GUI_GRID_Y;
    w = 6 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class header2: RscText
  {
    style = 2;
    idc = 1004;

    text = "Release menu";
    x = 20.5 * GUI_GRID_W + GUI_GRID_X;
    y = 6.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 12.4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class cancel: RscButtonMenu
  {
    action = "closedialog 0";
    idc = 1601;

    text = "Cancel";
    x = 6.4 * GUI_GRID_W + GUI_GRID_X;
    y = 12.3 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.6 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.8};
  };
  class civlist2: RscCombo
  {
    idc = 11;

    x = 20.8 * GUI_GRID_W + GUI_GRID_X;
    y = 7.65 * GUI_GRID_H + GUI_GRID_Y;
    w = 13.1 * GUI_GRID_W;
    h = 0.9 * GUI_GRID_H;
    sizeEx = MEDIUM_TEXT;
  };
  class submit2: RscButton
  {
    action = "[(call compile lbData [11, lbCurSel 11])] execVM ""setfree.sqf""; closeDialog 0";
    idc = 1602;

    text = "Set Free";
    x = 20.9 * GUI_GRID_W + GUI_GRID_X;
    y = 8.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 7.4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class set_unwanted: RscButton
  {
    action = "[(call compile lbData [1, lbCurSel 1]), 0, 1] execVM ""wantedrelease.sqf""; closeDialog 0";
    idc = 1603;

    text = "Un-Want";
    x = 13 * GUI_GRID_W + GUI_GRID_X;
    y = 10.75 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.2 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1007;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
};