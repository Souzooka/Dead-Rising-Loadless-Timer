// Pointers found and code written by Souzooka.

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
	
	uint mainMenuID : 0x1946FC0, 0x2F058, 0x38;
	byte mainMenuButtonSelection : 0x1946FC0, 0x2F058, 0x4C;
	byte mainMenuMaxPossibleButtonSelection : 0x1946FC0, 0x2F058, 0x9C;
	byte mainMenuSavePresent : 0x1946FC0, 0x2F058, 0xA0;
	ushort brockHealth : 0x01CF2620, 0x118, 0x12EC;
}
	
startup
{
	vars.introSequence = 0;
	vars.inLoad = 0;
	vars.gameStartSaveFromMenu = 0;
	
	vars.overtimeSplits = 0;
	vars.overtimeSelected = 0;
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
	
	print(vars.overtimeSplits.ToString());
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
		return true;
	}
}

start
{
//	For runs starting from the main menu, starts on new game or save load. Comment this out this code for ILs.
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
	// brock, the man with the hardest health pointers to find
	if (current.brockHealth == 0 & vars.overtimeSplits == 5)
	{
		vars.overtimeSplits = 0;
		return true;
	}
// Launch Confetti
}