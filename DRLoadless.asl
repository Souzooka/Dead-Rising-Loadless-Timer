state("DeadRising", "SteamPatch3")
{
    bool IsLoading : 0x1945F70, 0x70;

    // Used for subcase splitting
    byte CaseMenuState : 0x1946FC0, 0x2F058, 0x182;
    
    // Various split variables
    byte Bombs : 0x1944DD8, 0x20DC0, 0x848D;
    byte WatchCase1 : 0x1D18C80, 0x1F58;
    byte WatchCase2 : 0x1D18C80, 0x1F5F;
    byte WatchCase3 : 0x1D18C80, 0x1F66;
    byte WatchCase4 : 0x1D18C80, 0x1F6D;
    byte PPRewardText1 : 0x1946950, 0x154;
    byte PPRewardText2 : 0x1946950, 0x80;
    int CampaignProgress : 0x1944DD8, 0x20DC0, 0x150;
    int CutsceneId : 0x1944DD8, 0x20DC0, 0x8308;
    int Supplies : 0x1944DD8, 0x20FB0;
    int InGameTime : 0x1946FC0, 0x2F058, 0x198;
    int PlayerKills : 0x1959EA0, 0x3B0;
    int PlayerLevel : 0x1946950, 0x68;
    int RoomId : 0x1945F70, 0x48;
    float BossHealth : 0x1CF2620, 0x118, 0x12EC;
    float Boss2Health : 0x1CF2620, 0x118, 0x10, 0x12EC;
    float Boss3Health : 0x1CF2620, 0x118, 0x10, 0x10, 0x12EC;
    float Convict1Health : 0x1CF2620, 0xA0, 0x1220, 0x1C0, 0x12EC;
    float Convict2Health : 0x1CF2620, 0xA0, 0x1220, 0x1A0, 0x12EC;
    float Convict3Health : 0x1CF2620, 0xA0, 0x1220, 0x180, 0x12EC;
    uint PhotoStatsPtr : 0x1959EA0, 0xA8;
    int Transmissions : 0x1946398, 0xD10, 0xCA8, 0xCA8, 0xCB0;
}

