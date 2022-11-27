import win32gui
import win32ui
from ctypes import windll
from PIL import Image
import cv2
import numpy
import pytesseract
from pynput.keyboard import Listener as KeyboardListener
from pynput import keyboard
from pynput.mouse import Controller
from pynput.keyboard import Controller as KController

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


# SETUP

getWindow = getHWND('Zarcheyre-[NBR] - Dofus Retro v1.38.8')
getSize = getSizeFromHWND(getWindow)
screenshot = printScreen(getWindow, getSize, 2)


# SIZING COORDINATE + BLACK/WHITE

box = (684, 848, 710, 874)
screenCrop = screenshot.crop(box)
cropCV = convertPILToCV2(screenCrop)
cropCV = cv2.cvtColor(cropCV, cv2.COLOR_BGR2GRAY)
(_, cropCV) = cv2.threshold(cropCV, 203, 255, cv2.THRESH_BINARY)
cv2.imwrite('tempPA.png', cropCV)

# IMAGE TO STRING

pytesseract.pytesseract.tesseract_cmd = r'utils/Tesseract-OCR/tesseract.exe'
str = pytesseract.image_to_string(Image.open('tempPA.png'), config="outputbase digits")
print(str)
