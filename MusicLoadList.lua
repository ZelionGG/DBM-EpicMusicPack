local tinsert = table.insert
local inserted = false

function DBMMPEpicMusicPack()
	if inserted then 
        return 
    end
    -- All Music Table
	tinsert(DBM.Music, {
        text = "EMP - FormantX - Juggernaut March", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_JuggernautMarch.wav"
    })
    tinsert(DBM.Music, {
        text = "EMP - FormantX - Quantum Sonata", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_QuantumSonata.wav"
    })
	tinsert(DBM.Music, {
        text = "EMP - Niklas Johansson - Out Last Stand", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_OurLastStand.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Jo Blankenburg - Vanguard", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_Vanguard.mp3"
    })

    -- Dungeon BGM Table
	if DBM.DungeonMusic then
        tinsert(DBM.DungeonMusic, {
            text = "EMP - FormantX - Juggernaut March", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_JuggernautMarch.wav"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - FormantX - Quantum Sonata", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_QuantumSonata.wav"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Niklas Johansson - Out Last Stand", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_OurLastStand.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Jo Blankenburg - Vanguard", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_Vanguard.mp3"
        })
    end

    -- Boss BGM Table
	if DBM.BattleMusic then
        tinsert(DBM.BattleMusic, {
            text = "EMP - FormantX - Juggernaut March", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_JuggernautMarch.wav"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - FormantX - Quantum Sonata", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_QuantumSonata.wav"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Niklas Johansson - Out Last Stand", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_OurLastStand.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Jo Blankenburg - Vanguard", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_Vanguard.mp3"
        })
    end

	inserted = true
end
