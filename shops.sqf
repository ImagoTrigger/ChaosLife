INV_itemmaxstocks = [
  //fs
  [-1,20,20,20],
  [-1,20,20,20],
  [-1,20,20,20],
  [-1,20,20,20],
  [-1,20,20,20],

  //hunt
  [50,50,50,50,50,50,50,50,50,50,50,50,50,50,50],

  //boat
   -1,
   -1,
   -1,
   -1,
   -1,
   -1,
   -1,

  //boat tuning
  -1,
  -1,
  -1,
  -1,

    //scuba
    -1,
    //cave
    -1,

  //is
  [50,50,50,50,-1],
  [50,50,50,50,-1],
  [50,50,50,50,-1],
  [50,50,50,50,-1],
  [50,50,50,50,-1],

  //pub
  [-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1],
  [-1,-1,-1,-1,-1,-1,-1],

  //pshop
  [
	40,40,40,40,150,100	// a3 shit
  ],

  //rshop
  [200,200,200,200,950,250,250,250,250,
  200,550,250,250,250,250], //a3 shit

  //equipShop
  [100,100,100,50,25,25,25,50,50,50],
  [100,100,100,50,25,25,25,50,50,50],

  //cu
  [20,20,20,10,10,10,20],
  [20,20,20,10,10,10,20],

  //ts  (dont make this unlimited A3 todo)
  -1,

  //as
   -1,

  //mt
  [30,30,30],

  //rs
  [200,200,200,200,200,200,200],

  //gds
  [50,25,25,25],

  //os
  -1,

  //ga
  -1,
  -1,
  -1,
  -1,
  -1,

  //ds
  -1,
  -1,
  -1,
  -1,

  //ca
  -1,

  //cv
  -1,

  //sv
  -1,

  //td
 -1,

  //cops
  -1,

  //copsp
  -1,

  //copsc
  -1,

  //copss
  -1,

  //copsnipe
  -1,
  //copattach
  -1,

  //cs
  [30,30,30,30,30,30,30,30],
  [30,30,30,30,30,30,30],
  [30,30,30,30,30,30,30],
  [30,30,30,30,30,30,30,30],
  [30,30,30,30,30,30,30,30],
  [30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30],
  [30,30,30,30],
  [30,30,30,30,30,30,30,30,30,30],

  //blackmarket
  -1,

  //blackmarket_air
  -1,

  //blackmarket_veh
  -1,

  //jailbike
  -1,

  //bus
    -1,

  //horn shop
    -1,

  //chair shop
    -1,
    //clothes
    [30,30,30,30,30,30,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40],
    //goggles
    [30,30,30,30,30,30],
    //army
    [30,30,30,30,30,30,30,30,30,30,30,30],
    //food
    -1,
    //attach
    [30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30],

  //terror shop
    -1,

  //terror vehicle
  -1,

  //bags
  [30,30,30],

  //shit at the end
  -1,-1,-1,-1,-1,-1,-1

];

// Shop items
_emptyshop = [];

_hatchbacks = [
	"C_Hatchback_01_F_shit",
	"C_Hatchback_01_F_white",
	"C_Hatchback_01_F_cream",
	"C_Hatchback_01_F_green",
	"C_Hatchback_01_F_nblue",
	"C_Hatchback_01_F_blue",
	"C_Hatchback_01_F_yellow",
	"C_Hatchback_01_F_lgrey",
	"C_Hatchback_01_F_dgrey",
	"C_Hatchback_01_F_black",
	"C_Hatchback_01_sport_F_red",
	"C_Hatchback_01_sport_F_blue",
	"C_Hatchback_01_sport_F_orange",
	"C_Hatchback_01_sport_F_grey",
	"C_Hatchback_01_sport_F_green",
	"C_Hatchback_01_sport_F_gc"
];

_suvs = [
	"C_SUV_01_F_grey",
	"C_SUV_01_F_red",
	"C_SUV_01_F_orange",
	"C_SUV_01_F_black"
];

_vans = [
	"C_Van_01_box_F_white",
	"C_Van_01_box_F_red",
	"C_Van_01_transport_F_white",
	"C_Van_01_transport_F_red",
	"C_Van_01_fuel_F_white",
	"C_Van_01_fuel_F_red",
	"I_G_Van_01_transport_F_white",
	"I_G_Van_01_transport_F_red",
	"I_G_Van_01_fuel_F_white",
	"I_G_Van_01_fuel_F_red"
];

