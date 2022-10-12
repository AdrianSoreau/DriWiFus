# Imports :

import win32gui
import win32ui
from ctypes import windll
from PIL import Image
import cv2
import numpy

# Récupération des coordonnées de la map :


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

