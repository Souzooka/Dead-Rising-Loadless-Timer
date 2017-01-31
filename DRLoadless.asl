/* Pointers found and code written by Souzooka.
Load removal and autosplitting. All achievements/etc. not supported.
*/

state("DeadRising", "SteamPatch3")
{
 	uint currentRoomValue : 0x01945F70, 0x40;
   	uint loadingRoomValue : 0x01945F70, 0x48;
	ushort gameStatus : 0x01945F70, 0x88;

	uint brockHealth : 0x01CF2620, 0x118, 0x12EC;
	float frankX : 0x01CF2620, 0xC8, 0x40;

	ushort frankWatchTime : 0x01D18C80, 0x1f94;
	bool inCutsceneOrLoad : 0x01D18C80, 0x2338;

	ushort campaignProgress : 0x01944DD8, 0x20DC0, 0x150;
	byte bombsCollected : 0x1944DD8, 0x20DC0, 0x848D;
	
	uint inGameTimer : 0x1946FC0, 0x2F058, 0x198;
	byte caseFileOpen : 0x1946FC0, 0x2F058, 0x184;
	byte caseMenuOpen : 0x1946FC0, 0x2F058, 0x182;
	uint mainMenuID : 0x1946FC0, 0x2F058, 0x38;

	//Zombie Genocider
	uint kills : 0x1959EA0, 0x3B0;

	//Max Level
	uint level : 0x1946950, 0x68;
}
	
