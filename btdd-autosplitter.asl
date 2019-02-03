state("fceux")
{
    byte level:     0x3B1388, 0x0015;
    byte sound:     0x3B1388, 0x0311;
    byte complete:  0x3B1388, 0x004B;
    ushort reset:   0x3B1388, 0x0680;
}

state("nestopia")
{
    byte level:     "nestopia.exe", 0x1B2BCC, 0x00, 0x08, 0x0C, 0x0C, 0x7D;
    byte sound:     "nestopia.exe", 0x1B2BCC, 0x00, 0x08, 0x0C, 0x0C, 0x379;
    byte complete:  "nestopia.exe", 0x1B2BCC, 0x00, 0x08, 0x0C, 0x0C, 0xB3;
    ushort reset:   "nestopia.exe", 0x1B2BCC, 0x00, 0x08, 0x0C, 0x0C, 0x6E8;
}

state("mednafen")
{
    byte level:     "mednafen.exe", 0xBE1CF5;
    byte sound:     "mednafen.exe", 0xBE1FF1;
    byte complete:  "mednafen.exe", 0xBE1D2B;
    ushort reset:   "mednafen.exe", 0xBE2360;
}

startup
{
    settings.Add("gBosses", true, "Bosses");
    settings.Add("gLevels", false, "Levels");
    
    settings.Add("abobo", true, "Wizard", "gBosses");
    settings.Add("bigblag", true, "Big Blag", "gBosses");
    settings.Add("roper", true, "Roper", "gBosses");
    settings.Add("ratship", true, "Ratship", "gBosses");
    settings.Add("robomanus", true, "Robo Manus", "gBosses");
    settings.Add("shadowboss", true, "Shadow Boss", "gBosses");
    settings.Add("darkqueen", true, "The Dark Queen", "gBosses");
    
    settings.Add("l12", false, "Level 1-2", "gLevels");
    settings.Add("l22", false, "Level 2-2", "gLevels");
    settings.Add("l23", false, "Level 2-3", "gLevels");
    settings.Add("l32", false, "Level 3-2", "gLevels");
    settings.Add("l33", false, "Level 3-3", "gLevels");
    settings.Add("l42", false, "Level 4-2", "gLevels");
    settings.Add("l52", false, "Level 5-2", "gLevels");
}

split
{
    if (old.complete == 0xAC && current.complete == 0xAB)
    {
        switch((int)current.level)
        {
            case 0x05:
                if (settings["abobo"]) return true;
                break;
            case 0x0A:
                if (settings["bigblag"]) return true;
                break;
            case 0x03:
                if (settings["roper"]) return true;
                break;
            case 0x07:
                if (settings["ratship"]) return true;
                break;
            case 0x0C:
                if (settings["robomanus"]) return true;
                break;
            case 0x0D:
                if (settings["shadowboss"]) return true;
                break;
            case 0x0E:
                if (settings["darkqueen"]) return true;
                break;
        }
    }
    
    if (settings["l12"] && old.level == 0x04 && current.level == 0x05) return true;
    if (settings["l22"] && old.level == 0x08 && current.level == 0x09) return true;
    if (settings["l23"] && old.level == 0x09 && current.level == 0x0A) return true;
    if (settings["l32"] && old.level == 0x01 && current.level == 0x02) return true;
    if (settings["l33"] && old.level == 0x02 && current.level == 0x03) return true;
    if (settings["l42"] && old.level == 0x06 && current.level == 0x07) return true;
    if (settings["l52"] && old.level == 0x0B && current.level == 0x0C) return true;
    
    
}

reset
{
    return (current.reset == 0x0E) && (current.level == 0x00);
}

start
{
    return (current.level == 0x04) && (old.sound == 0x00) && (current.sound == 0x76);
}