startup
{
    #region Settings
    // Settings tree
    settings.Add("splits", true, "All Splits");

        // 72 Hour splits
        settings.Add("72Hour", false, "72 Hour Splits", "splits");

            // Case 1
            settings.Add("case1", false, "Case 1 Splits", "72Hour");
                settings.Add("case1EntrancePlaza", false, "Entrance Plaza", "case1");
                settings.Add("case1Barnaby", false, "Met Barnaby", "case1");
                settings.Add("case1Prologue", false, "Prologue", "case1");
                settings.Add("case1.1", false, "Case 1-1", "case1");
                settings.Add("case1.2", false, "Case 1-2", "case1");
                settings.Add("case1.3", false, "Case 1-3", "case1");
                settings.Add("case1.4", false, "Case 1-4", "case1");
                settings.Add("convicts", false, "Convicts", "case1");
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
                settings.Add("case2.1", false, "Case 2-1", "case2");
                settings.Add("case2Steven", false, "Steven", "case2");
                settings.Add("case2FirstAid", false, "First Aid", "case2");
                settings.Add("case2.2", false, "Case 2-2", "case2");
                settings.Add("case2.3", false, "Case 2-3", "case2");
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

            // Case 3
            settings.Add("case3", false, "Case 3 Splits", "72Hour");
                settings.Add("case3.1", false, "Case 3-1", "case3");

            // Case 4
            settings.Add("case4", false, "Case 4 Splits", "72Hour");
                settings.Add("case4.1", false, "Case 4-1", "case4");
                settings.Add("case4IsabelaStart", false, "Start Isabela Fight", "case4");
                settings.Add("case4.2", false, "Case 4-2", "case4");
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
                settings.Add("case5.1", false, "Case 5-1", "case5");
                settings.Add("case5.2", false, "Case 5-2", "case5");
                settings.Add("case5Transitions", false, "Room Transitions", "case5");
                    settings.Add("case5NP->LP", false, "North Plaza->Leisure Park", "case5Transitions");
                    settings.Add("case5LP->PP", false, "Lesiure Park->Paradise Plaza", "case5Transitions");
                    settings.Add("case5PP->WH", false, "Paradise Plaza->Warehouse", "case5Transitions");
                    settings.Add("case5WH->RT", false, "Warehouse->Rooftop", "case5Transitions");
                    settings.Add("case5RT->SR", false, "Rooftop->Security Room", "case5Transitions");

            // Case 6
            settings.Add("case6", false, "Case 6 Splits", "72Hour");
                settings.Add("case6.1", false, "Case 6-1", "case6");

            // Case 7
            settings.Add("case7", false, "Case 7 Splits", "72Hour");
                settings.Add("case7.1", false, "Case 7-1", "case7");
                for (int i = 1; i <= 5; ++i)
                {
                    settings.Add("case7Bomb" + i.ToString(), false, "Bomb #" + i.ToString(), "case7");
                }
                settings.Add("case7.2", false, "Case 7-2", "case7");
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
                settings.Add("case8.1", false, "Case 8-1", "case8");
                settings.Add("case8.2", false, "Case 8-2", "case8");
                settings.Add("case8.3", false, "Case 8-3", "case8");
                settings.Add("case8.4", false, "Case 8-4", "case8");
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

            // Case 9
            settings.Add("case9.1", false, "The Facts", "72Hour");

            // Endings
            settings.Add("endings", false, "Endings", "72Hour");
                settings.Add("endingA", false, "Ending A", "endings");

        // Overtime splits
        settings.Add("overtime", false, "Overtime", "splits");
            settings.Add("otDrone", false, "Frank sees a sick RC Drone", "overtime");
            settings.Add("otSupplies", false, "Supplies", "overtime");
                settings.Add("otSupplyTaken", false, "Splits when you grab the supplies", "otSupplies");
                settings.Add("otSupplyHideout", false, "Back to hideout", "otSupplies");
            settings.Add("otClockTower", false, "Clock Tower", "overtime");
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

        settings.Add("psycho", false, "PsychoSkip", "splits");
            settings.Add("psychoKent1", false, "Kent First Encounter", "psycho");
            settings.Add("psychoConvicts1", false, "Convicts First Encounter", "psycho");
            settings.Add("psychoCliff", false, "Cliff", "psycho");
            settings.Add("psychoCletus", false, "Cletus", "psycho");
            settings.Add("psychoAdam", false, "Adam", "psycho");
            settings.Add("psychoGreg", false, "Greg", "psycho");
            settings.Add("psychoKent2", false, "Kent Second Encounter", "psycho");
            settings.Add("psychoJo", false, "Jo", "psycho");
            settings.Add("psychoBrad", false, "Brad", "psycho");
            settings.Add("psychoSnipers", false, "Snipers", "psycho");
            settings.Add("psychoConvicts2", false, "Convicts Second Encounter", "psycho");
            settings.Add("psychoSean", false, "Sean", "psycho");
            settings.Add("psychoPaul", false, "Paul", "psycho");
            settings.Add("psychoKent3", false, "Kent Third Encounter", "psycho");

        settings.Add("survivor", false, "SurvivorSkip", "splits"); 
            settings.Add("uNpc00", false, "Burt Thompson", "survivor");
            settings.Add("uNpc01", false, "Heather Tompkins", "survivor");
            settings.Add("uNpc02", false, "Nathalie Meyer", "survivor");
            settings.Add("uNpc03", false, "Gordon Stalworth", "survivor");
            settings.Add("uNpc04", false, "Aaron Swoop", "survivor");
            settings.Add("uNpc05", false, "Jeff Meyer", "survivor");
            settings.Add("uNpc06", false, "Pamela Tompkins", "survivor");
            settings.Add("uNpc07", false, "Kindell Johnson", "survivor");
            settings.Add("uNpc08", false, "Jolie Wu", "survivor");
            settings.Add("uNpc09", false, "Rachel Decker", "survivor");
            settings.Add("uNpc0a", false, "Susan Walsh", "survivor");
            settings.Add("uNpc0b", false, "Ronald Shiner", "survivor");
            settings.Add("uNpc0c", false, "Leah Stein", "survivor");
            settings.Add("uNpc0d", false, "David Bailey", "survivor");
            settings.Add("uNpc0e", false, "Floyd Sanders", "survivor"); 
            settings.Add("uNpc0f", false, "Yuu Tanaka", "survivor");
            settings.Add("uNpc10", false, "Shinji Kitano", "survivor");
            settings.Add("uNpc11", false, "Tonya Waters", "survivor");
            settings.Add("uNpc12", false, "Ross Folk", "survivor");
            settings.Add("uNpc13", false, "Wayne Blackwell", "survivor");
            settings.Add("uNpc14", false, "Bill Brenton", "survivor");
            settings.Add("uNpc15", false, "Sally Mills", "survivor");
            settings.Add("uNpc16", false, "Nick Evans", "survivor");
            settings.Add("uNpc17", false, "Leroy McKenna", "survivor");
            settings.Add("uNpc18", false, "Simone Ravendark", "survivor");
            settings.Add("uNpc19", false, "Gil Jimenez", "survivor");
            settings.Add("uNpc1a", false, "Brett Styles", "survivor");
            settings.Add("uNpc1b", false, "Jonathan Picardsen", "survivor"); 
            settings.Add("uNpc1d", false, "Alyssa Laurent", "survivor");
            settings.Add("uNpc1e", false, "Paul Carson", "survivor");
            settings.Add("uNpc1f", false, "Sophie Richards", "survivor");
            settings.Add("uNpc20", false, "Jennifer Gorman", "survivor");
            settings.Add("uNpc21", false, "Kent Swanson", "survivor");
            settings.Add("uNpc40", false, "Ray Mathison", "survivor");
            settings.Add("uNpc42", false, "Nathan Crabbe", "survivor");
            settings.Add("uNpc44", false, "Michelle Feltz", "survivor");
            settings.Add("uNpc45", false, "Cheryl Jones", "survivor");
            settings.Add("uNpc46", false, "Beth Shrake", "survivor");
            settings.Add("uNpc4c", false, "Josh Manning", "survivor");
            settings.Add("uNpc4d", false, "Barbara Patterson", "survivor");
            settings.Add("uNpc4e", false, "Rich Atkins", "survivor");
            settings.Add("uNpc4f", false, "Mindy Baker", "survivor");
            settings.Add("uNpc50", false, "Debbie Willet", "survivor");
            settings.Add("uNpc52", false, "Tad Hawthorne", "survivor");
            settings.Add("uNpc54", false, "Greg Simpson", "survivor");
            settings.Add("uNpc56", false, "Kay Nelson", "survivor");
            settings.Add("uNpc57", false, "Lilly Deacon", "survivor");
            settings.Add("uNpc59", false, "Kelly Carpenter", "survivor");
            settings.Add("uNpc5a", false, "Janet Star", "survivor");
            settings.Add("survivorEscape", false, "Ending B", "survivor");

        settings.Add("MRSplits", false, "Mutinies & Requests", "splits");
            settings.Add("KBetrayal", false, "Kindell's Betrayal", "MRSplits");
            settings.Add("RAppetite", false, "Ronald's Appetite", "MRSplits");
            settings.Add("FSommelier", false, "Floyd The Sommelier", "MRSplits");
            settings.Add("SGunslinger", false, "Simone The Gunslinger", "MRSplits");
            settings.Add("PPresent", false, "Paul's Present", "MRSplits");
            settings.Add("CRequest", false, "Cheryl's Request", "MRSplits");



        // Max Level
        settings.Add("maxLevel", false, "Max Level", "splits");
            for (int level = 5; level <= 50; level += 5)
            {
                settings.Add("level" + level.ToString(), false, "Level " + level.ToString(), "maxLevel");
            }

        // Zombie Genocider
        settings.Add("zombieGenocider", false, "Zombie Genocider", "splits");
            vars.GenociderKills = new List<int> {2500, 5000, 7500, 10000, 10719, 12500, 15000, 17500, 20000, 21438, 22500, 25000, 27500, 30000, 32157, 32500, 35000, 37500, 40000, 42500, 42876, 45000, 47500, 50000, 52500, 53594};
            foreach(int count in vars.GenociderKills)
            {
                settings.Add("kills" + count.ToString(), false, String.Format("{0:n0}", count) + " kills", "zombieGenocider");
            };

        // PP stickers
        settings.Add("ppStickers", false, "PP Stickers", "splits");
            settings.Add("ppStickers1", false, "Split on every sticker", "ppStickers");
            settings.Add("ppStickers2", false, "Split on every photo which includes PP stickers", "ppStickers");

        settings.Add("willametteGenocider", false, "Willamette Genocider", "splits");
            settings.Add("wgSurvivors", false, "Survivors death", "willametteGenocider");

        //Otis Transistor Calls
        settings.Add("Otis", false, "Otis Transmissions", "splits");
            settings.Add("Otis1", false, "Split on every Otis Transmission picked up", "Otis");

#endregion
}

