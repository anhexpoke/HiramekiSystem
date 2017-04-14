Scriptname aaaHiramekiSystem extends ReferenceAlias
;メモ
;FloatからIntへのキャストは小数点以下切り捨て

;閃きHUD
aaaHiramekiWidget Property hiramekiWidget Auto

;閃き判定から無視する敵
Race Property GiantRace Auto
Race Property MammothRace Auto

;破壊魔法
Spell Property Flames Auto
Spell Property Frostbite Auto
Spell Property Sparks Auto
Spell Property FireRune Auto
Spell Property Firebolt  Auto
Spell Property FrostRune Auto
Spell Property IceSpike Auto
Spell Property ShockRune Auto
Spell Property LightningBolt Auto
Spell Property flameCloak Auto
Spell Property Fireball Auto
Spell Property FrostCloak Auto
Spell Property IceStorm Auto
Spell Property LightningCloak Auto
Spell Property ChainLightning Auto
Spell Property WallOfFlames Auto
Spell Property Incinerate Auto
Spell Property WallOfFrost Auto
Spell Property IcySpear Auto
Spell Property WallOfStorms Auto
Spell Property Thunderbolt Auto
Spell Property FireStorm Auto
Spell Property Blizzard Auto
Spell Property LightningStorm Auto

;召喚魔法
Spell Property BoundSword Auto
Spell Property ConjureFamiliar Auto
Spell Property RaiseZombie Auto
Spell Property BoundBattleAxe Auto
Spell Property ConjureFlameAtronach Auto
Spell Property dunHighGateSummonFlamingThrall Auto
Spell Property ReanimateCorpse Auto
Spell Property SoulTrap Auto
Spell Property BoundBow Auto
Spell Property ConjureFrostAtronach Auto
Spell Property Revenant Auto
Spell Property BanishDaedra Auto
Spell Property ConjureStormAtronach Auto
Spell Property DreadZombie Auto
Spell Property CommandDaedra Auto
Spell Property ExpelDaedra Auto
Spell Property ConjureDremoraLord Auto
Spell Property ConjureDragonPriest Auto
Spell Property FlameThrall Auto
Spell Property FrostThrall Auto
Spell Property StormThrall Auto
Spell Property DeadThrall Auto

;回復魔法
Spell Property Healing Auto
Spell Property WardLesser Auto
Spell Property FastHealing Auto
Spell Property HealingHands Auto
Spell Property WardSteadfast Auto
Spell Property TurnLesserUndead Auto
Spell Property CloseWounds Auto
Spell Property HealOther Auto
Spell Property WardGreater Auto
Spell Property RepelLesserUndead Auto
Spell Property TurnUndead Auto
Spell Property GrandHealing Auto
Spell Property RepelUndead Auto
Spell Property TurnGreaterUndead Auto
Spell Property CircleOfProtection Auto
Spell Property BaneoftheUndead Auto
Spell Property GuardianCircle Auto

;変性魔法
Spell Property Candlelight Auto
Spell Property Oakflesh Auto
Spell Property Magelight Auto
Spell Property Stoneflesh Auto
Spell Property DetectLife Auto
Spell Property Ironflesh Auto
Spell Property Telekinesis Auto
Spell Property TransmuteOreMineral Auto
Spell Property Waterbreathing Auto
Spell Property DetectDead Auto
Spell Property Ebonyflesh Auto
Spell Property Paralyze Auto
Spell Property Dragonhide Auto
Spell Property MassParalysis Auto
Spell Property dunLabyrinthianSpellReward Auto

;幻惑魔法
Spell Property Clairvoyance Auto
Spell Property Courage Auto
Spell Property Fury Auto
Spell Property Calm Auto
Spell Property Fear Auto
Spell Property Muffle Auto
Spell Property Rally Auto
Spell Property Frenzy Auto
Spell Property Pacify Auto
Spell Property Rout Auto
Spell Property Invisibility Auto
Spell Property CallToArms Auto
Spell Property Mayhem Auto
Spell Property Harmony Auto
Spell Property Hysteria Auto

;イベント駆動(こっからスタート)
Event OnSpellCast(Form akSpell)
    HiramekiMain(akSpell as Spell);この関数は一番下にあります
EndEvent

