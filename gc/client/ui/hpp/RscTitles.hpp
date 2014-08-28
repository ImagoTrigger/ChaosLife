#define nametags_idc 63500

class RscTitles {

  #define screenwidth (1 - safeZonex*2)
  #define screenheight (1 - safeZoney*2)

	class BTC_Hud
   	{
      	idd = 1000;
     	movingEnable=0;
      	duration=1e+011;
      	name = "BTC_Hud_Name";
      	onLoad = "uiNamespace setVariable [""HUD"", _this select 0];";
      	controlsBackground[] = {};
      	objects[] = {};
      	class controls
		{
			class Radar
			{
				type = CT_STATIC;
				idc = 1001;
				style = ST_PICTURE;
				x = (SafeZoneW+2*SafeZoneX) - 0.1;//safezonex + 0.1;//0.9
				y = (SafeZoneH+2*SafeZoneY) - 0.15;//safezoney + 0.1;//0.85
				w = 0.3;
				h = 0.4;
				font = "PuristaLight";
				sizeEx = 0.03;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "images\igui_radar_air_ca.paa";
			};
			class Img_Obj
			{
				type = CT_STATIC;
				idc = 1002;
				style = ST_PICTURE;
				x = (SafeZoneW+2*SafeZoneX) + 0.045;
				y = (SafeZoneH+2*SafeZoneY) + 0.045;
				w = 0.01;
				h = 0.01;
				font = "PuristaLight";
				sizeEx = 0.04;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "scripts\=BTC=_Logistic\=BTC=_Lift\=BTC=_Obj.paa";
			};
			class Pic_Obj
			{
				type = CT_STATIC;
				idc = 1003;
				style = ST_PICTURE;
				x = (SafeZoneW+2*SafeZoneX) - 0.125;
				y = (SafeZoneH+2*SafeZoneY) - 0.23;
				w = 0.1;
				h = 0.1;
				font = "PuristaLight";
				sizeEx = 0.03;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "";
			};
			class Arrow
			{
				type = CT_STATIC;
				idc = 1004;
				style = ST_PICTURE;
				x = (SafeZoneW+2*SafeZoneX) + 0.15;
				y = (SafeZoneH+2*SafeZoneY) - 0.15;
				w = 0.05;
				h = 0.05;
				font = "PuristaLight";
				sizeEx = 0.03;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "";
			};
			class Type_Obj
			{
				type = CT_STATIC;
				idc = 1005;
				style = ST_LEFT;
				x = (SafeZoneW+2*SafeZoneX) - 0.03;
				y = (SafeZoneH+2*SafeZoneY) - 0.335;
				w = 0.3;
				h = 0.3;
				font = "PuristaLight";
				sizeEx = 0.03;
				colorBackground[] = {0, 0, 0, 0};
				colorText[] = {1, 1, 1, 1};
				text = "";
			};
		};
 	};

  class GCHUD_Status {
    idd = -1;
    movingEnable = 0;
    enableSimulation = 0;
    enableDisplay = 0;
    fadein       = 0;
    duration     = 1e+011;
    fadeout      = 0;
    name         = "GCHUD_Status";
    onLoad       = "uiNamespace setVariable ['GCHUD_Status',_this select 0]";
    objects[]    = {};
    controls[]   = {health, armor, cash, most_wanted, stars, wanted, staminaFed, staminaWarn, staminaGood};

    class most_wanted {
		idc = 63310;
		type = CT_STRUCTURED_TEXT;
		style = ST_RIGHT;
		colorBackground[] = { 0, 0, 0, 0 };
		x = safezoneX + safeZoneW - 0.45;
		y = safeZoneY+0.230;
		w = 0.45;
		h = 0.45;
		size = 0.05;
		text = "";
	};

