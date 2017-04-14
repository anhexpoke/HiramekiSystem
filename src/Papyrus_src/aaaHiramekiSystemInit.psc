Scriptname aaaHiramekiSystemInit extends ReferenceAlias

;初期魔法
Spell Property Flames Auto
Spell Property BoundSword Auto
Spell Property Healing Auto
Spell Property Candlelight Auto
Spell Property Clairvoyance Auto

;初期魔法を覚えさせる
Event OnInit()
    Actor me = Game.GetPlayer()
    me.AddSpell(Flames as Spell)
    me.AddSpell(BoundSword as Spell)
    me.AddSpell(Healing as Spell)
    me.Addspell(Candlelight as Spell)
    me.AddSpell(Clairvoyance as Spell)
EndEvent
