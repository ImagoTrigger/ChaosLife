GC_NPCNames = [
  [travelagent, "Travel Agent"],
  [bailflag, "Pay Bail"],
  [impoundbuy, "Impound Lot"],
  [impoundbuy2, "Helo Impound"],
  [boatimpoundbuy, "Boat Impound"],
  [workplacejob_deliveryflag1, "Delivery Point"],
  [workplacejob_deliveryflag2, "Delivery Point"],
  [workplacejob_deliveryflag3, "Delivery Point"],
  [workplacejob_deliveryflag4, "Delivery Point"],
  [workplacejob_deliveryflag5, "Delivery Point"],
  [workplacejob_deliveryflag6, "Delivery Point"],
  [workplacejob_deliveryflag7, "Delivery Point"],
  [workplacejob_deliveryflag8, "Delivery Point"],
  [workplacejob_deliveryflag9, "Delivery Point"],
  [workplacejob_deliveryflag10, "Delivery Point"],
  [assassin, "Assassin Mission"],
  [prostituteflag, "Human Trafficker"],
  [hostage, "Hostage Mission"],
  [Diamond_1, "Diamond Processor"],
  [Oil_1, "Oil Processor"],
  [grapeprocess, "Wine Maker"],
  [hopsprocess, "Brewer"],
  [barleyprocess, "Vodka Distiller"],
  [ryeprocess, "Whiskey Distiller"],
  [licenseflag7, "Vehicle Licenses"],
  [licenseflag7_1, "Vehicle Licenses"],
  [licenseflag6, "Resource Licenses"],
  [licenseflag6_1, "Resource Licenses"],
  [licenseflag2, "Weapon Licenses"],
  [licenseflag2_1, "Weapon Licenses"],
  [licenseflag5, "Hunting Licenses"],
  [licenseflag5_1, "Hunting Licenses"]
];

{
  GC_NPCNames set [count GC_NPCNames, [_x select 0, _x select 2]];
} forEach INV_ItemFabriken;

GC_NPCNamesArray = [];
{ GC_NPCNamesArray set [count GC_NPCNamesArray, _x select 0];} forEach GC_NPCNames;

GC_FNC_GetNPCName = {
  private ["_name", "_object"];
  _object = _this;
  _name = "";

  if ((typeName _object) == "OBJECT") then {
    {
      if ((_x select 0) == _object) then {
        _name = _x select 1;
      };
    } forEach GC_NPCNames;
  };

  _name;
};