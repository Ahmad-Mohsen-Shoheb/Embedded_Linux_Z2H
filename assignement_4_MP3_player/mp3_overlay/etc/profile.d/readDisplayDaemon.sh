
#!/bin/sh

currentState=`cat /tmp/mp3_state`
clear
echo "Welcome to Embedded Linux MP3!"
sleep 1
clear
echo $currentState

while :
do
    if [ `cat /tmp/clear_flag` -eq 1 ] || [ "$currentState" != "`cat /tmp/mp3_state`" ]; then
        currentState=`cat /tmp/mp3_state`
        clear
        echo $currentState
        echo '0' > /tmp/clear_flag
    fi
	# run 'readInputs' script 
    sh /MP3/readInputs.sh  
    sleep 0.6
done