_fs    = ["Fuelline", "kanister", "kleinesreparaturkit", "reparaturkit"];
_hunt  = ["cow","cowleather",
	"turtle","turtleshell",
	"boarpelt", "boar",
	"sheepskin","sheep",
	"snake","snakeskin",
	"fish",
	"perch", "trout", "walleye", "bass"
];

_boat  = [
	"B_Lifeboat",
	"C_Rubberboat",
	"C_Rubberboat_black",
	"C_Rubberboat_sea",
	"B_Boat_Transport_01_F",
	"I_Boat_Transport_01_F",
	"I_G_Boat_Transport_01_F",
	"B_SDV_01_F",
	"I_SDV_01_F",
	"B_Boat_Armed_01_minigun_F",
	"C_Boat_Civil_01_F",
	"C_Boat_Civil_01_police_F",
	"C_Boat_Civil_01_rescue_F"
];

_gangboats  = [
	"C_Rubberboat_camo",
	"O_SDV_01_F",
	"O_Boat_Transport_01_F",
	"O_Boat_Armed_01_hmg_F",
	"I_Boat_Armed_01_minigun_F"
];

_bt = ["supgrade1", "supgrade2","supgrade3","supgrade4","supgrade5","brakes"];


_is    = ["woodaxe","flashlight","medikit", "fishingpole","fireworks"];
_pub   = ["beer","beer2","vodka","smirnoff","whiskey","wine"];
_pub2   = ["beer","beer2","vodka","smirnoff","whiskey","wine"];
_pub3   = ["beer","beer2","vodka","smirnoff","whiskey","wine"];

//pistol shop
_pshop = [
	"hgun_P07_snds_F","hgun_Rook40_snds_F","hgun_PDW2000_Holo_snds_F","Rnd_9x21_Mag_16",
	"hgun_ACPC2_snds_F","Rnd_45ACP_Mag_9"
];

_attach = [
	"optic_Arco",
	"optic_Hamr",
	"optic_Aco",
	"optic_ACO_grn",
	"optic_Holosight",
	"optic_SOS",
	"optic_MRCO",
	"optic_Nightstalker",
	"muzzle_snds_acp",
	"muzzle_snds_H",
	"muzzle_snds_L",
	"muzzle_snds_M",
	"muzzle_snds_B",
	"muzzle_snds_H_MG",
	"acc_flashlight",
	"acc_pointer_IR"
];

_cave = [
	"arifle_SDAR_F",
	"Rnd_556x45_UW_mag_20",
	"NVGoggles_INDEP",
	"medikit",
	"U_B_Wetsuit",
	"V_RebreatherIA",
	"G_Diving",
	"ziptie"

];

_scuba = [
	"NVGoggles_INDEP",
	"medikit",
	"U_B_Wetsuit",
	"V_RebreatherIA",
	"G_Diving"
];

//rifle shop
_rshop = [
	"arifle_Katiba_C_F","arifle_Katiba_GL_F","arifle_Katiba_GL_ARCO_pointer_F","arifle_Katiba_GL_ACO_pointer_F","Rnd_65x39_caseless_green_30","Rnd_SmokeBlue_Grenade_shell_1","Rnd_SmokeOrange_Grenade_shell_1","Rnd_SmokeYellow_Grenade_shell_1","Rnd_HE_Grenade_shell_1",
	"arifle_MX_GL_Hamr_pointer_F","Rnd_65x39_caseless_mag_30","Rnd_SmokeBlue_Grenade_shell_3","Rnd_SmokeOrange_Grenade_shell_3","Rnd_SmokeYellow_Grenade_shell_3","Rnd_HE_Grenade_shell_3"
];

_equipShop   = ["Binocular", "NVGoggles_INDEP", "GPS", "flashlight", "Chemlight_red","Chemlight_yellow","Chemlight_blue","stone","GasMask","I_UavTerminal"];

//car upgrades (tuning)
_cu    = ["caralarm", "supgrade1", "supgrade2","supgrade3","supgrade4","supgrade5","brakes"];

