/*InstallKeybdHook
    Setup
*/

#SingleInstance, Force
#InstallKeybdHook
#InstallMouseHook
#include ..\utils\findText.ahk
#include ..\utils\gdip.ahk
#include ..\utils\gdip_ImageSearch.ahk
SetWorkingDir, %A_ScriptDir%
if !A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}
SetTitleMatchMode, 2
SetTitleMatchMode, slow

Checkbmp := "../temp.png"
gdipToken := Gdip_Startup()
; Gdip_SaveBitmapToFile(bmpHaystack, Checkbmp)

Loop
{
ControlSend, Edit1, {z down}, "Dofus Retro"
bmpHaystack := Gdip_BitmapFromHWND(WinExist("Dofus Retro"))
Gdip_SaveBitmapToFile(bmpHaystack, Checkbmp)
bmpNeedle := Gdip_CreateBitmapFromFile("C:\Users\si201\Documents\DriWiFus\travels\craq.png")
RET := Gdip_ImageSearch(bmpHaystack,bmpNeedle,xy,0,0,0,0,*60,,1,1)
xy := StrSplit(xy, ",")
X := xy[1]
XX := xy[1]+10
Y := xy[2]
YY := xy[2]+10
if (RET = 1) {
  ControlClick, x%X% y%Y%, Dofus Retro
  Sleep, 500
  ControlClick, x%XX% y%YY%, Dofus Retro
}
Gdip_disposeImage( bmpHaystack )
Gdip_disposeImage( bmpNeedle )
ControlSend, Edit1, {z up}, "Dofus Retro"
}
Until RET = 1

EXIT_LABEL:

Gdip_Shutdown(gdipToken)
EXITAPP

Return

