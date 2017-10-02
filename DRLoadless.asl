state("DeadRising", "SteamPatch3")
{
    bool IsLoading : 0x1D18C80, 0x2338;

    // Used for subcase splitting
    byte CaseMenuState : 0x1946FC0, 0x2F058, 0x182;
    
    // Various split variables
    int CampaignProgress : 0x1944DD8, 0x20DC0, 0x150;
    int CutsceneId : 0x1944DD8, 0x8, 0xC8, 0x38, 0xC80, 0x8308;
    int InGameTime : 0x1946FC0, 0x2F058, 0x198;
    int PlayerKills : 0x1959EA0, 0x3B0;
    int PlayerLevel : 0x1946950, 0x68;
    float BossHealth : 0x1CF2620, 0x118, 0x12EC;
}

startup
{
    // Settings tree
    settings.Add("splits", true, "All Splits");

        // 72 Hour splits
        settings.Add("72Hour", false, "72 Hour Splits", "splits");
            settings.Add("caseSplits", false, "Split on Case End (all cases)", "72Hour");

            // Case 1
            settings.Add("case1", false, "Case 1 Splits", "72Hour");
                settings.Add("prologue", false, "Prologue", "case1");

        // Overtime splits
        settings.Add("overtime", false, "Overtime", "splits");
            settings.Add("supplies", false, "Supplies", "overtime");
            settings.Add("queens", false, "Queens", "overtime");
            settings.Add("tunnel", false, "Tunnel", "overtime");
            settings.Add("tank", false, "Tank", "overtime");
            settings.Add("brock", false, "Brock", "overtime");

        // Max Level
        settings.Add("maxLevel", false, "Max Level", "splits");
            for (int level = 5; level <= 50; level += 5)
            {
                settings.Add("level" + level.ToString(), false, "Level " + level.ToString(), "maxLevel");
            }

        // Zombie Genocider
        settings.Add("zombieGenocider", false, "Zombie Genocider", "splits");
            vars.GenociderKills = new List<int> {10000, 10719, 20000, 21438, 30000, 32157, 40000, 42876, 50000, 53594};
            foreach(int count in vars.GenociderKills)
            {
                settings.Add("kills" + count.ToString(), false, String.Format("{0:n0}", count) + " kills", "zombieGenocider");
            };
}

init 
{
    // Keep track of hit splits
    vars.Splits = new HashSet<string>();

    // For splitting when hitting a cutscene
    vars.Cutscenes = new Dictionary<int, string>
    {
        {4,   "prologue"},
        {126, "queens"},
        {131, "supplies"},
        {136, "tunnel"},
        {144, "tank"},
    };

    // For starting on player control
    vars.PrimeStart = false;
    vars.WillStart = false;
}

exit {}
update 
{
    // Clear any hit splits if timer stops
    if (timer.CurrentPhase == TimerPhase.NotRunning)
    {
        vars.Splits.Clear();
    }

    // For starting on player control
    if (current.InGameTime != 0 && old.InGameTime == 0)
    {
        vars.PrimeStart = true;
    }

    if (vars.PrimeStart && !current.IsLoading)
    {
        vars.WillStart = true;
    }
}

start 
{
    // Starts when player gains control
    if (vars.WillStart)
    {
        vars.PrimeStart = false;
        vars.WillStart = false;
        return true;
    }
}

reset 
{
    return current.InGameTime == 0 && old.InGameTime != 0;
}

isLoading
{
    return current.IsLoading;
}

split
{
    // Generic Case Split
    if (old.CaseMenuState == 2 && current.CaseMenuState == 0)
    {
        return settings["caseSplits"];
    }

    // Splitting when hitting cutscenes
    if (current.CutsceneId != old.CutsceneId)
    {
        if (vars.Cutscenes.ContainsKey(current.CutsceneId) && !vars.Splits.Contains(vars.Cutscenes[current.CutsceneId]))
        {
            vars.Splits.Add(vars.Cutscenes[current.CutsceneId]);
            return settings[vars.Cutscenes[current.CutsceneId]];
        }
    }

    // Brock
    if (current.CutsceneId == 144 && current.BossHealth == 0 && old.BossHealth != 0)
    {
        return settings["brock"];
    }

    // Max Level
    if (current.PlayerLevel != old.PlayerLevel)
    {
        return settings["level" + current.PlayerLevel.ToString()];
    }

    // Zombie Genocider
    if (current.PlayerKills != old.PlayerKills)
    {
        foreach(int count in vars.GenociderKills)
        {
            if (old.PlayerKills < count && count <= current.PlayerKills)
            {
                return true;
            }
        };
    }
}