//truck shop
_ts    = [
	"O_Truck_02_covered_F",
	"O_Truck_02_transport_F",
	"O_Truck_02_ammo_F",
	"O_Truck_02_fuel_F",
	"O_Truck_02_medical_F",
	"O_Truck_02_box_F",
	"B_Truck_01_ammo_F",
	"B_Truck_01_fuel_F",
	"B_Truck_01_medical_F",
	"B_Truck_01_repair_F"
];

//air shop
_as    = [
	"B_Heli_Light_01_F",
	"B_Heli_Light_01_F_red",
	"O_Heli_Light_02_unarmed_F_civ",
	//"O_UAV_02_F",
	"I_UAV_02_F",
	"B_UAV_02_F",
	"I_Plane_Fighter_03_AA_F",
	"I_Plane_Fighter_03_CAS_F"
];

_mt    = ["Shovel","Pickaxe","JackHammer"];
_rs    = ["Platinum","Gold","Silver","Rubies","iron","copper","steel"];
_gds   = ["Diamondring","EDiamondring","Platinumring","EPlatinumring"];
_os    = ["OilBarrel"];
_db1   = ["marijuana","cocaine","lsd"];
_db2   = ["cocaine","lsd"];
_db3   = ["heroin","marijuana"];
_dsc   = ["cocaine"];
_dsm   = ["marijuana"];
_dsl   = ["lsd"];
_dsh   = ["heroin"];

//cop air
_ca    = [
	"B_UAV_01_F",
	"B_Heli_Light_01_F_blue",
	"B_Heli_Transport_01_F",
	"B_Heli_Attack_01_F",
	"O_Heli_Attack_02_black_F"
];

//cop vehicles
_cv    = [
	"O_Quadbike_01_F",
	"C_Offroad_01_F_cop",
	"B_MRAP_01_F_cop",
	"B_MRAP_01_F_cr",
	"B_UGV_01_F"
];

//swat vehicles
_sv    = [
	"B_UGV_01_rcws_F",
	"B_MRAP_01_gmg_F",
	"B_MRAP_01_hmg_F",
	"B_APC_Wheeled_01_cannon_F",
	"O_APC_Tracked_02_cannon_F",
	"B_APC_Tracked_01_CRV_F",
	"B_MBT_01_cannon_F",
	"B_MBT_01_arty_F",
	"B_MBT_01_mlrs_F"
];

//the doctor
_td = ["medikit"];

_copshop = [
	"GPS",
	"flashlight",
	"LightArmor",
	"Binocular",
	"NVGoggles",
	"medikit",
	"hgun_Rook40_F",
	"Rnd_9x21_Mag_16",
	"Chemlight_green",
	"roadcone",
	"supgrade1",
	"brakes"
];

_copshop_patrol = [
  "kleinesreparaturkit",
  "reparaturkit",
  "kanister",
//  "nitro",
  "supgrade2",
  "supgrade3",
  "supgrade4",
  "radar",
  "caralarm",
  "roadblock",
  "bargate",
  "Hbarrier",
  "Spikestrip",
  "satcam1",
  "satcam2",
  "satcam3",
  "B_UavTerminal"
];

_copshop_response = [
	"SmokeShell",
	"HeavyArmor",
	"supgrade5",
	"arifle_SDAR_F","Rnd_556x45_Stanag_30"
];

_copshop_swat = [
  "vclammo",
  "arifle_MX_F","arifle_MX_ACO_pointer_F","arifle_MXM_F", "Rnd_65x39_caseless_mag_30",
  "LMG_Mk200_F","Rnd_65x39_cased_Box_200",
  "launch_NLAW_F","NLAW_F",
  "launch_Titan_F","Titan_AA",
  "launch_Titan_short_F","Titan_AP","Titan_AT",
	"B_GMG_01_F",
	"B_HMG_01_F",
	"B_Mortar_01_F"
];

_copshop_snipe = [
  "arifle_TRG21_ARCO_pointer_F","Rnd_556x45_Stanag_30",
  "srifle_EBR_ARCO_pointer_F","Rnd_762x51_Mag_20"
];

