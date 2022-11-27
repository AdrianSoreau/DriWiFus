#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

if !A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

/*
    Function :
*/

RandomWaitTime() {
    Random, a, 100, 200
    return a
}

/*
    Click sur les 4 comptes (Ctrl + Click)
*/

^LButton::
    MouseGetPos, xpos, ypos
    MsgBox, [%xpos%, %ypos%]
return

