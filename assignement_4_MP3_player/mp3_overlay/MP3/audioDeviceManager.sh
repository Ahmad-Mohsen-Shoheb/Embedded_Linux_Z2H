#!/bin/sh
#This script is called in the background to check for audio output devices


#Continuously check for new audio devices, with priority Audio jack
while :
do
    sleep 2
	  # amixer:>> Usage: amixer <options> [command]
	  # cset -> set control contents for one control
    amixer cset numid=3 1
    #TODO: if no device is plugged, pause the song
    #TODO: when device is changed, inform user via espeak

done