_cs1 = [
  "C_Quadbike_01_F_red",
  "C_Quadbike_01_F_white",
  "C_Quadbike_01_F_black",
  "C_Quadbike_01_F_blue",
  "B_Quadbike_01_F",
  "I_Quadbike_01_F",
  "I_G_Quadbike_01_F",
  "I_G_Quadbike_01_F_hunting"
];

_cs1_1 = [
  "C_Offroad_01_F_red",
  "C_Offroad_01_F_tan",
  "C_Offroad_01_F_white",
  "C_Offroad_01_F_teal",
  "C_Offroad_01_F_maroon",
  "C_Offroad_01_F_blue",
  "I_G_Offroad_01_F"
];

_cs2 = [
  "C_Quadbike_01_F",
  "C_Hatchback_01_F",
  "C_Offroad_01_F",
  "C_SUV_01_F",
  "B_MRAP_01_F",
  "B_MRAP_01_F_gc",
  "C_Van_01_transport_F"
];

_cs3 = [
  "C_Quadbike_01_F",
  "C_Hatchback_01_sport_F",
  "C_Offroad_01_F",
  "B_MRAP_01_F",
  "B_MRAP_01_F_gc",
  "O_MRAP_02_F",
  "I_G_Van_01_transport_F",
  "C_Van_01_box_F"
];

_blackmarket = [
	"ziptie",
	"LightArmor",
	"MiniGrenade",
	"arifle_TRG20_ACO_F","Rnd_556x45_Stanag_30",
	"srifle_EBR_MRCO_pointer_F",
	"srifle_EBR_SOS_F","Rnd_762x51_Mag_20",
	"vclammo",
	"I_UavTerminal"

];

_blackmarket_air = [
	"B_Heli_Light_01_F_black",
	"O_Heli_Light_02_unarmed_F",
	//"O_UAV_01_F",
	"I_UAV_01_F"
];

_blackmarket_veh = [
	"C_Van_01_fuel_F",
	"I_MRAP_03_F",
	"I_Truck_02_transport_F",
	"I_Truck_02_Ammo_F",
	"I_Truck_02_fuel_F",
	"I_Truck_02_medical_F",
	"I_Truck_02_box_F",
	//"O_UGV_01_F",
	"I_UGV_01_F",
	"I_G_Offroad_01_armed_F"
];

_jailbike = [
	"C_Quadbike_01_F"
];

_bus = [
	"B_Truck_01_transport_F"
];

_gangshop_buy = [
  "I_UavTerminal",
  //"O_UAV_01_F",
  "I_UAV_01_F",
  "U_Rangemaster",
  "U_Competitor",
  "V_TacVestCamo_khk",
  "hgun_ACPC2_snds_F","Rnd_45ACP_Mag_9",
  "SMG_01_Holo_pointer_snds_F","Rnd_45ACP_Mag_SMG_01_30",
  "Binocular",
  "NVGoggles_INDEP",
  "kleinesreparaturkit",
  "reparaturkit",
  "lockpick",
  "Fuelline",
  "kanister",
  "medikit",
  "bargate",
  "bunkersmall",
  "BigbagfenceCorner",
  "bigbagfence",
  "bigbagfenceRound",
  "danger"
];

_chairshop = [
	"chair",
	"chair_rug",
	//"bench_rug",  <-- not working right in A3, u float above the bench
	"a3_camping_chair",
	"a3_camping_chair_rug",
	"a3_sun_chair",
	"a3_sun_chair_shade"
];

_hornshop = [
	"hornregsfx",
	"hornoldsfx",
	"hornitasfx",
	"horntrucksfx",
	"horndukessfx",
	"horncucasfx"
];

