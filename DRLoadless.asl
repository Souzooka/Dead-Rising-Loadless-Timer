/* Pointers found and code written by Souzooka.
Load removal and autosplitting. All achievements/etc. not supported.
*/

state("DeadRising", "SteamPatch3")
{
    uint currentRoomValue : 0x01945F70, 0x40;               // Represents the current room Frank is in
    uint loadingRoomValue : 0x01945F70, 0x48;               // Represents the room Frank is loading
    uint bossHealth : 0x01CF2620, 0x118, 0x12EC;            // Represents the health of the primary (?) boss
    float frankX : 0x01CF2620, 0xC8, 0x40;                  // Represents Frank's X position
    bool inCutsceneOrLoad : 0x01D18C80, 0x2338;             // Represents if the game is in a cutscene or loading.
    ushort campaignProgress : 0x01944DD8, 0x20DC0, 0x150;   // Represents the current campaign progress
    byte bombsCollected : 0x1944DD8, 0x20DC0, 0x848D;       // Represents the number of bombs collected
    uint inGameTimer : 0x1946FC0, 0x2F058, 0x198;           // Represents the current game timer (108000 per in-game hour, starting at 3888000)
    byte caseFileOpen : 0x1946FC0, 0x2F058, 0x184;          // TODO: Needs more explanation
    byte caseMenuOpen : 0x1946FC0, 0x2F058, 0x182;          // TODO: Tracks HUD menu state, not only case menu, needs more explanation
    uint mainMenuID : 0x1946FC0, 0x2F058, 0x38;             // Tracks menu state of the main menu, needs more documentation
    uint kills : 0x1959EA0, 0x3B0;                          // Tracks player kills, used for zombie genocider splits
    uint level : 0x1946950, 0x68;                           // Tracks player level, used for max level splits
    ushort kentMenu : 0x19468D8, 0x38;                      // bool inCutsceneOrLoad thinks the game is in a cutscene when picking a picture for Kent, we can check this to disable that behavior
}

