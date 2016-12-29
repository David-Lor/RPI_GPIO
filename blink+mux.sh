#!/bin/bash
#BLINK 3 leds utilizando un multiplexor para controlar cada uno de ellos.
#Usar pines de control para el mux. y un solo pin de señal
#Por el momento, switcheo sencillo entre 3 leds (encender y apagar uno a uno) (mux. salidas 0, 1 y 2)

PIN_S0=23
PIN_S1=24
PIN_S2=27
PIN_S3=22
PIN_V=18
DELAY=0.42		#en segundos
#Valores Binarios: S3|S2|S1|S0
BIN_0=0000
BIN_1=0001
BIN_2=0010
BIN_3=0011
BIN_4=0100
BIN_5=0101
BIN_6=0110
BIN_7=0111
BIN_8=1000
BIN_9=1001
BIN_10=1010
BIN_11=1011
BIN_12=1100
BIN_13=1101
BIN_14=1110
BIN_15=1111

echo "Bash RPi: Blink 3 leds con Mux."
echo "-------------------------------"

#Función Desactivar pines
f_dealloc ()
{
	echo "Desactivando todos los pines..."
	echo $PIN_S0 >  /sys/class/gpio/unexport
	echo $PIN_S1 >  /sys/class/gpio/unexport
	echo $PIN_S2 >  /sys/class/gpio/unexport
	echo $PIN_S3 >  /sys/class/gpio/unexport
	echo $PIN_V >  /sys/class/gpio/unexport
	echo "Todos los pines desactivados"
}
#Función Activar pines
f_alloc ()
{ #S0~S3=0~3; V=4
	echo "Activando todos los pines..."
	ALLOC_COUNT=0
	while [ $ALLOC_COUNT -lt 5 ] #Procesar 5 pines (0~4), parar cuando se superan
	do
		if [ $ALLOC_COUNT -lt 4 ]; then #Pines S0~S3
			PIN_ORD=PIN_S$ALLOC_COUNT
		else #Pin 4º (PIN_V)
			PIN_ORD=PIN_V
		fi
		echo "Activando "$PIN_ORD"..."
		echo $(( $PIN_ORD )) > /sys/class/gpio/export
		echo out > /sys/class/gpio/gpio$(( $PIN_ORD ))/direction
		echo "Activado "$PIN_ORD
		ALLOC_COUNT=$(( $ALLOC_COUNT + 1 ))
	done
	echo "Todos los pines activados"
}
#Funcion cambiar posición del MUX
f_mux () #pasarle dirección en binario (0000;0001;0010...)
{
	echo "Cambiando Mux. a la salida b'"$1"..."
	#Tomar valores binarios 0/1 para cada pin director del Mux. (S0~S3)
	BIN_S3=$(echo $1 | cut -c1)
	BIN_S2=$(echo $1 | cut -c2)
	BIN_S1=$(echo $1 | cut -c3)
	BIN_S0=$(echo $1 | cut -c4)
	#Cambiar dirección del Mux.
	echo $BIN_S3 >  /sys/class/gpio/gpio$PIN_S3/value
	echo $BIN_S2 >  /sys/class/gpio/gpio$PIN_S2/value
	echo $BIN_S1 >  /sys/class/gpio/gpio$PIN_S1/value
	echo $BIN_S0 >  /sys/class/gpio/gpio$PIN_S0/value
	echo "Mux. cambiado a salida b'"$1
}
f_out () #pasarle valor (0/1)
{
	echo "Encendiendo pin de salida general..."
	echo $1 >  /sys/class/gpio/gpio$PIN_V/value
	echo "Pin de salida general encendido"
}

###//////***-------------------------------------***\\\\\\###

#Inicio de código a ejecutar
f_dealloc
f_alloc
f_out 1
echo "---Finalizados los preparativos---"
echo "***Inicio del loop infinito de switch led***"
while :
do
	f_mux 0000
	sleep $DELAY
	f_mux 0001
	sleep $DELAY
	f_mux 0010
	sleep $DELAY
done