%include images/core-solidrun-hummingboard.ks
%include features/smack.ks
%include features/extract_logs.ks

# Disabling bootloader for ARM images
bootloader --location=none --disabled
