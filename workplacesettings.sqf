//==================================DELIVERY MISSION=========================================

workplacejob_deliverymsg = [
  "STRS_workplacemission_deliverymsg_1",
  "STRS_workplacemission_deliverymsg_2",
  "STRS_workplacemission_deliverymsg_3",
  "STRS_workplacemission_deliverymsg_4",
  "STRS_workplacemission_deliverymsg_5",
  "STRS_workplacemission_deliverymsg_6",
  "STRS_workplacemission_deliverymsg_7"
];

deliveryjobmulti              = 12;
workplacejob_courier_maxmoney = 100000;
deliverymintime               = 300;

workplacejob_deliveryflagarray = [
  workplacejob_deliveryflag1,
  workplacejob_deliveryflag2,
  workplacejob_deliveryflag3,
  workplacejob_deliveryflag4,
  workplacejob_deliveryflag5,
  workplacejob_deliveryflag6,
  workplacejob_deliveryflag7,
  workplacejob_deliveryflag8,
  workplacejob_deliveryflag9,
  workplacejob_deliveryflag10
];

workplacejob_deliverynamearray = [
  "Delivery Point 1",
  "Delivery Point 2",
  "Delivery Point 3",
  "Delivery Point 4",
  "Delivery Point 5",
  "Delivery Point 6",
  "Delivery Point 7",
  "Delivery Point 8",
  "Delivery Point 9",
  "Delivery Point 10"
];

//========================================TAXI MISSION============================================

workplacejob_taxi_zielarray = [
  getmarkerpos "taximarker1",
  getmarkerpos "taximarker2",
  getmarkerpos "taximarker3",
  getmarkerpos "taximarker4",
  getmarkerpos "taximarker5",
  getmarkerpos "taximarker6",
  getmarkerpos "taximarker7",
  getmarkerpos "taximarker8",
  getmarkerpos "taximarker9",
  getmarkerpos "taximarker10",
  getmarkerpos "taximarker11",
  getmarkerpos "taximarker12",
  getmarkerpos "taximarker13",
  getmarkerpos "taximarker14",
  getmarkerpos "taximarker15",
  getmarkerpos "taximarker16",
  getmarkerpos "taximarker17",
  getmarkerpos "taximarker18",
  getmarkerpos "taximarker19",
  getmarkerpos "taximarker20",
  getmarkerpos "taximarker21",
  getmarkerpos "taximarker22",
  getmarkerpos "taximarker23",
  getmarkerpos "taximarker24",
  getmarkerpos "taximarker25"
];

workplacejob_taxi_sperrzeit     = 0.01;
workplacejob_taxi_multiplikator = 4;
workplacejob_taxi_maxmoney      = 200000;
taximaxdistance                 = 5000;
taximindistance                 = 500;

//========================================ASSASSINATION============================================
workplacejob_assassin_break   = 10;
workplacejob_assassion_failed = false;

//========================================SEARCH============================================
workplacejob_search_cancel = 0;
searchjobsuccess = 10000;
searchjobmin = 2500;
workplacejob_searchmessages = [localize "STRS_workplacemission_searchmsg_1", localize "STRS_workplacemission_searchmsg_2", localize "STRS_workplacemission_searchmsg_3"];
workplacejob_searchobjects = ["Land_Grave_V3_F", "Land_Wreck_Heli_Attack_01_F", "Land_WoodenCart_F"];
workplacejob_searchpos = [ [searchlogic, 250, 250] ];
workplacejob_searchnamearray = [
  "Haunted Grave",
  "Blackfoot Down",
  "Lost Cart"
];
searchmarker = nil;
searchmarker2 = nil;
alreadygotaworkplacejob = 0;
