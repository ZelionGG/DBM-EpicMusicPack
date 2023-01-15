local tinsert = table.insert
local inserted = false

function DBMMPEpicMusicPack()
	if inserted then 
        return 
    end
    -- All Music Table
	tinsert(DBM.Music, {
        text = "EMP - FormantX - Juggernaut March", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_JuggernautMarch.mp3"
    })
    tinsert(DBM.Music, {
        text = "EMP - FormantX - Quantum Sonata", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_QuantumSonata.mp3"
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
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_LastFightforFreedom.mp3"
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
	tinsert(DBM.Music, {
        text = "EMP - Machinimasound - Freedom Fighters", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_MS_FreedomFighters.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Machinimasound - Mercenaries", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_MS_Mercenaries.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - 2WEI - Pandora", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_2WEI_Pandora.mp3"
    })
    tinsert(DBM.Music, {
        text = "EMP - 2WEI - Insomnia", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_2WEI_Insomnia.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Really Slow Motion - Thunder Fist", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_RSM_ThunderFist.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Really Slow Motion - Point of Origin", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_RSM_PointOfOrigin.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Celestial Aeon Project - Battle Against Time", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_CAP_BattleAgainstTime.mp3"
    })
	tinsert(DBM.Music, {
        text = "EMP - Hypersonic Music - Hold the Beacon", 
        value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_HSM_HoldTheBeacon.mp3"
    })

    -- Dungeon BGM Table
	if DBM.DungeonMusic then
        tinsert(DBM.DungeonMusic, {
            text = "EMP - FormantX - Juggernaut March", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_JuggernautMarch.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - FormantX - Quantum Sonata", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_QuantumSonata.mp3"
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
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_LastFightforFreedom.mp3"
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
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Machinimasound - Freedom Fighters", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_MS_FreedomFighters.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Machinimasound - Mercenaries", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_MS_Mercenaries.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - 2WEI - Pandora", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_2WEI_Pandora.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - 2WEI - Insomnia", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_2WEI_Insomnia.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Really Slow Motion - Thunder Fist", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_RSM_ThunderFist.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Really Slow Motion - Point of Origin", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_RSM_PointOfOrigin.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Celestial Aeon Project - Battle Against Time", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_CAP_BattleAgainstTime.mp3"
        })
        tinsert(DBM.DungeonMusic, {
            text = "EMP - Hypersonic Music - Hold the Beacon", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_HSM_HoldTheBeacon.mp3"
        })
    end

    -- Boss BGM Table
	if DBM.BattleMusic then
        tinsert(DBM.BattleMusic, {
            text = "EMP - FormantX - Juggernaut March", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_JuggernautMarch.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - FormantX - Quantum Sonata", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_QuantumSonata.mp3"
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
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_ES_LastFightforFreedom.mp3"
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
        tinsert(DBM.BattleMusic, {
            text = "EMP - Machinimasound - Freedom Fighters", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_MS_FreedomFighters.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Machinimasound - Mercenaries", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_MS_Mercenaries.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - 2WEI - Pandora", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_2WEI_Pandora.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - 2WEI - Insomnia", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_2WEI_Insomnia.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Really Slow Motion - Thunder Fist", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_RSM_ThunderFist.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Really Slow Motion - Point of Origin", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_RSM_PointOfOrigin.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Celestial Aeon Project - Battle Against Time", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_CAP_BattleAgainstTime.mp3"
        })
        tinsert(DBM.BattleMusic, {
            text = "EMP - Hypersonic Music - Hold the Beacon", 
            value = "Interface\\AddOns\\DBM-EpicMusicPack\\Music\\EMP_HSM_HoldTheBeacon.mp3"
        })
    end
    
	inserted = true
end
