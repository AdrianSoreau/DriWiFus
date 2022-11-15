import time
import win32gui
import win32ui
from ctypes import windll
from PIL import Image
import cv2
import numpy
import pytesseract
import os
import pyautogui as pg
from GetCoords import getHWND, getSizeFromHWND, printScreen, convertPILToCV2
import re

pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'

Runes = {
    "vitalité": 2000,
    "intelligence":500,
    "chance":450,
    "coups critiques":4300,
    "créatures invocables":900,
    "dommages":825,
    "prospection":12000,
    "sagesse":550
}

TempRunes = {
    "vitalité": 0,
    "intelligence":0,
    "chance":0,
    "coups critiques":0,
    "créatures invocables":0,
    "dommages":0,
    "prospection":0,
    "sagesse":0
}

CasqueHarnage = {
    "vitalité": 250,
    "chance": 60,
    "intelligence": 60,
    "sagesse": 30,
    "coups critiques": 4,
    "dommages": 10,
    "prospection": 30,
    "créatures invocables": 2
}

TempCasqueHarnage = {
    "vitalité": 210,
    "chance": 58,
    "intelligence": 58,
    "sagesse": 24,
    "coups critiques": 4,
    "dommages": 10,
    "prospection": 28,
    "créatures invocables": 1
}

CapeMinotot = {
    "vitalité": 250,
    "chance": 50,
    "intelligence": 50,
    "sagesse": 25,
    "coups critiques": 4,
    "dommages": 10,
    "prospection": 30
}

TempCapeMinotot = {
    "vitalité": 210,
    "chance": 48,
    "intelligence": 48,
    "sagesse": 21,
    "coups critiques": 4,
    "dommages": 8,
    "prospection": 28
}

PositionFM = {
    "top": 219,
    "left": 368,
    "bottom": 499,
    "right": 699
}

def RefreshScreen():
    tempScreen = printScreen(HWND_ArcheryGolo, Size_ArcheryGolo, 2)
    tempScreen = convertPILToCV2(tempScreen)
    return tempScreen

def PutRune(runePos):
    pg.doubleClick(runePos["x"], runePos["y"])
    time.sleep(1)


def FindRune(rune, imageSearchedOn):
    runeImg = cv2.imread(os.path.join(os.path.dirname(
        __file__), "..\\img\\Runes\\{0}.png".format(rune)))
    method = cv2.TM_CCOEFF_NORMED
    result = cv2.matchTemplate(runeImg, imageSearchedOn, method)
    h, w, _ = runeImg.shape
    y, x = numpy.unravel_index(numpy.argmax(result), result.shape)
    return {"x": round((x + w/2)), "y": round((y + h/2))}


def FindStatToUp():
    CurrentStats = GetCurrentStats(CasqueHarnage)
    if "créatures invocables" not in CurrentStats or CurrentStats["créatures invocables"] < 1 :
        return {"rune":"creatures_invocables", "stat":"créatures invocables"}
    if "coups critiques" not in CurrentStats or CurrentStats["coups critiques"] < 4:
        return {"rune":"coups_critiques", "stat":"coups critiques"}
    if "dommages" not in CurrentStats or CurrentStats["dommages"] < 10:
        return {"rune":"dommages", "stat":"dommages"}
    if "sagesse" not in CurrentStats or CurrentStats["sagesse"] < 23:
        return {"rune":"pa_sagesse", "stat":"sagesse"}
    if "intelligence" not in CurrentStats or CurrentStats["intelligence"] < 58:
        return {"rune":"pa_intelligence", "stat":"intelligence"}
    if "chance" not in CurrentStats or CurrentStats["chance"] < 58:
        return {"rune":"pa_chance", "stat":"chance"}
    if "vitalité" not in CurrentStats or CurrentStats["vitalité"] < 210:
        return {"rune":"pa_vitalite", "stat":"vitalité"}
    if "prospection" not in CurrentStats or CurrentStats["prospection"] < 28:
        return {"rune":"pa_prospection", "stat":"prospection"}
    return {"rune":"pa", "stat":"pa"}


def GetCurrentStats(itemBaseStats):
    CurrentScreen_ArcheryGolo = RefreshScreen()
    croppedScreen = CurrentScreen_ArcheryGolo[PositionFM["top"]
        :PositionFM["bottom"], PositionFM["left"]:PositionFM["right"]]
    cropCV = cv2.cvtColor(croppedScreen, cv2.COLOR_BGR2GRAY)
    (_, cropCV) = cv2.threshold(cropCV, 150, 255, cv2.THRESH_BINARY)
    PilImg = Image.fromarray(cropCV)
    stats = pytesseract.image_to_string(PilImg, lang='fra').splitlines()
    cleanedStats = list(filter(lambda value: value, stats))
    cleanedStats = [x.lower() for x in cleanedStats]
    tempCasque = {}
    for stat in itemBaseStats:
        indice = [i for i, s in enumerate(cleanedStats) if stat in s]
        if indice:
            indice = indice[0]
            tempCasque[stat] = int(re.findall(
                r'\d+', cleanedStats[indice])[0])
    return tempCasque

def UpStat(stat):
    upped = False
    while not upped:
        allStats = GetCurrentStats(CasqueHarnage)
        statValue = allStats[stat] if stat in allStats else 0
        if statValue >= TempCasqueHarnage[stat]:
            upped = True
        else:
            pg.press("x")
            TempRunes[stat] += Runes[stat]
            time.sleep(0.4)
        

# Get window's data and screenshot
HWND_ArcheryGolo = getHWND("Archery-Golo - Dofus Retro v1.38.8")
Size_ArcheryGolo = getSizeFromHWND(HWND_ArcheryGolo)
CurrentScreen_ArcheryGolo = printScreen(HWND_ArcheryGolo, Size_ArcheryGolo, 2)
CurrentScreen_ArcheryGolo = convertPILToCV2(CurrentScreen_ArcheryGolo)
start_time = time.time()
time.sleep(2)
done = False
while not done:
    CurrentScreen_ArcheryGolo = RefreshScreen()
    runeToPut = FindStatToUp()
    print(runeToPut)
    if runeToPut["rune"] == "pa":
        done = True
    else:
        runePos = FindRune(runeToPut["rune"], CurrentScreen_ArcheryGolo)
        PutRune(runePos)
        UpStat(runeToPut["stat"])
        
# windll.user32.MessageBoxW(0, "FM FINI", "OMG", 1)
print("--- %s seconds ---" % (time.time() - start_time))
print("Cela a coûté {:,} kamas".format(sum(TempRunes.values())))
time.sleep(1)
for key in TempRunes:
    print("Nombre de runes " + key + ": " + str(TempRunes[key] / Runes[key]))
time.sleep(3)
