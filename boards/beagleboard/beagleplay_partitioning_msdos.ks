# Partitioning

# Beagleplay requires a MBR labeled /boot partition that the following code does

zerombr
clearpart --all --disklabel=msdos

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
    parted "${BLK_ID_SD}" set "${BLK_ID_SD_ID}" lba on
    parted "${BLK_ID_SD}" type "${BLK_ID_SD_ID}" "0x0c" # to have W95 FAT32 (LBA) format
else
    echo "Can't Add Flags to ${BLK_ID}..."
    exit 1
fi

%end
