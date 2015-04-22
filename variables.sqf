private ["_i","_queue","_list","_obj2","_storage"];

//the server deosnt have to load 1/2 this shit NYI
INV_smscost          = 1;
add_copmoney         = 5000;
add_workplace        = 4000;
add_checkpoint       = 12000;
CopWaffenAvailable   = 0;
CopIsInPrison        = false;
CopInPrisonTime      = 300;
shooting_self        = 0;
srHinbewegen         = 0;
deadcam              = 0;
isstunned            = false;
hatGanggebietErobert = false;
Antwort              = 0;
CivTimeInPrison      = 0;
CopLog               = [];
MayorSteuern         = 0;
MayorBekommtSteuern  = 35;
chiefSteuern         = 0;
chiefBekommtSteuern  = 35;
eigene_zeit          = time;
money_limit          = 999999;
bank_limit           = 10000000;
wantedbonus          = 30000;
StunActiveTime       = 0;
StunTimePerHit       = 30;
MaxStunTime          = 60;
cashStehlenMax       = 200000;
demerits             = 0;
keyblock             = false;
minagents            = 4;
maxmanitime          = 10800;
powerrestorecost     = 10000;
impoundpay           = 2000;
impoundpay3          = 10000;
impoundpay2          = 20000;
noholster            = false;
MGcost               = 10000;
PKcost               = 10000;
SQUADcost            = 20000;
maxinfai             = 16;
firestrikes          = 3;
totalstrikes         = 3;
facworkercost        = 3000;
maxfacworkers        = 15;
firingcaptive        = false;
pickingup            = false;
lockpickchance       = 10;
planting             = false;
drugstockinc         = 900;
druguse_minutes      = 2;
maxspeed             = 200;
add_civmoney         = 2500;

//========robbing variables===========
bankrobdelay              = 120;
stolenfromtime            = 300;
stolenfromtimeractive = false; // dont change


//===============MOTD==================
motdwaittime = 120;

//===============Cop Patrol==================
pmissionactive   = false;
patrolwaittime   = false;
patrolmoneyperkm = 14.0; // 1 would be equal to $3,000 for 1KM


//=========government convoy=============
govconvoybonus      = 100000;
govconvoythiefbonus = 200000;

//===== Gas station robbing
maxstationmoney        = 5000;
wantedamountforrobbing = 20000;


if(debug)then{drugstockinc = 6;druguserate = 20};

//==============================PETROL/OIL=========================================
petrolIncrement = 1;
maxPetrolPrice  = 300;
minPetrolPrice  = 100;
oildemand       = 0.25;
oilsellpricedec = 30;
oilbaseprice    = 16000;

//==============================MINING=============================================
shoveldur  = 20;
shovelmax  = 2;
pickaxedur = 50;
pickaxemax = 3;
hammerdur  = 100;
hammermax  = 4;
working    = false;

//===============================GANGS=============================================
gangincome      = 26000;
gangcreatecost  = 250000;
gangdel_minutes = 5;
gangsarray      = [];
gangmember      = false;
gangleader      = false;
gangareas       = [gangarea1,gangarea2,gangarea3,gangarea4,gangarea5];

//=================================================================================
//CityLocationArray = [[militarybase, 200]];
respawnarray      = [respawn1,respawn2,respawn3,respawn4,respawn5,respawn6,respawn7,respawn8,respawn9,respawn10,respawn11,respawn12];

//=========== cop patrol array ==========
coppatrolarray = [
  getmarkerpos "patrolpoint1",
  getmarkerpos "patrolpoint2",
  getmarkerpos "patrolpoint3",
  getmarkerpos "patrolpoint4",
  getmarkerpos "patrolpoint5",
  getmarkerpos "patrolpoint6",
  getmarkerpos "patrolpoint7",
  getmarkerpos "patrolpoint8",
  getmarkerpos "patrolpoint9",
  getmarkerpos "patrolpoint10",
  getmarkerpos "patrolpoint11",
  getmarkerpos "patrolpoint12",
  getmarkerpos "patrolpoint13",
  getmarkerpos "patrolpoint14",
  getmarkerpos "patrolpoint15",
  getmarkerpos "patrolpoint16",
  getmarkerpos "patrolpoint17",
  getmarkerpos "patrolpoint18",
  getmarkerpos "patrolpoint19",
  getmarkerpos "patrolpoint20",
  getmarkerpos "patrolpoint21",
  getmarkerpos "patrolpoint22",
  getmarkerpos "patrolpoint23",
  getmarkerpos "patrolpoint24",
  getmarkerpos "patrolpoint25"
];

