
export CROSS_COMPILE="$HOME/sm-arm-eabi-4.9/bin/arm-eabi-"
KERNEL_DIRECTORY="$HOME/franco-mako-cm"

make franco_defconfig
make -j16

cd $HOME/anykernel_mako
cp -r * $KERNEL_DIRECTORY/zip/
cd $KERNEL_DIRECTORY
cp arch/arm/boot/zImage zip/tmp/anykernel

zipfile="franco.Kernel-sm-r209-cm.zip"
echo "making zip file"
 
cd zip/
rm -f *.zip
zip -r $zipfile *
rm -f /tmp/*.zip
cp *.zip /tmp
