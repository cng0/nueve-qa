#!/bin/bash

function live_stream () {
        #Single Video+Audio stream
	ffmpeg -f avfoundation -framerate 30 -i "0:0" -c:v libx264 -preset veryfast -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 50 -ac 2 -ar 44100 -map 0:0 -map 0:1 -f rtp_mpegts $1
}


########################### MAIN ###########################

  	clear

        var=$1

        if [[ $var = "" ]]
        then
           	echo -e "You must have input URL as part of the command. Example: ./live_stream.sh rtp://52.38.157.73:1935"
	else
		live_stream $var
	fi

        echo -e "\n"
