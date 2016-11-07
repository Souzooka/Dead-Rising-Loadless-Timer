/* Pointers found and code written by Souzooka.

Load removal and autosplitting. All achievements/etc. not supported.
General purpose splits:	2 splits:	Shortcut (WP to PP), Shortcut (PP to WP)
Overtime splits: 	5 splits: 	Supplies, Queens, Tunnel, Tank, Brock
Prologue% splits: 	1 split: 	Prologue
Case 1 splits: 	5 splits: 	Prologue, Case 1-1, Case 1-2, Case 1-3, Case 1-4
Case 2 splits:	4 splits:	Case 2-2, Steven, First-Aid, Case 2-3
Case 4 splits: 	1 split:	Case 4-2
Case 5 splits: 	1 split:	Case 5-2
Case 7 splits:	1 split:	Case 7-2
Case 8 splits: 	3 splits:	Case 8-2, Case 8-3, Case 8-4

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
}
	
startup
{
	vars.stopWatch = new Stopwatch();
	
	settings.Add("splits", true, "All Splits");
	
	settings.Add("misc", true, "Miscellaneous Splits", "splits");
	settings.Add("shortcutpw", false, "Shortcut (PP to WP)", "misc");
	settings.Add("shortcutwp", false, "Shortcut (WP to PP)", "misc");
	
	settings.Add("72Hour", true, "72 Hour Splits", "splits");
	
	settings.Add("caseSplits", true, "Split on Case End (all cases)", "72Hour");
	
	settings.Add("case1", true, "Case 1 Splits", "72Hour");
	settings.Add("prologue", false, "Prologue", "case1");
	
	settings.Add("case2", true, "Case 2 Splits", "72Hour");
	settings.Add("steven", true, "Steven", "case2");
	settings.Add("firstaid", false, "First Aid", "case2");
	
	settings.Add("case7", true, "Case 7 Splits", "72Hour");
	settings.Add("allBombs", true, "Bombs", "case7");
	settings.Add("bomb1", true, "First Bomb", "allBombs");
	settings.Add("bomb2", true, "Second Bomb", "allBombs");
	settings.Add("bomb3", true, "Third Bomb", "allBombs");
	settings.Add("bomb4", true, "Fourth Bomb", "allBombs");
	settings.Add("bomb5", true, "Fifth Bomb", "allBombs");
	
	settings.Add("72HourEnd", true, "72 Hour Mode End", "72Hour");
	
	settings.Add("overtime", true, "Overtime Splits", "splits");
	settings.Add("supplies", true, "Supplies", "overtime");
	settings.Add("queens", true, "Queens", "overtime");
	settings.Add("tunnel", true, "Tunnel", "overtime");
	settings.Add("tank", true, "Tank", "overtime");
	settings.Add("brock", true, "Brock", "overtime");
	
	settings.Add("timingMethods", true, "Timing Method");
	
	settings.Add("loadless1", true, "Loadless", "timingMethods");
	settings.Add("loadless2", false, "Loadless + Menuless", "timingMethods");
	
	settings.SetToolTip("shortcutpw", "Splits when traveling to Wonderland Plaza from Paradise Plaza.");
	settings.SetToolTip("shortcutwp", "Splits when traveling to Paradise Plaza from Wonderland Plaza.");
	
	settings.SetToolTip("caseSplits", "Splits after a case has been filled into the case file.");
	
	settings.SetToolTip("prologue", "Splits after escaping Entrance Plaza.");
	
	settings.SetToolTip("steven", "Splits after killing Steven.");
	settings.SetToolTip("firstaid", "Splits after collecting first aid.");
	
	settings.SetToolTip("bomb1", "Splits after collecting first bomb.");
	settings.SetToolTip("bomb2", "Splits after collecting second bomb.");
	settings.SetToolTip("bomb3", "Splits after collecting third bomb.");
	settings.SetToolTip("bomb4", "Splits after collecting fourth bomb.");
	settings.SetToolTip("bomb5", "Splits after collecting fifth bomb.");
	
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
	if (current.mainMenuID == 264)
		{return true;}		
}

start
{
//	For runs starting from the main menu, starts on new game. Also starts Case 5 (which doesn't start with a case file screen)
	if (current.inGameTimer == 3888000 || current.inGameTimer == 12528000 || current.campaignProgress == 270)
		{return current.mainMenuID == 3;}

//	Case 2, 4, 7, 8 Start
	if (current.caseMenuOpen == 0 && old.caseMenuOpen == 19)
		{return true;}		
}

isLoading
{
	if (settings["loadless1"])
	return current.inCutsceneOrLoad;
	
	if (settings["loadless2"])
	return current.inCutsceneOrLoad || current.caseMenuOpen > 1;
}

split
{
// Shortcut (PP to WP)
	if (settings["shortcutpw"] && current.currentRoomValue == 512 && current.loadingRoomValue == 768 && old.loadingRoomValue != 768) return true;
// Shortcut (WP to PP)
	if (settings["shortcutwp"] && current.currentRoomValue == 768 && current.loadingRoomValue == 512 && old.loadingRoomValue != 512)
		{return true;}
// Case Splits
	if (settings["caseSplits"] && old.caseMenuOpen == 2 && current.caseMenuOpen == 0 && current.campaignProgress != 280)
	return true;
//	Prologue
	if (settings["prologue"] && current.frankWatchTime >= 11100 && current.frankWatchTime <= 11700)
	{
		// Prologue
		if (current.campaignProgress == 65 && current.inCutsceneOrLoad == true && old.inCutsceneOrLoad == false)
			{vars.stopWatch.Start();}
		
		if (vars.stopWatch.ElapsedMilliseconds >= 1000)
		{
			vars.stopWatch.Reset();
			return true;
		}	
	}
// Steven
	if (settings["steven"] && current.campaignProgress == 190 && current.brockHealth == 0 && old.brockHealth != 0)
		{return true;}
// First-Aid
	if (settings["firstaid"] && current.campaignProgress == 215 && old.campaignProgress == 210)
		{return true;}	
// Bombs
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
}
