Custom startup script with additional params
============================================

This folder contains an additional `run.sh` which adds the ability
to configure individual games with more customization.

This includes utilising the `-keymapfile` argument to swap `up` 
and `down` keys in flight based games _(included_ `flight.ini`_)_

    cp flight.ini ~/.daphne/
    cp run.sh ..

### Refer to individual ROM dip switch (BANK) settings at:

http://www.dragons-lair-project.com/tech/

    -bank <which bank> <base2 value> Used to modify dip switch settings. The 'which bank' argument specifies which dip
     switch bank to modify, where 0 is the first bank. The 'base2 value' argument is in 8-bit binary form that is 
     composed of 1's and 0's, where the right-most bit corresponds to the first dip switch. For example, if you wanted
     to enable dip switch 0 in bank 0, but disable switches 1-7, then you'd do "-bank 0 00000001".

Extra arguments can be found here: http://www.daphne-emu.com/mediawiki/index.php/CmdLine

### Customise `run.sh` for your own needs

    cobraab)
       VLDP_DIR="vldp"
       DAPINPUT="-keymapfile flight.ini"
       BANKS="-cheat"
    ;;

    ...

    dle21)
       VLDP_DIR="vldp_dl"

       if [ "$PROTOTYPE" ]; then
            BANKS="-bank 1 10110011 -bank 0 11011000"
       else
            BANKS="-bank 1 00110011 -bank 0 11011000"
       fi
    ;;

    ...

    lair)
       VLDP_DIR="vldp_dl"
       FASTBOOT="-fastboot"
       BANKS="-bank 1 00110011 -bank 0 10011000"
    ;;


Example run command using script:

    ./daphne.bin astron vldp -keymapfile flight.ini -framefile /home/user/.daphne/vldp/astron/astron.txt -homedir /home/user/.daphne -datadir /home/user/.daphne -sound_buffer 2048 -noserversend -nojoystick -volume_nonvldp 5 -volume_vldp 20 -x 800 -y 600

### Launcher GUI

A simplified GTK `DapnheLoader` clone frontend: https://github.com/DirtBagXon/ldfrontend

![daphneloader](https://github.com/DirtBagXon/ldfrontend/blob/master/screenshots/daphneloader.png)
