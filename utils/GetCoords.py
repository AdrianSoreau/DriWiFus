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


# Give wanted window name, return its HWND

def getHWND(name):
    return win32gui.FindWindow(None, name)


# Give HWND, return coords, width, height

def getSizeFromHWND(hwnd):
    left, top, right, bot = win32gui.GetClientRect(hwnd)
    w = right - left
    h = bot - top
    return {"left": left, "top": top, "right": right, "bot": bot, "w": w, "h": h}


# Give HWND + Size + N° of process wanted of your window, get a screenshot (PIL Image format)

def printScreen(hwnd, size, process):
    hwndDC = win32gui.GetWindowDC(hwnd)
    mfcDC = win32ui.CreateDCFromHandle(hwndDC)
    saveDC = mfcDC.CreateCompatibleDC()
    saveBitMap = win32ui.CreateBitmap()
    saveBitMap.CreateCompatibleBitmap(mfcDC, size["w"], size["h"])
    saveDC.SelectObject(saveBitMap)
    windll.user32.PrintWindow(hwnd, saveDC.GetSafeHdc(), process)
    bmpinfo = saveBitMap.GetInfo()
    bmpstr = saveBitMap.GetBitmapBits(True)

    imPIL = Image.frombuffer(
        'RGB',
        (bmpinfo['bmWidth'], bmpinfo['bmHeight']),
        bmpstr, 'raw', 'BGRX', 0, 1)

    win32gui.DeleteObject(saveBitMap.GetHandle())
    saveDC.DeleteDC()
    mfcDC.DeleteDC()
    win32gui.ReleaseDC(hwnd, hwndDC)

    return imPIL


# Convert PIL RGB Image to CV2 BGR Image

def convertPILToCV2(img):
    return cv2.cvtColor(numpy.array(img), cv2.COLOR_RGB2BGR)


# Search a CV2 image on another.
# IsTest : False to get coords, True to draw rectangles and save image. Default: False

def singleMatch(imageToSearch, imageSearchedOn, isTest=False, nameTest="TestSingleImage.png", method=cv2.TM_SQDIFF_NORMED):
    result = cv2.matchTemplate(imageToSearch, imageSearchedOn, method)
    result = cv2.findNonZero()
    print(result)
    _, _, mnLoc, _ = cv2.minMaxLoc(result)
    MPx, MPy = mnLoc
    trows, tcols = imageToSearch.shape[:2]
    if isTest:
        cv2.rectangle(imageSearchedOn, (MPx, MPy),
                      (MPx+tcols, MPy+trows), (0, 0, 255), 2)
        cv2.imshow(nameTest, imageSearchedOn)
        cv2.waitKey(0)
    return {"x": round((MPx + tcols)/2), "y": round((MPy + trows)/2)}


# Search a CV2 images on another.
# IsTest : False to get coords, True to draw rectangles and save image. Default: False
# Quantity : Quantity of result needed
# Threshold : Confidence of positive matches

def multipleMatches(imageToSearch, imageSearchedOn, quantity, isTest=False, nameTest="TestMultipleMatch.png", threshold=0.01, method=cv2.TM_SQDIFF_NORMED):
    result = cv2.matchTemplate(imageToSearch, imageSearchedOn, method)
    loc = numpy.where(result <= threshold)
    trows, tcols = imageToSearch.shape[:2]
    locations = []
    for pt in zip(*loc[:quantity-1:-1]):
        locations.append(
            {"x": round((pt[0] + tcols)/2), "y": round((pt[1] + trows)/2)})
    if isTest:
        for pt in zip(*loc[:quantity-1:-1]):
            cv2.rectangle(imageSearchedOn, pt,
                          (pt[0] + tcols, pt[1] + trows), (0, 0, 255), 2)
        cv2.imwrite(nameTest, imageSearchedOn)
    return locations


########################################################################################################################

# Get window's data and screenshot
HWND_ArcheryGolo = getHWND("Archery-Golo - Dofus Retro v1.38.8")
Size_ArcheryGolo = getSizeFromHWND(HWND_ArcheryGolo)
CurrentScreen_ArcheryGolo = printScreen(HWND_ArcheryGolo, Size_ArcheryGolo, 2)
CurrentScreen_ArcheryGolo = convertPILToCV2(CurrentScreen_ArcheryGolo)

# # Get current directory path
ScriptDir = os.path.dirname(__file__)

# # Get CV2 wanted image
# OsaImgRelPath = "../img/osa.png"
# OsaImgFullPath = os.path.join(ScriptDir, OsaImgRelPath)
# OsaImg = cv2.imread(OsaImgFullPath)

# # Check image on screenshot, get coords
# OsaPos = singleMatch(OsaImg, CurrentScreen_ArcheryGolo, False)
# print(OsaPos)

# mobsImg = []
# mobs = ["craq-no", "craq-ne", "craq-so", "craq-se", "craqueboule-no", "craqueboule-ne", "craqueboule-so", "craqueboule-se"]
# for mob_orientation in mobs:
#     pathToImg = os.path.join(ScriptDir, "..\\img\\" + mob_orientation + ".png")
#     print(pathToImg)
#     mobsImg.append(cv2.imread(pathToImg))
#     print(type(cv2.imread("img/" + mob_orientation + ".png")))

# for mob in mobsImg:
#     temp = singleMatch(mob, CurrentScreen_ArcheryGolo, True, "utils/tempImg/" + str(mobs[mobsImg.index(mob)]) + ".png")


def minStats(objet, stats):
    for stat in stats:
        objet[stat["name"]] = stat["value"]
    return objet


def upStat(stat):
    return 1


def testTesseract():
    pytesseract.pytesseract.tesseract_cmd = r'C:\\Program Files\\Tesseract-OCR\\tesseract.exe'
    img = cv2.imread(os.path.join(ScriptDir, "..\\img\\fm.png"))
    cropCV = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    (_, cropCV) = cv2.threshold(cropCV, 150, 255, cv2.THRESH_BINARY)
    print(pytesseract.image_to_string(Image.open('tempFM.png'), lang='fra'))


# time.sleep(5)
# print(pg.position())