    class staminaGood : RscProgress {
      idc = 63311;
      x = safezoneX + safeZoneW - 4.4 * GUI_GRID_W;
      y = safeZoneY + safeZoneH - 0.045;
      w = 4 * GUI_GRID_W;
      h = 0.5 * GUI_GRID_H;
    };
    class staminaWarn : RscProgress {
      idc = 63312;
      x = safezoneX + safeZoneW - 4.4 * GUI_GRID_W;
      y = safeZoneY + safeZoneH - 0.045;
      w = 4 * GUI_GRID_W;
      h = 0.5 * GUI_GRID_H;
      texture = "#(argb,8,8,3)color(0.909,0.439,0,0.5)";
    };
    class staminaFed : RscProgress {
      idc = 63313;
      x = safezoneX + safeZoneW - 4.4 * GUI_GRID_W;
      y = safeZoneY + safeZoneH - 0.045;
      w = 4 * GUI_GRID_W;
      h = 0.5 * GUI_GRID_H;
      texture = "#(argb,8,8,3)color(0.133,0.545,0.133,0.5)";
    };
    class armor {
		idc = 63308;
		type = CT_STRUCTURED_TEXT;
		style = ST_RIGHT;
		colorBackground[] = { 0, 0, 0, 0 };
		x = safezoneX + safeZoneW - 0.45;
		y = safeZoneY + safeZoneH - 0.090;
		w = 0.45;
		h = 0.15;
		size = 0.05;
		text = "";
	};
    class cash {
		idc = 63309;
		type = CT_STRUCTURED_TEXT;
		style = ST_RIGHT;
		colorBackground[] = { 0, 0, 0, 0 };
		x = safezoneX + safeZoneW - 0.45;
		y = safeZoneY + safeZoneH - 0.135;
		w = 0.45;
		h = 0.15;
		size = 0.05;
		text = "";
	};
    class health {
		idc = 63307;
		type = CT_STRUCTURED_TEXT;
		style = ST_RIGHT;
		colorBackground[] = { 0, 0, 0, 0 };
		x = safezoneX + safeZoneW - 0.45;
		y = safeZoneY + safeZoneH - 0.180;
		w = 0.45;
		h = 0.15;
		size = 0.05;
		text = "";
	};


    class stars {
      idc = 63302;
      type = CT_STRUCTURED_TEXT;
      style = ST_CENTER;
      colorBackground[] = { 0, 0, 0, 0 };
      x = .5 * safeZoneW + safezoneX+.10;
      y = safeZoneY+0.05;
      w = 0.5;
      h = 0.05;
      size = 0.1;
      text = "";
    };
    class wanted : RscText {
      idc    = 63303;
      colorBackground[] = { 0, 0, 0, 0 };
      x      = .5 * safeZoneW + safezoneX+.10;
      y      = safeZoneY+.08;
      w      = 0.5;
      h      = 0.1;
      style  = ST_CENTER;
      text   = "";
      sizeEx = 0.04;
      font   = "EtelkaMonospaceProBold";
    };
  };

  class GCHUD_CopRadar {
    idd = -1;
    movingEnable = 0;
    fadein       = 0;
    duration     = 2;
    fadeout      = 0;
    name         = "GCHUD_CopRadar";
    onLoad       = "uiNamespace setVariable ['GCHUD_CopRadar',_this select 0]";
    objects[]    = {};
    controls[]   = {background, target, digits};
    class background {
      idc = 63304;
      x = .5 * safeZoneW + safezoneX-.27;
      y = safeZoneY;
      text = "images\radar.paa";
      w = 0.5;
      h = 0.1666667;
      colorBackground[] = { 0, 0, 0, 0 };
      type=CT_STATIC;
      style=ST_PICTURE;
      colorText[] = {1,1,1,0.8};
      font = "PuristaMedium";
      sizeEx=MEDIUM_TEXT;
    };
    class digits {
      idc = 63305;
      type = CT_STRUCTURED_TEXT;
      style = ST_CENTER;
      colorBackground[] = { 0, 0, 0, 0 };
      x = .5 * safeZoneW + safezoneX-.206;
      y = safeZoneY+.05;
      w = 0.45;
      h = 0.10;
      size = 0.05;
      text = "<img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/> <img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/> <img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/><img size='0.9' image='images\digits\g8.pac'/>";
    };
    class target {
      idc = 63306;
      type = CT_STRUCTURED_TEXT;
      style = ST_CENTER;
      colorBackground[] = { 0, 0, 0, 0 };
      x = .5 * safeZoneW + safezoneX-.250;
      y = safeZoneY+.165;
      w = 0.45;
      h = 0.20;
      size = 0.05;
      text = "";
    };

  };

  class Rtags {
    idd=64431;
    movingEnable = 0;
    enableSimulation = 0;
    enableDisplay = 0;
    fadein = 0;
    fadeout = 0;
    duration = 1e+011;
    name="TAGS_HUD";
    onLoad="uiNamespace setVariable ['TAGS_HUD', _this select 0]";

    class controls
    {
      class nametag : RscStructuredText
      {
        type = 13;
        idc = -1;
        style = ST_CENTER;
        x = 0;
        y = 0;
        w = 0.5;
        h = 0.07;
        text = "";
        ShowImage = true;
        class Attributes
        {
          font = "PuristaMedium";
          color = "#ffffff";
          align = "center";
          shadow = 0;
        };
        size = 0.049;
        shadow = 0;
      };

