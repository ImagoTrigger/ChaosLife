if (isnil "gc_diaryloaded") then {gc_diaryloaded = false;};
if (gc_diaryloaded) exitWith {};

GC_RulesReadArray = [];
GC_RulesLink = {
	private ["_rec","_sub"];
	_rec = _this select 0;
	_sub = _this select 1;
    	processDiaryLink createDiaryLink [_sub,_rec , ""];
    	if (!(_rec in GC_RulesReadArray)) then {
    		GC_RulesReadArray = GC_RulesReadArray + [_rec];
    	};
    	if (isnil "GC_RulesRead" and count GC_RulesReadArray >= 29) then {
    		playsound "scoringsfx";
    		GC_RulesRead = 1;
    		["GC_RulesRead",GC_RulesRead] call ClientSaveVar;
    		["GC_Good",["Chaos experience awarded","You've read all of the rules!","+50"]] spawn bis_fnc_showNotification;
    	};
};

// Server Rules
player createDiarySubject ["serverRules", "Server Rules"];

Diaryrec30 = player createDiaryRecord ["serverRules",
	[
		"New Life Rule",
    "A wanted civilian's warrants are cleared if:<br />
  -- They are killed by another player.<br />
A wanted civilian's warrants are NOT cleared if:<br />
  -- They commit suicide.
  	<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec15,""civs""] call GC_RulesLink'>READ MORE</execute></b></t>
  "
	]
];


