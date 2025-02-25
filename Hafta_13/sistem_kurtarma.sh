#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
SARI='\033[1;33m'
NORMAL='\033[0m'

# Çalışma dizini oluştur
CALISMA_DIZINI=~/kurtarma_pratik
mkdir -p $CALISMA_DIZINI
cd $CALISMA_DIZINI

echo -e "${MAVI}#############################################${NORMAL}"
echo -e "${YESIL}Linux Sistem Kurtarma Senaryoları${NORMAL}"
echo -e "${MAVI}#############################################${NORMAL}"
echo

# 1. Senaryo: Bozuk Dosya Sistemi Simülasyonu
echo -e "${SARI}1. Senaryo: Bozuk Dosya Sistemi Simülasyonu${NORMAL}"
cat > dosya_sistemi_onarim.sh << 'EOF'
#!/bin/bash

# Test dizini ve dosyaları oluştur
TEST_DIZIN="./test_disk"
mkdir -p $TEST_DIZIN
dd if=/dev/zero of=$TEST_DIZIN/disk.img bs=1M count=100

# Dosya sistemi oluştur
echo "Dosya sistemi oluşturuluyor..."
mkfs.ext4 $TEST_DIZIN/disk.img

# Mount işlemi
mkdir -p $TEST_DIZIN/mount_point
echo "Dosya sistemi mount ediliyor..."
sudo mount -o loop $TEST_DIZIN/disk.img $TEST_DIZIN/mount_point

# Test dosyaları oluştur
echo "Test dosyaları oluşturuluyor..."
cd $TEST_DIZIN/mount_point
echo "Test verisi 1" > dosya1.txt
echo "Test verisi 2" > dosya2.txt
cd -

# Unmount
sudo umount $TEST_DIZIN/mount_point

# Dosya sistemi kontrolü
echo "Dosya sistemi kontrolü yapılıyor..."
e2fsck -f $TEST_DIZIN/disk.img

echo "Senaryo tamamlandı!"
EOF
chmod +x dosya_sistemi_onarim.sh

# 2. Senaryo: GRUB Kurtarma Simülasyonu
echo -e "${SARI}2. Senaryo: GRUB Kurtarma Simülasyonu${NORMAL}"
cat > grub_kurtarma.sh << 'EOF'
#!/bin/bash

# GRUB yapılandırma dosyası oluştur
mkdir -p ./grub_test/boot/grub
cat > ./grub_test/boot/grub/grub.cfg << 'END'
menuentry "Linux" {
    linux   /boot/vmlinuz-linux root=/dev/sda1
    initrd  /boot/initramfs-linux.img
}
END

# GRUB kurtarma komutları
echo "GRUB kurtarma adımları:"
echo "1. Live CD/USB ile boot et"
echo "2. Root partition'ı mount et:"
echo "   sudo mount /dev/sda1 /mnt"
echo "3. Gerekli dizinleri bind et:"
echo "   sudo mount --bind /dev /mnt/dev"
echo "   sudo mount --bind /proc /mnt/proc"
echo "   sudo mount --bind /sys /mnt/sys"
echo "4. chroot ortamına gir:"
echo "   sudo chroot /mnt"
echo "5. GRUB'ı yeniden yükle:"
echo "   grub-install /dev/sda"
echo "   grub-mkconfig -o /boot/grub/grub.cfg"

# GRUB yapılandırma örneği göster
echo -e "\nÖrnek GRUB yapılandırması:"
cat ./grub_test/boot/grub/grub.cfg
EOF
chmod +x grub_kurtarma.sh

# 3. Senaryo: Kayıp Dosya Kurtarma
echo -e "${SARI}3. Senaryo: Kayıp Dosya Kurtarma${NORMAL}"
cat > kayip_dosya_kurtarma.sh << 'EOF'
#!/bin/bash

# Test dizini oluştur
KURTARMA_DIZIN="./kurtarma_test"
mkdir -p $KURTARMA_DIZIN

# Örnek dosyalar oluştur
echo "Önemli veri 1" > $KURTARMA_DIZIN/onemli1.txt
echo "Önemli veri 2" > $KURTARMA_DIZIN/onemli2.txt
echo "Önemli veri 3" > $KURTARMA_DIZIN/onemli3.txt

# Dosya silme simülasyonu
rm $KURTARMA_DIZIN/onemli2.txt

echo "Kayıp dosya kurtarma adımları:"
echo "1. Dosya sistemini read-only mount et:"
echo "   sudo mount -o ro /dev/sda1 /mnt"
echo "2. TestDisk ile tarama yap:"
echo "   sudo testdisk /dev/sda"
echo "3. PhotoRec ile kurtarma yap:"
echo "   sudo photorec /dev/sda"

