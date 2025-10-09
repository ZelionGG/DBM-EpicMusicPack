-- This file augments the pack to load auto-generated tracks from EMP_MUSIC_AUTOLIST
-- without modifying the original MusicLoadList.lua.

local function makeSet(list)
    local byValue, byText = {}, {}
    if type(list) == "table" then
        for _, e in ipairs(list) do
            if type(e) == "table" then
                if e.value then byValue[e.value] = true end
                if e.text then byText[e.text] = true end
            end
        end
    end
    return byValue, byText
end

local _orig_DBMMPEpicMusicPack = DBMMPEpicMusicPack

function DBMMPEpicMusicPack()
    if type(_orig_DBMMPEpicMusicPack) == "function" then
        _orig_DBMMPEpicMusicPack()
    end

    if type(EMP_MUSIC_AUTOLIST) ~= "table" then
        return
    end

    local list = {}
    for id, name in pairs(EMP_MUSIC_AUTOLIST) do
        table.insert(list, { id = id, name = name })
    end

    table.sort(list, function(a, b)
        return a.name < b.name
    end)

    -- Auto-generated tracks now live under Music/custom
    local musicPath = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\custom\\"

    local musicByValue, musicByText = makeSet(DBM and DBM.Music)
    local dungByValue, dungByText = makeSet(DBM and DBM.DungeonMusic)
    local battleByValue, battleByText = makeSet(DBM and DBM.BattleMusic)

    for _, m in ipairs(list) do
        local entry = { text = "EMP - " .. m.name, value = musicPath .. m.id .. ".mp3" }
        if DBM and DBM.Music and not (musicByValue[entry.value] or musicByText[entry.text]) then
            table.insert(DBM.Music, entry)
            musicByValue[entry.value] = true
            musicByText[entry.text] = true
        end
        if DBM and DBM.DungeonMusic and not (dungByValue[entry.value] or dungByText[entry.text]) then
            table.insert(DBM.DungeonMusic, entry)
            dungByValue[entry.value] = true
            dungByText[entry.text] = true
        end
        if DBM and DBM.BattleMusic and not (battleByValue[entry.value] or battleByText[entry.text]) then
            table.insert(DBM.BattleMusic, entry)
            battleByValue[entry.value] = true
            battleByText[entry.text] = true
        end
    end
end