startup
{
    vars.getRunStarted = 0; // TODO: Unnecessary var, access timer state directly

    // Settings
    settings.Add("splits", false, "All Splits");
    // Misc splits
    settings.Add("misc", false, "Miscellaneous Splits", "splits");
    settings.Add("shortcutpw", false, "Shortcut (PP to WP)", "misc");
    settings.Add("shortcutwp", false, "Shortcut (WP to PP)", "misc");
    settings.SetToolTip("shortcutpw", "Splits when traveling to Wonderland Plaza from Paradise Plaza.");
    settings.SetToolTip("shortcutwp", "Splits when traveling to Paradise Plaza from Wonderland Plaza.");
    // Split after every case
    settings.Add("72Hour", false, "72 Hour Splits", "splits");
    settings.Add("caseSplits", false, "Split on Case End (all cases)", "72Hour");
    settings.SetToolTip("caseSplits", "Splits after a case has been filled into the case file.");
    // Case 1
    settings.Add("case1", false, "Case 1 Splits", "72Hour");
    settings.Add("prologue", false, "Prologue", "case1");
    settings.SetToolTip("prologue", "Splits after escaping Entrance Plaza.");
    // Case 2
    settings.Add("case2", false, "Case 2 Splits", "72Hour");
    settings.Add("steven", false, "Steven", "case2");
    settings.Add("firstaid", false, "First Aid", "case2");
    settings.SetToolTip("steven", "Splits after killing Steven.");
    settings.SetToolTip("firstaid", "Splits after collecting first aid.");
    // Case 4
    settings.Add("case4", false, "Case 4 Splits", "72Hour");
    settings.Add("elevator4", false, "Elevator", "case4");
    settings.Add("warehouse", false, "Warehouse", "case4");
    settings.Add("wonderlandPlaza", false, "Wonderland Plaza", "case4");
    settings.SetToolTip("elevator4", "Splits after entering the Warehouse in Case 4.");
    settings.SetToolTip("warehouse", "Splits after entering Paradise Plaza in Case 4.");
    settings.SetToolTip("wonderlandPlaza", "Splits after entering North Plaza in Case 4.");
    // Case 5
    settings.Add("case5", false, "Case 5 Splits", "72Hour");
    settings.Add("northPlaza", false, "North Plaza", "case5");
    settings.Add("leisurePark", false, "Leisure Park", "case5");
    settings.Add("paradisePlaza5", false, "Paradise Plaza", "case5");
    settings.Add("elevator5", false, "Elevator", "case5");
    settings.SetToolTip("northPlaza", "Splits after entering Leisure Park in Case 5.");
    settings.SetToolTip("leisurePark", "Splits after entering Paradise Plaza in Case 5.");
    settings.SetToolTip("paradisePlaza5", "Splits after entering the Warehouse in Case 5.");
    settings.SetToolTip("elevator5", "Splits after entering the Rooftop in Case 5.");
    // Case 7
    settings.Add("case7", false, "Case 7 Splits", "72Hour");
    settings.Add("paradisePlaza7", false, "Paradise Plaza", "case7");
    settings.SetToolTip("paradisePlaza7", "Splits after entering the Maintenance Tunnels in Case 7.");
        // Bombs
    settings.Add("allBombs", false, "Bombs", "case7");
    settings.Add("bomb1", false, "First Bomb", "allBombs");
    settings.Add("bomb2", false, "Second Bomb", "allBombs");
    settings.Add("bomb3", false, "Third Bomb", "allBombs");
    settings.Add("bomb4", false, "Fourth Bomb", "allBombs");
    settings.Add("bomb5", false, "Fifth Bomb", "allBombs");
    settings.SetToolTip("bomb1", "Splits after collecting first bomb.");
    settings.SetToolTip("bomb2", "Splits after collecting second bomb.");
    settings.SetToolTip("bomb3", "Splits after collecting third bomb.");
    settings.SetToolTip("bomb4", "Splits after collecting fourth bomb.");
    settings.SetToolTip("bomb5", "Splits after collecting fifth bomb.");
    // Case 8
    settings.Add("case8", false, "Case 8 Splits", "72Hour");
    settings.Add("paradisePlaza8", false, "Paradise Plaza", "case8");
    settings.Add("72HourEnd", false, "72 Hour Mode End", "72Hour");
    settings.SetToolTip("paradisePlaza8", "Splits after entering Leisure Park in Case 8.");
    settings.SetToolTip("72HourEnd", "Splits when entering the hideout after finishing Case 8.");
    // Overtime
    settings.Add("overtime", false, "Overtime Splits", "splits");
    settings.Add("supplies", false, "Supplies", "overtime");
    settings.Add("queens", false, "Queens", "overtime");
    settings.Add("tunnel", false, "Tunnel", "overtime");
    settings.Add("tank", false, "Tank", "overtime");
    settings.Add("brock", false, "Brock", "overtime");
    settings.SetToolTip("supplies", "Splits after giving Isabella supplies.");
    settings.SetToolTip("queens", "Splits after giving Isabella 10 queens.");
    settings.SetToolTip("tunnel", "Splits after entering jeep at the end of tunnel.");
    settings.SetToolTip("tank", "Splits when tank's HP is 0.");
    settings.SetToolTip("brock", "Splits when Brock's HP is 0.");
    // Levels
    settings.Add("maxLevel", false, "Max Level", "splits");
    settings.Add("level5", false, "Level 5", "maxLevel");
    settings.Add("level10", false, "Level 10", "maxLevel");
    settings.Add("level15", false, "Level 15", "maxLevel");
    settings.Add("level20", false, "Level 20", "maxLevel");
    settings.Add("level25", false, "Level 25", "maxLevel");
    settings.Add("level30", false, "Level 30", "maxLevel");
    settings.Add("level35", false, "Level 35", "maxLevel");
    settings.Add("level40", false, "Level 40", "maxLevel");
    settings.Add("level45", false, "Level 45", "maxLevel");
    settings.Add("level50", false, "Level 50", "maxLevel");
    // Zombie Genocider
    settings.Add("genocider", false, "Zombie Genocider", "splits");
    settings.Add("kills10k", false, "10,000 kills", "genocider");
    settings.Add("kills20%", false, "10,719 kills", "genocider");
    settings.Add("kills20k", false, "20,000 kills", "genocider");
    settings.Add("kills40%", false, "21,438 kills", "genocider");
    settings.Add("kills30k", false, "30,000 kills", "genocider");
    settings.Add("kills60%", false, "32,157 kills", "genocider");
    settings.Add("kills40k", false, "40,000 kills", "genocider");
    settings.Add("kills80%", false, "42,876 kills", "genocider");
    settings.Add("kills50k", false, "50,000 kills", "genocider");
    settings.Add("killsFinal", false, "53,594 kills", "genocider");
    // Timing methods
    settings.Add("timingMethods", true, "Timing Method");
    settings.Add("loadless1", true, "Loadless", "timingMethods");
    settings.Add("loadless2", false, "Loadless + Menuless", "timingMethods");
    settings.SetToolTip("loadless1", "Legal official timing method which pauses the timer during loads and cutscene.");
    settings.SetToolTip("loadless2", "Unofficial timing method which, along with pausing during loads and cutscenes, also pauses during menus (not the pause menu).");
}

