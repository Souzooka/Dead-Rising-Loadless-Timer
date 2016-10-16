// Pointers found and code written by Souzooka.

// This script contains load removal and autosplitters (some of which not currently functional) which will become active completely automatically, no editing of this script needed. Simply have the right number of splits for the run category you are doing. 72 Hour (all cases)/all achievements/etc. not supported.
// Overtime splits: 	5 splits: 	Supplies, Queens, Tunnel, Tank, Brock
// Prologue% splits: 	1 split: 	Prologue
// Case 1 splits: 		5 splits: 	Prologue, Case 1-1, Case 1-2, Case 1-3, Case 1-4
// Case 2 splits:
// Case 4 splits: 
// Case 5 splits: 
// Case 7 splits: 
// Case 8 splits: 

state("DeadRising", "SteamPatch3")
{
	bool cameraCheck : 0x01945F70, 0x70;
	bool nothingIsBeingRendered : 0x01945FE0, 0x3C;
	byte frankCanMove : 0x01945F70, 0x5C;
	byte frankCanMoveTwo : 0x01945F70, 0x58;
//	uint zeroAtTitleMenu : 0x01945F70, 0x38;
	uint currentRoomValue : 0x01945F70, 0x40;
	uint loadingRoomValue : 0x01945F70, 0x48;
//	uint oldRoomValue : 0x01945F70, 0x4B;
	ushort gameStatus : 0x01945F70, 0x88;
	float fadeStatus : 0x01945FE0, 0x40;
	
	uint mainMenuID : 0x1946FC0, 0x2F058, 0x38;
	byte mainMenuButtonSelection : 0x1946FC0, 0x2F058, 0x4C;
	byte mainMenuMaxPossibleButtonSelection : 0x1946FC0, 0x2F058, 0x9C;
	byte mainMenuSavePresent : 0x1946FC0, 0x2F058, 0xA0;

//	Value for Brock's (and tank's, possibly every first psychopath's?) health
	uint brockHealth : 0x01CF2620, 0x118, 0x12EC;
	
//	Value for Frank's watch, 11200 = Day 1 @ 12:00, 52200 = Day 5 @ 22:00, etc.
	ushort frankWatchTime : 0x01D18C80, 0x1f94;
	
	ushort lastCutsceneSeen : 0x01D18C80, 0x20e8;
	uint inGameTimer : 0x1946FC0, 0x2F058, 0x198;
}
	
startup
{
	vars.introSequence = 0;
	vars.inLoad = 0;
	vars.gameStartSaveFromMenu = 0;
	
// 	Overtime splits (automatic)
	vars.overtimeSplits = 0;
	vars.overtimeSelected = 0;

//	Case 1 splits (automatic -- two splits are included, prologue% and case 1 end)
	vars.case1Splits = 1;

//	Case 2 splits (automatic)
	vars.case2Splits = 1;

//	Case 4 splits (automatic)
	vars.case4Splits = 1;

//	Case 5 splits (automatic)
	vars.case5Splits = 1;

//	Case 7 splits (automatic)
	vars.case7Splits = 1;

//	Case 8 splits (automatic)
	vars.case8Splits = 1;
	

	vars.stopWatch = new Stopwatch();
}


update
{
	if (current.currentRoomValue == 4294967295 & current.nothingIsBeingRendered == true)
	{
		if (current.loadingRoomValue == 287)
		{
			vars.introSequence = 2;
		}
		else
		{
			vars.introSequence = 1;
		}
	}
	else
	{
		vars.introSequence = 0;
	}
	
	if (current.frankCanMove == 0 & current.frankCanMoveTwo == 0 & current.nothingIsBeingRendered == true | current.gameStatus == 652)
	{
		vars.inLoad = 1;
	}
	else
	{
		vars.inLoad = 0;
	}
	
	if (current.mainMenuID == 68097 & vars.gameStartSaveFromMenu == 0 | current.mainMenuID == 199169 & vars.gameStartSaveFromMenu == 0)
	{
		vars.gameStartSaveFromMenu++;
	}
	if (current.mainMenuID == 3 & vars.gameStartSaveFromMenu == 1)
	{
		vars.gameStartSaveFromMenu--;
	}

	if (current.mainMenuSavePresent == 1 & current.mainMenuMaxPossibleButtonSelection >= 3 & current.mainMenuButtonSelection == 2 | current.mainMenuSavePresent == 0 & current.mainMenuMaxPossibleButtonSelection >= 2 & current.mainMenuButtonSelection == 1)
	{vars.overtimeSelected = 1;}
	else
	{vars.overtimeSelected = 0;}

}
	