_clothes = [
	"U_C_Poloshirt_blue",
	"U_C_Poloshirt_burgundy",
	"U_C_Poloshirt_stripped",
	"U_C_Poloshirt_tricolour",
	"U_C_Poloshirt_salmon",
	"U_C_Poloshirt_redwhite",
	/*
	basicbody_green ,"\A3\characters_f\Civil\data\c_cloth4_v3_co.paa"
	basicbody_grey
	basicbody_black
	basicbody_blue
	*/
	//"U_C_CommonerGC_1",
	//"U_C_CommonerGC_2",
	//"U_C_CommonerGC_3",
	//"U_C_CommonerGC_4",
	"H_Cap_blu",
	"H_Cap_red",
	"H_Cap_tan",
	"H_Cap_grn",
	"H_Cap_grn_BI",
	"H_Cap_blk_Raven",
	"H_Cap_blk_ION",
	"H_Cap_blk",
	"H_Cap_brn_SPECOPS",
	"H_Cap_tan_specops_US",
	"H_Cap_khaki_specops_UK",
	"H_Hat_tan",
	"H_Hat_brown",
	"H_Hat_blue",
	"H_Hat_checker",
	"H_Hat_grey",
	"H_StrawHat_dark",
	"H_StrawHat",
	"H_TurbanO_blk",
	//"H_Watchcap_sgg",
	//"H_Watchcap_blk",
	//"H_ShemagOpen_tan",
	//"H_Shemag_tan",
	"H_Bandanna_gry",
	"H_Bandanna_khk",
	"H_Bandanna_sgg",
	"H_Bandanna_cbr",
	"H_Bandanna_camo",
	"H_Bandanna_mcamo",
	"H_Bandanna_surfer",
	"H_Beret_grn",
	"H_Beret_red"
];

_army = [
	"V_BandollierB_khk",
	"V_BandollierB_rgr",
	"V_BandollierB_cbr",
	"V_BandollierB_oli",
	//"V_HarnessOGL_gry", //suicide vest  todo A3 add more vests Imago
	"B_Carryall_mcamo",
	"B_Carryall_oli",
	"B_Carryall_khk",
	"B_Carryall_cbr",
	"B_TacticalPack_rgr",
	"B_TacticalPack_blk",
	//"B_HuntingWaffe",
	"Rnd_9x21_Mag_30",
	"I_UAV_01_backpack_F"
];

_goggles = [
	"G_Shades_Black",
	"G_Shades_Blue",
	"G_Tactical_Clear",
	"G_Squares",
	"G_Squares_Tinted",
	"G_Sport_Red"
];

_terrorshop = [
	"HeavyArmor",
	"medikit",
	"reparaturkit",
	"Fuelline",
	"lockpick",
	"HandGrenade",
	"LMG_Zafir_F","LMG_Zafir_pointer_F","Rnd_762x51_Box_150",
	"srifle_LRR_SOS_F","Rnd_408_Mag_7",
	"launch_RPG32_F","RPG32_HE_F","RPG32_F",
	"vehicle_bomb",
	"suicide_bomb",
	"remote_bomb",
	"vclammo",
	"I_UavTerminal",
	"O_GMG_01_F",
	"O_HMG_01_F",
	"O_Mortar_01_F"
];

_terrorveh = [
	"O_MRAP_02_hmg_F",
	"O_MRAP_02_gmg_F",
	"I_Heli_Transport_02_F",
	"B_Heli_Light_01_armed_F",
	"O_Heli_Attack_02_F",
	"O_APC_Wheeled_02_rcws_F",
	"B_APC_Tracked_01_rcws_F",
	//"O_UGV_01_rcws_F",
	"I_UGV_01_rcws_F",
	"O_MBT_02_arty_F",
	"O_MBT_02_cannon_F"
];

_foodShop = [
  "taco",
  "burger",
  "pizza"
];

gc_bags = [
	"B_HuntingBackpack",
	"B_OutdoorPack_blk",
	"B_OutdoorPack_blu"
];

