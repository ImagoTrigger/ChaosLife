class RscMenuMainCam
{
  idd = 2005;
  movingEnable = true;
  objects[] = { };
  controls[] = {button_nvgOn, button_nvgOff, close, dummybutton, VL1, VL2, VL3, VL4, VL5, VL6, VL7, VL8, VL9, HL1, HL2, HL3, HL4, HL5, HL6, HL7, cross_horizontal, cross_vertical, CamSlider5, LightSlider};

  class VL1: RscText
  {
    x = 0.100;
    y = 0.200;
    w = 0.001;
    h = 0.600;

    colorBackground[] = {1,1,1,0.1};
  };

  class VL2: VL1 {x = 0.2;};
  class VL3: VL1 {x = 0.3;};
  class VL4: VL1 {x = 0.4;};
  class VL5: VL1 {x = 0.5;};
  class VL6: VL1 {x = 0.6;};
  class VL7: VL1 {x = 0.7;};
  class VL8: VL1 {x = 0.8;};
  class VL9: VL1 {x = 0.9;};

  class HL1: RscText
  {
    x = 0.100;
    y = 0.200;
    w = 0.800;
    h = 0.001;

    colorBackground[] = {1,1,1,0.1};
  };

  class HL2: HL1 {y = 0.3;};
  class HL3: HL1 {y = 0.4;};
  class HL4: HL1 {y = 0.5;};
  class HL5: HL1 {y = 0.6;};
  class HL6: HL1 {y = 0.7;};
  class HL7: HL1 {y = 0.8;};

    class cross_horizontal: RscText
  {
    x = 0.465;
    y = 0.500;
    w = 0.070;
    h = 0.002;

    colorBackground[] = {1,0.9,0.9,0.2};
  };

  class cross_vertical: RscText
  {
    x = 0.500;
    y = 0.465;
    w = 0.002;
    h = 0.070;

    colorBackground[] = {1,0.9,0.9,0.2};
  };

  class button_nvgOn : RscButton
  {
    idc = 25;
    x = 0.10;
    y = 0.82;
    w = 0.15;
    h = 0.04;

    colorBackground[] = {0.3,0.3,0.3,1};
    text = $STRD_cam_description_nvgon;
  };

  class button_nvgOff : RscButton
  {
    idc = 26;
    x = 0.30;
    y = 0.82;
    w = 0.15;
    h = 0.04;

    colorBackground[] = {0.3,0.3,0.3,1};
    text = $STRD_cam_description_nvgoff;
  };

  class close : RscButton
  {
    idc = 28;
    x = 0.70;
    y = 0.82;
    w = 0.15;
    h = 0.04;
    colorBackground[] = {0.3,0.3,0.3,1};
    text = $STRD_description_close;
  };

  class CamSlider5 : RscSliderV
  {
    idc = 1055;
    x = 0.05;
    y = 0.20;
    w = 0.04;
    h = 0.70;
  };

  class LightSlider : RscSliderV
  {
    idc = 11;
    x = 0.92;
    y = 0.20;
    w = 0.04;
    h = 0.70;
  };

  class dummybutton : RscDummy
  {
    idc = 1050;
  };
};