;スキル名ぶっこみ関数
String[] Function SkillNameList()
    string[] skillNameList = new String[8]
    skillNameList[0] = "OneHanded"  ;片手剣
    skillNameList[1] = "TwoHanded"  ;両手剣
    skillNameList[2] = "Marksman"   ;弓術
    skillNameList[3] = "Alteration" ;変性
    skillNameList[4] = "Conjuration";召喚
    skillNameList[5] = "Destruction";破壊
    skillNameList[6] = "Restoration";回復
    skillNameList[7] = "Illusion"   ;幻惑
    return skillNameList
EndFunction

;閃いたスペルを両手に装備する
Function EquipSpellEitherHand(Spell newSpell)
    Game.GetPlayer().EquipSpell(newSpell,0)
    Game.GetPlayer().EquipSpell(newSpell,1)
EndFunction

;閃いたスペルを左手に装備する
Function EquipSpellLeftHand(Spell newSpell)
    Game.GetPlayer().EquipSpell(newSpell,0)
EndFunction

;シグモイド関数(DeepLearningの知識でもない限り弄らないように)
Float Function Sigmoid(Float x)
    ;ネイピア数
    Float e = 2.7182818284
    return 1 / (1 + Math.pow(e, -x))
EndFunction

;破壊魔法閃き度リスト
Float[] Function DestructionHirameki()
    Float[] destructionList = new Float[24]
    destructionList[0]  = 3.00;火炎
    destructionList[1]  = 3.85;氷雪
    destructionList[2]  = 3.85;雷撃
    destructionList[3]  = 5.50;炎の罠
    destructionList[4]  = 5.25;ファイアボルト
    destructionList[5]  = 5.55;氷の罠
    destructionList[6]  = 5.28;アイススパイク
    destructionList[7]  = 5.60;雷の罠
    destructionList[8]  = 5.30;ライトニングボルト
    destructionList[9]  = 5.95;炎のマント
    destructionList[10] = 6.26;エクスプロージョン
    destructionList[11] = 6.01;氷のマント
    destructionList[12] = 6.35;アイスストーム
    destructionList[13] = 6.03;雷のマント
    destructionList[14] = 6.43;チェインラ0イトニング
    destructionList[15] = 6.75;炎の壁
    destructionList[16] = 7.00;ファイアボール
    destructionList[17] = 6.77;氷の壁
    destructionList[18] = 7.02;アイスジャベリン
    destructionList[19] = 6.79;雷の障壁
    destructionList[20] = 7.08;サンダーボルト
    destructionList[21] = 8.05;ファイアストーム
    destructionList[22] = 8.05;ブリザード
    destructionList[23] = 8.05;ライトニングテンペスト
    return destructionList
EndFunction

;破壊魔法Spellリスト
Spell[] Function DestructionSpellList()
    Spell[] destructionSpellList = new Spell[24]
    destructionSpellList[0]  = Flames as Spell;火炎
    destructionSpellList[1]  = Frostbite as Spell;氷雪
    destructionSpellList[2]  = Sparks as Spell;雷撃
    destructionSpellList[3]  = FireRune as Spell;炎の罠
    destructionSpellList[4]  = Firebolt as Spell;ファイアボルト
    destructionSpellList[5]  = FrostRune as Spell;氷の罠
    destructionSpellList[6]  = IceSpike as Spell;アイススパイク
    destructionSpellList[7]  = ShockRune as Spell;雷の罠
    destructionSpellList[8]  = LightningBolt as Spell;ライトニングボルト
    destructionSpellList[9]  = flameCloak as Spell;炎のマント
    destructionSpellList[10] = Fireball as Spell;エクスプロージョン
    destructionSpellList[11] = FrostCloak as Spell;氷のマント
    destructionSpellList[12] = IceStorm as Spell;アイスストーム
    destructionSpellList[13] = LightningCloak as Spell;雷のマント
    destructionSpellList[14] = ChainLightning as Spell;チェインライトニング
    destructionSpellList[15] = WallOfFlames as Spell;炎の壁
    destructionSpellList[16] = Incinerate as Spell;ファイアボール
    destructionSpellList[17] = WallOfFrost as Spell;氷の壁
    destructionSpellList[18] = IcySpear as Spell;アイスジャベリン
    destructionSpellList[19] = WallOfStorms as Spell;雷の障壁
    destructionSpellList[20] = Thunderbolt as Spell;サンダーボルト
    destructionSpellList[21] = FireStorm as Spell;ファイアストーム
    destructionSpellList[22] = Blizzard as Spell;ブリザード
    destructionSpellList[23] = LightningStorm as Spell;ライトニングテンペスト
    return destructionSpellList
