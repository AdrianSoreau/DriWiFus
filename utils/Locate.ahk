#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Include, FindText.ahk
if !A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}