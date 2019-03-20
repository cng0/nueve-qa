#!/bin/bash

fileName="/Users/ttonthat/Documents/NHRA/audiosamp.aac"

function live_stream () {
	#sound from audio file (10 minutes)
        #audio + video will go to video player, song will go to audio only
	if [ $2 = "file" ]
	then

		ffmpeg -f avfoundation -framerate 30 -i "0:0" -i $fileName -c:v libx264 -preset veryfast -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 50 -ac 2 -ar 44100 -map 0:0 -map 0:1 -map 1:0 -f rtp_mpegts $1

	#If you wanted different audio on the audio only channel, you’d need to define another input to ffmpeg - you’ve done this in the past with an aac file.
	#In that case there would be a second input after the -i “0:0” and then the third map command would be -map 1:0 
	#In that instance the 1 is the ffmpeg command input (zero based) and the 0 is the first stream on that input which is 0 because it’s audio only (aac file, no video).

	#sound from microphone
        #audio + video will go to video player, audio will go to audio only
	elif [ $2 = "mic" ]
	then

		ffmpeg -f avfoundation -framerate 30 -i "0:0" -c:v libx264 -preset veryfast -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 50 -ac 2 -ar 44100 -map 0:0 -map 0:1 -map 0:1 -f rtp_mpegts $1

	#map 0:0 grabs the first input (0) and the video stream (0) from that
	#map 0:1 grabs the first input (0) and the audio stream (1) from that
	#each map sets an output.  So map 0:0 is the first output, map 0:1 is the second output and map 0:1 the second time is the third out.
	#By default fro ffmpeg these correspond to PIDs 256 (video), 257 (first audio gets output with the video stream) and 258 (second audio which gets output as the audio only stream).

	fi
}

########################### MAIN ###########################

  	clear

        var1=$1
        var2=$2

        if [[ $var1 = "" || $var2 = "" ]]
        then
           	echo -e "You must have input URL as part of the command. Example: ./live_audio.sh rtp://52.38.157.73:1935 mic OR ./live_audio.sh rtp://52.38.157.73:1935 file"
	else
		live_stream $var1 $var2
	fi

        echo -e "\n"
