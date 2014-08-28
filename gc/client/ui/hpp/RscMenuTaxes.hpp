class RscMenuTaxes
{
  idd = -1;
  movingEnable = true;
  controlsBackground[] = {background};
  objects[] = { };
  controls[] = {text_itemsteuer, slider_itemsteuer, fahrzeugsteuer_text, fahrzeugsteuer_slider, magazinsteuer_text, magazinsteuer_slider, waffesteuer_text, waffesteuer_slider, banksteuer_text, banksteuer_slider, button_submit, button_cancel, dummybutton};

  class background : IGUIBack
  {
    x = 0.34;
    y = 0.08;
    w = 0.28;
    h = 0.70;

    text = $STRD_description_steuer_header;
  };

  class text_itemsteuer : RscText
  {
    x = 0.35;
    y = 0.12;
    w = 0.26;
    h = 0.04;
    idc = 11;
  };

  class slider_itemsteuer : RscSliderH
  {
    idc = 12;
    x = 0.35;
    y = 0.17;
    w = 0.26;
    h = 0.04;
  };

  class fahrzeugsteuer_text : RscText
  {
    idc = 21;
    x = 0.35;
    y = 0.23;
    w = 0.26;
    h = 0.04;
  };

  class fahrzeugsteuer_slider : RscSliderH
  {
    idc = 22;
    x = 0.35;
    y = 0.28;
    w = 0.26;
    h = 0.04;
  };

  class magazinsteuer_text : RscText
  {
    idc = 31;
    x = 0.35;
    y = 0.34;
    w = 0.26;
    h = 0.04;
  };

  class magazinsteuer_slider : RscSliderH
  {
    idc = 32;
    x = 0.35;
    y = 0.39;
    w = 0.26;
    h = 0.04;
  };

  class waffesteuer_text : RscText
  {
    idc = 41;
    x = 0.35;
    y = 0.45;
    w = 0.26;
    h = 0.04;
  };

  class waffesteuer_slider : RscSliderH
  {
    idc = 42;
    x = 0.35;
    y = 0.50;
    w = 0.26;
    h = 0.04;
  };

  class banksteuer_text : RscText
  {
    idc = 51;
    x = 0.35;
    y = 0.56;
    w = 0.25;
    h = 0.04;
  };

  class banksteuer_slider : RscSliderH
  {
    idc = 52;
    x = 0.35;
    y = 0.61;
    w = 0.25;
    h = 0.04;
  };

  class button_submit : RscButton
  {
    x = 0.38;
    y = 0.67;
    w = 0.20;
    h = 0.04;

    text = $STRD_description_steuer_submit;
    action = "[0,1,2,[""steuernMayor"", (round(sliderPosition 12)), (round(sliderPosition 32)), (round(sliderPosition 42)), (round(sliderPosition 22)), (round(sliderPosition 52))]] execVM ""mayor.sqf""; closedialog 0;";
  };

  class button_cancel : RscButton
  {
    x = 0.38;
    y = 0.72;
    w = 0.20;
    h = 0.04;

    text = $STRD_description_buyitem_close;
    action = "closedialog 0;";
  };

  class dummybutton : RscDummy
  {
    idc = 1032;
  };
};