startup
{
	vars.getRunStarted = 0;
	
	settings.Add("splits", false, "All Splits");
	
	settings.Add("misc", false, "Miscellaneous Splits", "splits");
	settings.Add("shortcutpw", false, "Shortcut (PP to WP)", "misc");
	settings.Add("shortcutwp", false, "Shortcut (WP to PP)", "misc");
	
	settings.Add("72Hour", false, "72 Hour Splits", "splits");
	
	settings.Add("caseSplits", false, "Split on Case End (all cases)", "72Hour");
	
	settings.Add("case1", false, "Case 1 Splits", "72Hour");
	settings.Add("prologue", false, "Prologue", "case1");
	
	settings.Add("case2", false, "Case 2 Splits", "72Hour");
	settings.Add("steven", false, "Steven", "case2");
	settings.Add("firstaid", false, "First Aid", "case2");
	
	settings.Add("case4", false, "Case 4 Splits", "72Hour");
	settings.Add("elevator4", false, "Elevator", "case4");
	settings.Add("warehouse", false, "Warehouse", "case4");
	settings.Add("wonderlandPlaza", false, "Wonderland Plaza", "case4");
	
	settings.Add("case5", false, "Case 5 Splits", "72Hour");
	settings.Add("northPlaza", false, "North Plaza", "case5");
	settings.Add("leisurePark", false, "Leisure Park", "case5");
	settings.Add("paradisePlaza5", false, "Paradise Plaza", "case5");
	settings.Add("elevator5", false, "Elevator", "case5");
	
	settings.Add("case7", false, "Case 7 Splits", "72Hour");
	settings.Add("paradisePlaza7", false, "Paradise Plaza", "case7");
	settings.Add("allBombs", false, "Bombs", "case7");
	settings.Add("bomb1", false, "First Bomb", "allBombs");
	settings.Add("bomb2", false, "Second Bomb", "allBombs");
	settings.Add("bomb3", false, "Third Bomb", "allBombs");
	settings.Add("bomb4", false, "Fourth Bomb", "allBombs");
	settings.Add("bomb5", false, "Fifth Bomb", "allBombs");
	
	settings.Add("case8", false, "Case 8 Splits", "72Hour");
	settings.Add("paradisePlaza8", false, "Paradise Plaza", "case8");
	
	settings.Add("72HourEnd", false, "72 Hour Mode End", "72Hour");
	
	settings.Add("overtime", false, "Overtime Splits", "splits");
	settings.Add("supplies", false, "Supplies", "overtime");
	settings.Add("queens", false, "Queens", "overtime");
	settings.Add("tunnel", false, "Tunnel", "overtime");
	settings.Add("tank", false, "Tank", "overtime");
	settings.Add("brock", false, "Brock", "overtime");

	settings.Add("genocider", false, "Zombie Genocider", "splits");

	settings.Add("kills10k", false, "10,000 kills", "genocider");
	settings.Add("kills20%", false, "10,719 kills", "genocider");
	settings.Add("kills20k", false, "20,000 kills", "genocider");
	settings.Add("kills40%", false, "21,438 kills", "genocider");
	settings.Add("kills30k", false, "30,000 kills", "genocider");
	settings.Add("kills60%", false, "32,157 kills", "genocider");
	settings.Add("kills40k", false, "40,000 kills", "genocider");
	settings.Add("kills80%", false, "42,876 kills", "genocider");
	settings.Add("kills50k", false, "50,000 kills", "genocider");
	settings.Add("killsFinal", false, "53,594 kills", "genocider");

	settings.Add("maxLevel", false, "Max Level", "splits");

	settings.Add("level5", false, "Level 5", "maxLevel");
	settings.Add("level10", false, "Level 10", "maxLevel");
	settings.Add("level15", false, "Level 15", "maxLevel");
	settings.Add("level20", false, "Level 20", "maxLevel");
	settings.Add("level25", false, "Level 25", "maxLevel");
	settings.Add("level30", false, "Level 30", "maxLevel");
	settings.Add("level35", false, "Level 35", "maxLevel");
	settings.Add("level40", false, "Level 40", "maxLevel");
	settings.Add("level45", false, "Level 45", "maxLevel");
	settings.Add("level50", false, "Level 50", "maxLevel");

	
	settings.Add("timingMethods", true, "Timing Method");
	
	settings.Add("loadless1", true, "Loadless", "timingMethods");
	settings.Add("loadless2", false, "Loadless + Menuless", "timingMethods");
	
	settings.SetToolTip("shortcutpw", "Splits when traveling to Wonderland Plaza from Paradise Plaza.");
	settings.SetToolTip("shortcutwp", "Splits when traveling to Paradise Plaza from Wonderland Plaza.");
	
	settings.SetToolTip("caseSplits", "Splits after a case has been filled into the case file.");
	
	settings.SetToolTip("prologue", "Splits after escaping Entrance Plaza.");
	
	settings.SetToolTip("steven", "Splits after killing Steven.");
	settings.SetToolTip("firstaid", "Splits after collecting first aid.");
	
	settings.SetToolTip("elevator4", "Splits after entering the Warehouse in Case 4.");
	settings.SetToolTip("warehouse", "Splits after entering Paradise Plaza in Case 4.");
	settings.SetToolTip("wonderlandPlaza", "Splits after entering North Plaza in Case 4.");
	
	settings.SetToolTip("northPlaza", "Splits after entering Leisure Park in Case 5.");
	settings.SetToolTip("leisurePark", "Splits after entering Paradise Plaza in Case 5.");
	settings.SetToolTip("paradisePlaza5", "Splits after entering the Warehouse in Case 5.");
	settings.SetToolTip("elevator5", "Splits after entering the Rooftop in Case 5.");
	
	settings.SetToolTip("paradisePlaza7", "Splits after entering the Maintenance Tunnels in Case 7.");
	settings.SetToolTip("bomb1", "Splits after collecting first bomb.");
	settings.SetToolTip("bomb2", "Splits after collecting second bomb.");
	settings.SetToolTip("bomb3", "Splits after collecting third bomb.");
	settings.SetToolTip("bomb4", "Splits after collecting fourth bomb.");
	settings.SetToolTip("bomb5", "Splits after collecting fifth bomb.");
	
	settings.SetToolTip("paradisePlaza8", "Splits after entering Leisure Park in Case 8.");
	
	settings.SetToolTip("72HourEnd", "Splits when entering the hideout after finishing Case 8.");
	
	settings.SetToolTip("supplies", "Splits after giving Isabella supplies.");
	settings.SetToolTip("queens", "Splits after giving Isabella 10 queens.");
	settings.SetToolTip("tunnel", "Splits after entering jeep at the end of tunnel.");
	settings.SetToolTip("tank", "Splits when tank's HP is 0.");
	settings.SetToolTip("brock", "Splits when Brock's HP is 0.");
	
	settings.SetToolTip("loadless1", "Legal official timing method which pauses the timer during loads and cutscene.");
	settings.SetToolTip("loadless2", "Unofficial timing method which, along with pausing during loads and cutscenes, also pauses during menus (not the pause menu).");
	
}

reset
{
//	Resets when the title menu is entered.
	if (current.mainMenuID == 264){
		vars.getRunStarted = 0;
		return true;
	}		
}

exit
{
	// Just in case
	vars.getRunStarted = 0;
	vars.paradisePlaza8Split = 0;
}

