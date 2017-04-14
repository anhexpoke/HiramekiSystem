Scriptname aaaHiramekiWidget extends ski_widgetbase

Int HUD_Size = 67
Bool HUD_Visible = false
String HiramekiName = ""

;閃き音
Sound Property aaaHiramekiSound Auto
Sound Property aaaHiramekiSoundEnd Auto

;Visibleのゲッタセッタ
Bool Property Visible
    Bool Function Get()
        Return HUD_Visible
    EndFunction

    Function Set(bool a_val)
        HUD_Visible = a_val
        If (Ready)
            UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", HUD_Visible)
        EndIf
    EndFunction
EndProperty

;Sizeのゲッタセッタ
Int Property Size
    Int Function Get()
        Return HUD_Size
    EndFunction

    Function Set(int a_val)
        HUD_Size = a_val
        If (Ready)
            UpdateScale()
        EndIf
    EndFunction
EndProperty

;テキストデータのセッタゲッタ
String Property MessageText
    String Function Get()
        Return HiramekiName
    EndFunction

    Function Set(String a_val)
        HiramekiName = a_val
        If (Ready)
            UI.InvokeString(HUD_MENU, WidgetRoot + ".setLabelText", HiramekiName)
        EndIf
    EndFunction
EndProperty

Event OnWidgetInit()
	HAnchor = "center"
	VAnchor = "bottom"
	X = 640
	Y = 720
    WidgetName = "HiramekiWidget"
    RequireExtend = false
    Visible = false
    HiramekiWidgetStart(true, "initialize", false)
	OnWidgetReset()
EndEvent

Event OnWidgetReset()
    UpdateScale()
    Parent.OnWidgetReset()

    if (Visible)
        UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", false)
        Utility.Wait(0.2)
        CutInToX(-640, 0.01)
    EndIf
EndEvent

;swfファイルの指定(カレントはData/Interface/exported/widgets/)
String Function GetWidgetSource()
	return "hirameki/HiramekiWidget.swf"
EndFunction

String Function GetWidgetType()
    Return "aaaHiramekiWidget"
EndFunction

;スケール更新
Function UpdateScale()
	UI.SetInt(HUD_MENU, WidgetRoot + ".Scale", HUD_Size)
EndFunction

Function HiramekiWidgetStart(Bool on, String a_val, Bool a_trigger)
    ;位置の初期化
    CutInToX(-640, 0)
    ;ピコーン
    if (a_trigger)
        Sound pikon = aaaHiramekiSound as Sound
        int instanceIDpikon = pikon.play(Game.GetPlayer())
    EndIf
    ;表示開始
	Visible = on
    MessageText = a_val
    CutInToX(-70, 0.2)
    Utility.Wait(0.2)
    CutInToX(0, 1.0)
    Utility.Wait(1.0)
    ;テューン
    if (a_trigger)
        Sound thun = aaaHiramekiSoundEnd as Sound
        int instanceIDthun = thun.play(Game.GetPlayer())
    EndIf
    FadeTo(0, 0.3)
    Utility.Wait(0.3)
    OnWidgetReset()
EndFunction

function CutInToX(float a_x, float a_duration)
	CutInTo(a_x, 22.5, a_duration)
endFunction

function CutInToY(float a_y, float a_duration)
	CutInTo(22.5, a_y, a_duration)
endFunction

function CutInTo(float a_x, float a_y, float a_duration)
	float[] args = new float[3]
	args[0] = a_x
	args[1] = a_y
	args[2] = a_duration
	UI.InvokeFloatA(HUD_MENU, WidgetRoot + ".cutIn", args)
endFunction