      class nametag0: nametag{idc = nametags_idc + 0;};
      class nametag1: nametag{idc = nametags_idc + 1;};
      class nametag2: nametag{idc = nametags_idc + 2;};
      class nametag3: nametag{idc = nametags_idc + 3;};
      class nametag4: nametag{idc = nametags_idc + 4;};
      class nametag5: nametag{idc = nametags_idc + 5;};
      class nametag6: nametag{idc = nametags_idc + 6;};
      class nametag7: nametag{idc = nametags_idc + 7;};
      class nametag8: nametag{idc = nametags_idc + 8;};
      class nametag9: nametag{idc = nametags_idc + 9;};
      class nametag10: nametag{idc = nametags_idc + 10;};
      class nametag11: nametag{idc = nametags_idc + 11;};
      class nametag12: nametag{idc = nametags_idc + 12;};
      class nametag13: nametag{idc = nametags_idc + 13;};
      class nametag14: nametag{idc = nametags_idc + 14;};
      class nametag15: nametag{idc = nametags_idc + 15;};
      class nametag16: nametag{idc = nametags_idc + 16;};
      class nametag17: nametag{idc = nametags_idc + 17;};
      class nametag18: nametag{idc = nametags_idc + 18;};
      class nametag19: nametag{idc = nametags_idc + 19;};
      class nametag20: nametag{idc = nametags_idc + 20;};
      class nametag21: nametag{idc = nametags_idc + 21;};
      class nametag22: nametag{idc = nametags_idc + 22;};
      class nametag23: nametag{idc = nametags_idc + 23;};
      class nametag24: nametag{idc = nametags_idc + 24;};
      class nametag25: nametag{idc = nametags_idc + 25;};
      class nametag26: nametag{idc = nametags_idc + 26;};
      class nametag27: nametag{idc = nametags_idc + 27;};
      class nametag28: nametag{idc = nametags_idc + 28;};
      class nametag29: nametag{idc = nametags_idc + 29;};
      class nametag30: nametag{idc = nametags_idc + 30;};
      class nametag31: nametag{idc = nametags_idc + 31;};
      class nametag32: nametag{idc = nametags_idc + 32;};
      class nametag33: nametag{idc = nametags_idc + 33;};
      class nametag34: nametag{idc = nametags_idc + 34;};
      class nametag35: nametag{idc = nametags_idc + 35;};
      class nametag36: nametag{idc = nametags_idc + 36;};
      class nametag37: nametag{idc = nametags_idc + 37;};
      class nametag38: nametag{idc = nametags_idc + 38;};
      class nametag39: nametag{idc = nametags_idc + 39;};
      class nametag40: nametag{idc = nametags_idc + 40;};
      class nametag41: nametag{idc = nametags_idc + 41;};
      class nametag42: nametag{idc = nametags_idc + 42;};
      class nametag43: nametag{idc = nametags_idc + 43;};
      class nametag44: nametag{idc = nametags_idc + 44;};
      class nametag45: nametag{idc = nametags_idc + 45;};
      class nametag46: nametag{idc = nametags_idc + 46;};
      class nametag47: nametag{idc = nametags_idc + 47;};
      class nametag48: nametag{idc = nametags_idc + 48;};
      class nametag49: nametag{idc = nametags_idc + 49;};
      class nametag50: nametag{idc = nametags_idc + 50;};
      class nametag51: nametag{idc = nametags_idc + 51;};
      class nametag52: nametag{idc = nametags_idc + 52;};
      class nametag53: nametag{idc = nametags_idc + 53;};
      class nametag54: nametag{idc = nametags_idc + 54;};
      class nametag55: nametag{idc = nametags_idc + 55;};
      class nametag56: nametag{idc = nametags_idc + 56;};
      class nametag57: nametag{idc = nametags_idc + 57;};
      class nametag58: nametag{idc = nametags_idc + 58;};
      class nametag59: nametag{idc = nametags_idc + 59;};
      class nametag60: nametag{idc = nametags_idc + 60;};
      class nametag61: nametag{idc = nametags_idc + 61;};
      class nametag62: nametag{idc = nametags_idc + 62;};
      class nametag63: nametag{idc = nametags_idc + 63;};
      class nametag64: nametag{idc = nametags_idc + 64;};
      class nametag65: nametag{idc = nametags_idc + 65;};
      class nametag66: nametag{idc = nametags_idc + 66;};
      class nametag67: nametag{idc = nametags_idc + 67;};
      class nametag68: nametag{idc = nametags_idc + 68;};
      class nametag69: nametag{idc = nametags_idc + 69;};
      class nametag70: nametag{idc = nametags_idc + 70;};
      class nametag71: nametag{idc = nametags_idc + 71;};
      class nametag72: nametag{idc = nametags_idc + 72;};
      class nametag73: nametag{idc = nametags_idc + 73;};
      class nametag74: nametag{idc = nametags_idc + 74;};
      class nametag75: nametag{idc = nametags_idc + 75;};
      class nametag76: nametag{idc = nametags_idc + 76;};
      class nametag77: nametag{idc = nametags_idc + 77;};
      class nametag78: nametag{idc = nametags_idc + 78;};
      class nametag79: nametag{idc = nametags_idc + 79;};
      class nametag80: nametag{idc = nametags_idc + 80;};
      class nametag81: nametag{idc = nametags_idc + 81;};
      class nametag82: nametag{idc = nametags_idc + 82;};
      class nametag83: nametag{idc = nametags_idc + 83;};
      class nametag84: nametag{idc = nametags_idc + 84;};
      class nametag85: nametag{idc = nametags_idc + 85;};
      class nametag86: nametag{idc = nametags_idc + 86;};
      class nametag87: nametag{idc = nametags_idc + 87;};
      class nametag88: nametag{idc = nametags_idc + 88;};
      class nametag89: nametag{idc = nametags_idc + 89;};
      class nametag90: nametag{idc = nametags_idc + 90;};
      class nametag91: nametag{idc = nametags_idc + 91;};
      class nametag92: nametag{idc = nametags_idc + 92;};
      class nametag93: nametag{idc = nametags_idc + 93;};
      class nametag94: nametag{idc = nametags_idc + 94;};
      class nametag95: nametag{idc = nametags_idc + 95;};
      class nametag96: nametag{idc = nametags_idc + 96;};
      class nametag97: nametag{idc = nametags_idc + 97;};
      class nametag98: nametag{idc = nametags_idc + 98;};
      class nametag99: nametag{idc = nametags_idc + 99;};
      class nametag100: nametag{idc = nametags_idc + 100;};

