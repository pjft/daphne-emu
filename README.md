# daphne-emu
https://www.daphne-emu.com:9443/daphnesvn/branches/v_1_0 

To build:

```
cd src/vldp2
./configure --disable-accel-detect
make -f Makefile.linux_x64
cd ../game/singe
make -f Makefile.linux_x64
cd ../..
ln -s Makefile.vars.linux_x64 Makefile.vars
make
```
