#!/bin/bash

########## Modo DEBUG ##########
##			      ##
        flux_DEBUG=0
##			      ##
################################

################################
# Name : Flux
# Version : 0.01
# ##############################


clear
##################################### < CONFIGURATION vom SCRIPT > #####################################
#DUMP_PATH 
DUMP_PATH="/tmp/TMPlflux"
#Anzahl der "DEAUTHTIME"
DEAUTHTIME="8"
#Anzahl der "revision"
revision=35
# Numero de version
version=0.101
# IP DHCP
IP=192.168.1.1
RANG_IP=$(echo $IP | cut -d "." -f 1,2,3)

#Farben 
#Colores
Weis="\033[1;37m"
Grau="\033[0;37m"
Magenta="\033[0;35m"
Rot="\033[1;31m"
Gruen="\033[1;32m"
Gelb="\033[1;33m"
Blau="\033[1;34m"
Transparent="\e[0m"


# Debug / Entwickler MODUS
if [ $LINSET_DEBUG = 1 ]; then
	export linset_output_device=/dev/stdout
	HOLD="-hold"
else
	export linset_output_device=/dev/null
	HOLD=""
fi


function conditional_clear() {
	
	if [[ "$linset_output_device" != "/dev/stdout" ]]; then clear; fi
}

# Check Updates [NOT WORKING]
function checkupdatess {
	
	revision_online="$(timeout -s SIGTERM 20 curl -L "https://sites.google.com/site/flux" 2>/dev/null| grep "^revision" | cut -d "=" -f2)"
	if [ -z "$revision_online" ]; then
		echo "?">$DUMP_PATH/Irev
	else
		echo "$revision_online">$DUMP_PATH/Irev
	fi
	
}
function exitmode {
	
	echo -e "\n\n"$Weis["$Rot" "$Weiß"] "$rot"Ejecutando la limpieza y cerrando."$Transparent"
	
	if ps -A | grep -q aireplay-ng; then
		echo -e ""$Weis"["$Rot"-"$Weis"] "$Weis "Matando "$Grau "aireplay-ng"$Transparent
		killall aireplay-ng &>$linset_output_device
	fi
	