EndFunction

;召喚魔法閃き度リスト
Float[] Function ConjurationHirameki()
    Float[] conjurationList = new Float[22]
    conjurationList[0]  = 3.00;魔力の剣
    conjurationList[1]  = 3.10;使い魔召喚
    conjurationList[2]  = 3.25;幽鬼作成
    conjurationList[3]  = 4.01;魔力の両手斧
    conjurationList[4]  = 4.40;炎の精霊召喚
    conjurationList[5]  = 4.58;火炎使い魔召喚
    conjurationList[6]  = 4.46;死霊作成
    conjurationList[7]  = 4.00;魂縛
    conjurationList[8]  = 5.25;魔力の弓
    conjurationList[9]  = 5.42;氷の精霊召喚
    conjurationList[10] = 5.61;幽鬼支配
    conjurationList[11] = 5.78;デイドラ帰還
    conjurationList[12] = 6.00;雷の精霊召喚
    conjurationList[13] = 6.14;死霊支配
    conjurationList[14] = 6.31;デイドラ支配
    conjurationList[15] = 6.31;デイドラ送還
    conjurationList[16] = 6.54;ドレモラ・ロード召喚
    conjurationList[17] = 6.52;ドラゴンプリースト召喚
    conjurationList[18] = 7.50;炎の従徒
    conjurationList[19] = 7.50;氷の従徒
    conjurationList[20] = 7.50;雷の従徒
    conjurationList[21] = 7.60;死の従徒
    return conjurationList
EndFunction

;召喚魔法Spellリスト
Spell[] Function ConjurationSpellList()
    Spell[] conjurationSpellList = new Spell[22]
    conjurationSpellList[0]  = BoundSword as Spell;魔力の剣
    conjurationSpellList[1]  = ConjureFamiliar as Spell;使い魔召喚
    conjurationSpellList[2]  = RaiseZombie as Spell;幽鬼作成
    conjurationSpellList[3]  = BoundBattleAxe as Spell;魔力の両手斧
    conjurationSpellList[4]  = ConjureFlameAtronach as Spell;炎の精霊召喚
    conjurationSpellList[5]  = dunHighGateSummonFlamingThrall as Spell;火炎使い魔召喚
    conjurationSpellList[6]  = ReanimateCorpse as Spell;死霊作成
    conjurationSpellList[7]  = SoulTrap as Spell;魂縛
    conjurationSpellList[8]  = BoundBow as Spell;魔力の弓
    conjurationSpellList[9]  = ConjureFrostAtronach as Spell;氷の精霊召喚
    conjurationSpellList[10] = Revenant as Spell;幽鬼支配
    conjurationSpellList[11] = BanishDaedra as Spell;デイドラ帰還
    conjurationSpellList[12] = ConjureStormAtronach as Spell;雷の精霊召喚
    conjurationSpellList[13] = DreadZombie as Spell;死霊支配
    conjurationSpellList[14] = CommandDaedra as Spell;デイドラ支配
    conjurationSpellList[15] = ExpelDaedra as Spell;デイドラ送還
    conjurationSpellList[16] = ConjureDremoraLord as Spell;ドレモラ・ロード召喚
    conjurationSpellList[17] = ConjureDragonPriest as Spell;ドラゴンプリースト召喚
    conjurationSpellList[18] = FlameThrall as Spell;炎の従徒
    conjurationSpellList[19] = FrostThrall as Spell;氷の従徒
    conjurationSpellList[20] = StormThrall as Spell;雷の従徒
    conjurationSpellList[21] = DeadThrall as Spell;死の従徒
    return conjurationSpellList
EndFunction

