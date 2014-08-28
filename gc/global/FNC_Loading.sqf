GC_Cfg_Var_UsedLoadingMessages = [];

GC_ChaosArray = [
  "Iterating Chaos Array",
  "Loading ""Vroom"" Sounds",
  "Inserting Chaos Generator",
  "Downloading Weather Data",
  "Locating Misplaced Calculations",
  "Fabricating Imaginary Infrastructure",
  "Establishing Link with Internet Police",
  "Activating Anticheat System",
  "Analyzing User Scripts",
  "Script Tracker Enabled",
  "Taking off every Zig",
  "Manipulating trend analysis vector",
  "Correlating variances",
  "Gleaning information",
  "Not actually doing anything",
  "Alphabetizing numerals",
  "Mating animals for more animals",
  "Indexing drops of water in ocean",
  "Sacrificing a goat",
  "Querying non-sequential sequences",
  "Initializing polysyllabic hyperverbosity",
  "Enhancing",
  "Escalating threat level",
  "Determining mass of Higgs-Boson",
  "Generating aesthetics",
  "Printing ASCII characters to screen",
  "Reticulating splines",
  "Waking up NPCs",
  "Evaporating watermark",
  "Sending personal data to NSA",
  "Waxing Quixotic",
  "Surgically implanting heads-up display",
  "Storing DNA for respawn",
  "Filling SCUBA tanks",
  "Looking for hookahs",
  "Running out of gum",
  "Building up Steam",
  "Blinking battle eyes",
  "Checking the gravitational constant",
  "Moving the SatCam into position",
  "Optimizing frame rate",
  "Cloning sheep for hunting grounds",
  "Counting backwards from infinity",
  "Deterministically simulating the future",
  "Testing for perfection",
  "Salting sea water",
  "Hiding treasure",
  "Teaching snakes how to dodge",
  "Heating up your GPU",
  "Signing payroll checks"
];

GC_Cfg_RandomLoadingMessage = {
    private ["_current"];
    _current = floor(random (count GC_ChaosArray));

  while {_current in GC_Cfg_Var_UsedLoadingMessages} do {
    _current = floor(random (count GC_ChaosArray));
  };

  GC_Cfg_Var_UsedLoadingMessages set [count GC_Cfg_Var_UsedLoadingMessages, _current];
  format["%1", GC_ChaosArray select _current];
};
