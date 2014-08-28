class RscMenuATM {
  idd = -1;
  movingEnable = true;
  objects[] = {};
  controls[]=
  {
    DepostBackground,
    DepositHeader,
    text4,
    text5,
    dummybutton,
    text2,
    submit,
    RscButtonMenu_2401,
    withdraw_submit,
    AccountBackground,
    RscText_1009,
    spielerliste,
    transfer_eingabe,
    money_steuern,
    text_accountmoney,
    withdraw_eingabe,
    RscButtonMenu_2403
  };

  class DepostBackground: IGUIBack
  {
    idc = 1009;

    x = 11 * GUI_GRID_W + GUI_GRID_X;
    y = 13 * GUI_GRID_H + GUI_GRID_Y;
    w = 17.1 * GUI_GRID_W;
    h = 4.7 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class DepositHeader: IGUIHeader
  {
    idc = 1000;

    text = "Deposit/Transfer";
    x = 11 * GUI_GRID_W + GUI_GRID_X;
    y = 12 * GUI_GRID_H + GUI_GRID_Y;
    w = 17.1 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class text4: RscText
  {
    idc = 4;
    style = 1;

    text = "Incl. Taxes:";
    x = 18 * GUI_GRID_W + GUI_GRID_X;
    y = 16 * GUI_GRID_H + GUI_GRID_Y;
    w = 5.4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class text5: IGUIHeader
  {
    idc = 1005;

    text = "Withdraw";
    x = 11 * GUI_GRID_W + GUI_GRID_X;
    y = 4 * GUI_GRID_H + GUI_GRID_Y;
    w = 17 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class dummybutton: RscDummy
  {
    idc = 1003;

    x = -40 * GUI_GRID_W + GUI_GRID_X;
    y = -25 * GUI_GRID_H + GUI_GRID_Y;
    w = 0.4 * GUI_GRID_W;
    h = 0.25 * GUI_GRID_H;
  };
  class text2: RscText
  {
    style = 1;
    idc = 1002;

    text = "Select player:";
    x = 12 * GUI_GRID_W + GUI_GRID_X;
    y = 13.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class submit: RscButtonMenu
  {
    idc = 2400;

    text = "Deposit/Transfer";
    x = 11 * GUI_GRID_W + GUI_GRID_X;
    y = 17.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 9.9 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscButtonMenu_2401: RscButtonMenu
  {
    idc = 2401;
    action = "closedialog 0";

    text = "Cancel";
    x = 21.2 * GUI_GRID_W + GUI_GRID_X;
    y = 17.8 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.9 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class withdraw_submit: RscButtonMenu
  {
    idc = 2402;

    text = "Withdraw";
    x = 11 * GUI_GRID_W + GUI_GRID_X;
    y = 9.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 9.9 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class AccountBackground: IGUIBack
  {
    idc = 1008;

    x = 11 * GUI_GRID_W + GUI_GRID_X;
    y = 5 * GUI_GRID_H + GUI_GRID_Y;
    w = 17 * GUI_GRID_W;
    h = 4.3 * GUI_GRID_H;
    colorBackground[] = {0,0,0,0.7};
  };
  class RscText_1009: RscText
  {
    style = 1;
    idc = 1002;

    text = "Balance:";
    x = 12 * GUI_GRID_W + GUI_GRID_X;
    y = 5.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 4 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class spielerliste: RscCombo
  {
    idc = 1;

    x = 12 * GUI_GRID_W + GUI_GRID_X;
    y = 14.6 * GUI_GRID_H + GUI_GRID_Y;
    w = 15 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class transfer_eingabe: RscEdit
  {
    idc = 2;

    text = "0";
    x = 12 * GUI_GRID_W + GUI_GRID_X;
    y = 16.1 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.1 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class money_steuern: RscText
  {
    idc = 5;

    text = $;
    x = 23.6 * GUI_GRID_W + GUI_GRID_X;
    y = 16 * GUI_GRID_H + GUI_GRID_Y;
    w = 4.1 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class text_accountmoney: RscText
  {
    idc = 102;

    x = 16.3 * GUI_GRID_W + GUI_GRID_X;
    y = 5.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 10.8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class withdraw_eingabe: RscEdit
  {
    idc = 6;

    text = "0";
    x = 12 * GUI_GRID_W + GUI_GRID_X;
    y = 7 * GUI_GRID_H + GUI_GRID_Y;
    w = 14 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
  class RscButtonMenu_2403: RscButtonMenu
  {
    idc = 2401;
    action = "closedialog 0";

    text = "Cancel";
    x = 21.2 * GUI_GRID_W + GUI_GRID_X;
    y = 9.4 * GUI_GRID_H + GUI_GRID_Y;
    w = 6.8 * GUI_GRID_W;
    h = 1 * GUI_GRID_H;
  };
};