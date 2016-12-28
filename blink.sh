#!/bin/bash
#BLINK 1 sólo led. Se desactiva el GPIO usado ANTES de ejecutar el código.

PIN=17
DELAY=0.42

#Funcion Blink
f_blink ()
{
	echo 1 >  /sys/class/gpio/gpio$PIN/value
	sleep $DELAY
	echo 0 >  /sys/class/gpio/gpio$PIN/value
	sleep $DELAY
}
#Funcion Desactivar GPIO
f_end ()
{
	echo $PIN >  /sys/class/gpio/unexport
}
#Funcion Iniciar GPIO
f_begin ()
{
	echo $PIN > /sys/class/gpio/export
	echo out > /sys/class/gpio/gpio$PIN/direction
}

#Empieza
echo "Raspberry Pi Bash - LED Blink"
echo "El LED conectado a GPIO #"$PIN" se encenderá y apagará cada "$DELAY" s."
#Apagar GPIO anteriores
	f_end
#Inicializar GPIO
	f_begin
#Bucle ON-OFF (blink)
while :
do
	f_blink
done