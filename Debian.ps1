$naam1 = "NPEDebian"
$naam2 = "NPEKali"
$router = "Debain Router"

# De hostonlyadapter met onze debian router 
# vboxmanage list hostonlyifs 
$adapt = "VirtualBox Host-Only Ethernet Adapter #3"

# Path aanpassen naar locatie van de VDI files, 1 voor Debian en 2 voor Kali!
$vdi1 = "C:\Users\Jelle\Desktop\debian.vdi" 
$vdi2 = "C:\Users\Jelle\Desktop\kali.vdi"

# UUID aanpassen om conflict te voorkomen met al bestaande HDD 
# VBoxManage internalcommands sethduuid "vdi2"

# Gedeelte voor Debian(machine 1) 2 cores om kernel panic te vermijden met 2GB aan RAM. 
vboxmanage createvm --name "$naam1" --ostype Debian_64 --register
vboxmanage modifyvm "$naam1" --memory 2048 --cpus 2 --nic1 hostonly --hostonlyadapter1 "$adapt"
vboxmanage storagectl "$naam1" --name "SATA Controller" --add sata
vboxmanage storageattach "$naam1" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$vdi1"

# Gedeelte voor Kali(machine 2) 4 cores 4GB aan RAM.
vboxmanage createvm --name "$naam2" --ostype Debian_64 --register
vboxmanage modifyvm "$naam2" --memory 4096 --cpus 4 --nic1 hostonly --hostonlyadapter1 "$adapt"
vboxmanage storagectl "$naam2" --name "SATA Controller" --add sata
vboxmanage storageattach "$naam2" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$vdi2"

# Machines opstarten (debian router optie kan weggelaten worden)
vboxmanage startvm "$naam1"
vboxmanage startvm "$naam2"
vboxmanage startvm "$router"