;回復魔法閃き度リスト
Float[] Function RestorationHirameki()
    Float[] restorationList = new Float[17]
    restorationList[0]  = 2.00;治癒
    restorationList[1]  = 3.10;魔力の盾
    restorationList[2]  = 3.83;治癒の光
    restorationList[3]  = 4.01;治癒の手
    restorationList[4]  = 4.62;魔力の壁
    restorationList[5]  = 4.67;聖者の光
    restorationList[6]  = 5.05;治癒の息吹
    restorationList[7]  = 4.82;他者治癒
    restorationList[8]  = 5.36;魔力の砦
    restorationList[9]  = 5.24;死者撃退の光
    restorationList[10] = 5.53;聖者の息吹
    restorationList[11] = 6.20;大治癒
    restorationList[12] = 6.03;死者撃退の息吹
    restorationList[13] = 6.57;聖者の涙
    restorationList[14] = 6.71;守りのサークル
    restorationList[15] = 7.40;アンデッドベイン
    restorationList[16] = 8.00;守護のサークル
    return restorationList
EndFunction

;回復魔法Spellリスト
Spell[] Function RestorationSpellList()
    Spell[] restorationSpellList = new Spell[17]
    restorationSpellList[0]  = Healing as Spell;治癒
    restorationSpellList[1]  = WardLesser as Spell;魔力の盾
    restorationSpellList[2]  = FastHealing as Spell;治癒の光
    restorationSpellList[3]  = HealingHands as Spell;治癒の手
    restorationSpellList[4]  = WardSteadfast as Spell;魔力の壁
    restorationSpellList[5]  = TurnLesserUndead as Spell;聖者の光
    restorationSpellList[6]  = CloseWounds as Spell;治癒の息吹
    restorationSpellList[7]  = HealOther as Spell;他者治癒
    restorationSpellList[8]  = WardGreater as Spell;魔力の砦
    restorationSpellList[9]  = RepelLesserUndead as Spell;死者撃退の光
    restorationSpellList[10] = TurnUndead as Spell;聖者の息吹
    restorationSpellList[11] = GrandHealing as Spell;大治癒
    restorationSpellList[12] = RepelUndead as Spell;死者撃退の息吹
    restorationSpellList[13] = TurnGreaterUndead as Spell;聖者の涙
    restorationSpellList[14] = CircleOfProtection as Spell;守りのサークル
    restorationSpellList[15] = BaneoftheUndead as Spell;アンデッドベイン
    restorationSpellList[16] = GuardianCircle as Spell;守護のサークル
    return restorationSpellList
EndFunction

;変性魔法閃き度リスト
Float[] Function AlterationHirameki()
    Float[] alterationList = new Float[15]
    alterationList[0]  = 2.00;灯火
    alterationList[1]  = 3.30;オークフレッシュ
    alterationList[2]  = 3.20;灯明
    alterationList[3]  = 4.06;ストーンフレッシュ
    alterationList[4]  = 5.25;生命探知
    alterationList[5]  = 5.41;アイアンフレッシュ
    alterationList[6]  = 5.37;念動力
    alterationList[7]  = 6.01;鉱石変化
    alterationList[8]  = 5.89;水中呼吸
    alterationList[9]  = 6.38;死体探知
    alterationList[10] = 6.60;エボニーフレッシュ
    alterationList[11] = 6.74;麻痺
    alterationList[12] = 7.41;ドラゴンスケイル
    alterationList[13] = 7.85;麻痺の嵐
    alterationList[14] = 5.25;魔力変換
    return alterationList
EndFunction

;変性魔法Spellリスト
Spell[] Function AlterationSpellList()
    Spell[] alterationSpellList = new Spell[15]
    alterationSpellList[0]  = Candlelight as Spell;灯火
    alterationSpellList[1]  = Oakflesh as Spell;オークフレッシュ
    alterationSpellList[2]  = Magelight as Spell;灯明
    alterationSpellList[3]  = Stoneflesh as Spell;ストーンフレッシュ
    alterationSpellList[4]  = DetectLife as Spell;生命探知
    alterationSpellList[5]  = Ironflesh as Spell;アイアンフレッシュ
    alterationSpellList[6]  = Telekinesis as Spell;念動力
    alterationSpellList[7]  = TransmuteOreMineral as Spell;鉱石変化
    alterationSpellList[8]  = Waterbreathing as Spell;水中呼吸
    alterationSpellList[9]  = DetectDead as Spell;死体探知
    alterationSpellList[10] = Ebonyflesh as Spell;エボニーフレッシュ
    alterationSpellList[11] = Paralyze as Spell;麻痺
    alterationSpellList[12] = Dragonhide as Spell;ドラゴンスケイル
    alterationSpellList[13] = MassParalysis as Spell;麻痺の嵐
    alterationSpellList[14] = dunLabyrinthianSpellReward as Spell;魔力変換
    return alterationSpellList