      class interact
      {
        type = 0;
        idc = 64438;
        style = 0;
        x = 0.45;
        y = 0.55;
        w = 0.3;
        h = 0.2;
        font = "PuristaBold";
        sizeEx = 0.0265;
        colorText[] = {0, 1, 0, 0.8};
        colorBackground[]={0,0,0,0.0};
        text = "";
        shadow = 0;
      };
    };
  };

	class GC_Timer
	{
		onLoad = "[""onLoad"",_this,""GC_Timer"",'GCGUI'] call compile preprocessfilelinenumbers ""gc\client\GC_initDisplay.sqf""";
		onUnload = "[""onUnload"",_this,""GC_Timer"",'GCGUI'] call compile preprocessfilelinenumbers ""gc\client\GC_initDisplay.sqf""";
		idd = -1;
		duration = 600;
		fadein = 0;
		name="GC_Timer";
		class Controls
		{
			class Time: RscControlsGroupNoScrollbars
			{
				idc = 2300;
				x = "1 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX)";
				y = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY) + 0.125";
				w = "7.9 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
				h = "3.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				class controls
				{
					class CurrentBackground: RscStructuredText
					{
						colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"};
						idc = 1100;
						x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
						y = "0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						w = "7.9 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
						h = "1.4 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					};
					class Current: RscStructuredText
					{
						idc = 1104;
						x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
						y = "0.2 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						w = "6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
						h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						colorBackground[] = {0,0,0,0};
					};
					class Bonus: RscStructuredText
					{
						idc = 1103;
						x = "5.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
						y = "0.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						w = "2.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
						h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						colorBackground[] = {0,0,0,0};
					};
					class Penalty: RscStructuredText
					{
						idc = 1105;
						x = "5.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
						y = "0.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						w = "2.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
						h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						colorBackground[] = {0,0,0,0};
					};
					class Best: RscStructuredText
					{
						colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"};
						idc = 1101;
						x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
						y = "1.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						w = "7.9 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
						h = "0.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					};
					class Previous: RscStructuredText
					{
						colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"};
						idc = 1102;
						x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
						y = "2.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
						w = "7.9 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
						h = "0.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					};
				};
			};
		};
	};

};