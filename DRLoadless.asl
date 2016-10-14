// Pointers found and code written by Souzooka.

state("DeadRising", "SteamPatch3")
{
//	bool cameraCheck : 0x01945F70, 0x70;
	bool NothingIsBeingRendered : 0x01945FE0, 0x3C;
	byte frankCanMove : 0x01945F70, 0x5C;
	uint currentRoomValue : 0x01945F70, 0x40;
	uint loadingRoomValue : 0x01945F70, 0x48;
	uint oldRoomValue : 0x01945F70, 0x4B;
	ushort gameStatus :0x01945F70, 0x88;
	
}

isLoading
{	
	if (current.gameStatus == 652 | current.gameStatus != 607 & current.gameStatus != 608 & current.gameStatus != 609 & current.frankCanMove == 0 & current.NothingIsBeingRendered == true | current.gameStatus != 609 & current.currentRoomValue == 4294967295 & current.loadingRoomValue == 287 & current.NothingIsBeingRendered == true)
	{
	return true;
	}
	else
	{
	return false;
	}
}