Diaryrec29 = player createDiaryRecord ["serverRules",
	[
		"Crime Free Zone",
		"- The Green zones marked on the map are Crime Free Zones.<br />
- You may NOT shoot into or out of these zones.<br />
- You may NOT commit any crimes in these zones. (Robbery, theft, etc)<br />
- You may NOT Kill anyone in these zones.<br />
- Cops MAY Stun/Restrain/Arrest wanted criminals in Crime Free Zones.<br />
- Cops MAY Shoot down air vehicles attempting a jail break.<br />
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec30,""serverRules""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec28 = player createDiaryRecord ["serverRules",
	[
		"Deathmatching",
		"- Killing other players (civilians or cops) for no reason is considered deathmatching.<br />
- Intentional deathmatching with the intent to compensate the victim is NOT allowed.<br />
- Killing an unarmed person is deathmatching as they are of no danger (with the exception of Gang Areas.)<br />
- Being a wanted criminal does NOT give you the right to kill all cops.<br />
- If you are a wanted criminal, you are only allowed to kill cops that are attempting to PURSUE or otherwise INTERACT with you.<br />
- You cannot pay or bribe someone to kill another person (hitman/assassination).<br />
- Terrorists with a Terror Pact are NOT bound by the Deathmatching/Compensation rules.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec29,""serverRules""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];


Diaryrec27 = player createDiaryRecord ["serverRules",
	[
		"Compensation",
		"- If a player (civilian or cop) is accidentally killed for no reason or deathmatched, the killer must compensate the victim $50,000.<br />
- If a player refuses to obey these rules and provide proper compensation, inform a server admin and action will be taken.<br />
- Terrorists with a Terror Pact are NOT bound by the Deathmatching/Compensation rules.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec28,""serverRules""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec26 = player createDiaryRecord ["serverRules",
	[
		"Music / Global VON",
		"- Music can be played in Direct Chat or Vehicle Chat ONLY!<br />
- Playing music in Global or Side chat is considered spamming and will result in a kick/ban.<br />
- Global VON is for necessary communication only and extended misuse will result in a kick/ban.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec27,""serverRules""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec25 = player createDiaryRecord ["serverRules",
	[
		"Advertising",
		"- Giving out Non Global Chaos Gaming Teamspeak, Game Server or Website information is a bannable offense!
		<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec26,""serverRules""] call GC_RulesLink'>READ MORE</execute></b></t>
		"
	]
];

Diaryrec24 = player createDiaryRecord ["serverRules",
	[
		"Bugs / Glitches / Cheats",
		"- Players may NOT take advantage of any bugs or glitches in the mission. <br />
- Players may NOT use any hacks, scripts or malicious 3rd party programs.<br />
- Players doing any of the above will be ** PERMANENTLY BANNED **!
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec25,""serverRules""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

gc_diarylink = createDiaryLink ["serverRules",Diaryrec24,""];

// Civilian Rules and Guide
player createDiarySubject ["civs", "Civilian Rules"];

Diaryrec23 = player createDiaryRecord ["civs",
	[
		"Civilian Terrorism Rules",
		"- You Must have a Terror Pact to commit any terrorist acts.<br />
- Terrorists with a Terror Pact are NOT bound by the Deathmatching/Compensation rules.<br />
- Terrorists are individuals and have no gang ties or affiliations.<br />
- Terrorists may NOT crash air vehicles into major buildings/shops/factories/spawns or checkpoints.<br />
- Terrorists MAY be shot on sight by Civilians or Cops.<br />
- When you purchase a Terror Pact you will be given a Terrorist uniform and 5 wanted stars automatically.<br />
- Terror Pacts are removed upon death, and must be repurchased for continued terror access and acts.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec3,""cops""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec22 = player createDiaryRecord ["civs",
	[
		"Civilian Robbery Rules",
		"- You Must state verbally or via chat your intentions of robbing.<br />
- If a robbery victim doesn't comply you MAY kill them.<br />
- You Must state the player(s) name(s) you are attemping to rob. <br />
- You Must give appropriate time (20 seconds) for the victim(s) to react and complete said tasks. <br />
- If a player reports a crime you've committed you MAY kill them (Snitches get Stitches).
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec23,""civs""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec21 = player createDiaryRecord ["civs",
	[
		"Civilian Gang Rules",
		"- Maximum gang size is 7<br />
- Capturing enemy gang areas is an automatic declaration of war.<br />
- Declaring gang wars must be written over global chat, stating the Warring gangs' names.<br />
- When in a gang war, you may NOT kill an unarmed rival gang member (Rule is void if inside Gang Areas or Weapons Factory).<br />
- Any players within a Gang Area aside from fellow gang members may be killed regardless of warring status or area ownership.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec22,""civs""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec20 = player createDiaryRecord ["civs",
	[
		"Civilian Prostitution Rules",
		"- When buying prostitutes, they must all be transported by vehicle to their destination.<br />
- You must be in the vehicle while prostitutes are being transported.<br />
- You may NOT put prostitutes in places that cannot be reached on foot.<br />
- You may NOT run prostitutes to their destination on foot.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec21,""civs""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec19 = player createDiaryRecord ["civs",
	[
		"Civilian Aviation Laws",
		"- Civilians must stay above 200m altitude over town<br />
- Civilians flying under 200m altitude over town may be shot down by police AFTER a warning.<br />
- Civilian landing zones are marked on the map.<br />
- Civilians landing at non-landing points will be arrested.<br />
- Civilians must have an Air Vehicle Licence when flying.<br />
- If asked by police for an Air Vehicle Licence check, you must land at the requested landing zone immediately.<br />
- Civilians that fail to land for an Air Vehicle Licence check may be shot down.<br />
- If you fly/hover over the jail, you may be shot down without warning.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec20,""civs""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec18 = player createDiaryRecord ["civs",
	[
		"Civilian Boating Laws",
		"-Cops may request that any civilian operating a water vehicle beach their boat in order to submit to a boating license search<br />
-Any contraband or incrimenating evidence  found during the boating license search may not be used against the civilian.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec19,""civs""] call GC_RulesLink'>READ MORE</execute></b></t>
"

	]
];

Diaryrec17 = player createDiaryRecord ["civs",
	[
		"Civilian Traffic Laws",
		"-The speed limit is 60.<br />
-Civilian Must drive on the right side of the road.<br />
-At night, Civilians must have their headlights on.<br />
-When being pulled over, you must pull over or your can be wanted for evading. (No matter if you think the cop is right/wrong).
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec18,""civs""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];


Diaryrec15 = player createDiaryRecord ["civs",
	[
		"Civilian Rules",
		"- Civilians may NOT carry/use stun ammunition.<br />
- Civilians may NOT suicide to avoid arrest.<br />
- Civilians may NOT disconnect/reconnect to avoid arrest.<br />
- Civilians may NOT direct or shoot any type of explosive weapon or crash air vehicles near important buildings. (Factories, Bank, Hospital, Black Market, Cop Base).<br />
- Civilians may NOT drive inside/through the paved spawn area (marked by concrete blocks).<br />
- Civilians must park their vehicles in designated car parks or they will be impounded.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec17,""civs""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];


// Cops Rules and Guide
player createDiarySubject ["cops", "Police Rules"];

Diaryrec14 = player createDiaryRecord ["cops",
	[
		"Ticket Amounts and Jail Times",
		"- Driving without headlights on - $1000<br />
- Illegal Parking - $1000<br />
- Driving Over the speed limit - $2000<br />
- Driving Recklessly - $2500<br />
- Property Damage - $2500<br />
- Driving Off-Road - $2500<br />
- Carrying Legal Handguns unholstered *inside town* - $1000<br />
- Carrying Legal Rifles *inside town* - $5000<br />
- Unlicenced handgun - $10,000 *Confiscate weapon*<br />
- Unlicenced semi-automatic rifle - $15,000 *Confiscate weapon*<br />
- Unlicenced fully automatic rifle or sub-machine gun - $25,000 *Confiscate weapon*<br /><br />

- Driving without a licence - 1 Minute<br />
- Refusing to Pay Ticket - 1 Minute<br />
- Attempted Robbery/Theft - 1 Minute<br />
- Prostitution - 1 Minute per Prostitute.<br />
- Kidnapping - 2 Minutes<br />
- Evading Police - 2 Minute<br />
- Jailbreak - Previous Jail Sentence plus 2 Minutes<br />
- Attempted Murder - 2 Minute<br />
- Robbery/Theft - 2 Minutes<br />
- Hunting/Fishing without a licence - 3 Minute<br />
- Processing Alchohol without a licence - 3 Minute <br />
- Smuggling/Possession of illegal weapons - 3 Minutes<br />
- Flying without a licence - 3 Minute<br />
- Smuggling Drugs - 3 Minutes<br />
- Aiding in Jail Break - 3 Minute<br />
- Murder/Manslaughter - 4 Minutes<br />
- Murder/Manslaughter of a cop - 6 Minutes<br />
- Terrorism - 15 Minutes<br /><br />

**Max Sentence 15 Mins Total**<br />
**You may NOT ticket a civlian being arrested**
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec2,""GC Information""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec13 = player createDiaryRecord ["cops",
	[
		"Illegal Weapons and Vehicles",
"Any Sniper rifle (LRR, EBR)
Any Light machine gun (LMG)
Any Launcher (RPG, Titan)
Any Grenade
Any Mine
Any Bomb<br /><br />
Anyone in possession of these weapons may be arrested.<br />
Anyone driving armed vehicles or drones may be arrested or shot on sight!
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec14,""cops""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec12 = player createDiaryRecord ["cops",
	[
		"Checkpoints",
		"Man made Checkpoints :<br />
-Man made Checkpoints Must be marked on the map.<br />
-Man made Checkpoints Must be manned by at least 2 cops or removed/lowered.<br />
-Man made Checkpoints are NOT allowed within 2 blocks of bank or infront of bank.<br />
-Cops may search all civilians and vehicles that request to pass the checkpoint.<br />
-Cops may warrant the arrest for all civilians who attempt to bypass the checkpoint.<br /><br />

Static Checkpoints :<br />
-Static Checkpoints MAY be manned by 1 or more cops.<br />
-Static Checkpoints are hostile territory, civilans may freely engage cops.<br />
-Cops may search all civilians and vehicles that request to pass the checkpoint.<br />
-Cops may check for proper licensing and passports.<br />
-Alcohol may be transported through checkpoints with an alcohol license.<br />
-Cops may NOT charge fees or tolls for passage.<br />
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec13,""cops""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec11 = player createDiaryRecord ["cops",
	[
		"Crime Scenes",
		"-Cops may declare any place under attack or being robbed a crime scene.<br />
-Cops may restrain and search all civilians and vehicles within the general vicinity.<br />
-Crime scenes may ONLY last 5 minutes maximum and all innocent civilians must be set free and healed if injured.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec12,""cops""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec10 = player createDiaryRecord ["cops",
	[
		"Bank",
		"-Any Civilian found on the 2nd floor or roof of the bank may be arrested for attempted robbery.<br />
-After a robbery, cops may declare the bank a crime scene *Must be said over global*.<br />
-Cops are NOT allowed to setup checkpoints within 2 blocks of bank.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec11,""cops""] call GC_RulesLink'>READ MORE</execute></b></t>
"

	]
];

Diaryrec9 = player createDiaryRecord ["cops",
	[
		"Raiding Procedure",
		"-All Raids are to be conducted with 2+ cops.<br />
-Once commenced with 2+ cops, the 2+ rule no longer applies due to possible casualties.<br />
-Cops must first announce their presence before entering the area being raided and inform all occupants to come out and put their hands up.<br />
-Once 1 minute has been given for all to surrender, cops may enter the area.<br />
-All unarmed civilians are to be restrained then released after raid is done.<br />
-All armed civilians not surrendering may be handled with lethal force.<br />
-Raids may last up to 10 mins, once 10 mins has passed all cops must leave the area immediately.<br />
-Cops must wait 5 minutes after completing a raid before beginning another raid.
-Gang Areas can NOT be entered without following the Raiding Procedure!<br />
-If an officer is in pursuit of a criminal prior to them entering a Gang Area, The officer may enter but ONLY to arrest/search/detain the civilian(s) they were in pursuit of.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec10,""cops""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec8 = player createDiaryRecord ["cops",
	[
		"Arresting Procedure",
		"1. Restrain subject.<br />
2. Disarm subject via Disarm button.<br />
3. Heal Subject if wounded.<br />
4. Check all warrants, and add any new charges before arrest for accurate jail time.<br />
5. Explain to them the reason for being arrested.<br />
6. Arrest subject for the appropriate time according to the Jail Times List.<br />
7. Impound civilian's vehicle.<br /><br />

**The arrest process should last no longer than 3 minutes**<br />
**All innocent civilians must be released and compensated for any legal weapons confiscated or lost due to stun**<br />
**Suspected Bank Robbers should be checked for money prior to arrest**
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec9,""cops""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec7 = player createDiaryRecord ["cops",
	[
		"Searches",
		"Cops can search a civilian and/or their vehicle if:<br />
--The civilian is wanted for any reason OTHER than a minor traffic violation.<br />
--The civilian has been seen committing a crime.<br />
--The civilian is seen with a weapon.<br />
--The civilian is at an active checkpoint.<br />
--The civilian is near a crime scene, and the police are unsure of who commited the crime.<br />
--The civilian is outside of their vehicle at a drug seller.<br />
--The civilian is following an officer for an extended length of time, either in a vehicle or on foot.<br /><br />

Cops can NOT search a civilian and/or their vehicle:<br />
--During a routine traffic stop.<br />
--Based on a hunch or probable cause. Probable cause doesn't exist in this server.<br />
--Based on the possibility of the car occupants being prostitutes unless the car is within a Work Area.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec8,""cops""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec6 = player createDiaryRecord ["cops",
	[
		"Traffic Stops",
		"A Cop may initiate a traffic stop if:<br />
--The civilian is seen violating traffic laws, if they have commited a crime, or within Work Area 1,2 or 3.<br />
--The civilian is driving a similar vehicle that was reported stolen, the officer may ONLY walk up to the vehicle and check the vehicle information. They may NOT request the driver to put their hands up OR search the driver, or their vehicle, unless the vehicle is determined to be stolen (in which case the normal process and rules apply for handling criminals).<br /><br />

A Cop may Not initiate a traffic stop if:<br />
--The civilian is not wanted.<br />
--The civilian has not broken any traffic laws.
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec7,""cops""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec5 = player createDiaryRecord ["cops",
	[
		"Cop Traffic Laws",
		"-Cops Must follow the speed limits.<br />
- The speed limit is 60.<br />
- Cops should drive on the right side of the road.<br />
- At night, Cops should have their headlights on.<br />
- Cops May only violate traffic laws if they are in Pursuit, Responding to a 911 call or Bank robbery - but must have their sirens on.<br />
* Failure to follow traffic laws may result in removal from cop side or other actions *
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec6,""cops""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec4 = player createDiaryRecord ["cops",
	[
		"Cop Rules",
		"-Cops Must holster their pistol or lower lethal weapons by doubletapping ctrl when not in use.<br />
-Cops Must always take civilian weapons as evidence, cops caught using civilian weapons will recieve disciplinary actions.<br />
-Cops MAY impound any illegally parked vehicles.<br />
-Cops May NOT stun/kill other cops.<br />
-Cops May NOT steal civilian or terrorist vehicles.<br />
-Cops May NOT give/sell police weapons/vehicles to civilians or terrorists.<br />
-Cops May NOT remove other cops' warrants.<br />
-Cops MAY use lethal weapons to disable the tires on cars of WANTED criminals ONLY. If the civilian is inadvertantly killed, compensation rules apply.<br />
-Cops MAY use lethal force on Terrorists (civs with terrorist skin) on sight!
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec5,""cops""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

Diaryrec3 = player createDiaryRecord ["cops",
	[
		"To Be a Cop",
		"-You Must speak English!<br />
-You Must have a Microphone and use it.<br />
-You Must be on GC Teamspeak (TS.GCG.IO) and respond to admin pokes.<br /><br />

**Failure to follow these rules will result in removal from Cop side (or worse!)**
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec4,""cops""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

// GC Information
player createDiarySubject ["GC Information", "GC Information"];

Diaryrec2 = player createDiaryRecord ["GC Information",
	[
		"GC Information",
		"<b>Website:</b> www.globalchaosgaming.net<br /><br />
<b><u>Teamspeak Info</u></b><br />
IP: ts.gcg.io<br />
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec1,""Server Admins""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

// Server Admins
player createDiarySubject ["Server Admins", "Server Admins"];

Diaryrec1 = player createDiaryRecord ["Server Admins",
	[
		"Server Admins",
		"<b>Founder / Owner -</b> Foster[GC]<br />
<b>Head Admin -</b> Durandal[GC]<br />
<b>Head Admin -</b> Amerine[GC]<br />
<b>Development -</b> DOA[GC]<br />
<b>Admin -</b> Romans[GC]<br />
<b>Admin -</b> Predreus[GC]<br />
<b>Admin -</b> Mash[GC]<br />
<b>Admin -</b> Zargero[GC]<br />
<b>Admin -</b> Danta96[GC]<br />
<b>Admin -</b> GhostStalker[GC]<br />
<b>Moderator -</b> Jesus[GC]<br />
<B>Moderator/Wannabe Dev. -</b> Floppy Pancakes[GC]<br />
<br/><br/><t shadowColor='#cc0000' underline='1' align='center' valign='bottom' font='LucidaConsoleB'>Read and understood? Then click: - </t> <t align='center' valign='bottom' color='#0000ff'><b><execute expression='[Diaryrec24,""serverRules""] call GC_RulesLink'>READ MORE</execute></b></t>
"
	]
];

gc_diaryloaded = player diarySubjectExists "Server Admins";
