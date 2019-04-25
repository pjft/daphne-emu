#!/bin/sh

SCRIPT_DIR=`dirname "$0"`
if realpath / >/dev/null; then SCRIPT_DIR=$(realpath "$SCRIPT_DIR"); fi
DAPHNE_BIN=daphne.bin
DAPHNE_SHARE=~/.daphne

echo "Daphne Launcher : Script dir is $SCRIPT_DIR"
cd "$SCRIPT_DIR"

# point to our linked libs that user may not have
export LD_LIBRARY_PATH=$SCRIPT_DIR:$DAPHNE_SHARE:$LD_LIBRARY_PATH

if [ -z "$1" ] ; then
    echo "Specify a game to try: "
    echo
    echo "\t$0 [gamename]"


    for game in ace astron badlands bega cliff cobra esh galaxyr gpworld interstellar lair lair2 mach3 rb sdq tq uvt; do
	if ls ~/.daphne/vldp*/$game >/dev/null 2>&1; then
	    installed="$installed $game"
	else
	    uninstalled="$uninstalled $game"
	fi
    done
    if [ "$uninstalled" ]; then
	echo
	echo "Games not found in ~/.daphne/vldp*: "
	echo "$uninstalled" | fold -s -w60 | sed 's/^ //; s/^/\t/'
    fi
    if [ -z "$installed" ]; then
	cat <<EOF 

Error: No games installed. DVDs can be purchased from DigitalLeisure.com.
       Please put the required files in ~/.daphne/vldp_dl/gamename/
EOF
    else   
	echo
	echo "Games available: "
	echo "$installed" | fold -s -w60 | sed 's/^ //; s/^/\t/'
    fi
    exit 1
fi

case "$1" in
    lair|lair2|ace|tq)
	VLDP_DIR="vldp_dl"
	FASTBOOT="-fastboot"		   
	;;
    *) VLDP_DIR="vldp"
esac

#strace -o strace.txt \
./$DAPHNE_BIN $1 vldp \
$FASTBOOT \
-fullscreen \
-framefile $DAPHNE_SHARE/$VLDP_DIR/$1/$1.txt \
-homedir $DAPHNE_SHARE \
-datadir $DAPHNE_SHARE \
-blank_searches \
-min_seek_delay 1000 \
-seek_frames_per_ms 20 \
-sound_buffer 2048 \
-noserversend \
-x 640 \
-y 480

#-x 1920 \
#-y 1080

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

