state("DeadRising", "SteamPatch3")
{
    bool IsLoading : 0x1D18C80, 0x2338;

    // Used for subcase splitting
    byte CaseMenuState : 0x1946FC0, 0x2F058, 0x182;
    
    // Various split variables
    byte Bombs : 0x1944DD8, 0x20DC0, 0x848D;
    int CampaignProgress : 0x1944DD8, 0x20DC0, 0x150;
    int CutsceneId : 0x1D1A6B8, 0xA98, 0x22F0, 0x420, 0x20, 0x508, 0x38, 0xC10, 0x8308;
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
                settings.Add("case1Transitions", false, "Room Transitions", "case1");
	                settings.Add("case1HP->SR", false, "Helipad->Security Room", "case1Transitions");
	                settings.Add("case1SR->EP", false, "Security Room->Entrance Plaza", "case1Transitions");
	                settings.Add("case1EP->SR", false, "Entrance Plaza->Security Room", "case1Transitions");
	                settings.Add("case1SR->RT", false, "Security Room>->Rooftop", "case1Transitions");
	                settings.Add("case1RT->WH", false, "Rooftop->Warehouse", "case1Transitions");
	                settings.Add("case1WH->PP", false, "Warehouse->Paradise Plaza", "case1Transitions");
	                settings.Add("case1PP->LP", false, "Paradise Plaza->Leisure Park", "case1Transitions");
	                settings.Add("case1LP->FC", false, "Lesiure Park->Food Court", "case1Transitions");
	                settings.Add("case1FC->AP", false, "Food Court->Al Fresca Plaza", "case1Transitions");
	                settings.Add("case1AP->EP", false, "Al Fresca Plaza->Entrance Plaza", "case1Transitions");
	                settings.Add("case1EP->AP", false, "Entrance Plaza->Al Fresca Plaza", "case1Transitions");
	                settings.Add("case1AP->FC", false, "Al Fresca Plaza->Food Court", "case1Transitions");
	                settings.Add("case1FC->LP", false, "Food Court->Leisure Park", "case1Transitions");
	                settings.Add("case1LP->PP", false, "Lesiure Park->Paradise Plaza", "case1Transitions");
	                settings.Add("case1PP->WH", false, "Paradise Plaza->Warehouse", "case1Transitions");
	                settings.Add("case1WH->RT", false, "Warehouse->Rooftop", "case1Transitions");
	                settings.Add("case1RT->SR", false, "Rooftop->Security Room", "case1Transitions");

            // Case 2
            settings.Add("case2", false, "Case 2 Splits", "72Hour");
                settings.Add("case2FirstAid", false, "First Aid", "case2");
            	settings.Add("case2Transitions", false, "Room Transitions", "case2");
	                settings.Add("case2SR->RT", false, "Security Room->Rooftop", "case2Transitions"); // first time
	                settings.Add("case2RT->WH", false, "Rooftop->Warehouse", "case2Transitions"); // first time
	                settings.Add("case2WH->PP", false, "Warehouse->Paradise Plaza", "case2Transitions"); // first time
	                settings.Add("case2PP->EP", false, "Paradise Plaza->Entrance Plaza", "case2Transitions");
	                settings.Add("case2EP->SR", false, "Entrance Plaza->Security Room", "case2Transitions");
	                settings.Add("case2.1SR->RT", false, "Security Room->Rooftop (After saving Barnaby)", "case2Transitions"); // second time
	                settings.Add("case2.1RT->WH", false, "Rooftop->Warehouse (After saving Barnaby)", "case2Transitions"); // second time
	                settings.Add("case2.1WH->PP", false, "Warehouse->Paradise Plaza (After saving Barnaby)", "case2Transitions"); // second time
	                settings.Add("case2.1PP->WP", false, "Paradise Plaza->Wonderland Plaza (Any%)", "case2Transitions");
	                settings.Add("case2.1WP->NP", false, "Wonderland Plaza->North Plaza (Any%)", "case2Transitions");
	                settings.Add("case2.1PP->LP", false, "Paradise Plaza->Leisure Park (Low%)", "case2Transitions");
	                settings.Add("case2.1LP->NP", false, "Lesiure Park->North Plaza (Low%)", "case2Transitions");
	                settings.Add("case2.1NP->SFS", false, "North Plaza->Seon's Food & Stuff", "case2Transitions");
	                settings.Add("case2.2SFS->NP", false, "Seon's Food & Stuff->North Plaza", "case2Transitions");
	                settings.Add("case2.2NP->WP", false, "North Plaza->Wonderland Plaza (Any%)", "case2Transitions");
	                settings.Add("case2.2WP->PP", false, "Wonderland Plaza->Paradise Plaza (Any%)", "case2Transitions");
	                settings.Add("case2.2NP->LP", false, "North Plaza->Leisure Park (Low%)", "case2Transitions");
	                settings.Add("case2.2LP->PP", false, "Lesiure Park->Paradise Plaza (Low%)", "case2Transitions");
	                settings.Add("case2.2PP->WH", false, "Paradise Plaza->Warehouse", "case2Transitions");
	                settings.Add("case2.2WH->RT", false, "Warehouse->Rooftop", "case2Transitions");
	                settings.Add("case2.2RT->SR", false, "Rooftop->Security Room", "case2Transitions");


            // Case 4
            settings.Add("case4", false, "Case 4 Splits", "72Hour");
            	settings.Add("case4Transitions", false, "Room Transitions", "case4");
	                settings.Add("case4SR->RT", false, "Security Room->Rooftop", "case4Transitions");
	                settings.Add("case4RT->WH", false, "Rooftop->Warehouse", "case4Transitions");
	                settings.Add("case4WH->PP", false, "Warehouse->Paradise Plaza", "case4Transitions");
	                settings.Add("case4PP->WP", false, "Paradise Plaza->Wonderland Plaza (Any%)", "case4Transitions");
	                settings.Add("case4WP->NP", false, "Wonderland Plaza->North Plaza (Any%)", "case4Transitions");
	                settings.Add("case4PP->LP", false, "Paradise Plaza->Leisure Park (Low%)", "case4Transitions");
	                settings.Add("case4LP->NP", false, "Lesiure Park->North Plaza (Low%)", "case4Transitions");

            // Case 5
            settings.Add("case5", false, "Case 5 Splits", "72Hour");
            	settings.Add("case5Zombie", false, "Killed First Zombie", "case5");
            	settings.Add("case5Transitions", false, "Room Transitions", "case5");
	                settings.Add("case5NP->LP", false, "North Plaza->Leisure Park", "case5Transitions");
	                settings.Add("case5LP->PP", false, "Lesiure Park->Paradise Plaza", "case5Transitions");
	                settings.Add("case5PP->WH", false, "Paradise Plaza->Warehouse", "case5Transitions");
	                settings.Add("case5WH->RT", false, "Warehouse->Rooftop", "case5Transitions");
	                settings.Add("case5RT->SR", false, "Rooftop->Security Room", "case5Transitions");

            // Case 7
            settings.Add("case7", false, "Case 7 Splits", "72Hour");
                for (int i = 1; i <= 5; ++i)
                {
                    settings.Add("case7Bomb" + i.ToString(), false, "Bomb #" + i.ToString(), "case7");
                }
                settings.Add("case7Transitions", false, "Room Transitions", "case7");
	                settings.Add("case7SR->RT", false, "Security Room->Rooftop", "case7Transitions");
	                settings.Add("case7RT->WH", false, "Rooftop->Warehouse", "case7Transitions");
	                settings.Add("case7WH->PP", false, "Warehouse->Paradise Plaza", "case7Transitions");
	                settings.Add("case7PP->MT", false, "Paradise Plaza->Maintenance Tunnels (Any%)", "case7Transitions");
	                settings.Add("case7PP->LP", false, "Paradise Plaza->Leisure Park (Low%)", "case7Transitions");
	                settings.Add("case7LP->MT", false, "Lesiure Park->Maintenance Tunnels (Low%)", "case7Transitions");
	                settings.Add("case7MT->LP", false, "Maintenance Tunnels->Leisure Park", "case7Transitions");

            // Case 8
            settings.Add("case8", false, "Case 8 Splits", "72Hour");
            settings.Add("case8Transitions", false, "Room Transitions", "case8");
                settings.Add("case8SR->RT", false, "Security Room->Rooftop", "case8Transitions"); // First time
                settings.Add("case8RT->WH", false, "Rooftop->Warehouse", "case8Transitions"); // First time
                settings.Add("case8WH->PP", false, "Warehouse->Paradise Plaza", "case8Transitions"); // First time
                settings.Add("case8PP->LP", false, "Paradise Plaza->Leisure Park", "case8Transitions");
                settings.Add("case8LP->NP", false, "Lesiure Park->North Plaza", "case8Transitions");
                settings.Add("case8NP->CH", false, "North Plaza->Carlito's Hideout", "case8Transitions");
                settings.Add("case8CH->NP", false, "Carlito's Hideout->North Plaza", "case8Transitions");
                settings.Add("case8NP->WP", false, "North Plaza->Wonderland Plaza (Any%)", "case8Transitions");
                settings.Add("case8WP->PP", false, "Wonderland Plaza->Paradise Plaza (Any%)", "case8Transitions");
                settings.Add("case8NP->LP", false, "North Plaza->Leisure Park (Low%)", "case8Transitions");
                settings.Add("case8LP->PP", false, "Lesiure Park->Paradise Plaza (Low%)", "case8Transitions");
                settings.Add("case8PP->WH", false, "Paradise Plaza->Warehouse", "case8Transitions");
                settings.Add("case8WH->RT", false, "Warehouse->Rooftop", "case8Transitions");
                settings.Add("case8RT->SR", false, "Rooftop->Security Room", "case8Transitions");
                settings.Add("case8.1SR->RT", false, "Security Room->Rooftop (After Jessie)", "case8Transitions"); // Second time
                settings.Add("case8.1RT->WH", false, "Rooftop->Warehouse (After Jessie)", "case8Transitions"); // Second time
                settings.Add("case8.1WH->PP", false, "Warehouse->Paradise Plaza (After Jessie)", "case8Transitions"); // Second time
                settings.Add("case8.1PP->MT", false, "Paradise Plaza->Maintenance Tunnels (Any%)", "case8Transitions");
                settings.Add("case8.1PP->LP", false, "Paradise Plaza->Leisure Park (Low%)", "case8Transitions");
                settings.Add("case8.1LP->MT", false, "Lesiure Park->Maintenance Tunnels (Low%)", "case8Transitions");
                settings.Add("case8.1MT->MPA", false, "Maintenance Tunnels->Meat Processing Area", "case8Transitions");

        // Overtime splits
        settings.Add("overtime", false, "Overtime", "splits");
            settings.Add("otDrone", false, "Frank sees a sick RC Drone", "overtime");
        	settings.Add("otSupplies", false, "Supplies", "overtime");
        	settings.Add("otQueens", false, "Queens", "overtime");
        	settings.Add("otTunnel", false, "Tunnel", "overtime");
        	settings.Add("otTank", false, "Tank", "overtime");
        	settings.Add("otBrock", false, "Brock", "overtime");
        	settings.Add("overtimeTransitions", false, "Room Transitions", "overtime");
	            settings.Add("case9CH->NP", false, "Carlito's Hideout->North Plaza", "overtimeTransitions");
	            settings.Add("case9NP->WP", false, "North Plaza->Wonderland Plaza (Any%)", "overtimeTransitions");
	            settings.Add("case9WP->PP", false, "Wonderland Plaza->Paradise Plaza (Any%)", "overtimeTransitions");
	            settings.Add("case9NP->LP", false, "North Plaza->Leisure Park (Low%)", "overtimeTransitions");
	            settings.Add("case9LP->PP", false, "Lesiure Park->Paradise Plaza (Low%)", "overtimeTransitions");
	            settings.Add("case9PP->WH", false, "Paradise Plaza->Warehouse", "overtimeTransitions");
	            settings.Add("case9WH->RT", false, "Warehouse->Rooftop", "overtimeTransitions");
	            settings.Add("case9RT->SR", false, "Rooftop->Security Room", "overtimeTransitions");
	            settings.Add("case9SR->EP", false, "Security Room->Entrace Plaza", "overtimeTransitions");
	            settings.Add("case9EP->PP", false, "Entrance Plaza->Paradise Plaza", "overtimeTransitions");
	            settings.Add("case9PP->WP", false, "Paradise Plaza->Wonderland Plaza (Any%)", "overtimeTransitions");
	            settings.Add("case9PP->CM", false, "Paradise Plaza->Colby's Movieland (Low%)", "overtimeTransitions");
	            settings.Add("case9CM->PP", false, "Colby's Movieland->Paradise Plaza (Low%)", "overtimeTransitions");
	            settings.Add("case9PP->LP", false, "Paradise Plaza->Leisure Park (Low%)", "overtimeTransitions");
	            settings.Add("case9LP->FC", false, "Lesiure Park->Food Court (Low%)", "overtimeTransitions");
	            settings.Add("case9FC->WP", false, "Food Court->Wonderland Plaza (Low%)", "overtimeTransitions");
	            settings.Add("case9WP->NP", false, "Wonderland Plaza->North Plaza", "overtimeTransitions");
	            settings.Add("case9NP->SFS", false, "North Plaza->Seon's Food & Stuff", "overtimeTransitions");
	            settings.Add("case9SFS->NP", false, "Seon's Food & Stuff->North Plaza", "overtimeTransitions");
	            settings.Add("case9NP->CH", false, "North Plaza->Carlito's Hideout", "overtimeTransitions");
	            settings.Add("case9.1CH->NP", false, "Carlito's Hideout->North Plaza (Queens)", "overtimeTransitions");
	            settings.Add("case9.1NP->LP", false, "North Plaza->Leisure Park (Queens)", "overtimeTransitions");
	            settings.Add("case9.1LP->NP", false, "Lesiure Park->North Plaza (Queens)", "overtimeTransitions");
	            settings.Add("case9.1NP->CH", false, "North Plaza->Carlito's Hideout (Queens)", "overtimeTransitions");
	            settings.Add("case9.1CH->T1", false, "Carlito's Hideout->Tunnels 1", "overtimeTransitions");
	            settings.Add("case9.1T1->T2", false, "Tunnels 1->Tunnels 2", "overtimeTransitions");
	            settings.Add("case9.1T2->T3", false, "Tunnels 2->Tunnels 3", "overtimeTransitions");


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
        {31,  "case5Zombie"},
        {126, "otQueens"},
        {131, "otSupplies"},
        {136, "otTunnel"},
        {140, "otDrone"},
        {144, "otTank"},
    };

    vars.CaseProgress = new Dictionary<double, HashSet<int>>
    {
    	{1,   new HashSet<int>(Enumerable.Range(10, 150))},
        {2,   new HashSet<int>(Enumerable.Range(160, 20))},
        {2.1, new HashSet<int>(Enumerable.Range(180, 25))},  // Case 2 after saving Barnaby
        {2.2, new HashSet<int>(Enumerable.Range(215, 1))},   // Case 2 after picking up first-aid
        {4,   new HashSet<int>(Enumerable.Range(230, 21))},
        {5,   new HashSet<int>(Enumerable.Range(270, 21))},
        {7,   new HashSet<int>(Enumerable.Range(320, 21))},
        {8,   new HashSet<int>(Enumerable.Range(350, 20))},
        {8.1, new HashSet<int>(Enumerable.Range(370, 20))},
        {9,   new HashSet<int>(Enumerable.Range(500, 150))}, // Overtime
        {9.1, new HashSet<int>(Enumerable.Range(650, 999))}, // Overtime after supplies
    };

    // Represents the progress level at the starts of cases. Provided so that we don't split on them.
    vars.CaseStarts = new HashSet<int> {160, 230, 280, 320, 350};

    vars.Rooms = new Dictionary<int, string>
    {
        {256,  "EP"},  // Entrance Plaza
        {287,  "HP"},  // Helipad
        {288,  "SR"},  // Security Room
        {512,  "PP"},  // Paradise Plaza
        {534,  "WH"},  // Warehouse
        {535,  "RT"},  // Rooftop
        {768,  "WP"},  // Wonderland Plaza
        {1024, "NP"},  // North Plaza
        {1025, "CH"},  // Carlito's Hideout
        {1280, "SFS"}, // Seon's Food & Stuff
        {1283, "CM"},  // Colby's Movieland
        {1536, "MT"},  // Maintenance Tunnels
        {1537, "MPA"}, // Meat Processing Area
        {1792, "LP"},  // Leisure Park
        {2304, "AP"},  // Al Fresca Plaza
        {2560, "FC"},  // Food Court
        {2816, "T1"},  // Tunnels 1
        {2817, "T2"},  // Tunnels 2
        {2818, "T3"},  // Tunnels 3
    };

    // For starting on player control
    vars.PrimeStart = false;
    vars.WillStart = false;
}

update 
{
    print(current.CutsceneId.ToString());
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
            double chapter = 0;
            foreach (double key in vars.CaseProgress.Keys)
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

            vars.Splits.Add(settingsKey);

            // ONLY return if the setting is enabled, as some transitions are duplicates
            if (settings[settingsKey])
            {
                return true;
            };
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