class RscMenuAnimations
{
	idd = -1;
	movingEnable = 1;
	objects[] = { };
  controls[]=
  {
    background,
    animationsliste,
    submit,
    cancel,
    dummybutton,
    RscText_1002
  };
  class background: IGUIBack
  {
    idc = 1000;

    x = 11.6 * GUI_GRID_W + GUI_GRID_X;
    y = 2.15 * GUI_GRID_H + GUI_GRID_Y;
    w = 17.2 * GUI_GRID_W;
    h = 17.55 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class animationsliste: RscListBox
  {
    idc = 1;

    x = 12.2 * GUI_GRID_W + GUI_GRID_X;
    y = 2.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 16 * GUI_GRID_W;
    h = 16.25 * GUI_GRID_H;
  };
  class submit: RscButtonMenu
  {
    idc = 2;

    text = "Submit";
    x = 22.3 * GUI_GRID_W + GUI_GRID_X;
    y = 19.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class cancel: RscButtonMenu
  {
    action = "closedialog 0;";
    idc = 1601;

    text = "Cancel";
    x = 11.6 * GUI_GRID_W + GUI_GRID_X;
    y = 19.9 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1009;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class RscText_1002: IGUIHeader
  {
    idc = 1002;
    text = "Choose an animation";
    x = 11.6 * GUI_GRID_W + GUI_GRID_X;
    y = 0.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 17.2 * GUI_GRID_W;
    h = 1.2 * GUI_GRID_H;
  };
};