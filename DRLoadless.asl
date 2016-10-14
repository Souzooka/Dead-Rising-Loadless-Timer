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

isLoading
{	
	// room loads // title load (?) // accurate cutscene loads // 72 hour intro // overtime intro // infinity intro //
	if (current.gameStatus == 652 | current.gameStatus == 607 & current.currentRoomValue == current.loadingRoomValue | current.gameStatus != 607 & current.gameStatus != 608 & current.gameStatus != 609 & current.frankCanMove == 0 & current.frankCanMoveTwo == 0 & current.nothingIsBeingRendered == true | current.gameStatus != 609 & current.currentRoomValue == 4294967295 & current.loadingRoomValue == 287 & current.nothingIsBeingRendered == true | current.currentRoomValue == 4294967295 & current.loadingRoomValue == 1025 & current.nothingIsBeingRendered == true | current.currentRoomValue == 4294967295 & current.loadingRoomValue == 288 & current.nothingIsBeingRendered == true)
	{
	return true;
	}
	else
	{
	return false;
	}
}