EndFunction

;幻惑魔法閃き度リスト
Float[] Function IllusionHirameki()
    Float[] illusionList = new Float[15]
    illusionList[0]  = 2.00;千里眼
    illusionList[1]  = 3.20;挑発
    illusionList[2]  = 3.40;激昂
    illusionList[3]  = 4.05;鎮静
    illusionList[4]  = 4.16;恐怖
    illusionList[5]  = 4.20;消音
    illusionList[6]  = 5.12;扇動
    illusionList[7]  = 5.28;錯乱
    illusionList[8]  = 6.02;魅了
    illusionList[9]  = 5.99;威圧
    illusionList[10] = 6.38;透明化
    illusionList[11] = 7.40;戦場への誘い
    illusionList[12] = 7.20;狂乱
    illusionList[13] = 7.25;調和
    illusionList[14] = 7.80;畏怖
    return illusionList
EndFunction

;幻惑魔法Spellリスト
Spell[] Function IllusionSpellList()
    Spell[] illusionSpellList = new Spell[15]
    illusionSpellList[0]  = Clairvoyance as Spell;千里眼
    illusionSpellList[1]  = Courage as Spell;挑発
    illusionSpellList[2]  = Fury as Spell;激昂
    illusionSpellList[3]  = Calm as Spell;鎮静
    illusionSpellList[4]  = Fear as Spell;恐怖
    illusionSpellList[5]  = Muffle as Spell;消音
    illusionSpellList[6]  = Rally as Spell;扇動
    illusionSpellList[7]  = Frenzy as Spell;錯乱
    illusionSpellList[8]  = Pacify as Spell;魅了
    illusionSpellList[9]  = Rout as Spell;威圧
    illusionSpellList[10] = Invisibility as Spell;透明化
    illusionSpellList[11] = CallToArms as Spell;戦場への誘い
    illusionSpellList[12] = Mayhem as Spell;狂乱
    illusionSpellList[13] = Harmony as Spell;調和
    illusionSpellList[14] = Hysteria as Spell;畏怖
    return illusionSpellList
EndFunction

;どのスペルを詠唱したか配列の番号を返す
Int Function WhichSpell(Spell nowSpell, Spell[] spellList)
    Int cnt = 0
    Bool bBreak = False
    While(!bBreak && cnt < spellList.Length)
        if (nowSpell == spellList[cnt])
            bBreak = True
        endIf
        if (!bBreak)
            cnt += 1
        endIf
    EndWhile
    return cnt
EndFunction

;敵アクタの対象スキル内で一番高いスキルレベルを持ってくる
Float Function TargetMaxSkillLevel(Actor TargetRef, string[] skillNameList)
    int cnt = 0
    Float targetMaxSkill = 1.0
    While(cnt < skillNameList.Length)
        Float nowSkillLevel = TargetRef.GetAV(skillNameList[cnt])
        if (targetMaxSkill < nowSkillLevel)
            targetMaxSkill = nowSkillLevel
        endIf
        cnt += 1
    EndWhile
    return targetMaxSkill
EndFunction

;マジカ全快関数
Function SetMagickaFull()
    Actor acPlayer = Game.GetPlayer()
    Float curMgk = acPlayer.GetAV("Magicka")
    Float baseMgk = acPlayer.GetBaseActorValue("Magicka")
    acPlayer.RestoreAV("Magicka", baseMgk - curMgk)
EndFunction

