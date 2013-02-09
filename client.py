import os
import zmq
import wiringpi

RED_PIN = 0
GREEN_PIN = 1
BLUE_PIN = 2

def main():
    context = zmq.Context()
    socket = context.socket(zmq.SUB)
    socket.setsockopt(zmq.SUBSCRIBE, '')
    socket.connect('tcp://192.168.2.1:7777')

    wiringpi.wiringPiSetup()
    wiringpi.softPwmCreate(RED_PIN, 0, 255)
    wiringpi.softPwmCreate(GREEN_PIN, 0, 255)
    wiringpi.softPwmCreate(BLUE_PIN, 0, 255)

    while True:
        data = socket.recv()
        red = int(data[:3])
        green = int(data[3:6])
        blue = int(data[6:9])

        wiringpi.softPwmWrite(RED_PIN, red)
        wiringpi.softPwmWrite(GREEN_PIN, green)
        wiringpi.softPwmWrite(BLUE_PIN, blue)

if __name__ == '__main__':
    main()

