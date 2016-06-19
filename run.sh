#!/bin/sh

SCRIPT_DIR=`dirname "$0"`
DAPHNE_BIN=daphne.bin


echo "Daphne Launcher : Script dir is $SCRIPT_DIR"
cd "$SCRIPT_DIR"

# point to our linked libs that user may not have
LD_LIBRARY_PATH=$PWD:$LD_LIBRARY_PATH

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
./$DAPHNE_BIN $1 vldp \
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

EXIT_CODE=$?

if [ "$EXIT_CODE" -ne "0" ] ; then
	if [ "$EXIT_CODE" -eq "127" ]; then
		echo ""
		echo "Daphne failed to start."
		echo "This is probably due to a library problem."
		echo "Run ./daphne.bin directly to see which libraries are missing."
		echo ""
	else
		echo "DaphneLoader failed with an unknown exit code : $EXIT_CODE."
	fi
fi

