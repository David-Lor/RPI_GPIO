import RPi.GPIO as GPIO
import time

PIN_S0=23
PIN_S1=24
PIN_S2=27
PIN_S3=22
PIN_V=18
DELAY=0.42

GPIO.cleanup()
GPIO.setmode(GPIO.BCM)

GPIO.setup(PIN_V, GPIO.OUT)
GPIO.setup(PIN_S0, GPIO.OUT)
GPIO.setup(PIN_S1, GPIO.OUT)
GPIO.setup(PIN_S2, GPIO.OUT)
GPIO.setup(PIN_S3, GPIO.OUT)

GPIO.output(PIN_V, GPIO.HIGH)
GPIO.output(PIN_S0, GPIO.LOW)
GPIO.output(PIN_S1, GPIO.LOW)
GPIO.output(PIN_S2, GPIO.LOW)
GPIO.output(PIN_S3, GPIO.LOW)
#var = 1
while 1 == 1 : #infinite loop
	GPIO.output(PIN_S0, GPIO.LOW)
	GPIO.output(PIN_S1, GPIO.LOW)
	GPIO.output(PIN_S2, GPIO.LOW)
	GPIO.output(PIN_S3, GPIO.LOW)
	time.sleep(DELAY)
	GPIO.output(PIN_S0, GPIO.HIGH)
	GPIO.output(PIN_S1, GPIO.LOW)
	GPIO.output(PIN_S2, GPIO.LOW)
	GPIO.output(PIN_S3, GPIO.LOW)
	time.sleep(DELAY)
	GPIO.output(PIN_S0, GPIO.LOW)
	GPIO.output(PIN_S1, GPIO.HIGH)
	GPIO.output(PIN_S2, GPIO.LOW)
	GPIO.output(PIN_S3, GPIO.LOW)
	time.sleep(DELAY)
GPIO.cleanup()