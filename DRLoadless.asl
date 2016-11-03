/* Pointers found and code written by Souzooka.

Load removal and autosplitting. 72 Hour (all cases)/all achievements/etc. not supported.
Overtime splits: 	5 splits: 	Supplies, Queens, Tunnel, Tank, Brock
Prologue% splits: 	1 split: 	Prologue
Case 1 splits: 	5 splits: 	Prologue, Case 1-1, Case 1-2, Case 1-3, Case 1-4
Case 2 splits:	3 splits:	Case 2-2, First-Aid Acquired, Case 2-3
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

	ushort frankWatchTime : 0x01D18C80, 0x1f94;
	bool inCutsceneOrLoad : 0x01D18C80, 0x2338;

	ushort campaignProgress : 0x01944DD8, 0x20DC0, 0x150;	
	
	uint inGameTimer : 0x1946FC0, 0x2F058, 0x198;
	byte caseFileOpen : 0x1946FC0, 0x2F058, 0x184;
	byte caseMenuOpen : 0x1946FC0, 0x2F058, 0x182;
	uint mainMenuID : 0x1946FC0, 0x2F058, 0x38;
}
	
startup
{
	vars.stopWatch = new Stopwatch();
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
		{return !current.inCutsceneOrLoad && current.mainMenuID == 3;}

//	Case 2, 4, 7, 8 Start
	if (current.caseMenuOpen == 0 && old.caseMenuOpen == 19)
		{return true;}
}

isLoading
{
	return current.inCutsceneOrLoad;
}

split
{

//	Run this code only if we're actually in Prologue.
	if (current.frankWatchTime >= 11100 && current.frankWatchTime <= 11700)
	{
		// Prologue
		if (current.campaignProgress > 50 && current.inCutsceneOrLoad == true && old.inCutsceneOrLoad == false)
		{vars.stopWatch.Start();}
		
		if (vars.stopWatch.ElapsedMilliseconds >= 1000)
		{
			vars.stopWatch.Reset();
			return true;
		}	
	}
	
	// Run this code only if we're actually in Overtime.
	if (current.frankWatchTime >= 41215)
	{
		// Supplies
		if (current.currentRoomValue == 1025 && current.loadingRoomValue != 1024 && current.inCutsceneOrLoad != old.inCutsceneOrLoad)
		{return true;}
		
		// Queens
		if (current.currentRoomValue == 1025 && current.loadingRoomValue == 2816 && old.loadingRoomValue != 2816)
		{return true;}
		
		// Tunnel
		if (current.loadingRoomValue == 2819 && old.loadingRoomValue != 2819)
		{return true;}
		
		// Tank & Brock
		if (current.currentRoomValue == 2819 && current.brockHealth == 0 && old.brockHealth != 0)
			{return true;}
	}
	
	// First-Aid
	if (current.campaignProgress == 215 && old.campaignProgress == 210)
		{return true;}
	
	// Always running, will return true ONLY when closing case file (exception being start of case 5)
	return old.caseMenuOpen == 2 && current.caseMenuOpen == 0 && current.campaignProgress != 280;
}