class RscMenuCivCam
{
  idd = -1;
  movingEnable = true;
  objects[] = { };
  controls[]=
  {
    RscMenuCivCamBackground,
    RscMenuCivCamHeader,
    dauer_slider,
    text1,
    camlist,
    text2,
    seconds,
    text3,
    cost,
    submit,
    dummybutton,
    RscButtonMenuCancel_2700
  };
  class RscMenuCivCamBackground: IGUIBack
  {
    idc = 1000;

    x = 12 * GUI_GRID_W + GUI_GRID_X;
    y = 7 * GUI_GRID_H + GUI_GRID_Y;
    w = 16 * GUI_GRID_W;
    h = 6 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscMenuCivCamHeader: IGUIHeader
  {
    idc = 1007;

    text = "CHAOS LIFE CIV CAM";
    x = 12 * GUI_GRID_W + GUI_GRID_X;
    y = 5.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 16 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dauer_slider: RscSlider
  {
    idc = 2;

    x = 12.4 * GUI_GRID_W + GUI_GRID_X;
    y = 8.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 15 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class text1: RscText
  {
    style = 1;
    idc = 1002;

    text = "Choose Civ:";
    x = 12.4 * GUI_GRID_W + GUI_GRID_X;
    y = 7.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 5.9 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class camlist: RscCombo
  {
    idc = 1;

    x = 18.7 * GUI_GRID_W + GUI_GRID_X;
    y = 7.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 8.8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class text2: RscText
  {
    style = 1;
    idc = 1003;

    text = "Duration:";
    x = 12.4 * GUI_GRID_W + GUI_GRID_X;
    y = 10.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 4.7 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class seconds: RscText
  {
    idc = 5;

    text = "s";
    x = 17.4 * GUI_GRID_W + GUI_GRID_X;
    y = 10.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 1.9 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class text3: RscText
  {
    style = 1;
    idc = 1005;

    text = "Cost:";
    x = 20.2 * GUI_GRID_W + GUI_GRID_X;
    y = 10.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 2.6 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class cost: RscText
  {
    idc = 3;

    text = $;
    x = 23.2 * GUI_GRID_W + GUI_GRID_X;
    y = 10.2 * GUI_GRID_H + GUI_GRID_Y;
    w = 4.4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class submit: RscButton
  {
    action = "[0,1,2,[""civcam"", call compile lbData [1, lbCurSel 1], sliderPosition 2]] execVM ""copcams.sqf""; closeDialog 0";
    idc = 1600;

    text = "Watch him";
    x = 17 * GUI_GRID_W + GUI_GRID_X;
    y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1002;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class RscButtonMenuCancel_2700: RscButtonMenuCancel
  {
    x = 12 * GUI_GRID_W + GUI_GRID_X;
    y = 13.1 * GUI_GRID_H + GUI_GRID_Y;
    w = 4.2 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.8};
    action = "closeDialog 0;";
  };
};