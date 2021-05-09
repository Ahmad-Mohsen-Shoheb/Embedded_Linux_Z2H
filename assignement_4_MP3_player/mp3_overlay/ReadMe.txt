/etc/init.d scripts explained
--------------------------------
S40PulseAccessService :>>
This service adds root to pulse-access if not already added
Changing Pulseaudio access.


S50pulseaudio :>>
Starts pulseaudio.


S55MP3Service :>>
runs -> /MP3/mainDaemon.sh


S60AudioDeviceService :>>
assigns DAEMON -> /MP3/audioDeviceManager.sh


S60MountsService :>>
assigns DAEMON ->  "/MP3/audioDeviceManager.sh"
######################################################
######################################################
/MP3 scripts explained
--------------------------------
mainDaemon.sh :>> 
contains: - GPIO config (buttons initialization)
	  - sound card loading
	  - Initializing song list
	  - Main execution loop () -> /MP3/mp3Start.sh