init 
{
    // Pending splits (for PP collector mostly)
    vars.PendingSplits = 0;

    // A PP Sticker Counter
    vars.PPStickersCount = 0;

    // Keep track of hit splits
    vars.Splits = new HashSet<string>();

    // For splitting when hitting a cutscene
    vars.Cutscenes = new Dictionary<int, string>
    {
        {2,   "case1EntrancePlaza"},
        {3,   "case1Barnaby"},
        {4,   "case1Prologue"},
        {22,  "case2Steven"},
        {26,  "case4IsabelaStart"},
        {31,  "case5Zombie"},
        {53,  "endingA"},
        {70,  "psychoKent3"},
        {71,  "psychoCliff"},
        {72,  "psychoCletus"},
        {73,  "psychoSean"},
        {74,  "psychoAdam"},
        {75,  "psychoJo"},
        {76,  "psychoPaul"},
        {112, "psychoKent1"},
        {117, "psychoKent2"},
        {125, "otClockTower"},
        {126, "otQueens"},
        {131, "otSupplyHideout"},
        {136, "otTunnel"},
        {140, "otDrone"},
        {143, "endingB"},
        {144, "otTank"},
    };

    // Used for room transition splits
    vars.CaseProgress = new Dictionary<string, HashSet<int>>
    {
        {"1",   new HashSet<int>(Enumerable.Range(10, 150))},
        {"2",   new HashSet<int>(Enumerable.Range(160, 20))},
        {"2.1", new HashSet<int>(Enumerable.Range(180, 25))},  // Case 2 after saving Barnaby
        {"2.2", new HashSet<int>(Enumerable.Range(215, 1))},   // Case 2 after picking up first-aid
        {"4",   new HashSet<int>(Enumerable.Range(230, 21))},
        {"5",   new HashSet<int>(Enumerable.Range(270, 21))},
        {"7",   new HashSet<int>(Enumerable.Range(320, 21))},
        {"8",   new HashSet<int>(Enumerable.Range(350, 20))},
        {"8.1", new HashSet<int>(Enumerable.Range(370, 20))},
        {"9",   new HashSet<int>(Enumerable.Range(500, 150))}, // Overtime
        {"9.1", new HashSet<int>(Enumerable.Range(650, 999))}, // Overtime after supplies
    };

    // Represents the progress level at the starts of cases for splits.
    vars.CaseStarts = new Dictionary<int, string>
    {
        {80,  "1.1"},
        {110, "1.2"},
        {130, "1.3"},
        {140, "1.4"},
        {160, "2.1"},
        {180, "2.2"},
        {215, "2.3"},
        {220, "3.1"},
        {230, "4.1"},
        {250, "4.2"},
        {280, "5.1"},
        {290, "5.2"},
        {300, "6.1"},
        {320, "7.1"},
        {340, "7.2"},
        {350, "8.1"},
        {360, "8.2"},
        {370, "8.3"},
        {390, "8.4"},
        {400, "9.1"}
    };

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

    vars.Survivors = new List<string>
    {
        "uNpc00",
        "uNpc01",
        "uNpc02",
        "uNpc03",
        "uNpc04",
        "uNpc05",
        "uNpc06",
        "uNpc07",
        "uNpc08",
        "uNpc09",
        "uNpc0a",
        "uNpc0b",
        "uNpc0c",
        "uNpc0d",
        "uNpc0e",
        "uNpc0f",
        "uNpc10",
        "uNpc11",
        "uNpc12",
        "uNpc13",
        "uNpc14",
        "uNpc15",
        "uNpc16",
        "uNpc17",
        "uNpc18",
        "uNpc19",
        "uNpc1a",
        "uNpc1b",
        "uNpc1d",
        "uNpc1e",
        "uNpc1f",
        "uNpc20",
        "uNpc21",
        "uNpc40",
        "uNpc42",
        "uNpc44",
        "uNpc45",
        "uNpc46",
        "uNpc4c",
        "uNpc4d",
        "uNpc4e",
        "uNpc4f",
        "uNpc50",
        "uNpc52",
        "uNpc54",
        "uNpc56",
        "uNpc57",
        "uNpc59",
        "uNpc5a"
    };

    vars.DeadSurvivors = new List<string>();

    // For starting on player control
    vars.PrimeStart = false;
    vars.WillStart = false;
    
    // Add Watchers for NPC Statues
    vars.NPCStates = new MemoryWatcherList();
    
    for (int i = 0; i < 51; ++i)
    {
        var statePtr = new DeepPointer("DeadRising.exe", 0x1946660, 0x58, 0x8 * i, 0x44);
        var watcher = new MemoryWatcher<byte>(statePtr) { Name = i.ToString() };

        vars.NPCStates.Add(watcher);
    }

    // Add Watchers for NPC Health
    vars.NPCHealth = new MemoryWatcherList();

    for (int i = 0; i < 51; ++i)
    {
        var healthPtr = new DeepPointer("DeadRising.exe", 0x1946660, 0x58, 0x8 * i, 0x18);
        var watcher = new MemoryWatcher<uint>(healthPtr) { Name = i.ToString() };

        vars.NPCHealth.Add(watcher);
    }

    // Use for PP Stickers
    vars.PPStickersLoaded = false;
    vars.PPStickersWatchers = new MemoryWatcherList();
}

