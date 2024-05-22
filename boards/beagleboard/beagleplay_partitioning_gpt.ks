# Partitioning

# It seems the following partitioning code doesn't work because the Beagleboard's Beagleplay
# firmware only supports MBR bootable partition...

zerombr
clearpart --all --disklabel=gpt

part /boot --fstype vfat --size 200 --asprimary --label=boot --mkfsoptions="-F 32"

%post --nochroot --logfile=/mnt/sysroot/tmp/post-arm-boot.log --erroronfail

BLK_ID=$(blkid -L boot) # /dev/sda1
BLK_ID_SD=$(echo "${BLK_ID}" | sed -e 's/\([0-9]\+\)//g') # /dev/sda
BLK_ID_SD_ID=$(echo "${BLK_ID}" | tr -dc '0-9') # 1

echo "BLK_ID ${BLK_ID}"
echo "BLK_ID_SD ${BLK_ID_SD}"
echo "BLK_ID_SD_ID ${BLK_ID_SD_ID}"

echo "Setting Flags into "\"${BLK_ID}\"\(\[${BLK_ID_SD}\]\[${BLK_ID_SD_ID}\]\)"... \(boot,lba\)"
if [ -n "${BLK_ID_SD}" ] && [ -n "${BLK_ID_SD_ID}" ]; then
    parted "${BLK_ID_SD}" set "${BLK_ID_SD_ID}" boot on
else
    echo "Can't Add Flags to ${BLK_ID}..."
    exit 1
fi

%end
