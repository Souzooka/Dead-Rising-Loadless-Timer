// Written by Souzooka, pls do not steal or you will be banished to the depths of hell.

state("DeadRising", "SteamPatch3")
{
    bool NothingIsBeingRendered : 0x01945FE0, 0x3C;
}

isLoading
{
return current.NothingIsBeingRendered;
}