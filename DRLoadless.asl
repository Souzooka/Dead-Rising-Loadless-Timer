// Written by Souzooka, pls do not steal or you will be banished to the depths of hell.

state("DeadRising", "SteamPatch3")
{
//	bool NothingIsBeingRenderedInverse : 0x019461B8, 0x8, 0x10, 0x0, 0x178, 0xB4;
//	float ActiveTime : 0x1950F08;
	bool NothingIsBeingRendered : 0x01945FE0, 0x3C;
	bool CameraCheck : 0x01945F70, 0x70;
	ushort CameraOverlayPresent : 0x019284E8, 0x28, 0x4C8, 0x2F8, 0x140, 0x14;
}



isLoading
{	
	if (current.CameraCheck == true & current.NothingIsBeingRendered == true & current.CameraOverlayPresent != 257)
	{
	return true;
	}
	else
	{
	return false;
	}

}