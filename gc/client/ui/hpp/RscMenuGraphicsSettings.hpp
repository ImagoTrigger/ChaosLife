class RscMenuGraphicsSettings

{

idd = -1;
movingEnable = true;
objects[] = { };
controls[]=
{
  GraphicsSettingsBackground,
  sichtweite_text,
  DecreasViewDistanceButton,
  IncreaseViewDistanceButton,
  terrain_text,
  DecreaseTerrainDetailButton,
  IncreaseTerrainDetailButton,
  dummybutton,
  button_close,
  GraphicsSettingsHeader
};
class GraphicsSettingsBackground: IGUIBack
{
  idc = 1003;

  x = 15 * GUI_GRID_W + GUI_GRID_X;
  y = 5 * GUI_GRID_H + GUI_GRID_Y;
  w = 10 * GUI_GRID_W;
  h = 6.1 * GUI_GRID_H;
  colorBackground[] = {0,0,0,0.7};
};
class sichtweite_text: RscText
{
  style = 2;
  idc = 1001;

  text = "View distance";
  x = 16.2 * GUI_GRID_W + GUI_GRID_X;
  y = 5.4 * GUI_GRID_H + GUI_GRID_Y;
  w = 6.8 * GUI_GRID_W;
  h = 1 * GUI_GRID_H;
};
class DecreasViewDistanceButton: RscButton
{
  action = "if (GFX_ArmaViewDistance >= 100) then {GFX_ArmaViewDistance = GFX_ArmaViewDistance - 100; setViewDistance GFX_ArmaViewDistance; player groupChat format['Viewdistance: %1', GFX_ArmaViewDistance];};";
  idc = 1600;

  text = "-100";
  x = 16.1 * GUI_GRID_W + GUI_GRID_X;
  y = 6.75 * GUI_GRID_H + GUI_GRID_Y;
  w = 2.8 * GUI_GRID_W;
  h = 1 * GUI_GRID_H;
};
class IncreaseViewDistanceButton: RscButton
{
  action = "if (GFX_ArmaViewDistance <= 10000) then {GFX_ArmaViewDistance = GFX_ArmaViewDistance + 100; setViewDistance GFX_ArmaViewDistance; player groupChat format['Viewdistance: %1', GFX_ArmaViewDistance];};";
  idc = 1601;

  text = "+100";
  x = 21.1 * GUI_GRID_W + GUI_GRID_X;
  y = 6.75 * GUI_GRID_H + GUI_GRID_Y;
  w = 2.8 * GUI_GRID_W;
  h = 1 * GUI_GRID_H;
};
class terrain_text: RscText
{
  style = 2;
  idc = 1002;

  text = "Terrain Detail";
  x = 16.2 * GUI_GRID_W + GUI_GRID_X;
  y = 8.25 * GUI_GRID_H + GUI_GRID_Y;
  w = 7.7 * GUI_GRID_W;
  h = 1 * GUI_GRID_H;
};
class DecreaseTerrainDetailButton: RscButton
{
  action = "if (GFX_ArmaTerrainGridsSel > 0) then {GFX_ArmaTerrainGridsSel = GFX_ArmaTerrainGridsSel - 1; setTerrainGrid(GFX_ArmaTerrainGrids select GFX_ArmaTerrainGridsSel); player groupChat format['Terrain Detail: %1/%2.', (GFX_ArmaTerrainGridsSel+1), (count GFX_ArmaTerrainGrids)];};";
  idc = 1602;

  text = "-";
  x = 16.1 * GUI_GRID_W + GUI_GRID_X;
  y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
  w = 2.8 * GUI_GRID_W;
  h = 1 * GUI_GRID_H;
};
class IncreaseTerrainDetailButton: RscButton
{
  action = "if (GFX_ArmaTerrainGridsSel < ((count GFX_ArmaTerrainGrids)-1)) then {GFX_ArmaTerrainGridsSel = GFX_ArmaTerrainGridsSel + 1; setTerrainGrid(GFX_ArmaTerrainGrids select GFX_ArmaTerrainGridsSel); player groupChat format['Terrain Detail: %1/%2.', (GFX_ArmaTerrainGridsSel+1), (count GFX_ArmaTerrainGrids)];};";
  idc = 1603;

  text = "+";
  x = 21.1 * GUI_GRID_W + GUI_GRID_X;
  y = 9.5 * GUI_GRID_H + GUI_GRID_Y;
  w = 2.8 * GUI_GRID_W;
  h = 1 * GUI_GRID_H;
};
class dummybutton: RscDummy
{
  idc = 1004;

  x = -40 * GUI_GRID_W + GUI_GRID_X;
  y = -25 * GUI_GRID_H + GUI_GRID_Y;
  w = 0.4 * GUI_GRID_W;
  h = 0.25 * GUI_GRID_H;
};
class button_close: RscButtonMenu
{
  idc = 2400;
  action = "closedialog 0; [""Settings""] execVM ""settings.sqf"";";
  default = 1;

  text = "Close";
  x = 15 * GUI_GRID_W + GUI_GRID_X;
  y = 11.2 * GUI_GRID_H + GUI_GRID_Y;
  w = 4 * GUI_GRID_W;
  h = 1 * GUI_GRID_H;
};
class GraphicsSettingsHeader: IGUIHeader
{
  idc = 1000;

  text = "Graphics Settings";
  x = 15 * GUI_GRID_W + GUI_GRID_X;
  y = 4 * GUI_GRID_H + GUI_GRID_Y;
  w = 10 * GUI_GRID_W;
  h = 1 * GUI_GRID_H;
};
};