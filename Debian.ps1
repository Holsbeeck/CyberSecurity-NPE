# Aanmaken van variable, herbruiken script (Kali & Debian) + mogelijk maken van path changes

$naam = "NPEDebian"
$vdi = "C:\Users\Jelle\Desktop\debian.vdi" 

# Script om de VM aan te maken, bekijken ostype - cores - mem 

vboxmanage createvm --name "$naam" --ostype Debian_64 --register
vboxmanage modifyvm "$naam" --memory 2048 --cpus 2 --nic1 nat

vboxmanage storagectl "$naam" --name "SATA Controller" --add sata
vboxmanage storageattach "$naam" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$vdi"

vboxmanage storagectl "$naam" --name "IDE Controller" --add ide
vboxmanage storageattach "$naam" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "C:\Program files\Oracle\VirtualBox\VBoxGuestAdditions.iso"

# VM te starten voor Vbox additions 

vboxmanage startvm "$naam"
# Start-Sleep -Seconds 30
# vboxmanage guestcontrol "$naam" run --exe /mnt/VBoxGuestAdditions/VBoxLinuxAdditions.run --username "osboxes" --password "osboxes.org"
# vboxmanage controlvm "$naam" poweroff

# vboxmanage storageattach "$naam" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium emptydrive