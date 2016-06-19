#!/bin/sh

if [ -z $1 ] ; then
	echo "Specify a game to try: ace astron badlands bega cliff cobra esh"
	echo "\tgalaxyr gpworld interstellar lair lair2 mach3 rb sdq tq uvt"
	exit
fi

case "$1" in
	"lair") VLDP_DIR="vldp_dl"
	;;
	"lair2") VLDP_DIR="vldp_dl"
	;;
	"ace") VLDP_DIR="vldp_dl"
	;;
	"tq") VLDP_DIR="vldp_dl"
	;;
	*) VLDP_DIR="vldp"
esac

#strace -o strace.txt \
./daphne $1 vldp \
-framefile ~/.daphne/$VLDP_DIR/$1/$1.txt \
-homedir ~/.daphne \
-datadir ~/.daphne \
-blank_searches \
-min_seek_delay 1000 \
-seek_frames_per_ms 20 \
-sound_buffer 2048 \
-x 640 \
-y 480

#-bank 0 11111001 \
#-bank 1 00100111 \
