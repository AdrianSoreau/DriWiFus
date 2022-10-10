/*InstallKeybdHook
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

;temp := WinExist("Zaborigene - Dofus Retro v1.38.8")
ft := new FindTextClass
temp := WinExist("Zaborigene - Dofus Retro v1.38.8")
;ft.BindWindow(temp,4,0,0)

;FindText().BindWindow(WinExist("Zaborigene - Dofus Retro v1.38.8"))
;MsgBox, % temp


/*
    Fonction
*/

ReturnWaitTime() {
    Random, a, 50, 120
    return a
}

RandomPos(b) {
    Random, b1, b-5, b+5
    return b1
}

/* 
    Définition des images de coordonées
*/

Map1:="|<>*85$71.00000000000000000000000000000000000000000000000000000000000000000000000000zs0000yE0001zk0001wU00030000021U0000000000300000000000C0000A000000M0000y00000M000TU0U00TVg000z01U00z61U000030000A300000600008600000A40000A00001kM0000s0003z0k001zU0001w3U000w000000600000000000A00000000000E000000000000000001"
Map2:="|<>*50$71.00000000000000000000000000000000000000000000000000000000000000000000000000zk0001s00001zU000710000200000A20000000000M40000000000kA00000000000M0001s000000k00z01000z41U01y01001y7X00000600000600000A00000M00000MA0001k00001Us000700007y1U003w00001s30007U000000A00000000000M00000000000U000000000000000001"
Map3:="|<>*175$71.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzkTzzzy1zzzzz2zzzzwMzzzzwzzzzzltzzzznzzzzzbvzzzzbzzzzzDnzzzzQzzzzyTbzzzw0TzzzwzDzzUMyTzz0wwTzz0nwzzy1s0zzzzbtzzzzztzzzzjvzzzzzrzzzzDbzzzzzDzzzyTD7zzzwzzzzy0yTzzw3zzzzz3wzzzsTzzzzzzvzzzzzzzzzzzbzzzzzzzzzzzDzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
Map4:="|<>*50$71.00000000000y00000000001w00000000001s00000000003k00000000007U0000000000D00000000000C000T00001k0Q00100000620M00400000840E00E000000A00000000000k00000000001U0003s00001U081y41001y6E0M1w82003w820k00E40000kA1U000M0000UM10000k00000k000031U000300003w30003w000000400000000000M00000000000U000000000010000001"
Map5:="|<>*60$71.000000000000000000000000000000000000000000000000000000000000003s0000zA0000A000000M0000U000000k0002000000300000000000600001000000M0000T000000U00DkU800Dk3000DV0E00TU4000020U0000M00000300000U00000600003000000MA000A00000TUM000M0000000U00000000003000000000006000000000008000000000000000000000000000001"
Map6:="|<>*30$71.zk003y020001zk007w000003zU007k000007y000DU00000Dw000C000000TU0000000000w01zU0007sU1003z00000300004000000400000000000800000000000U0000000000300003k000004001y00001y0M003w0200200U00000A00003000000M00004000000kE000M0000031U000U00007w30002000003k600000000000M00000000000k000000000010000000000000000001"
Map7:="|<>*80$71.000000000000000000000000000000000000000000000000000000000000000U0001yM00001000000k00002000001U0001Y00000700002800000A0000AE00000k0000kU00001U00TU0000TU7000z00000z0A0000Db00000k00000800003000000E00006000000UM000M0000010k000k000000100000000000600000000000A00000000000E000000000000000000000000000001"

/*
    Boucle de déplacement, Break à la dernière map
*/
While, End!=1 {

 if (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0.5, 0.5, Map1))
 {
   Send {e down}
   xpos:=RandomPos(633)
   ypos:=RandomPos(62)
   ControlClick, x%xpos%  y%ypos%, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   While, (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map1)) {
    Sleep, 500
    ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map1)
   }
 }

 if (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map2))
 {
   Send {e down}
   xpos:=RandomPos(54)
   ypos:=RandomPos(551)
   ControlClick, x%xpos% y%ypos%, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   While, (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map2)) {
    Sleep, 500
    ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map2)
   }
 }

 if (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map3))
 {
   Send {e down}
   xpos:=RandomPos(917)
   ypos:=RandomPos(793)
   ControlClick, x%xpos%  y%ypos%, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   While, (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map3)) {
    Sleep, 500
    ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map3)
   }
 }

 if (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map4))
 {
   Send {e down}
   xpos:=RandomPos(153)
   ypos:=RandomPos(793)
   ControlClick, x%xpos%  y%ypos%, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   While, (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map4)) {
    Sleep, 500
    ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map4)
   }
 }
    
 if (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map5))
 {
   Send {e down}
   xpos:=RandomPos(1302)
   ypos:=RandomPos(744) 
   ControlClick, x%xpos%  y%ypos%, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   While, (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map5)) {
    Sleep, 500
    ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map5)
   }
 }

 if (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map6))
 {
   Send {e down}
   xpos:=RandomPos(1301)
   ypos:=RandomPos(257)
   ControlClick, x%xpos%  y%ypos%, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   While, (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map6)) {
    Sleep, 500
    ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map6)
   }
 }

 if (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map7))
 {
   Send {e down}
   xpos:=RandomPos(1293)
   ypos:=RandomPos(696)
   ControlClick, x%xpos%  y%ypos%, Zaborigene - Dofus Retro v1.38.8
   Sleep, ReturnWaitTime()
   Send {e up}
   While, (ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map7)) {
    Sleep, 500
    ok:=ft.FindText(X, Y, 19, 79, 251, 125, 0, 0, Map7)
   }
   End=1
 }
 }

Return