isLoading
{	
	if (609 < current.gameStatus & vars.inLoad == 1 | current.gameStatus != 609 & vars.introSequence == 2 | vars.introSequence == 1)
	{
	return true;
	}
	else
	{
	return false;
	}
}

reset
{
//	Resets when the title menu is entered.
	if (current.mainMenuID == 264)
	{
		vars.overtimeSplits = 0;
		vars.case1Splits = 1;
		vars.case2Splits = 1;
		vars.case4Splits = 1;
		vars.case5Splits = 1;
		vars.case7Splits = 1;
		vars.case8Splits = 1;
		return true;
	}
}

start
{
//	For runs starting from the main menu, starts on new game. Comment this out this code for ILs.
	if (current.mainMenuID == 199169 & vars.overtimeSelected == 1)
	vars.overtimeSplits = 1;
	if (current.mainMenuID == 199169)
	return true;
}

split
{
// Overtime splits, the user should not have to comment any of this out if they are not doing Overtime.
	// supplies
	if (current.currentRoomValue == 1025 & current.loadingRoomValue != 1024 & current.gameStatus == 652 & vars.overtimeSplits == 1 & vars.gameStartSaveFromMenu == 0)
	{
		vars.overtimeSplits++;
		return true;
	}
	// queens
	if (current.currentRoomValue == 1025 & current.loadingRoomValue == 2816 & current.gameStatus == 652 & vars.overtimeSplits == 2 & vars.gameStartSaveFromMenu == 0)
	{
		vars.overtimeSplits++;
		return true;
	}
	// tunnel
	if (current.currentRoomValue == 2818 & current.loadingRoomValue != 2817 & current.gameStatus == 652 & vars.overtimeSplits == 3 & vars.gameStartSaveFromMenu == 0)
	{
		vars.overtimeSplits++;
		return true;
	}
	// tank
	if (current.currentRoomValue == 2819 & current.gameStatus == 652 & current.nothingIsBeingRendered == true & vars.overtimeSplits == 4)
	{
		vars.overtimeSplits++;
		return true; 
	}
	// brock
	if (current.brockHealth == 0 & current.gameStatus == 687 & current.nothingIsBeingRendered == false & vars.overtimeSplits == 5)
	{
		vars.overtimeSplits = 0;
		return true;
	//	vars.confetti.launch();
	}

//	Prologue% + Case 1 splits

	// Prologue
	if (current.lastCutsceneSeen == 3 & current.loadingRoomValue == 288 & current.currentRoomValue != 288 & vars.case1Splits == 1)
	{
		vars.stopWatch.Start();
		if (vars.stopWatch.ElapsedMilliseconds >= 1000)
		{
			vars.stopWatch.Reset();
			vars.case1Splits++;
			return true;
		}	
	}
	//	Case 1-1
	if (current.lastCutsceneSeen == 8 & current.currentRoomValue == 534 & current.gameStatus != 652 & current.gameStatus != 654 & vars.case1Splits == 2)
	{
		vars.stopWatch.Start();
		if (vars.stopWatch.ElapsedMilliseconds >= 2000)
		{
			if (current.inGameTimer != old.inGameTimer)
			{
				vars.stopWatch.Reset();
				vars.case1Splits++;
				return true;
			}
		}
	}
	//	Case 1-2
	if (current.lastCutsceneSeen == 10 & current.currentRoomValue == 2560 & current.gameStatus != 652 & current.gameStatus != 654 & vars.case1Splits == 3)
	{
		vars.stopWatch.Start();
		if (vars.stopWatch.ElapsedMilliseconds >= 2000)
		{
			if (current.inGameTimer != old.inGameTimer)
			{
				vars.stopWatch.Reset();
				vars.case1Splits++;
				return true;
			}
		}
	}
	//	Case 1-3
	if (current.lastCutsceneSeen == 12 & current.currentRoomValue == 256 & current.gameStatus != 652 & current.gameStatus != 654 & vars.case1Splits == 4)
	{
		vars.stopWatch.Start();
		if (vars.stopWatch.ElapsedMilliseconds >= 2000)
		{
			if (current.inGameTimer != old.inGameTimer)
			{
				vars.stopWatch.Reset();
				vars.case1Splits++;
				return true;
			}
		}
	}
	//	Case 1-4
	if (current.lastCutsceneSeen == 13 & current.currentRoomValue == 288 & current.gameStatus != 652 & current.gameStatus != 654 & vars.case1Splits == 5)
	{
		vars.stopWatch.Start();
		if (vars.stopWatch.ElapsedMilliseconds >= 2000)
		{
			if (current.inGameTimer != old.inGameTimer)
			{
				vars.stopWatch.Reset();
				vars.case1Splits++;
				return true;
			}
		}
	}

}