reset
{
//	Resets when the title menu is entered.
    if (current.mainMenuID == 264){
        vars.getRunStarted = 0;     // TODO: a getRunStarted check isn't necessary, we can refactor to access timer state directly
        return true;                // TODO: After refactoring, just return current.mainMenuID == 264
    }
}

start
{
//	For runs starting from the main menu, starts on new game. Also starts Case 5 (which doesn't start with a case file screen)
    if (current.inGameTimer == 3888000 	|| 	// Starting time for new game
        current.inGameTimer == 12528000 || 	// Starting time for overtime
        current.campaignProgress == 270) {	// Starting progress for case 5
        return current.mainMenuID == 3;     // TODO: What does current.mainMenuID == 3 represent?
    }

    //	Case 2, 4, 7, 8 Start
    else if (current.campaignProgress in {160, 230, 320, 350} && 	
        current.inCutsceneOrLoad == false 	                  && 
        current.mainMenuID == 3                               && 
        vars.getRunStarted == 0) {                              // TODO: a getRunStarted check isn't necessary, we can refactor to access timer state directly
            vars.getRunStarted = 1;	                            // TODO: a getRunStarted check isn't necessary, we can refactor to access timer state directly
            return true;
    }
}

update
{
    // TODO: We can access timer state directly, so this can be refactored to be much more clean
    // In case of manual reset by runner
    if (current.mainMenuID == 264 && vars.getRunStarted == 1) {
        vars.paradisePlaza8Split = 0;
        vars.getRunStarted = 0;
    }
}

isLoading
{

    // Check for loading screens or cutscenes
    if (settings["loadless1"] &&
        current.inCutsceneOrLoad == true &&    
        current.kentMenu != 1793) return true; // kentMenu is 1793 when selecting a picture for Kent, this is to prevent the timer from pausing in that scenario

    // TODO: What does this represent?
    else if (settings["loadless1"]          && 
        !settings["maxLevel"])              &&          // As per community discretion, the timer does not pause on case menus for Max Level runs.
        ((current.caseMenuOpen == 2         ||          // TODO: What does this represent?
        current.caseMenuOpen == 19)         &&          // TODO: What does this represent?
        (current.campaignProgress == 160    ||          // TODO: What does this represent?
        current.campaignProgress == 230     ||          // TODO: What does this represent?
        current.campaignProgress == 320     ||          // TODO: What does this represent?
        current.campaignProgress == 350)) return true;  // TODO: What does this represent?

    // Pauses during loads and all menus, except for the pause menu (caseMenuOpen == 1)
    else if (settings["loadless2"] && 
        (current.inCutsceneOrLoad || 
        current.caseMenuOpen > 1)) return true;

    return false;
}