update 
{
    // Clear any hit splits if timer stops
    if (timer.CurrentPhase == TimerPhase.NotRunning)
    {
        vars.Splits.Clear();
        vars.PPStickersLoaded = false;
    }

    // For starting on player control
    if (current.InGameTime != 0 && old.InGameTime == 0)
    {
        vars.PrimeStart = true;
    }

    if (vars.PrimeStart && !current.IsLoading && current.CampaignProgress > 0)
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

        if (settings["willametteGenocider"])
        {
            vars.DeadSurvivors.Clear();
        }

        // Load the PP Stickers watchers
        if (settings["ppStickers"] && !vars.PPStickersLoaded)
        {
            vars.PPStickersCount = 0;
            vars.PPStickersWatchers.Clear();

            for (int i = 0; i < 100; ++i)
            {
                var ppStickerPtr = new DeepPointer("DeadRising.exe", 0x1CF3128, 0x40, 0x6E8 + (0x4 * i));
                var watcher = new MemoryWatcher<int>(ppStickerPtr) { Name = i.ToString() };

                vars.PPStickersCount += ppStickerPtr.Deref<int>(game);
                vars.PPStickersWatchers.Add(watcher);
            }
            
            vars.PPStickersLoaded = true;
        }

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
    if (old.CaseMenuState == 2 && (current.CaseMenuState == 0 || current.CaseMenuState == 19))
    {
        if (vars.CaseStarts.ContainsKey(current.CampaignProgress) && !vars.Splits.Contains("case" + vars.CaseStarts[current.CampaignProgress]))
        {
            vars.Splits.Add("case" + vars.CaseStarts[current.CampaignProgress]);
            return settings["case" + vars.CaseStarts[current.CampaignProgress]];
        }
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
    if ((settings["case1Transitions"] || settings["case2Transitions"] ||
            settings["case4Transitions"] || settings["case5Transitions"] || 
            settings["case7Transitions"] || settings["case8Transitions"] || 
            settings["overtimeTransitions"]) 
            && current.RoomId != old.RoomId)
    {
        if (vars.Rooms.ContainsKey(current.RoomId) && vars.Rooms.ContainsKey(old.RoomId))
        {
            string chapter = "0";
            foreach (string key in vars.CaseProgress.Keys)
            {
                if (vars.CaseProgress[key].Contains(current.CampaignProgress))
                {
                    chapter = key;
                    break;
                }
            }

            string settingsKey = "case" + chapter + vars.Rooms[old.RoomId] + "->" + vars.Rooms[current.RoomId];
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
    if (current.CampaignProgress <= 340 && current.CampaignProgress < 350 && current.Bombs > old.Bombs)
    {
        return settings["case7Bomb" + current.Bombs.ToString()];
    }

    // Overtime splits
    if (settings["overtime"])
    {
        // Supplies
        if(current.CutsceneId == 140 && current.Supplies > old.Supplies)
        {
            return settings["otSupplyTaken"];
        }

        // Brock
        if (current.CutsceneId == 144 && current.BossHealth == 0 && old.BossHealth != 0)
        {
            return settings["otBrock"];
        }
    }

    // Willamette Genocider Case 1-4
    // Generic Case Split
    if (settings["willametteGenocider"] && old.CaseMenuState == 2 && current.CaseMenuState == 0)
    {
        if (current.CampaignProgress == 150)
        {
            return settings["case1.4"];
        }
    }

    // Psycho and Willamette Genocider
    if (settings["psycho"] || settings["willametteGenocider"])
    {
        if (settings["psychoGreg"] || settings["wgSurvivors"])
        {
            vars.NPCHealth.UpdateAll(game);

            foreach (var watcher in vars.NPCHealth)
            {
                if (watcher.Changed && (watcher.Current == uint.MaxValue || watcher.Current == (uint)0))
                {
                    int i = int.Parse(watcher.Name);
                    
                    if (game != null)
                    {

                        string npcName = new DeepPointer("DeadRising.exe", 0x1946660, 0x58, 0x8 * i, 0x8, 0x8).DerefString(game, 6);
                    
                        if (!string.IsNullOrEmpty(npcName) && !string.IsNullOrEmpty(npcName.Trim()) && npcName.Trim()[0] == 'u')
                        {
                            // Greg Skip
                            if (settings["psychoGreg"] && npcName == "uNpc54")
                            {
                                return settings["psychoGreg"];
                            }
                            else if (settings["willametteGenocider"] && settings["wgSurvivors"] && !vars.DeadSurvivors.Contains(npcName))
                            {
                                vars.DeadSurvivors.Add(npcName);
                                return vars.Survivors.Contains(npcName);
                            }
                        }
                    }
                }
            }
        }

        // Brad death
        if (old.CaseMenuState == 0 && current.CaseMenuState == 2 && current.CutsceneId == 9)
        {
            // The truth vanished
            if (current.CampaignProgress == 1100)
            {
                return settings["psychoBrad"];
            }
        }

        // Snipers
        if (current.CutsceneId == 64 && current.RoomId == 256 && 
            ((current.BossHealth == 0 && old.BossHealth != 0 && current.Boss2Health == 0 && current.Boss3Health == 0) || 
            (current.Boss2Health == 0 && old.Boss2Health != 0 && current.BossHealth == 0 && current.Boss3Health == 0) ||
            (current.Boss3Health == 0 && old.Boss3Health != 0 && current.Boss2Health == 0 && current.BossHealth == 0)))
        {
            return settings["psychoSnipers"];
        }
    }

    // Convicts
    if (current.RoomId == 1792 &&
        ((current.Convict1Health == 0 && old.Convict1Health != 0 && current.Convict2Health == 0 && current.Convict3Health == 0) || 
        (current.Convict2Health == 0 && old.Convict2Health != 0 && current.Convict1Health == 0 && current.Convict3Health == 0) ||
        (current.Convict3Health == 0 && old.Convict3Health != 0 && current.Convict2Health == 0 && current.Convict1Health == 0)))
    {
        if (current.CutsceneId == 63)
        {
            return settings["convicts"] || settings["psychoConvicts1"];
        }
        else if (current.CutsceneId == 64)
        {
            return settings["psychoConvicts2"];
        }
    }

    // Survivors
   if (settings["survivor"])
    {
        vars.NPCStates.UpdateAll(game);

        foreach (var watcher in vars.NPCStates)
        {
            if (watcher.Changed && watcher.Current == 4 && watcher.Old != 11)
            {
                int i = int.Parse(watcher.Name);
                string npcName = new DeepPointer("DeadRising.exe", 0x1946660, 0x58, 0x8 * i, 0x8, 0x8).DerefString(game, 6);
                return settings[npcName];
            }
        }
    }

        // Mutinies & Requests
    if (settings["MRSplits"])
    {
        if (!vars.Splits.Contains("RAppetite"))
        {
            if (old.WatchCase3 == 37 && current.PPRewardText1 == 20 && current.PPRewardText2 == 1)
            {
                vars.Splits.Add("RAppetite");
                return settings["RAppetite"];
            }
        }

        if (!vars.Splits.Contains("KBetrayal"))
        {
            if (old.WatchCase2 == 36 && current.PPRewardText1 == 20 && current.PPRewardText2 == 1 || old.WatchCase3 == 36 && current.PPRewardText1 == 20 && current.PPRewardText2 == 1)
            {
                vars.Splits.Add("KBetrayal");
                return settings["KBetrayal"];
            }
        }

        if (!vars.Splits.Contains("FSommelier"))
        {
            if (old.WatchCase2 == 38 && current.PPRewardText1 == 21 && current.PPRewardText2 == 1 || old.WatchCase3 == 38 && current.PPRewardText1 == 21 && current.PPRewardText2 == 1 || old.WatchCase4 == 38 && current.PPRewardText1 == 21 && current.PPRewardText2 == 1)
            {
                vars.Splits.Add("FSommelier");
                return settings["FSommelier"];
            }
        }

        if (!vars.Splits.Contains("SGunslimger"))
        {
            if (old.WatchCase2 == 39 && current.PPRewardText1 == 21 && current.PPRewardText2 == 1 || old.WatchCase3 == 39 && current.PPRewardText1 == 21 && current.PPRewardText2 == 1 || old.WatchCase4 == 39 && current.PPRewardText1 == 21 && current.PPRewardText2 == 1)
            {
                vars.Splits.Add("SGunslinger");
                return settings["SGunslinger"];
            }
        }

        if (!vars.Splits.Contains("PPresent"))
        {
            if (old.WatchCase2 == 40 && current.PPRewardText1 == 21 && current.PPRewardText2 == 1 || old.WatchCase3 == 40 && current.PPRewardText1 == 21 && current.PPRewardText2 == 1 || old.WatchCase4 == 40 && current.PPRewardText1 == 21 && current.PPRewardText2 == 1)
            {
                vars.Splits.Add("PPresent");
                return settings["PPresent"];
            }
        }

        if (!vars.Splits.Contains("CRequest"))
        {
            if (old.WatchCase2 == 41 && current.PPRewardText1 == 21 && current.PPRewardText2 == 1 || old.WatchCase3 == 41 && current.PPRewardText1 == 21 && current.PPRewardText2 == 1 || old.WatchCase4 == 41 && current.PPRewardText1 == 21 && current.PPRewardText2 == 1)
            {
                vars.Splits.Add("CRequest");
                return settings["CRequest"];
            }
        }
    }

    // Max Level
    if (settings["maxLevel"] && current.PlayerLevel != old.PlayerLevel)
    {
        return settings["level" + current.PlayerLevel.ToString()];
    }

    // Zombie Genocider
    if (settings["zombieGenocider"] && current.PlayerKills != old.PlayerKills)
    {
        foreach(int count in vars.GenociderKills)
        {
            if (old.PlayerKills < count && count <= current.PlayerKills)
            {
                return settings["kills" + count.ToString()];
            }
        }
    }

    // PP Stickers
    if (settings["ppStickers"] && vars.PPStickersLoaded)
    {
        // Any pending splits (only used if you get multiple PP stickers in one shot)
        if (vars.PendingSplits-- > 0) { return true; }

        vars.PPStickersWatchers.UpdateAll(game);

        int CurrentPPStickersCount = 0;

        foreach (var watcher in vars.PPStickersWatchers)
        {
            CurrentPPStickersCount += watcher.Current;
        }

        if (CurrentPPStickersCount > vars.PPStickersCount)
        {
            if (settings["ppStickers1"])
            {
                vars.PendingSplits = CurrentPPStickersCount - vars.PPStickersCount - 1;
                vars.PPStickersCount = CurrentPPStickersCount;
                return true;
            }
            else if(settings["ppStickers2"])
            {
                vars.PPStickersCount = CurrentPPStickersCount;
                return true;
            }
        }
    }

    // Otis Transmissions
    if (old.Transmissions == 1 && current.Transmissions < 1 && current.CaseStarts != 290)
    {
        {
            vars.Splits.Add("Otis1");
            return settings["Otis1"];
        }
    }
}