if (iscop) then {
  RadioTextMsg_1 = "Put your hands up!";
  RadioTextMsg_2 = "Pull over and stay in your vehicle!";
  RadioTextMsg_3 = "Drop your weapon and put your hands on your head!";
  RadioTextMsg_4 = "Your free to go, have a nice day";
} else {
  RadioTextMsg_1 = "Put your hands up now!";
  RadioTextMsg_2 = "Step away from the vehicle!";
  RadioTextMsg_3 = "Do it now or your dead!";
  RadioTextMsg_4 = "Dont shoot i give up!";
};

RadioTextArt_1 = "direct";
RadioTextArt_2 = "direct";
RadioTextArt_3 = "direct";
RadioTextArt_4 = "direct";

publicarbeiterarctionarray= [];

for [{_i=1}, {_i <= civscount}, {_i=_i+1}] do {
call compile format ['
  kopfcash_civ%1      = 0;
  civ%1_wanted        = 0;
  civ%1_reason        = [];
  civ%1_arrest        = 0;
  civ%1_markerjammed  = 0;
', _i];
};

for [{_i=1}, {_i <= copscount}, {_i=_i+1}] do {
	call compile format['Cop%1_Sirene_on = false;', _i];
};

GC_Wanted = [[0,0,[],0]];
GC_A3 = [["",[],"",[],"",[],"","",[],[]]];

isdead           = 0;
local_arrest     = 0;
extradeadtime    = 0;
respawntimeinc   = 10;
killedplayerinc  = 15;
respawnzeit      = 3;
DeadWaitSec      = respawnzeit;
DeadTimeMax      = 60;
deadtimebonus    = 0;
deadtimes        = 0;
suicided         = false;
suicidepenalty   = 60;
CopsKilled       = 0;
CivsKilled       = 0;
SelfKilled       = 0;
CivsBusted       = 0;
BailPaid         = 0;
RewardsCollected = 0;
GesetzAnzahl     = 10;
GesetzArray      = ["Press M to read server laws and rules.", "", "", "", "","", "", "", ""];
chaos = false;
PlayerUID = [];

if (debug) then {
  suicidepenalty = 0;
  respawntimeinc = 0;
  killedplayerinc = 0;
};

isMayor       = false;
WahlArray     = [];
MayorNumber   = -1;
MayorExtraPay = 3000;

for [{_i=0}, {_i < playercount}, {_i=_i+1}] do {WahlArray = WahlArray + [ [] ];}; //wtf is this A3 NYI TODO IMAGO

ischief       = false;
WahlArrayc    = [];
chiefNumber   = -1;
chiefExtraPay = 5000;

for [{_i=0}, {_i < playercount}, {_i=_i+1}] do {WahlArrayc = WahlArrayc + [ [] ];};


//make sure this is ok for the rejoin cam NYI
deadcam_target_array = [
  [114238.47,12719.49,3040.26],
  [114238.47,12719.49,3040.28]
];

deadcam_position_array = [
  [6573.78,2365.67,19.16],
  [6563.33,2409.16,3.60]
];
// rejoincam ^-- may crash A3 TODO (seems ok v0.71)

atmscriptrunning          = 0;
shopactivescript          = false;
deadcam_wechsel_dauer     = 5;
deadcam_kameraposition    = round(random (count deadcam_position_array - 1));
prostitute_cost           = 25000;
prostitutemoneyprosekunde = 16000;
maxprostitute             = 6;
copprostituteallowed      = 1;
localprostitute           = 0;
localprostitutecounter    = 0;
doingSomething            = false;
unholstering              = false;
busses                    = ["B_Truck_01_transport_F"];
busRouteActive            = false;
busRouteWaiting           = false;
takingFlag                = false;
inVehicle                 = false;
nossing                   = 0;
jumpMod                   = 1;
fedUntil                  = 0;
flashlightStrength        = 0.07;

speedbomb_minspeed        = 1;
speedbomb_maxspeed        = 100;
speedbomb_mindur          = 10;
speedbomb_maxdur          = 300;
zeitbombe_mintime         = 1;
zeitbombe_maxtime         = 10;

publichideoutarray        = [];
hideoutcost               = 20000;
marker_innerhalb          = 5;
marker_CopDistance        = 50; //controls distance cops need to be to make civ dots appear outside of towns.
CivMarkerUngenau          = 20;
copmarker_on              = 1;

workplacearray            = [[workplace1, 30], [workplace2, 30], [workplace3, 30]];
checkpointarray           = [[copgate2, 50], [copgate3, 50], [copgate4, 50], [copgate5, 50]];
huntingarray              = [["boarhunting", 200]];
ambientanimals = ["Fin_random_F","Alsatian_Random_F","Hen_random_F","Cock_Random_F","Hen_random_F","Cock_Random_F"];
ambientarray = [
	["animals",180],
	["animals_1",100]
];
turtlearray = [
  ["turtlearea1", 120],
  ["turtlearea2", 120],
  ["turtlearea3", 120],
  ["turtlearea4", 120],
  ["turtlearea5", 120]
];

fisharray = [
  ["bassarea",80],
  ["percharea",80],
  ["troutarea",80],
  ["walleyearea",80]
];
huntinggrounds      = turtlearray + fisharray + huntingarray;
fishtypes           = ["CatShark_F","Mullet_F","Tuna_F","Mackerel_F","Salema_F"];
nonlethalweapons    = ["Binocular", "NVGoggles", "NVGoggles_INDEP", "ItemMap", "ItemCompass", "ItemRadio", "ItemWatch", "ItemGPS"];
prostitutearray     = workplacearray;
timeinworkplace     = 0;
wpcapacity          = 10;
INV_hasitemshop     = 0;
INV_haswepshop      = 0;
BuildingsOwnerArray = [];
prevWhistles        = [-60, -60, -60, -60, -60, -60];

if (isciv) then {
  BuyAbleBuildingsArray = [
    ["wp1", "Workplace 1", workplace_getjobflag_1, 10000, 1000, "wp", "WpAblage_1"],
    ["wp2", "Workplace 2", workplace_getjobflag_2, 20000, 2000, "wp", "WpAblage_2"],
    ["wp3", "Workplace 3", workplace_getjobflag_3, 30000, 3000, "wp", "WpAblage_3"]
  ];
} else {
  BuyAbleBuildingsArray = [];
};


civprostitutearray = ["o_helipilot_f"];
AIarray = ["i_soldier_tl_f","i_soldier_sl_f","i_soldier_f","i_helipilot_f","o_helipilot_f"];

gc_tiedplayer = false;

robbable = [
  carshop1,
  carshop2,
  carshop3,
  carshop4,
  offroadshop,
  boattuning,
  boattuning2,
  boattuning3,
  boattuning4,
  scubashop,
  caveshop,
  fuelshop1,
  fuelshop2,
  fuelshop3,
  fuelshop4,
  fuelshop6,
  fuelshop7,
  bagshop,
  shop1,
  shop2,
  shop3,
  shop4,
  shop5,
  lottoshop,
  shop1export,
  shop2export,
  shop3export,
  shop4export,
  miningt,
  tuning1,
  tuning2,
  RingShop,
  equipshop,
  equipshop2,
  resourcesell,
  pub1,
  pub2,
  pub3,
  delivery1,
  taxi1,
  oilsell1,
  hornnpc,
  attachshop,
  clothshop,
  boatshop1,
  boatshop3,
  boatshop4,
  boatshop5,
  boatshop6,
  armyshop,
  goggleshop,
  busshop
];

// Define Rapel Variables

gcrsrepelvehicle = "none";
gcrsropedeployed = "false";
gcrsdeployropeactionid = 0;
gcrsdropropeactionid = 0;
gcrsplayerrepelactionid = 0;
gcrsplayerveh = "none";
gcrspilotvehicle = "none";
gcrsrapelvehiclearray = [
	"B_Heli_Light_01_F",
	"B_Heli_Light_01_armed_F",
	"B_Heli_Attack_01_F",
	"B_Heli_Transport_01_F",
	"O_Heli_Light_02_F",
	"O_Heli_Light_02_unarmed_F",
	"O_Heli_Attack_02_F",
	"O_Heli_Attack_02_black_F",
	"I_Heli_Transport_02_F"
];
gcrsrapelheloarray = [];
gcrsplayerveharray = [];

playing_lotto = 0;
LottoArray =[
  ["lotto1", "Cheap ticket",  100,   10000, 3],
  ["lotto2", "Normal ticket", 500,   50000, 3],
  ["lotto3", "Super ticket",  5000,  500000, 3],
  ["lotto4","Chaos ticket",   10000, 1000000, 3]
];

LottoFlags = [[lottoshop,["lotto1", "lotto2", "lotto3", "lotto4"]]];

idleAnims = ["UnaErcPoslechVelitele1", "UnaErcPoslechVelitele2", "UnaErcPoslechVelitele3", "UnaErcPoslechVelitele4"];
sitAnims = ["InBaseMoves_SittingRifle1"];
sitNPCs = [
	atm1npc,
	atm1npc_1,
	atm2npc,
	atm4npc,
	atm5npc,
	atm6npc,
	atm7npc,
	atm8npc,
	atmpfnpc,
	copbanknpc,
	shop1export,
	shop2export,
	shop3export,
	shop4export,
	shop1,
	resourcesell,
	bagshop,
	//equipshop,
	carshop3,
	chairnpc];

playerWeapons     = [];
playerMagazines   = [];
weaponsloaded     = false;
CopStartGear_Mags = [
  "16Rnd_9x21_Mag",
  "16Rnd_9x21_Mag",
  "16Rnd_9x21_Mag",
  "16Rnd_9x21_Mag",
  "16Rnd_9x21_Mag",
  "16Rnd_9x21_Mag",
  "16Rnd_9x21_Mag"
];


CopStartGear_Weap = ["ItemGPS","NVGoggles","Binocular","hgun_Rook40_F"]; //keep the default stun gun last
stunfxammo = "F_40mm_Red";
stunammo = ["F_40mm_Red","B_9x21_Ball"];
stunmags = ["16Rnd_9x21_Mag"];
teargas = ["SmokeShell", "Rnd_Smoke_Grenade_shell_1"];

iactionarr = [];

unholsterPistol = -1;
holsterPistol = -1;
saveWeaponPistol = ["",false,false];

gc_boxes = [];
{
	_queue = _x select 8;
	_list  = _x select 5;
	_storage = _x select 7;
	call compile format['%1workers = 0;', _queue];
	_obj2 = _x select 3;
	{ call compile format['%1avail = 0; %1prod = 0; %1eta = 0; %1pend = 0;', _x]; } forEach _list;
	if (!(_obj2 in gc_boxes) and _obj2 != dummyobj) then{[gc_boxes, _obj2] call BIS_fnc_arrayPush;};
	call compile format['
		%1 = [];
		%2 = [];
	',_storage,_queue];
} foreach INV_ItemFabriken;
{
	_obj2 = _x select 2;
	if (!(_obj2 in gc_boxes) and _obj2 != dummyobj) then {[gc_boxes, _obj2] call BIS_fnc_arrayPush;};
} foreach INV_ItemShops;

handleDamage_handle = 0 spawn {};
radio_handle = 0 spawn {};

//TODO A3 NYI Imago - get rid of the ones that dont exist in A3!
armor_big = [
	"B_545x39_SD",
	"B_545x39_Ball",
	"B_762x39_Ball",
	"B_556x45_Ball",
	"B_556x45_SD",
	"B_762x51_noTracer",
	"B_556x45_Ball_SD",
	"B_762x51_Ball",
	"B_127x99_Ball_noTracer",
	"B_12Gauge_74Slug",
	"B_762x54_Ball",
	"B_762x54_noTracer",
	"B_127x108_Ball",
	"B_9x39_SP5",
	"B_127x107_Ball",
	"B_145x115_AP",
	"B_762x51_3RndBurst",
	"B_127x99_Ball",
	"B_77x56_Ball",
	"B_19mm_HE",
	"B_86x70_Ball_noTracer",
	"B_303_Ball",
	"B_127x108_APHE",
	"G_40mm_HE",
	"G_30mm_HE",
	//a3
	"B_56x15_dual",
	"B_65x39_Caseless",
	"B_12Gauge_Slug",
	"B_127x33_Ball",
	"B_127x108_Ball",
	"B_20mm",
	"B_25mm",
	"B_30mm_AP",
	"B_35mm_AA"
];

armor_small = [
	"B_765x17_Ball",
	"B_9x18_Ball",
	"B_9x18_SD",
	"B_45ACP_Ball",
	"B_12Gauge_Pellets",
	"B_9x19_Ball",
	"B_9x19_SD",
	//a3
	"B_9x21_Ball"
];

refuel_action_a1 = 0; refuel_action_f1 = 0; refuel_action_v1 = 0;
factory_action_a2 = 0; factory_action_a3 = 0; factory_action_f2 = 0;
factory_busy_array = []; for [{_i=0}, {_i < (count INV_ItemFabriken)},{_i=_i+1}] do {factory_busy_array = factory_busy_array + [0]};
licenses_purchased_array = []; for [{_i=0}, {_i < (count INV_Lizenzen)},{_i=_i+1}] do {licenses_purchased_array = licenses_purchased_array + [0]};

chairaction = -1;
bombplanted = false;
raidarray = []; //checkpoint names
copraidarray = []; //cop names
not_raiding = true;
OutOFBoundsTicks = 0;

wipewanted = true;
kickedout = false;
private_storage = [];
last_terror_time = 0;

oldSlot = nil;

siren_is_on = false;
cop_is_driving = false;
action_code0 = -1;
action_code1 = -1;
action_code2 = -1;
camfixid = -1;
siren_action_veh = 0;

impersonating = false;

notuning = []; //A3 NYI TODO let any class name be tuned for now
sandstorm_pp = [objnull];

robpoolsafe1 		 = 0;
robpoolsafe2 		 = 0;
robpoolsafe3 		 = 0;

bombtypes = [
	"R_60mm_HE",
	"R_80mm_HE",
	"M_Air_AA",
	"Grenade",
	"B_20mm_Tracer_Red",
	"B_762x51_Tracer_Red",
	"Bomb"
];

convoyhascash = false;
{call compile format["%1money = 0;", _x];} forEach robbable;

near_animals = false;
near_vehicles = false;
near_objects = false;
near_evidence = false;
near_slaves = false;
near_spikes = false;

hostage1 = objnull;
VIPtarget = objnull;
assveh = objnull;
ass_action = -1;

canceltime              = false;
gc_fireballed = false;

next_satcam_time = 0;
next_jailcam_time = 0;
next_civcam_time = 0;

SKILL_FISHING = 0;
SKILL_HUNTING = 0;
SKILL_GATHERING = 0;
SKILL_MINING = 0;
SKILL_MANUFACTURING = 0;
SKILL_LOCKPICKING = 0;
SKILL_ROBBERY = 0;
GC_Skills = ["SKILL_FISHING","SKILL_HUNTING","SKILL_GATHERING","SKILL_MINING","SKILL_MANUFACTURING","SKILL_LOCKPICKING","SKILL_ROBBERY"];

GC_LastPos = [0,0,0];

hostageaction = -1;
workplacejob_hostage_break = 1;

fvspam = false;

paraspawned = false;

life_objects = [];