/*
    Setup
*/

#SingleInstance, Force
#InstallKeybdHook
#InstallMouseHook
#include ..\utils\findText.ahk
SendMode Input
SetWorkingDir, %A_ScriptDir%
if !A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

FindText().BindWindow(WinExist("Zaborigene - Dofus Retro v1.38.8"))

/*
    Fonction
*/

ReturnWaitTime() {
    Random, a, 50, 120
    return a
}

RandomPos(b) {
    Random, b1, b-5, b+5
    return x%b1%
}

/* 
    Définition des images de coordonées
*/

Map1:="|<>*110$59.0000000000000000000000000000000000000000000000000000200000000Tw0000T800zs0000yM01U000010k000000001U00000000700C000000A00T80000A0Dk0E00DkyETU0k00TX0k001U00061U003000043000C300006000sC0000Q01zkM000zk00y1k000S0000300000000060000000008000000000000001"
Map2:="|<>*80$59.00000000000000000000000000000003zU0003k007z0000C200A00000M400000000kA00000001UM00k000000k03t000001Vy02001yDX3w06003wD6000A00000Q000M00000k000kM0003U0071k000C00Dy30007s007kC000D00000M000000000k000000001000004"
Map3:="|<>*80$57.00000000000000000000000000000000000000000000000000000000000DU0001s007o0000A401k000030U0800000M6000000030k0/000000603w000000nwM2003wD6TV0E00TVskE86000006000k00001U00620000Q001kk0007007w6000Dk00S0k001s0000A000000001k000000008000000000000004"
Map4:="|<>*90$57.00000000000000000000000000000000000000000000000000000000000DU0001wU0300000A400U000010k080000006000000001k09000000A03w00000k3wM2003wBUTV0E00TX0k0860000M6000k00010k006000006001Uk0001k07s6000Dw0000k000Q0000A000000001U000000008000000000000004"
Map5:="|<>*90$57.00000000000000000000000000000000000000000000000001w0000Ta00s000000k0C0000006010000001U00000000A01M00000300TU00000MTX0E00TU63w82003w0U010k0000A0006000030000kE000M000C60006000zUk000k001k6000000001U00000000A0000000010000000000000000000000004"
Map6:="|<>*50$57.000000000000000000000000000000000000000000000000000000000000000000003z0000Dn00Ts00000M020000003000000000k000000004000000001U07U000008Dk0E00Dk31y01001k0E000M00006000300000U000M8000A000630001001zUM000M001s3000000000k000000006000000000U00004"
Map7:="|<>*150$57.00000000000000000000000000000000000000000000000000M0000Ta00300003wk01M00000600P000001U07M00000Q01n00000300AM00000sTU0000TU63wE8003w1k07vs0000A000Q00003U0030s000M000M7000600030k000k0000C000000001U00000000A0000000010000000000000000000000004"

/*
    Boucle de déplacement, Break à la dernière map
*/
While, End!=1 {

 if (ok:=FindText(19, 79, 251, 125, 0, 0, Map1))
 {
   Send {e down}
   xpos:=RandomPos(633)
   ypos:=RandomPos(62)
   ControlClick, x%xpos%  y%ypos%, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   Sleep, 5000
 }

 if (ok:=FindText(19, 79, 251, 125, 0, 0, Map2))
 {
   Send {e down}
   ControlClick, x54 y551, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   Sleep, 5000
 }

 if (ok:=FindText(19, 79, 251, 125, 0, 0, Map3))
 {
   Send {e down} 
   ControlClick, x917 y793, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   Sleep, 5000
 }

 if (ok:=FindText(19, 79, 251, 125, 0, 0, Map4))
 {
   Send {e down}
   ControlClick, x153 y793, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   Sleep, 5000
 }
    
 if (ok:=FindText(19, 79, 251, 125, 0, 0, Map5))
 {
   Send {e down} 
   ControlClick, x1302 y744, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   Sleep, 5000
 }

 if (ok:=FindText(19, 79, 251, 125, 0, 0, Map6))
 {
   Send {e down}
   MsgBox, RandomPos(1301)
   ControlClick, x1301 y257, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   Sleep, 5000
 }

 if (ok:=FindText(19, 79, 251, 125, 0, 0, Map7))
 {
   Send {e down}
   ControlClick, x1293 y696, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   Sleep, 5000
   End=1
 }
 }

Return

