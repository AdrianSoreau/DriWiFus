#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Include, findText.ahk
if !A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

Soleil:="|<>**30$8.TaRVks7zU"
Passe:="|<>*160$40.zzzzzzzzs7lzzzzUT3zzzy1w7zzzs7kDzzzUT0Tzzy1w0zz00001zw00003zk00007z00000Dw00000zk00001z00000Dw00001zk0000Dz00001zzzUT0Dzzy1w0zzzs7k7zzzUT0zzzy1w7zzzs7kzzzzzzzzzU"
/*
    Function :
*/

RandomWaitTime() {
    Random, a, 100, 200
    return a
}

RandomPasse() {
    Random, a, 500, 600
    return a
}

RandomClickPos(a) {
    Random, a1, a-5, a+5
    return a1
}

/*
    Click sur les 4 comptes (Ctrl+Click)
*/
While, End!=1 {
if (temp:=FindText(X, Y, 19, 79, 1800, 1800, 0.2, 0.2, Soleil)) {
    for k, v in temp { ; Loop over all the search results in "ok". "k" will be the nth result, and "v" will contain the result itself.
        MouseMove, v[1], v[2]
        MsgBox, % "Result number " k " is located at X" v[1] " Y" v[2]

}
}
}

^LButton:
    MouseGetPos, xpos, ypos
    ControlClick, x%xpos% y%ypos%, Zarcheyre-[NBR] - Dofus Retro v1.38.8
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zacross-Themap - Dofus Retro v1.38.8
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zarrow - Dofus Retro v1.38.8
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zarbalete - Dofus Retro v1.38.8
    Sleep, RandomWaitTime()
return

/*
    Click droit sur les 4 comptes (Ctrl + ClickDroit)
*/

^RButton::
    MouseGetPos, xpos, ypos
    ControlClick, x%xpos% y%ypos%, Zarcheyre-[NBR] - Dofus Retro v1.38.8
    ControlClick, x%xpos% y%ypos%, Zarcheyre-[NBR] - Dofus Retro v1.38.8, ,R
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zacross-Themap - Dofus Retro v1.38.8
    ControlClick, x%xpos% y%ypos%, Zacross-Themap - Dofus Retro v1.38.8, ,R
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zarrow - Dofus Retro v1.38.8
    ControlClick, x%xpos% y%ypos%, Zarrow - Dofus Retro v1.38.8, ,R
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zarbalete - Dofus Retro v1.38.8
    ControlClick, x%xpos% y%ypos%, Zarbalete - Dofus Retro v1.38.8, ,R
    Sleep, RandomWaitTime()
return

/*
    Molette bas sur tous les comptes (Ctrl+MoletteBas)
*/

+WheelDown::
    MouseGetPos, xpos, ypos
    ControlClick, x%xpos% y%ypos%, Zarcheyre-[NBR] - Dofus Retro v1.38.8
    ControlClick, x%xpos% y%ypos%, Zarcheyre-[NBR] - Dofus Retro v1.38.8, ,WheelDown
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zacross-Themap - Dofus Retro v1.38.8
    ControlClick, x%xpos% y%ypos%, Zacross-Themap - Dofus Retro v1.38.8, ,WheelDown
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zarrow - Dofus Retro v1.38.8
    ControlClick, x%xpos% y%ypos%, Zarrow - Dofus Retro v1.38.8, ,WheelDown
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zarbalete - Dofus Retro v1.38.8
    ControlClick, x%xpos% y%ypos%, Zarbalete - Dofus Retro v1.38.8, , WheelDown
    Sleep, RandomWaitTime()
return

/*
    Molette haut sur tous les comptes (Ctrl+MoletteHaut)
*/

+WheelUp::
    MouseGetPos, xpos, ypos
    ControlClick, x%xpos% y%ypos%, Zarcheyre-[NBR] - Dofus Retro v1.38.8, ,WU
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zacross-Themap - Dofus Retro v1.38.8, ,WU
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zarrow - Dofus Retro v1.38.8, ,WU
    Sleep, RandomWaitTime()
    ControlClick, x%xpos% y%ypos%, Zarbalete - Dofus Retro v1.38.8, ,WU
    Sleep, RandomWaitTime()
return

/*
    Spam passer sur les mules (Ctrl+p = ON // Ctrl+o = OFF)
*/

^p::

    Loop {
        ControlClick, x887 y996, Zacross-Themap - Dofus Retro v1.38.8
        Sleep, RandomPasse()
        ControlClick, x887 y996, Zarrow - Dofus Retro v1.38.8
        Sleep, RandomPasse()
        ControlClick, x887 y996, Zarbalete - Dofus Retro v1.38.8
        Sleep, RandomPasse()
    }
    Until GetKeyState("o", "P")



