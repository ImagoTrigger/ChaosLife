if(local server and !local player)then{dedicatedServer = true};
if(local server and local player)then{hostedServer = true};

playerstringarray = ["Civ1","Civ2","Civ3","Civ4","Civ5","Civ6","Civ7","Civ8","Civ9","Civ10","Civ11","Civ12","Civ13","Civ14","Civ15","Civ16","Civ17","Civ18","Civ19","Civ20","Civ21","Civ22","Civ23","Civ24","Civ25","Civ26","Civ27","Civ28","Civ29","Civ30","Civ31","Civ32","Civ33","Civ34","Civ35","Civ36","Civ37","Civ38","Civ39","Civ40","Cop1","Cop2","Cop3","Cop4","Cop5","Cop6","Cop7","Cop8","Cop9","Cop10","Cop11","Cop12","Cop13","Cop14","Cop15","Cop16","Cop17","Cop18","Cop19","Cop20","ChaosBot"];

for [{_i=0}, {_i < (count playerstringarray)}, {_i=_i+1}] do {
  if (isNil (playerstringarray select _i)) then {
    call compile format["%1 = objNull;", (playerstringarray select _i)];
  };
};

playerarray = [civ1,civ2,civ3,civ4,civ5,civ6,civ7,civ8,civ9,civ10,civ11,civ12,civ13,civ14,civ15,civ16,civ17,civ18,civ19,civ20,civ21,civ22,civ23,civ24,civ25,civ26,civ27,civ28,civ29,civ30,civ31,civ32,civ33,civ34,civ35,civ36,civ37,civ38,civ39,civ40,cop1,cop2,cop3,cop4,cop5,cop6,cop7,cop8,cop9,cop10,cop11,cop12,cop13,cop14,cop15,cop16,cop17,cop18,cop19,cop20,chaosbot];
civstringarray    = ["Civ1","Civ2","Civ3","Civ4","Civ5","Civ6","Civ7","Civ8","Civ9","Civ10","Civ11","Civ12","Civ13","Civ14","Civ15","Civ16","Civ17","Civ18","Civ19","Civ20","Civ21","Civ22","Civ23","Civ24","Civ25","Civ26","Civ27","Civ28","Civ29","Civ30","Civ31","Civ32","Civ33","Civ34","Civ35","Civ36","Civ37","Civ38","Civ39","Civ40"];
civarray = [civ1,civ2,civ3,civ4,civ5,civ6,civ7,civ8,civ9,civ10,civ11,civ12,civ13,civ14,civ15,civ16,civ17,civ18,civ19,civ20,civ21,civ22,civ23,civ24,civ25,civ26,civ27,civ28,civ29,civ30,civ31,civ32,civ33,civ34,civ35,civ36,civ37,civ38,civ39,civ40];
copstringarray    = ["Cop1","Cop2","Cop3","Cop4","Cop5","Cop6","Cop7","Cop8","Cop9","Cop10","Cop11","Cop12","Cop13","Cop14","Cop15","Cop16","Cop17","Cop18","Cop19","Cop20"];
coparray = [cop1,cop2,cop3,cop4,cop5,cop6,cop7,cop8,cop9,cop10,cop11,cop12,cop13,cop14,cop15,cop16,cop17,cop18,cop19,cop20];

rolenumber = 0;

for [{_i=0}, {_i < (count playerarray)}, {_i=_i+1}] do {
  call compile format["if ((playerarray select %1) == player) then {rolenumber = (%1 + 1);}", _i];
};

role = player;

if (player in coparray) then {
  iscop          = true;
  isciv          = false;
  rolecop        = 1;
  sidenumber     = rolenumber - civscount;
  rolestring     = format["Cop%1", sidenumber];
};

if (player in civarray) then {
  isciv          = true;
  iscop          = false;
  rolecop        = 0;
  sidenumber     = rolenumber;
  rolestring     = format["Civ%1", sidenumber];
};

if (profileName == "ChaosBot") then {
  isciv          = false;
  iscop          = false;
  rolecop        = 0;
  sidenumber     = 420;
  rolestring     = "ChaosBot";	
};