INV_ItemShops = [
  [fuelshop1,"Main Gas Station",dummyobj,dummyobj,_fs,_fs,true, "shopdialogs.sqf"],
  [fuelshop2,"Marina Gas Station",dummyobj,dummyobj,_fs,_fs,true, "shopdialogs.sqf"],
  [fuelshop3,"North Gas Station",dummyobj,dummyobj,_fs,_fs,true, "shopdialogs.sqf"],
  [fuelshop4,"South Gas Station",dummyobj,dummyobj,_fs,_fs,true, "shopdialogs.sqf"],
  [fuelshop6,"Northeast Gas Station",dummyobj,dummyobj,_fs,_fs,true, "shopdialogs.sqf"],
  [fuelshop7,"Southeast Gas Station",dummyobj,dummyobj,_fs,_fs,true, "shopdialogs.sqf"],
  [huntshop1,"Butcher",dummyobj,dummyobj,_hunt,_hunt,true, "shopdialogs.sqf"],
  [boatshop1,"West Boat Shop",dummyobj,[boatspawn1,boatspawn1_1],_boat,_boat,true, "shopdialogs.sqf"],
  [boatshop2,"Gang Boat Shop",dummyobj,[boatspawn2],_gangboats,_gangboats,true, "shopdialogs.sqf"],
  [boatshop3,"East Boat Shop",dummyobj,[boatspawn3,boatspawn3_1],_boat,_boat,true, "shopdialogs.sqf"],
  [boatshop4,"Pirate Boat Shop",dummyobj,[boatspawn4,boatspawn4_1],_gangboats,_gangboats,true, "shopdialogs.sqf"],
  [boatshop5,"Kamino Boat Shop",dummyobj,[boatspawn5,boatspawn5_1],_boat,_boat,true, "shopdialogs.sqf"],
  [boatshop6,"Girna Boat Shop",dummyobj,[boatspawn6,boatspawn6_1],_boat,_boat,true, "shopdialogs.sqf"],
  [boatshop7,"Gang Boat Shop",dummyobj,[boatspawn7],_gangboats,_gangboats,true, "shopdialogs.sqf"],
  [boattuning,"Boat Tuning",dummyobj,dummyobj,_bt,_bt,true, "shopdialogs.sqf"],
  [boattuning2,"Boat Tuning",dummyobj,dummyobj,_bt,_bt,true, "shopdialogs.sqf"],
  [boattuning3,"Boat Tuning",dummyobj,dummyobj,_bt,_bt,true, "shopdialogs.sqf"],
  [boattuning4,"Boat Tuning",dummyobj,dummyobj,_bt,_bt,true, "shopdialogs.sqf"],
  [scubashop,"Scuba Gear Shop",scubabox,dummyobj,_scuba,_scuba,true, "shopdialogs.sqf"],
  [caveshop,"Scuba Gun Shop",cavegunbox,dummyobj,_cave,_cave,true, "shopdialogs.sqf"],
  [shop1,"Marina Item Shop",dummyobj,dummyobj,_is,_is,true, "shopdialogs.sqf"],
  [shop2,"South Item Shop",dummyobj,dummyobj,_is,_is,true, "shopdialogs.sqf"],
  [shop3,"Midwest Item Shop",dummyobj,dummyobj,_is,_is,true, "shopdialogs.sqf"],
  [shop4,"East Item Shop",dummyobj,dummyobj,_is,_is,true, "shopdialogs.sqf"],
  [shop5,"Girna Item Shop",dummyobj,dummyobj,_is,_is,true, "shopdialogs.sqf"],
  [pub1,"Romans Pub",dummyobj,dummyobj,_pub,_pub,true, "shopdialogs.sqf"],
  [pub2,"Mashs Pub",dummyobj,dummyobj,_pub2,_pub2,true, "shopdialogs.sqf"],
  [pub3,"Zargeros Pub",dummyobj,dummyobj,_pub3,_pub3,true, "shopdialogs.sqf"],
  [pistolshop,"Pistol Shop",pistolbox,dummyobj,_pshop,_pshop,true, "shopdialogs.sqf"],
  [rifleshop,"Rifle Shop",riflebox,dummyobj,_rshop,_rshop,true, "shopdialogs.sqf"],
  [equipshop,"Equipment Shop",equipbox,dummyobj,_equipShop,_equipShop,true, "shopdialogs.sqf"],
  [equipshop2,"Equipment Shop",equipbox2,dummyobj,_equipShop,_equipShop,true, "shopdialogs.sqf"],
  [tuning1,"Car Tuning",dummyobj,dummyobj,_cu,_cu,true, "shopdialogs.sqf"],
  [tuning2,"Car Tuning",dummyobj,dummyobj,_cu,_cu,true, "shopdialogs.sqf"],
  [truckshop,"Truck Shop",dummyobj,[truckspawn_0, truckspawn_1, truckspawn_2, truckspawn_3],_ts,_ts,true, "shopdialogs.sqf"],
  [airshop,"Air Shop",dummyobj,[asairspawn_0, asairspawn_1, asairspawn_2, asairspawn_3],_as,_as,true, "shopdialogs.sqf"],
  [miningt,"Mining equipment",dummyobj,dummyobj,_mt,_mt,true, "shopdialogs.sqf"],
  [resourcesell,"Sell Resources",dummyobj,dummyobj,_rs,_rs,true, "shopdialogs.sqf"],
  [RingShop,"Ring Shop", dummyobj,dummyobj,_gds,_gds,true, "shopdialogs.sqf"],
  [OilSell1,"Oil Dealer", dummyobj,dummyobj, _emptyshop,_os,true, "shopdialogs.sqf"],
  [gangarea1,"Gang Shop",gangbox1,dummyobj,_gangshop_buy,_gangshop_buy,false, "shopdialogs.sqf"],
  [gangarea2,"Gang Shop",gangbox2,dummyobj,_gangshop_buy,_gangshop_buy,false, "shopdialogs.sqf"],
  [gangarea3,"Gang Shop",gangbox3,dummyobj,_gangshop_buy,_gangshop_buy,false, "shopdialogs.sqf"],
  [gangarea4,"Gang Shop",gangbox4,dummyobj,_gangshop_buy,_gangshop_buy,false, "shopdialogs.sqf"],
  [gangarea5,"Gang Shop",gangbox5,dummyobj,_gangshop_buy,_gangshop_buy,false, "shopdialogs.sqf"],
  [cdrugsell,"Sell Cocaine",dummyobj,dummyobj,_emptyshop,_dsc,true, "shopdialogs.sqf"],
  [mdrugsell,"Sell marijuana",dummyobj,dummyobj,_emptyshop,_dsm,true, "shopdialogs.sqf"],
  [ldrugsell,"Sell LSD",dummyobj,dummyobj,_emptyshop,_dsl,true, "shopdialogs.sqf"],
  [hdrugsell,"Sell Heroin",dummyobj,dummyobj,_emptyshop,_dsh,true, "shopdialogs.sqf"],
  [copair,"Police Air Shop",dummyobj, [cairspawn_0,cairspawn_1],_ca,_ca,true, "shopdialogs.sqf"],
  [copcar,"Police Vehicle Shop",dummyobj, [ccarspawn_0, ccarspawn_1, ccarspawn_2, ccarspawn_3],_cv,_cv,true, "shopdialogs.sqf"],
  [swatcar,"SWAT Vehicle Shop",dummyobj, [scarspawn1,scarspawn1_1],_sv,_sv,true, "shopdialogs.sqf"],
  [tdoc,"Doctor",dummyobj,dummyobj,_td,_td,false, "shopdialogs.sqf"],
  [copbasic,"Police Supplies",copbasicbox,dummyobj, _copshop,_copshop,false, "shopdialogs.sqf"],
  [coppatrol,"Patrol Shop",coppatrolbox,dummyobj,_copshop_patrol,_copshop_patrol,true, "shopdialogs.sqf"],
  [copcriminal,"Criminal Response Shop",copcriminalbox,dummyobj,_copshop_response,_copshop_response,true, "shopdialogs.sqf"],
  [copswat,"SWAT Officer Shop",copswatbox,dummyobj,_copshop_swat,_copshop_swat,true, "shopdialogs.sqf"],
  [copsnipe,"Police Sniper Shop",copsnipebox,dummyobj,_copshop_snipe,_copshop_snipe,true, "shopdialogs.sqf"],
  [copattach,"Weapon Attachments",copattachbox,dummyobj,_attach,_attach,true, "shopdialogs.sqf"],
  [carshop1,"ATV Dealership",dummyobj,[carspawn1_0,carspawn1_1,carspawn1_2],_cs1,_cs1,true, "shopdialogs.sqf"],
  [offroadshop,"Offroad Dealership",dummyobj,[carspawn1_3,carspawn1_4,carspawn1_5],_cs1_1,_cs1_1,true, "shopdialogs.sqf"],
  [carshop2,"Car Shop",dummyobj,[carspawn2_0,carspawn2_1,carspawn2_2,carspawn2_3,carspawn2_4,carspawn2_5],_cs2,_cs2,true, "shopdialogs.sqf"],
  [carshop3,"Car Shop",dummyobj,[carspawn3_0,carspawn3_1,carspawn3_2,carspawn3_3],_cs3,_cs3,true, "shopdialogs.sqf"],
  [carshop4,"Car Shop",dummyobj,[carspawn4_0,carspawn4_1],_cs3,_cs3,true, "shopdialogs.sqf"],
  [carshop5,"Hatchback Dealership",dummyobj,[carspawn5,carspawn5_1,carspawn5_2],_hatchbacks,_hatchbacks,true, "shopdialogs.sqf"],
  [carshop6,"SUV Dealership",dummyobj,[carspawn6,carspawn6_1,carspawn6_2],_suvs,_suvs,true, "shopdialogs.sqf"],
  [carshop7,"Van Dealership",dummyobj,[carspawn7,carspawn7_1],_vans,_vans,true, "shopdialogs.sqf"],
  [bmshop,"Pirate Gun Shop",bmgunbox,dummyobj,_blackmarket,_blackmarket,true, "shopdialogs.sqf"],
  [bmshopair,"Pirate Air Shop",dummyobj,[bmairspawn],_blackmarket_air,_blackmarket_air,true, "shopdialogs.sqf"],
  [bmshopveh,"Pirate Truck Shop",dummyobj,[bmvehspawn_0, bmvehspawn_1, bmvehspawn_2, bmvehspawn_3],_blackmarket_veh,_blackmarket_veh,true, "shopdialogs.sqf"],
  [jailbike,"Jail ATV Shop",dummyobj,[jailbikespawn_0,jailbikespawn_1],_jailbike,_jailbike,true, "shopdialogs.sqf"],
  [busshop,"Bus Station Shop",dummyobj,[busspawn_0, busspawn_1],_bus,_bus,true, "shopdialogs.sqf"],
  [hornnpc,"Horn Shop",dummyobj,dummyobj,_hornshop,_hornshop,true, "shopdialogs.sqf"],
  [chairnpc,"Chair Shop",dummyobj,dummyobj,_chairshop,_chairshop,true, "shopdialogs.sqf"],
  [clothshop,"Clothes Shop",itembox,dummyobj,_clothes,_clothes,true, "shopdialogs.sqf"],
  [goggleshop,"Glasses Shop",dummyobj,dummyobj,_goggles,_goggles,true, "shopdialogs.sqf"],
  [armyshop,"Army Surplus Shop",armybox,dummyobj,_army,_army,true, "shopdialogs.sqf"],
  [foodshop,"Fast Food",dummyobj,dummyobj,_foodShop,_foodShop,true, "shopdialogs.sqf"],
  [attachshop,"Weapon Attachment Dealer",attachbox,dummyobj,_attach,_attach,true, "shopdialogs.sqf"],
  [terrornpc,"Terror Shop",terrorbox,dummyobj,_terrorshop,_terrorshop,true, "shopdialogs.sqf"],
  [terrorveh,"Terror Vehicle Shop",dummyobj,[terrorvehspawn],_terrorveh,_terrorveh,true, "shopdialogs.sqf"],
  [bagshop,"Bag Shop",bagbox,dummyobj,gc_bags,gc_bags,true, "bagshop.sqf"],
  [lottoshop,"Lottery",dummyobj,dummyobj,dummyobj,dummyobj,true, "gc\client\GC_DialogLotto.sqf"],
  [shop1export,"Market Export 1",dummyobj,dummyobj,dummyobj,dummyobj,true, "shopdialogs.sqf"],
  [shop2export,"Market Export 2",dummyobj,dummyobj,dummyobj,dummyobj,true, "shopdialogs.sqf"],
  [shop3export,"Market Export 3",dummyobj,dummyobj,dummyobj,dummyobj,true, "shopdialogs.sqf"],
  [shop4export,"Market Export 4",dummyobj,dummyobj,dummyobj,dummyobj,true, "shopdialogs.sqf"],
  [taxi1,"Taxi Jobs",dummyobj,dummyobj,dummyobj,dummyobj,true, "gc\client\GC_InformScrollUsage.sqf"],
  [delivery1,"Post Office",dummyobj,dummyobj,dummyobj,dummyobj,true, "gc\client\GC_InformScrollUsage.sqf"]
];

shopusearray = [];
{shopusearray = shopusearray + [(_x select 0)];} foreach INV_ItemShops;

//diag_log text format["%1 %2 %3",__FILE__,count INV_ItemShops,count INV_itemmaxstocks];
