import time
from picar import back_wheels, front_wheels

def followPath(duration, speed, angle)
  bw.speed = speed
  time.sleep(duration*.75)
  fw.angle(angle+90)
  time.sleep(duration*0.25)
  bw.speed = speed *-1
  fw.angle(angle)
  time.sleep(duration*0.25)
  fw.angle(90)
  time.sleep(duration)