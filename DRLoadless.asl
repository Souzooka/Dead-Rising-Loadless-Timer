state("DeadRising", "SteamPatch3")
{
    bool IsLoading : 0x1D18C80, 0x2338;

    // Used for subcase splitting
    byte CaseMenuState : 0x1946FC0, 0x2F058, 0x182;
    
    // Various split variables
    byte Bombs : 0x1944DD8, 0x20DC0, 0x848D;
    int CampaignProgress : 0x1944DD8, 0x20DC0, 0x150;
    int CutsceneId : 0x1944DD8, 0x8, 0xC8, 0x38, 0xC80, 0x8308;
    int InGameTime : 0x1946FC0, 0x2F058, 0x198;
    int PlayerKills : 0x1959EA0, 0x3B0;
    int PlayerLevel : 0x1946950, 0x68;
    int RoomId : 0x1945F70, 0x48;
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
                settings.Add("case1Prologue", false, "Prologue", "case1");

            // Case 2
            settings.Add("case2", false, "Case 2 Splits", "72Hour");
                settings.Add("case2PP->WP", false, "PP->WP (Any%)", "case2");
                settings.Add("case2PP->LP", false, "PP->LP (Low%)", "case2");
                settings.Add("case2FirstAid", false, "First Aid", "case2");
                settings.Add("case2WP->PP", false, "WP->PP (Any%)", "case2");
                settings.Add("case2LP->PP", false, "LP->PP (Low%)", "case2");

            // Case 4
            settings.Add("case4", false, "Case 4 Splits", "72Hour");
                settings.Add("case4Roof->Ware", false, "Roof->Warehouse", "case4");
                settings.Add("case4Ware->PP", false, "Warehouse->PP", "case4");
                settings.Add("case4PP->WP", false, "PP->WP (Any%)", "case4");
                settings.Add("case4PP->LP", false, "PP->LP (Low%)", "case4");
                settings.Add("case4WP->NP", false, "WP->NP (Any%)", "case4");
                settings.Add("case4LP->NP", false, "LP->NP (Low%)", "case4");

            // Case 5
            settings.Add("case5", false, "Case 5 Splits", "72Hour");
                settings.Add("case5NP->LP", false, "NP->LP", "case5");
                settings.Add("case5LP->PP", false, "LP->PP", "case5");
                settings.Add("case5PP->Ware", false, "PP->Warehouse", "case5");
                settings.Add("case5Ware->Roof", false, "Warehouse->Roof", "case5");

            // Case 7
            settings.Add("case7", false, "Case 7 Splits", "72Hour");
                settings.Add("case7PP->Tunnels", false, "PP->Tunnels (Any%)", "case7");
                settings.Add("case7PP->LP", false, "PP->LP (Low%)", "case7");
                for (int i = 1; i <= 5; ++i)
                {
                    settings.Add("case7Bomb" + i.ToString(), false, "Bomb #" + i.ToString(), "case7");
                }

            // Case 8
            settings.Add("case8", false, "Case 8 Splits", "72Hour");
                settings.Add("case8PP->LP", false, "PP->LP", "case8");
                settings.Add("case8WP->PP", false, "WP->PP (Any%)", "case8");
                settings.Add("case8LP->PP", false, "LP->PP (Low%)", "case8");

        // Overtime splits
        settings.Add("overtime", false, "Overtime", "splits");
            settings.Add("otSupplies", false, "Supplies", "overtime");
            settings.Add("otQueens", false, "Queens", "overtime");
            settings.Add("otTunnel", false, "Tunnel", "overtime");
            settings.Add("otTank", false, "Tank", "overtime");
            settings.Add("otBrock", false, "Brock", "overtime");

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
        {4,   "case1Prologue"},
        {126, "otQueens"},
        {131, "otSupplies"},
        {136, "otTunnel"},
        {144, "otTank"},
    };

    vars.CaseProgress = new Dictionary<int, HashSet<int>>
    {
        {2, new HashSet<int>(Enumerable.Range(160, 56))},
        {4, new HashSet<int>(Enumerable.Range(230, 21))},
        {5, new HashSet<int>(Enumerable.Range(270, 21))},
        {7, new HashSet<int>(Enumerable.Range(320, 21))},
        {8, new HashSet<int>(Enumerable.Range(350, 150))},
    };

    // Represents the progress level at the starts of cases. Provided so that we don't split on them.
    vars.CaseStarts = new HashSet<int> {160, 230, 280, 320, 350};

    vars.Rooms = new Dictionary<int, string>
    {
        {512,  "PP"},
        {534,  "Ware"},
        {535,  "Roof"},
        {768,  "WP"},
        {1024, "NP"},
        {1536, "Tunnels"}, // Maintenance tunnels
        {1792, "LP"},
    };

    // For starting on player control
    vars.PrimeStart = false;
    vars.WillStart = false;
}

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
    if (old.CaseMenuState == 2 && current.CaseMenuState == 0 && !vars.CaseStarts.Contains(current.CampaignProgress))
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

    // Splitting on room transitions
    if (current.RoomId != old.RoomId)
    {
        if (vars.Rooms.ContainsKey(current.RoomId) && vars.Rooms.ContainsKey(old.RoomId))
        {
            int chapter = 0;
            foreach (int key in vars.CaseProgress.Keys)
            {
                if (vars.CaseProgress[key].Contains(current.CampaignProgress))
                {
                    chapter = key;
                    break;
                }
            }

            string settingsKey = "case" + chapter.ToString() + vars.Rooms[old.RoomId] + "->" + vars.Rooms[current.RoomId];
            if (vars.Splits.Contains(settingsKey))
            {
                return false;
            }

            // Special handlers
            // Case 2
            if (current.CampaignProgress < 215)
            {
                if (settingsKey == "case2WP->PP" || settingsKey == "case2LP->PP")
                {
                    return false;
                }
            }

            vars.Splits.Add(settingsKey);
            return settings[settingsKey];
        }
    }

    // First Aid
    if (current.CampaignProgress == 215 && old.CampaignProgress != 215)
    {
        if (!vars.Splits.Contains("case2FirstAid"))
        {
            vars.Splits.Add("case2FirstAid");
            return settings["case2FirstAid"];
        }
    }

    // Bombs
    if (current.Bombs > old.Bombs)
    {
        return settings["case7Bomb" + current.Bombs.ToString()];
    }

    // Brock
    if (current.CutsceneId == 144 && current.BossHealth == 0 && old.BossHealth != 0)
    {
        return settings["otBrock"];
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
                return settings["kills" + count.ToString()];
            }
        };
    }
}