start
{
//	For runs starting from the main menu, starts on new game. Also starts Case 5 (which doesn't start with a case file screen)
	if (current.inGameTimer == 3888000 || current.inGameTimer == 12528000 || current.campaignProgress == 270)
		{return current.mainMenuID == 3;}

//	Case 2, 4, 7, 8 Start
	if ((current.campaignProgress == 160 || current.campaignProgress == 230 || current.campaignProgress == 320 || current.campaignProgress == 350) && current.inCutsceneOrLoad == false && current.mainMenuID == 3 && vars.getRunStarted == 0) {
		vars.getRunStarted = 1;
		return true;
	}
}

update
{
	// In case of manual reset by runner
	if (current.mainMenuID == 264 && vars.getRunStarted == 1) {
	vars.paradisePlaza8Split = 0;
	vars.getRunStarted = 0;
	}
}

isLoading
{

	if (settings["loadless1"]) {
		if (current.inCutsceneOrLoad == true && current.mainMenuID != 197383 && current.mainMenuID != 519 && current.mainMenuID != 262919) {
			return true;
		}
	}

	if (settings["loadless1"] && (current.level != 50 || !(settings["maxLevel"]))) {
		if ((current.caseMenuOpen == 2 || current.caseMenuOpen == 19) && (current.campaignProgress == 160 || current.campaignProgress == 230 || current.campaignProgress == 320 || current.campaignProgress == 350)) {
			return true;
		}
	}
	
	if (settings["loadless2"] && (current.inCutsceneOrLoad || current.caseMenuOpen > 1)) {
	return true;
	}
}

