// Pointers found and code written by Souzooka.

// This script contains load removal and autosplitters (some of which not currently functional) which will become active completely automatically, no editing of this script needed. Simply have the right number of splits for the run category you are doing. 72 Hour (all cases)/all achievements/etc. not supported.
// Overtime splits: 	5 splits: 	Supplies, Queens, Tunnel, Tank, Brock
// Prologue% splits: 	1 split: 	Prologue
// Case 1 splits: 	5 splits: 	Prologue, Case 1-1, Case 1-2, Case 1-3, Case 1-4
// Case 2 splits:	2 splits:	Case 2-2, Case 2-3
// Case 4 splits: 
// Case 5 splits: 
// Case 7 splits: 
// Case 8 splits: 

state("DeadRising", "SteamPatch3")
{
//	bool cameraCheck : 0x01945F70, 0x70;
	byte frankCanMove : 0x01945F70, 0x5C;
	byte frankCanMoveTwo : 0x01945F70, 0x58;
//	uint zeroAtTitleMenu : 0x01945F70, 0x38;
	uint currentRoomValue : 0x01945F70, 0x40;
	uint loadingRoomValue : 0x01945F70, 0x48;
//	uint oldRoomValue : 0x01945F70, 0x4B;
	ushort gameStatus : 0x01945F70, 0x88;
	byte isLoading : 0x01CF27F8, 0x11B68, 0x48;
	
	bool nothingIsBeingRendered : 0x01945FE0, 0x3C;
//	float fadeStatus : 0x01945FE0, 0x40;
	
	uint mainMenuID : 0x1946FC0, 0x2F058, 0x38;
	byte mainMenuButtonSelection : 0x1946FC0, 0x2F058, 0x4C;
//	byte mainMenuMaxPossibleButtonSelection : 0x1946FC0, 0x2F058, 0x9C;
	byte mainMenuSavePresent : 0x1946FC0, 0x2F058, 0xA0;

//	Value for Brock's (and tank's, possibly every first psychopath's?) health
	uint brockHealth : 0x01CF2620, 0x118, 0x12EC;
	
//	Value for Frank's watch, 11200 = Day 1 @ 12:00, 52200 = Day 5 @ 22:00, etc.
	ushort frankWatchTime : 0x01D18C80, 0x1f94;
	
//	Values used for IL splits (after the case file disappears, with the case file having immediately followed a cutscene)
	ushort lastCutsceneSeen : 0x01D18C80, 0x20e8;
	uint inCutscene : 0x01D18C80, 0x20f4;
	uint inGameTimer : 0x1946FC0, 0x2F058, 0x198;
	
//	Values used for Case 2-3 split
	// Value which increments during certain checkpoints in the story, picking up the first aid kit in Medicine Run will set this value to 215.
	ushort campaignProgress : 0x01944DD8, 0x20DC0, 0x150;
	byte caseFileOpen : 0x1946FC0, 0x2F058, 0x184;
	
	
}
	
startup
{
	// See update block for comments on these variables.
	vars.introSequence = 0;
	vars.inLoad = 0;
	vars.resetCheck = 0;
	
	//Prevents splits from firing twice.
	vars.splitsTick = 3;
	
	vars.stopWatch = new Stopwatch();
	
	refreshRate = 300;
	
}


update
{
	// currentRoomValue is FF FF FF FF when not valid (e.g. title menu) and updates during a playable segment in a room (Frank gaining control / turret segment / NOT THE HELICOPTER CUTSCENE). vars.introSequence is 2 for 72 Hour, 1 for Overtime.
	if (current.currentRoomValue == 4294967295 & current.inCutscene == 1677743)
	{
		vars.introSequence = 1;
	}
	else
	{
		vars.introSequence = 0;
	}
	
	// frankCanMove and frankCanMoveTwo are both set to 0 when Frank doesn't have control (e.g. during cutscene) and checking these two values prevents the game from starting the timer when still in a loading screen allowing for more accurate timing. nothingIsBeingRendered is 1 when no new 3D frames are being rendered (e.g. during loads, picture taking, and fading into/out of the pause menu), gameStatus is 652 when the game is loading (?). ISSUE: Triggers incorrectly when Overtime rewards are being given out, but this doesn't affect any run using this script.
	if (current.frankCanMove == 0 & current.frankCanMoveTwo == 0 & current.nothingIsBeingRendered == true | current.gameStatus == 652)
	{
		vars.inLoad = 1;
	}
	else
	{
		vars.inLoad = 0;
	}

	// Checks if we hit a cutscene and sets vars.resetCheck to 1 if we have. vars.resetCheck is set back to 0 when the title menu is enetered. This prevents false starts as the lastCutsceneSeen's value persists until a new cutscene is seen. For example, if the timer starts after viewing 2-1's cutscene and the player resets, the timer will falsely start immediately after a reset.
	if (current.inCutscene == 65537)
	{
		vars.resetCheck = 1;
	}
}

isLoading
{	
	// 609 and lower gameStatus values are used for title menu and intro sequence, etc. First set of conditions checks if we're not in an intro sequence/title menu and if we're in a load. Second set checks if the game's not rendering anything during 72 Hour's into EXCEPT for the helicopter cutscene. Third set checks if we're in Overtime's intro and not rendering anything (Probably doesn't work properly if you go straight from 72 hour into Overtime). 
	if (current.inCutscene == 16777473 | current.isLoading == 1 & current.currentRoomValue != 4294967295)
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
		vars.resetCheck = 0;
		vars.splitsTick = 0;
		return true;
	}
}

