local tinsert = table.insert
local inserted = false

function DBMMPEpicMusicPack()
	if inserted then 
        return 
    end
    -- All Music Table
	tinsert(DBM.Music, {
        text = "EMP - FormantX - Juggernaut March", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_JuggernautMarch.ogg"
    })
    tinsert(DBM.Music, {
        text = "EMP - FormantX - Quantum Sonata", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_QuantumSonata.ogg"
    })
	tinsert(DBM.Music, {
        text = "EMP - Niklas Johansson - Out Last Stand", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_OurLastStand.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Jo Blankenburg - Vanguard", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_Vanguard.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Edgar Hopp - Last Fight for Freedom", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_LastFightforFreedom.ogg"
    })
	tinsert(DBM.Music, {
        text = "EMP - Dream Cave - Last Strike for Glory", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_LastStrikeForGlory.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Bonnie Grace - Trails of Legends", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_TrailsOfLegends.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Robert Ruth - Karma Bullet", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_KarmaBullet.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Sham Stalin & Pandora Journey - My Condolences, Monster", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_MyCondolencesMonster.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Mark Petrie - Abeyance", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_Abeyance.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Baptiste Thiry - Oblivion", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_Oblivion.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Audiomachine - So Say We All", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_SoSayWeAll.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Audiomachine - Absolute Magnitude", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_AbsoluteMagnitude.mp3"
    })

    -- Dungeon BGM Table
	if DBM.DungeonMusic then
        tinsert(DBM.DungeonMusic, {
            text = "EMP - FormantX - Juggernaut March", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_JuggernautMarch.ogg"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - FormantX - Quantum Sonata", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_QuantumSonata.ogg"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Niklas Johansson - Out Last Stand", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_OurLastStand.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Jo Blankenburg - Vanguard", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_Vanguard.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Edgar Hopp - Last Fight for Freedom", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_LastFightforFreedom.ogg"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Dream Cave - Last Strike for Glory", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_LastStrikeForGlory.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Bonnie Grace - Trails of Legends", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_TrailsOfLegends.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Robert Ruth - Karma Bullet", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_KarmaBullet.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Sham Stalin & Pandora Journey - My Condolences, Monster", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_MyCondolencesMonster.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Mark Petrie - Abeyance", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_Abeyance.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Baptiste Thiry - Oblivion", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_Oblivion.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Audiomachine - So Say We All", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_SoSayWeAll.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Audiomachine - Absolute Magnitude", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_AbsoluteMagnitude.mp3"
        })
    end

    -- Boss BGM Table
	if DBM.BattleMusic then
        tinsert(DBM.BattleMusic, {
            text = "EMP - FormantX - Juggernaut March", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_JuggernautMarch.ogg"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - FormantX - Quantum Sonata", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_QuantumSonata.ogg"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Niklas Johansson - Out Last Stand", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_OurLastStand.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Jo Blankenburg - Vanguard", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_Vanguard.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Edgar Hopp - Last Fight for Freedom", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_LastFightforFreedom.ogg"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Dream Cave - Last Strike for Glory", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_LastStrikeForGlory.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Bonnie Grace - Trails of Legends", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_TrailsOfLegends.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Robert Ruth - Karma Bullet", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_KarmaBullet.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Sham Stalin & Pandora Journey - My Condolences, Monster", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_MyCondolencesMonster.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Mark Petrie - Abeyance", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_Abeyance.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Baptiste Thiry - Oblivion", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_Oblivion.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Audiomachine - So Say We All", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_SoSayWeAll.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Audiomachine - Absolute Magnitude", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_AbsoluteMagnitude.mp3"
        })
    end
    
	inserted = true
end
