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
    ControlClick, x%xpos% y%ypos%, Zantedeschia-[NBR] - Dofus Retro v1.39.1
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zarboricole - Dofus Retro v1.39.1
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zaborigene - Dofus Retro v1.39.1
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zarbre - Dofus Retro v1.39.1
    Sleep, RandomWaitTime()
return

/*
    Click droit sur les 4 comptes (Ctrl + ClickDroit)
*/

^RButton::
    MouseGetPos, xpos, ypos
    ControlClick, x%xpos% y%ypos%, Zantedeschia-[NBR] - Dofus Retro v1.39.1
    ControlClick, x%xpos% y%ypos%, Zantedeschia-[NBR] - Dofus Retro v1.39.1, ,R
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zarboricole - Dofus Retro v1.39.1
    ControlClick, x%xpos% y%ypos%, Zarboricole - Dofus Retro v1.39.1, ,R
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zaborigene - Dofus Retro v1.39.1
    ControlClick, x%xpos% y%ypos%, Zaborigene - Dofus Retro v1.39.1, ,R
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zarbre - Dofus Retro v1.39.1
    ControlClick, x%xpos% y%ypos%, Zarbre - Dofus Retro v1.39.1, ,R
    Sleep, RandomWaitTime()
return
