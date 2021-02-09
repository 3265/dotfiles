DISK_PW=disk
sudo mkdir -p /mnt/disk1
sudo mount -t cifs //10.0.1.1/Disk1 /mnt/disk1 -o sec=ntlm,password=$DISK_PW,vers=1.0,user=mike,gid=1000,uid=1000
# sudo umount /mnt/disk1l
