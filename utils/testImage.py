import win32gui
import win32ui
from ctypes import windll
from PIL import Image
import cv2
import numpy

method = cv2.TM_SQDIFF_NORMED
small_image = cv2.imread('osa.png')

hwnd = win32gui.FindWindow(None, 'Archery-Golo - Dofus Retro v1.38.8')

# Change the line below depending on whether you want the whole window
# or just the client area. 
left, top, right, bot = win32gui.GetClientRect(hwnd)
#left, top, right, bot = win32gui.GetWindowRect(hwnd)
w = right - left
h = bot - top

hwndDC = win32gui.GetWindowDC(hwnd)
mfcDC  = win32ui.CreateDCFromHandle(hwndDC)
saveDC = mfcDC.CreateCompatibleDC()

saveBitMap = win32ui.CreateBitmap()
saveBitMap.CreateCompatibleBitmap(mfcDC, w, h)

saveDC.SelectObject(saveBitMap)

# Change the line below depending on whether you want the whole window
# or just the client area. 
#result = windll.user32.PrintWindow(hwnd, saveDC.GetSafeHdc(), 1)
result = windll.user32.PrintWindow(hwnd, saveDC.GetSafeHdc(), 2)

bmpinfo = saveBitMap.GetInfo()
bmpstr = saveBitMap.GetBitmapBits(True)

im = Image.frombuffer(
    'RGB',
    (bmpinfo['bmWidth'], bmpinfo['bmHeight']),
    bmpstr, 'raw', 'BGRX', 0, 1) 

img = cv2.cvtColor(numpy.array(im), cv2.COLOR_RGB2BGR)

result = cv2.matchTemplate(small_image, img, method)
print(result)
mn,_,mnLoc,mxLoc = cv2.minMaxLoc(result)
MPx,MPy = mnLoc
loc = numpy.where( result <= 0.05)
# Step 2: Get the size of the template. This is the same size as the match.
trows,tcols = small_image.shape[:2]
for pt in zip(*loc[::-1]):
    cv2.rectangle(img, pt,(pt[0]+tcols,pt[1]+trows),(0,0,255),2)
# Step 3: Draw the rectangle on large_image
# cv2.rectangle(img, (MPx,MPy),(MPx+tcols,MPy+trows),(0,0,255),2)
# Display the original image with the rectangle around the match.
cv2.imwrite('Testcv.jpg', img)
win32gui.DeleteObject(saveBitMap.GetHandle())
saveDC.DeleteDC()
mfcDC.DeleteDC()
win32gui.ReleaseDC(hwnd, hwndDC)
