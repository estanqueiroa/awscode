import pyautogui
import time
import random as rnd

#calculate height and width of screen
w, h = list(pyautogui.size())[0], list(pyautogui.size())[1]

while True:
    time.sleep(10)
    #move mouse at random location in screen, change it to your preference
    pyautogui.moveTo(rnd.randrange(0, w), 
                     rnd.randrange(0, h))#, duration = 0.1)