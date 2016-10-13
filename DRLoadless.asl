// Written by Souzooka, pls do not steal or you will be banished to the depths of hell.

state("DeadRising", "SteamPatch3")
{
//	bool NothingIsBeingRenderedInverse : 0x019461B8, 0x8, 0x10, 0x0, 0x178, 0xB4;
//	float ActiveTime : 0x1950F08;
	bool NothingIsBeingRendered : 0x01945FE0, 0x3C;
	bool CameraCheck : 0x01945F70, 0x70;
}



isLoading
{

// 	Doesn't work
//	return current.NothingIsBeingRendered;
//	if (current.ActiveTime == old.ActiveTime)
//	return current.NothingIsBeingRendered;
//	if (current.ActiveTime > old.ActiveTime)
//	return false;
	
	if (current.CameraCheck == true)
	return current.NothingIsBeingRendered;
	if (current.CameraCheck == false)
	return false;

}