start
{
//	For runs starting from the main menu, starts on new game.
	if (current.mainMenuID == 199169)
	{
		if (current.mainMenuSavePresent == 1 & current.mainMenuButtonSelection == 0)
		{
			return false;
		}
		else
		{
			return true;
		}
	}
	
//	Case 2 Start
	if (current.lastCutsceneSeen == 15 & vars.resetCheck == 1 & vars.splitsTick == 0 & current.inCutscene != 65537)
	{
		vars.stopWatch.Start();
		if (vars.stopWatch.ElapsedMilliseconds >= 1000)
		{
			if (current.inGameTimer != old.inGameTimer)
			{
				vars.stopWatch.Reset();
				vars.splitsTick++;
				return true;
			}
		}
	}
}

split
{

// Overtime splits, the user should not have to comment any of this out if they are not doing Overtime.
// Run this code only if we're actually in Overtime.
	if (current.frankWatchTime > 41214)
	{
		// supplies
		if (current.currentRoomValue == 1025 & current.campaignProgress == 520 & current.gameStatus == 652 & vars.splitsTick == 0 & vars.resetCheck == 1)
		{
			vars.splitsTick++;
			return true;
		}
		// queens
		if (current.currentRoomValue == 1025 & current.loadingRoomValue == 2816 & current.gameStatus == 652 & vars.splitsTick == 1 & vars.resetCheck == 1)
		{
			vars.splitsTick++;
			return true;
		}
		// tunnel
		if (current.currentRoomValue == 2818 & current.loadingRoomValue != 2817 & current.gameStatus == 652 & vars.splitsTick == 2 & vars.resetCheck == 1)
		{
			vars.splitsTick++;
			return true;
		}
		// tank
		if (current.currentRoomValue == 2819 & current.gameStatus == 652 & current.nothingIsBeingRendered == true & vars.splitsTick == 3 & vars.resetCheck == 1)
		{
			vars.splitsTick++;
			return true; 
		}
		// brock
		if (current.brockHealth == 0 & current.gameStatus == 687 & current.nothingIsBeingRendered == false & vars.splitsTick == 4 & vars.resetCheck == 1)
		{
			vars.splitsTick = 0;
		//	vars.confetti.launch();
			return true;
		}
	}

//	All splits (except for Overtime and Prologue) check if a particular cutscene has been hit, waits 2 seconds (because there is a quarter second of control immediately after a cutscene before the case file appears) and then constantly checks if the in-game time is advancing. When this happens, a split occurs.

//	Prologue% + Case 1 splits
//	Run this code only if we're actually in Case 1.
	if (current.frankWatchTime > 11100 & current.frankWatchTime < 20500)
	{
		// Prologue
		if (current.lastCutsceneSeen == 3 & current.loadingRoomValue == 288 & current.currentRoomValue != 288 & vars.splitsTick == 0)
		{
			vars.stopWatch.Start();
			if (vars.stopWatch.ElapsedMilliseconds >= 1000)
			{
				vars.stopWatch.Reset();
				vars.splitsTick++;
				return true;
			}	
		}
		//	Case 1-1
		if (current.lastCutsceneSeen == 8 & vars.splitsTick == 1 & vars.resetCheck == 1 & current.inCutscene != 65537)
		{
			vars.stopWatch.Start();
			if (vars.stopWatch.ElapsedMilliseconds >= 2000)
			{
				if (current.inGameTimer != old.inGameTimer)
				{
					vars.stopWatch.Reset();
					vars.splitsTick++;
					return true;
				}
			}
		}
		//	Case 1-2
		if (current.lastCutsceneSeen == 10 & vars.splitsTick == 2 & vars.resetCheck == 1 & current.inCutscene != 65537)
		{
			vars.stopWatch.Start();
			if (vars.stopWatch.ElapsedMilliseconds >= 2000)
			{
				if (current.inGameTimer != old.inGameTimer)
				{
					vars.stopWatch.Reset();
					vars.splitsTick++;
					return true;
				}
			}
		}
		//	Case 1-3
		if (current.lastCutsceneSeen == 12 & vars.splitsTick == 3 & vars.resetCheck == 1 & current.inCutscene != 65537)
		{
			vars.stopWatch.Start();
			if (vars.stopWatch.ElapsedMilliseconds >= 2000)
			{
				if (current.inGameTimer != old.inGameTimer)
				{
					vars.stopWatch.Reset();
					vars.splitsTick++;
					return true;
				}
			}
		}
		//	Case 1-4
		if (current.lastCutsceneSeen == 13 & vars.splitsTick == 4 & vars.resetCheck == 1 & current.inCutscene != 65537)
		{
			vars.stopWatch.Start();
			if (vars.stopWatch.ElapsedMilliseconds >= 2000)
			{
				if (current.inGameTimer != old.inGameTimer)
				{
					vars.stopWatch.Reset();
					vars.splitsTick = 0;
					return true;
				}
			}
		}
	}

	//	Run this code only if we're actually in Case 2.
	if (current.frankWatchTime > 20500 & current.frankWatchTime < 21200)
	{
		//	Case 2-2
		if (current.lastCutsceneSeen == 17 & vars.splitsTick == 1 & vars.resetCheck == 1 & current.inCutscene != 65537)
		{
			vars.stopWatch.Start();
			if (vars.stopWatch.ElapsedMilliseconds >= 2000)
			{
				if (current.inGameTimer != old.inGameTimer)
				{
					vars.stopWatch.Reset();
					vars.splitsTick++;
					return true;
				}
			}
		}
		//	First Aid Acquired
		if (current.campaignProgress == 215 & vars.splitsTick == 2)
		{
			vars.splitsTick++;
			return true;
		}
		//	Case 2-3
		if (current.campaignProgress == 215 & vars.splitsTick == 3 & current.caseFileOpen == 0 & old.caseFileOpen == 2)
		{
			vars.splitsTick = 0;
			return true;
		}
	}
}
