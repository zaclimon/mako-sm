#!/bin/bash
export CROSS_COMPILE="$HOME/sm-arm-eabi-4.9/bin/arm-eabi-"
KERNEL_DIRECTORY="$HOME/mako-sm"
ANYKERNEL_DIRECTORY="$HOME/anykernel_msm"
JOBS=`grep -c "processor" /proc/cpuinfo`

if [[ "$1" =~ "cm" || "$1" =~ "CM" ]] ; then
git checkout sm-4.4-sm
zipfile="franco.Kernel-SaberMod-r210-CM.zip"
else
git checkout sm-4.4
zipfile="franco.Kernel-SaberMod-r210.zip"
fi


cd $ANYKERNEL_DIRECTORY
git checkout mako

cd $KERNEL_DIRECTORY

if [ -e zip/*.zip ] ; then
rm -rf zip/*
fi

make franco_defconfig
make -j$JOBS

cd $ANYKERNEL_DIRECTORY
cp -r * $KERNEL_DIRECTORY/zip/
cd $KERNEL_DIRECTORY
cp arch/arm/boot/zImage zip/tmp/anykernel

echo "making zip file"
 
cd zip/
zip -r $zipfile *