# Örnek kurtarma komutu
echo -e "\nÖrnek kurtarma komutu (ext4):"
echo "sudo extundelete /dev/sda1 --restore-file path/to/file"
EOF
chmod +x kayip_dosya_kurtarma.sh

# 4. Senaryo: Sistem Log Analizi
echo -e "${SARI}4. Senaryo: Sistem Log Analizi${NORMAL}"
cat > log_analiz.sh << 'EOF'
#!/bin/bash

# Örnek log dosyaları oluştur
mkdir -p ./log_test/var/log
cat > ./log_test/var/log/syslog << 'END'
May 1 10:00:01 server kernel: [    0.000000] Linux version 5.4.0
May 1 10:00:02 server systemd[1]: Starting System...
May 1 10:00:03 server kernel: [    0.045876] CPU0: Intel(R) Core(TM) i7
May 1 10:01:01 server kernel: [  150.302394] EXT4-fs error (device sda1)
END

cat > ./log_test/var/log/auth.log << 'END'
May 1 10:05:01 server sshd[1234]: Failed password for root from 192.168.1.100
May 1 10:05:05 server sshd[1234]: Accepted password for user1 from 192.168.1.101
May 1 10:06:01 server sudo: user1 : TTY=pts/0 ; PWD=/home/user1 ; USER=root
END

# Log analiz fonksiyonları
echo "Log analiz komutları:"
echo "1. Sistem hatalarını bul:"
echo "   grep -i error ./log_test/var/log/syslog"
echo "2. Başarısız giriş denemelerini bul:"
echo "   grep 'Failed password' ./log_test/var/log/auth.log"
echo "3. Sudo kullanımını izle:"
echo "   grep 'sudo' ./log_test/var/log/auth.log"

# Örnek analiz
echo -e "\nÖrnek log analizi:"
grep -i error ./log_test/var/log/syslog
EOF
chmod +x log_analiz.sh

# 5. Senaryo: Acil Durum Shell
echo -e "${SARI}5. Senaryo: Acil Durum Shell${NORMAL}"
cat > acil_durum.sh << 'EOF'
#!/bin/bash

echo "Acil Durum Shell Kullanımı:"
echo "1. Single User Mode'a geç:"
echo "   systemctl isolate rescue.target"
echo "2. Emergency Mode'a geç:"
echo "   systemctl isolate emergency.target"

echo -e "\nÖnemli acil durum komutları:"
echo "1. Disk kontrolü:"
echo "   fsck -f /dev/sda1"
echo "2. Root parolası sıfırlama:"
echo "   passwd root"
echo "3. Servis yönetimi:"
echo "   systemctl list-units --type=service"
echo "4. Network yapılandırması:"
echo "   ip addr show"
echo "   ip link set eth0 up"

echo -e "\nAcil durum kaynakları:"
echo "- /proc/cmdline"
echo "- /etc/fstab"
echo "- /var/log/messages"
echo "- /var/log/syslog"
EOF
chmod +x acil_durum.sh

# Alıştırma talimatları
echo -e "\n${YESIL}Senaryo Talimatları:${NORMAL}"
echo -e "1. Dosya sistemi onarımı için:"
echo -e "   ${MAVI}./dosya_sistemi_onarim.sh${NORMAL}"
echo -e "2. GRUB kurtarma senaryosu için:"
echo -e "   ${MAVI}./grub_kurtarma.sh${NORMAL}"
echo -e "3. Kayıp dosya kurtarma için:"
echo -e "   ${MAVI}./kayip_dosya_kurtarma.sh${NORMAL}"
echo -e "4. Log analizi için:"
echo -e "   ${MAVI}./log_analiz.sh${NORMAL}"
echo -e "5. Acil durum shell için:"
echo -e "   ${MAVI}./acil_durum.sh${NORMAL}"

echo -e "\n${KIRMIZI}Önemli Notlar:${NORMAL}"
echo "- Her senaryoyu dikkatle inceleyin"
echo "- Komutları anlamadan çalıştırmayın"
echo "- Sistem üzerinde test ederken dikkatli olun"
echo "- Gerçek sistemlerde önce yedek alın"
echo "- Root yetkisi gereken komutları not edin"

echo -e "\n${MAVI}Temizlik:${NORMAL}"
echo "Senaryoları tamamladıktan sonra çalışma dizinini temizlemek için:"
echo -e "${MAVI}rm -rf $CALISMA_DIZINI${NORMAL}" 