;判定関数
Function JudgeHirameki(Float[] hiramekiList, Spell[] spellList, Float targetMaxSkillLevel)
    Int cnt = 0
    Float fTmp = 0.0
    Int judge = 0
    Int threshold = 0
    Bool bBreak = False
    Actor acPlayer = Game.GetPlayer()
    targetMaxSkillLevel = targetMaxSkillLevel / 20
    While (cnt < hiramekiList.Length && !bBreak)
        Float x = targetMaxSkillLevel - hiramekiList[cnt]
        if (x == 0)
            x = 0.01
        endIf
        fTmp = Sigmoid(x) * 100
        judge = fTmp as Int
        ;閾値
        threshold =  Utility.RandomInt(1, 100)
        ;判定
        if (judge > threshold)
            Int playerMaxMagicka = acPlayer.GetBaseActorValue("Magicka") as Int
            Int spellCost = spellList[cnt].GetMagickaCost()
            ;覚えたときに詠唱可能なマジカまで成長していなければスルー
            if (playerMaxMagicka > spellCost)
                if (Game.GetPlayer().AddSpell(spellList[cnt]))
                    ;左手にセット
                    EquipSpellLeftHand(spellList[cnt])
                    ;マジカ全回復
                    SetMagickaFull()
                    ;閃きHUDスタート
                    hiramekiWidget.HiramekiWidgetStart(True, spellList[cnt].GetName(), True)
                    ;何か閃いたのでループ脱出
                    bBreak = True
                endIf
            endIf
        endIf
        cnt += 1
    EndWhile
EndFunction

;メイン処理
Function HiramekiMain(Spell cstSpl)
    ;スキル名リスト
    String[] skillNameList = SkillNameList()

    ;戦っている相手を取得
    Actor TargetRef = Game.GetPlayer().GetCombatTarget()
    Race TargetRace = TargetRef.GetRace()
    Race Giant = GiantRace as Race
    Race Mammoth = MammothRace as Race
    ;Effectの1番目を取り出しておく
    MagicEffect me = cstSpl.GetNthEffectMagicEffect(0)
    String type = me.GetAssociatedSkill()
    ;ケース分類
    if (TargetRef != none && TargetRace != Giant && TargetRace != Mammoth && type != skillNameList[3] && type != skillNameList[7])
        ;Effectが存在したら
        if (cstSpl.GetNumEffects()>0)
            ;敵の対象スキルで最大レベルの値を持ってきて
            Float targetMaxSkillLevel = TargetMaxSkillLevel(TargetRef, skillNameList)
            ;Debug.Notification("TargetLvl: "+targetMaxSkillLevel)
            if (type == skillNameList[4]);召喚魔法だったら
                ;閃き度リストとスペルリスト取得
                Float[] conjurationList = ConjurationHirameki()
                Spell[] conjurationSpellList = ConjurationSpellList()
                ;判定
                JudgeHirameki(conjurationList, conjurationSpellList, targetMaxSkillLevel)
            Elseif (type == skillNameList[5]);破壊魔法だったら
                ;閃き度リストとスペルリスト取得
                Float[] destructionList = DestructionHirameki()
                Spell[] destructionSpellList = DestructionSpellList()
                ;判定
                JudgeHirameki(destructionList, destructionSpellList, targetMaxSkillLevel)
            ElseIf (type == skillNameList[6]);回復魔法だったら
                ;閃き度リストとスペルリスト取得
                Float[] restorationList = RestorationHirameki()
                Spell[] restorationSpellList = RestorationSpellList()
                ;判定
                JudgeHirameki(restorationList, restorationSpellList, targetMaxSkillLevel)
            endIf
        endIf
    ElseIf(type == skillNameList[3]);変性魔法だったら
        if (cstSpl.GetNumEffects()>0);Effectが存在したら
            ;自分の変性魔法のスキルレベルを取得して
            Float myAlterationLvl = Game.GetPlayer().GetAV("Alteration")
            ;Debug.Notification("MyAltLvl: "+myAlterationLvl)
            ;閃き度リストとスペルリスト取得
            Float[] alterationList = AlterationHirameki()
            Spell[] alterationSpellList = AlterationSpellList()
            ;判定
            JudgeHirameki(alterationList, alterationSpellList, myAlterationLvl)
        endIf
    ElseIf(type == skillNameList[7]);幻惑魔法だったら
        if (cstSpl.GetNumEffects()>0);Effectが存在したら
            ;自分の幻惑魔法のスキルレベルを取得して
            Float myIllusionLvl = Game.GetPlayer().GetAV("Illusion")
            ;Debug.Notification("MyIllLvl: "+myIllusionLvl)
            ;閃き度リストとスペルリスト取得
            Float[] illusionList = IllusionHirameki()
            Spell[] illusionSpellList = IllusionSpellList()
            ;判定
            JudgeHirameki(illusionList, illusionSpellList, myIllusionLvl)
        endIf
    endIf
EndFunction