split
{
// Shortcut (PP to WP)
	if (settings["shortcutpw"] && current.currentRoomValue == 512 && current.loadingRoomValue == 768 && old.loadingRoomValue != 768) {
		return true;
	}
// Shortcut (WP to PP)
	if (settings["shortcutwp"] && current.currentRoomValue == 768 && current.loadingRoomValue == 512 && old.loadingRoomValue != 512) {
		return true;
	}
// Case Splits (All cases)
	if (settings["caseSplits"] && old.caseMenuOpen == 2 && current.caseMenuOpen == 0 && current.campaignProgress != 280 && current.campaignProgress != 160 && current.campaignProgress != 230 && current.campaignProgress != 320 && current.campaignProgress != 350) {
		return true;
	}
//	Prologue (Case 1)
	if (settings["prologue"] && current.frankWatchTime >= 11100 && current.frankWatchTime <= 11700) {
		if (current.campaignProgress == 65 && current.inCutsceneOrLoad == true && old.inCutsceneOrLoad == false) {
			return true;
		}	
	}
// Steven (Case 2)
	if (settings["steven"] && current.campaignProgress == 190 && current.brockHealth == 0 && old.brockHealth != 0)
		{return true;}
// First-Aid (Case 2)
	if (settings["firstaid"] && current.campaignProgress == 215 && old.campaignProgress == 210)
		{return true;}	
// Elevator (Case 4)
	if (settings["elevator4"] && current.currentRoomValue == 535 && current.loadingRoomValue == 534 && old.loadingRoomValue != 534 && current.campaignProgress >= 230 && current.campaignProgress < 270) {
		return true;
	}
// Warehouse (Case 4)
	if (settings["warehouse"] && current.currentRoomValue == 534 && current.loadingRoomValue == 512 && old.loadingRoomValue != 512 && current.campaignProgress >= 230 && current.campaignProgress < 270) {
		return true;
	}
// Wonderland Plaza (Case 4)
	if (settings["wonderlandPlaza"] && current.currentRoomValue == 768 && current.loadingRoomValue == 1024 && old.loadingRoomValue != 1024 && current.campaignProgress >= 230 && current.campaignProgress < 270) {
		return true;
	}
// North Plaza (Case 5)
	if (settings["northPlaza"] && current.currentRoomValue == 1024 && current.loadingRoomValue == 1792 && old.loadingRoomValue != 1792 && current.campaignProgress >= 270 && current.campaignProgress < 320) {
		return true;
	}
// Leisure Park (Case 5)
	if (settings["leisurePark"] && current.currentRoomValue == 1792 && current.loadingRoomValue == 512 && old.loadingRoomValue != 512 && current.campaignProgress >= 270 && current.campaignProgress < 320) {
		return true;
	}
// Paradise Plaza (Case 5)
	if (settings["paradisePlaza5"] && current.currentRoomValue == 512 && current.loadingRoomValue == 534 && old.loadingRoomValue != 534 && current.campaignProgress >= 270 && current.campaignProgress < 320) {
		return true;
	}
// Elevator (Case 5)
	if (settings["elevator5"] && current.currentRoomValue == 534 && current.loadingRoomValue == 535 && old.loadingRoomValue != 535 && current.campaignProgress >= 270 && current.campaignProgress < 320) {
		return true;
	}
// Paradise Plaza (Case 7)
	if (settings["paradisePlaza7"] && current.currentRoomValue == 512 && current.loadingRoomValue == 1536 && old.loadingRoomValue != 1536 && current.campaignProgress >= 320 && current.campaignProgress < 350) {
		return true;
	}
// Bombs (Case 7)
if (current.bombsCollected != old.bombsCollected)
	{
		switch ((byte)current.bombsCollected)
		{
			case 1:
				if (settings["bomb1"])
				{return true;}
				break;
			case 2:
				if (settings["bomb2"])
				{return true;}
				break;
			case 3:
				if (settings["bomb3"])
				{return true;}
				break;
			case 4:
				if (settings["bomb4"])
				{return true;}
				break;
			case 5:
				if (settings["bomb5"])
				{return true;}
				break;
			default:
				print("SOMETHING IS WRONG. AMOUNT OF BOMBS COLLECTED IS " + current.bombsCollected + "?");
				break;
		}
	}
// Paradise Plaza (Case 8)
	if (settings["paradisePlaza8"] && current.currentRoomValue == 512 && current.loadingRoomValue == 1536 && old.loadingRoomValue != 1536 && current.campaignProgress >= 350 && current.campaignProgress < 500) {
		vars.paradisePlaza8Split = 1;
		return true;
	}
// 72 Hour Mode Run End
	if (settings["72HourEnd"] && current.campaignProgress == 390 && current.loadingRoomValue == 1025 && old.loadingRoomValue != 1025)
		{return true;}
// Overtime
	if (settings["overtime"] && current.frankWatchTime >= 41215)
	{
		// Supplies
		if (settings["supplies"] && current.currentRoomValue == 1025 && current.frankX > 1000 && current.campaignProgress <= 600 && current.inCutsceneOrLoad != old.inCutsceneOrLoad)
			{return true;}
		// Queens
		if (settings["queens"] && current.currentRoomValue == 1025 && current.loadingRoomValue == 2816 && old.loadingRoomValue != 2816)
			{return true;}	
		// Tunnel
		if (settings["tunnel"] && current.loadingRoomValue == 2819 && old.loadingRoomValue != 2819)
			{return true;}
		// Tank
		if (settings["tank"] && current.currentRoomValue == 2819 && current.brockHealth == 0 && old.brockHealth % 500 == 0 && old.brockHealth != 0)
			{return true;}
		// Brock
		if (settings["brock"] && current.currentRoomValue == 2819 && current.brockHealth == 0 && old.brockHealth % 500 != 0 && old.brockHealth != 0)
			{return true;}
	}
// Zombie Genocider
	if (current.kills != old.kills) {
		switch ((uint)current.kills) {
			case 10000:
				if (settings["kills10k"]) {
					return true;
				}
				break;
			case 10719:
				if (settings["kills20%"]) {
					return true;
				}
				break;
			case 20000:
				if (settings["kills20k"]) {
					return true;
				}
				break;
			case 21438:
				if (settings["kills40%"]) {
					return true;
				}
				break;
			case 30000:
				if (settings["kills30k"]) {
					return true;
				}
				break;
			case 32157:
				if (settings["kills60%"]) {
					return true;
				}
				break;
			case 40000:
				if (settings["kills40k"]) {
					return true;
				}
				break;
			case 42876:
				if (settings["kills80%"]) {
					return true;
				}
				break;
			case 50000:
				if (settings["kills50k"]) {
					return true;
				}
				break;
			case 53594:
				if (settings["killsFinal"]) {
					return true;
				}
				break;
			default:
				break;
		}
	}

	// Max Level
	if (current.level != old.level) {
		switch ((uint)current.level) {
			case 5:
				if (settings["level5"]) {
					return true;
				}
				break;
			case 10:
				if (settings["level10"]) {
					return true;
				}
				break;
			case 15:
				if (settings["level15"]) {
					return true;
				}
				break;
			case 20:
				if (settings["level20"]) {
					return true;
				}
				break;
			case 25:
				if (settings["level25"]) {
					return true;
				}
				break;
			case 30:
				if (settings["level30"]) {
					return true;
				}
				break;
			case 35:
				if (settings["level35"]) {
					return true;
				}
				break;
			case 40:
				if (settings["level40"]) {
					return true;
				}
				break;
			case 45:
				if (settings["level45"]) {
					return true;
				}
				break;
			case 50:
				if (settings["level50"]) {
					return true;
				}
				break;
		}
	}
}
