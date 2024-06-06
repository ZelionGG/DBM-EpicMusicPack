local function insertMusic(musicName, musicId)
    if DBM and DBM.Music and DBM.DungeonMusic and DBM.BattleMusic then
        local musicPath = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\"
        local musicEntry = {text = "EMP - " .. musicName, value = musicPath .. musicId .. ".mp3"}

        table.insert(DBM.Music, musicEntry)
        if DBM.DungeonMusic then table.insert(DBM.DungeonMusic, musicEntry) end
        if DBM.BattleMusic then table.insert(DBM.BattleMusic, musicEntry) end
    end
end


-- This table contains all the music files that DBM will use. The keys are the names
-- of the files without the extension, and the values are the names of the files as
-- they should appear in the music drop-down menus. The files are located in the
-- DBM-EpicMusicPack\Music directory.

-- Each line of the table follows the following format:

-- ["file_name_without_extension"] = "display_name_as_it_should_appear_in_drop_down_menus"

-- For example:

-- ["file_name_without_extension"] = "Display Name as it should appear in drop-down menus"

-- The files are inserted into the DBM.Music, DBM.DungeonMusic, and DBM.BattleMusic
-- tables, if they exist.
local musicTable = {
    ["EMP_ES_JuggernautMarch"] = "FormantX - Juggernaut March",
    ["EMP_ES_QuantumSonata"] = "FormantX - Quantum Sonata",
    ["EMP_ES_OurLastStand"] = "Niklas Johansson - Out Last Stand",
    ["EMP_ES_Vanguard"] = "Jo Blankenburg - Vanguard",
    ["EMP_ES_LastFightforFreedom"] = "Edgar Hopp - Last Fight for Freedom",
    ["EMP_ES_LastStrikeForGlory"] = "Dream Cave - Last Strike for Glory",
    ["EMP_ES_TrailsOfLegends"] = "Bonnie Grace - Trails of Legends",
    ["EMP_ES_KarmaBullet"] = "Robert Ruth - Karma Bullet",
    ["EMP_ES_MyCondolencesMonster"] = "Sham Stalin & Pandora Journey - My Condolences, Monster",
    ["EMP_ES_Abeyance"] = "Mark Petrie - Abeyance",
    ["EMP_Oblivion"] = "Baptiste Thiry - Oblivion",
    ["EMP_SoSayWeAll"] = "Audiomachine - So Say We All",
    ["EMP_AbsoluteMagnitude"] = "Audiomachine - Absolute Magnitude",
    ["EMP_MS_FreedomFighters"] = "Machinimasound - Freedom Fighters",
    ["EMP_MS_Mercenaries"] = "Machinimasound - Mercenaries",
    ["EMP_2WEI_Pandora"] = "2WEI - Pandora",
    ["EMP_2WEI_Insomnia"] = "2WEI - Insomnia",
    ["EMP_RSM_ThunderFist"] = "Really Slow Motion - Thunder Fist",
    ["EMP_RSM_PointOfOrigin"] = "Really Slow Motion - Point of Origin",
    ["EMP_CAP_BattleAgainstTime"] = "Celestial Aeon Project - Battle Against Time",
    ["EMP_HSM_HoldTheBeacon"] = "Hypersonic Music - Hold the Beacon",
    ["EMP_HSM_Tesseract"] = "Hypersonic Music - Tesseract",
}

function DBMMPEpicMusicPack()
    local musicOrder = {}
    for musicId, musicName in pairs(musicTable) do
        table.insert(musicOrder, {id = musicId, name = musicName})
    end
    
    table.sort(musicOrder, function(a, b)
        return a.name < b.name
    end)
    
    for _, music in ipairs(musicOrder) do
        insertMusic(music.name, music.id)
    end
end