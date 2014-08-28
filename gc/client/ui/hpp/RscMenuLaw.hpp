class RscMenuLaw
{
  idd = -1;
  movingEnable = true;
  controlsBackground[] = {background};
  objects[] = { };
  controls[] = {gesetzliste, eingabefenster, submit, dummybutton};

  class background : IGUIBack
  {
    x = 0.03;
    y = 0.21;
    w = 0.93;
    h = 0.43;

    text = $STRD_dialogandere_gesetze_header;
  };

  class gesetzliste : RscListBox
  {
    idc = 1;
    x = 0.04;
    y = 0.24;
    w = 0.91;
    h = 0.34;
  };

  class eingabefenster : RscEdit
  {
    idc = 2;
    x = 0.04;
    y = 0.58;
    w = 0.71;
    h = 0.04;

    onChar = "[_this, 1] call TastenDruck;";
  };

  class submit : RscButton
  {
    x = 0.75;
    y = 0.58;
    w = 0.20;
    h = 0.04;
    idc = 3;

    text = $STRD_dialogandere_gesetze_submit;
    action = "[0,0,0,[""clientgesetz"", lbcursel 1, Ctrltext 2]] execVM ""mayor.sqf""; closedialog 0;";
  };

  class dummybutton : RscDummy
  {
    idc = 1020;
  };
};