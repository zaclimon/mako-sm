
RAMDISK="boot.img-ramdisk"

if [[ ! "$1" =~ "f2fs" ]] ; then
echo $RAMDISK
fi
 
if [[ "$1" =~ "f2fs" ]] ; then
RAMDISK="boot.img-ramdisk-f2fs"
echo $RAMDISK
fi
 
make -j16
 
cp arch/arm/boot/zImage ../ramdisk_mako/
 
cd ../ramdisk_mako/
 
echo "making ramdisk"
./mkbootfs $RAMDISK | gzip > ramdisk.gz
echo "making boot image"
./mkbootimg --kernel zImage --cmdline 'console=ttyHSL0,115200,n8 androidboot.hardware=mako lpj=67677 user_debug=31' --base 0x80200000 --pagesize 2048 --ramdisk_offset 0x01600000 --ramdisk ramdisk.gz --output ../mako/boot.img
 
rm -rf ramdisk.gz
rm -rf zImage
 
cd ../mako/
 
zipfile="franco.Kernel-nightly.zip"
echo "making zip file"
cp boot.img zip/
 
rm -rf ../ramdisk_mako/boot.img
 
cd zip/
rm -f *.zip
zip -r $zipfile *
rm -f /tmp/*.zip
cp *.zip /tmp
