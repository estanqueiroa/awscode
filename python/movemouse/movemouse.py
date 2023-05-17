#! python3

import pyautogui
import time
import random as rnd

print('Press Ctrl-C to quit.')

try:
    while True:

        #calculate height and width of screen
        w, h = list(pyautogui.size())[0], list(pyautogui.size())[1]

        time.sleep(10) # execute function every 10 seconds

        # this random move was replaced by position move below to avoid clicking on active screens / windows
        #move mouse at random location in screen, change it to your preference
        # pyautogui.moveTo(rnd.randrange(0, w), 
        #                 rnd.randrange(0, h))#, duration = 0.1)
        
        pyautogui.move(0, 50)       # move the mouse down 50 pixels.
        pyautogui.move(-30, 0)      # move the mouse left 30 pixels.
        pyautogui.move(0, -50)      # move the mouse up 50 pixels.
        pyautogui.move(30, 0)      # move the mouse right 30 pixels.
        pyautogui.click(clicks=1)  # single-click the left mouse button

except KeyboardInterrupt:
    print('\n')