split
{
// Shortcut (PP to WP)
    if (settings["shortcutpw"] 			&& 
        current.currentRoomValue == 512 &&  // Paradise Plaza
        current.loadingRoomValue == 768 &&  // Wonderland Plaza
        old.loadingRoomValue != 768) return true;
// Shortcut (WP to PP)
    else if (settings["shortcutwp"]		&& 
        current.currentRoomValue == 768 &&  // Wonderland Plaza
        current.loadingRoomValue == 512 &&  // Paradise Plaza
        old.loadingRoomValue != 512) return true;
// Case Splits (All cases)
    else if (settings["caseSplits"]     && 
        old.caseMenuOpen == 2           &&            // TODO: What does this represent?
        current.caseMenuOpen == 0       &&            // TODO: What does this represent?
        current.campaignProgress != 160 &&            // TODO: What does this represent?
        current.campaignProgress != 230 &&            // TODO: What does this represent?
        current.campaignProgress != 280 &&            // TODO: What does this represent?
        current.campaignProgress != 320 &&            // TODO: What does this represent?
        current.campaignProgress != 350) return true; // TODO: What does this represent?
//	Prologue (Case 1)
    else if (settings["prologue"]       && 
        current.campaignProgress == 65  && 
        old.inCutsceneOrLoad == false) return true;
// Steven (Case 2)
    else if (settings["steven"]         &&
        current.campaignProgress == 190 && 
        current.bossHealth == 0         && 
        old.bossHealth != 0) return true;
// First-Aid (Case 2)
    else if (settings["firstaid"]       && 
        current.campaignProgress == 215 && 
        old.campaignProgress == 210) return true;
// Elevator (Case 4)
    else if (settings["elevator4"]      && 
        current.currentRoomValue == 535 && 
        current.loadingRoomValue == 534 && 
        old.loadingRoomValue != 534     && 
        current.campaignProgress >= 230 && 
        current.campaignProgress < 270) return true;
// Warehouse (Case 4)
    else if (settings["warehouse"]      && 
        current.currentRoomValue == 534 && 
        current.loadingRoomValue == 512 && 
        old.loadingRoomValue != 512     && 
        current.campaignProgress >= 230 && 
        current.campaignProgress < 270) return true;
// Wonderland Plaza (Case 4)
    else if (settings["wonderlandPlaza"] && 
        current.currentRoomValue == 768  && 
        current.loadingRoomValue == 1024 && 
        old.loadingRoomValue != 1024     && 
        current.campaignProgress >= 230  && 
        current.campaignProgress < 270) return true;
// North Plaza (Case 5)
    else if (settings["northPlaza"]      && 
        current.currentRoomValue == 1024 && 
        current.loadingRoomValue == 1792 && 
        old.loadingRoomValue != 1792     && 
        current.campaignProgress >= 270  && 
        current.campaignProgress < 320) return true;
// Leisure Park (Case 5)
    else if (settings["leisurePark"]     && 
        current.currentRoomValue == 1792 && 
        current.loadingRoomValue == 512  && 
        old.loadingRoomValue != 512      && 
        current.campaignProgress >= 270  && 
        current.campaignProgress < 320) return true;
// Paradise Plaza (Case 5)
    else if (settings["paradisePlaza5"] && 
        current.currentRoomValue == 512 && 
        current.loadingRoomValue == 534 && 
        old.loadingRoomValue != 534     && 
        current.campaignProgress >= 270 && 
        current.campaignProgress < 320) return true;
// Elevator (Case 5)
    else if (settings["elevator5"]      && 
        current.currentRoomValue == 534 && 
        current.loadingRoomValue == 535 && 
        old.loadingRoomValue != 535     && 
        current.campaignProgress >= 270 && 
        current.campaignProgress < 320) return true;
// Paradise Plaza (Case 7)
    else if (settings["paradisePlaza7"]  && 
        current.currentRoomValue == 512  && 
        current.loadingRoomValue == 1536 && 
        old.loadingRoomValue != 1536     && 
        current.campaignProgress >= 320  && 
        current.campaignProgress < 350) return true;
// Bombs (Case 7)
    else if (current.bombsCollected != old.bombsCollected) 
        return {settings["bomb1"], settings["bomb2"], settings["bomb3"], settings["bomb4"], settings["bomb5"]}[current.bombsCollected - 1] || false;
// Paradise Plaza (Case 8)
    else if (settings["paradisePlaza8"]  && 
        current.currentRoomValue == 512  && 
        current.loadingRoomValue == 1536 && 
        old.loadingRoomValue != 1536     && 
        current.campaignProgress >= 350  && 
        current.campaignProgress < 500) {
            vars.paradisePlaza8Split = 1;
            return true;
    }
// 72 Hour Mode Run End
    else if (settings["72HourEnd"]       && 
        current.campaignProgress == 390  && 
        current.loadingRoomValue == 1025 && 
        old.loadingRoomValue != 1025) return true;
// Overtime
    // Supplies
    else if (settings["supplies"] 		    && 
        current.currentRoomValue == 1025 	&& 
        current.frankX > 1000 				&& 
        current.campaignProgress <= 600 	&& 
        current.inCutsceneOrLoad != old.inCutsceneOrLoad) return true;
    // Queens
    else if (settings["queens"] 		 && 
        current.currentRoomValue == 1025 && 
        current.loadingRoomValue == 2816 && 
        old.loadingRoomValue != 2816) return true;
    // Tunnel
    else if (settings["tunnel"]          && 
        current.loadingRoomValue == 2819 && 
        old.loadingRoomValue != 2819) return true;
    // Tank
    else if (settings["tank"]            && 
        current.currentRoomValue == 2819 && // End-game fight arena (Tank/Brock)
        current.bossHealth == 0          && 
        old.bossHealth % 500 == 0        && // The tank takes damage in chunks of 500, so this is to check that we are fighting the tank
        old.bossHealth != 0) return true;
    // Brock
    else if (settings["brock"]              && 
        current.currentRoomValue == 2819    &&   // End-game fight arena (Tank/Brock)
        current.bossHealth == 0             && 
        old.bossHealth % 500 != 0           &&   // The tank takes damage in chunks of 500, so this is to check that we aren't fighting the tank
        old.bossHealth != 0) return true;
// Zombie Genocider
    else if (current.kills != old.kills) {
        if (settings["kills10k"]        && old.kills < 10000 && current.kills >= 10000) return true;
        else if (settings["kills20%"]   && old.kills < 10719 && current.kills >= 10719) return true;
        else if (settings["kills20k"]   && old.kills < 20000 && current.kills >= 20000) return true;
        else if (settings["kills40%"]   && old.kills < 21438 && current.kills >= 21438) return true;
        else if (settings["kills30k"]   && old.kills < 30000 && current.kills >= 30000) return true;
        else if (settings["kills60%"]   && old.kills < 32157 && current.kills >= 32157) return true;
        else if (settings["kills40k"]   && old.kills < 40000 && current.kills >= 40000) return true;
        else if (settings["kills80%"]   && old.kills < 42876 && current.kills >= 42876) return true;
        else if (settings["kills50k"]   && old.kills < 50000 && current.kills >= 50000) return true;
        else if (settings["killsFinal"] && old.kills < 53594 && current.kills >= 53594) return true;
    }
// Max Level
    else if (current.level != old.level) {
        if (settings["level5"]       && current.level == 5)  return true;
        else if (settings["level10"] && current.level == 10) return true;
        else if (settings["level15"] && current.level == 15) return true;
        else if (settings["level20"] && current.level == 20) return true;
        else if (settings["level25"] && current.level == 25) return true;
        else if (settings["level30"] && current.level == 30) return true;
        else if (settings["level35"] && current.level == 35) return true;
        else if (settings["level40"] && current.level == 40) return true;
        else if (settings["level45"] && current.level == 45) return true;
        else if (settings["level50"] && current.level == 50) return true;
    }
}
