%include AM62x.ks
%include beagleplay_partitioning_msdos.ks

%post --erroronfail --log /tmp/post-beagleplay.log

%end

%packages
uboot
kernel-modules-extra
kernel-modules
%end