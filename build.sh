cd src/vldp2
./configure --disable-accel-detect
make -f Makefile.linux_x64
cd ../game/singe
make -f Makefile.linux_x64
cd ../..
ln -s Makefile.vars.linux_x64 Makefile.vars
make
cd ..
