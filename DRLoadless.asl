// Pointers found and code written by Souzooka.

state("DeadRising", "SteamPatch3")
{
//	bool cameraCheck : 0x01945F70, 0x70;
	bool nothingIsBeingRendered : 0x01945FE0, 0x3C;
	byte frankCanMove : 0x01945F70, 0x5C;
	byte frankCanMoveTwo : 0x01945F70, 0x58;
	uint zeroAtTitleMenu : 0x01945F70, 0x38;
	uint currentRoomValue : 0x01945F70, 0x40;
	uint loadingRoomValue : 0x01945F70, 0x48;
	uint oldRoomValue : 0x01945F70, 0x4B;
	ushort gameStatus :0x01945F70, 0x88;
}
	
startup
{
	vars.introSequence = 0;
	vars.inLoad = 0;
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