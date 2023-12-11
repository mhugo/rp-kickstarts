# Partitioning X86 images
zerombr
clearpart --all --initlabel --disklabel=gpt

part /boot/efi  --fstype FAT32 --size 200    --asprimary --label=EFI

%post --erroronfail --log /tmp/post-efi.log
echo "fix boot/loaders options config"
source /etc/default/grub
sed -i "s/^options.*$/& $GRUB_CMDLINE_LINUX/" /boot/loader/entries/*.conf
echo "regenerate grub config"
grub2-mkconfig -o $(find /boot/efi/EFI/ -name grub.cfg)
%end
