# Hafta 13: Sistem Yedekleme ve Kurtarma

## İçerik
1. Yedekleme Stratejileri
2. Yedekleme Araçları
3. Sistem Kurtarma
4. Felaket Kurtarma Planı

## 1. Yedekleme Stratejileri

### Yedekleme Türleri
```bash
# Tam Yedekleme (Full Backup)
- Tüm verilerin yedeklenmesi
- Avantaj: Kolay geri yükleme
- Dezavantaj: Zaman ve alan kullanımı fazla

# Artımlı Yedekleme (Incremental Backup)
- Son yedekten sonraki değişikliklerin yedeklenmesi
- Avantaj: Hızlı ve az alan kullanımı
- Dezavantaj: Geri yükleme daha karmaşık

# Fark Yedekleme (Differential Backup)
- Son tam yedekten sonraki tüm değişikliklerin yedeklenmesi
- Avantaj: Orta seviye geri yükleme kolaylığı
- Dezavantaj: Orta seviye alan kullanımı
```

### Yedekleme Politikaları
```bash
# Yedekleme Sıklığı
- Günlük: Kritik veriler
- Haftalık: Sistem dosyaları
- Aylık: Tam sistem yedeği

# Yedekleme Rotasyonu
- Son 7 günlük yedekler
- Son 4 haftalık yedekler
- Son 12 aylık yedekler
```

## 2. Yedekleme Araçları

### rsync Kullanımı
```bash
# Temel Kullanım
rsync -av kaynak/ hedef/
rsync -avz kaynak/ kullanici@uzak_sunucu:hedef/

# Özel Seçenekler
rsync -av --delete kaynak/ hedef/    # Silinen dosyaları senkronize et
rsync -av --exclude '*.tmp' kaynak/ hedef/  # Dosya hariç tut
rsync -av --backup --backup-dir=/yedek kaynak/ hedef/  # Yedek dizini
```

### tar ile Yedekleme
```bash
# Yedek Oluşturma
tar -czf yedek.tar.gz kaynak_dizin/
tar -cjf yedek.tar.bz2 kaynak_dizin/

# Yedekten Geri Yükleme
tar -xzf yedek.tar.gz
tar -xjf yedek.tar.bz2

# Özel Seçenekler
tar -czf yedek.tar.gz --exclude='*.tmp' kaynak_dizin/
tar -czf yedek.tar.gz --listed-incremental=snapshot.file kaynak_dizin/
```

### dd ile Disk Yedekleme
```bash
# Disk İmajı Oluşturma
dd if=/dev/sda of=/yedek/disk.img bs=4M
dd if=/dev/sda1 of=/yedek/partition.img bs=4M

# İmajdan Geri Yükleme
dd if=/yedek/disk.img of=/dev/sda bs=4M
dd if=/yedek/partition.img of=/dev/sda1 bs=4M
```

## 3. Sistem Kurtarma

### GRUB Kurtarma
```bash
# GRUB Yeniden Yükleme
sudo grub-install /dev/sda
sudo update-grub

# GRUB Yapılandırması
sudo nano /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

### Acil Durum Konsolu
```bash
# Single User Mode
init 1
systemctl isolate rescue.target

# Emergency Mode
systemctl isolate emergency.target

# chroot Kullanımı
mount /dev/sda1 /mnt
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
chroot /mnt
```

### Dosya Sistemi Onarımı
```bash
# fsck Kullanımı
fsck /dev/sda1
fsck -f /dev/sda1    # Zorla kontrol
fsck -y /dev/sda1    # Otomatik onar

# e2fsck (ext2/3/4)
e2fsck -f /dev/sda1
e2fsck -p /dev/sda1  # Otomatik onar
```

## 4. Felaket Kurtarma Planı

### Hazırlık Aşaması
```bash
# Sistem Envanteri
lshw > donanim_envanter.txt
dpkg -l > yazilim_listesi.txt
crontab -l > zamanlanmis_gorevler.txt

# Yapılandırma Yedekleri
tar -czf /yedek/etc_yedek.tar.gz /etc/
mysqldump --all-databases > veritabani_yedek.sql
```

### Kurtarma Prosedürleri
1. Sistem Durumu Değerlendirmesi
   - Donanım kontrolü
   - Veri kaybı tespiti
   - Servis durumu kontrolü

2. Kurtarma Adımları
   - Sistem önyükleme
   - Dosya sistemi onarımı
   - Yedekten geri yükleme
   - Servis yapılandırması

3. Doğrulama ve Test
   - Sistem bütünlüğü kontrolü
   - Servis testleri
   - Veri doğrulama

## Pratik Örnekler

### Örnek 1: Otomatik Yedekleme Scripti
```bash
#!/bin/bash

# Yedekleme dizini
BACKUP_DIR="/yedek"
DATE=$(date +%Y%m%d)

# Sistem yapılandırması yedeği
tar -czf $BACKUP_DIR/sistem_$DATE.tar.gz /etc/

# Kullanıcı verileri yedeği
rsync -av --delete /home/ $BACKUP_DIR/home_$DATE/

# Veritabanı yedeği
mysqldump --all-databases > $BACKUP_DIR/db_$DATE.sql

# Eski yedekleri temizle
find $BACKUP_DIR -type f -mtime +30 -delete
```

### Örnek 2: Sistem Kurtarma Scripti
```bash
#!/bin/bash

# Disk kontrolü
fsck -f /dev/sda1

# GRUB onarımı
grub-install /dev/sda
update-grub

# Yedekten geri yükleme
tar -xzf /yedek/sistem.tar.gz -C /
rsync -av /yedek/home/ /home/

# Servis kontrolü
systemctl daemon-reload
systemctl restart networking
```

## Alıştırmalar

1. Yedekleme:
   - rsync ile otomatik yedekleme scripti yazın
   - Artımlı yedekleme sistemi kurun
   - Yedekleme rotasyonu uygulayın
   - Uzak sunucuya yedekleme yapın

2. Sistem Kurtarma:
   - GRUB onarımı yapın
   - Bozuk bir dosya sistemini onarın
   - chroot ortamında sistem onarımı yapın
   - Kayıp dosyaları kurtarın

3. Felaket Kurtarma:
   - Felaket kurtarma planı oluşturun
   - Kurtarma prosedürlerini test edin
   - Otomatik kurtarma scripti yazın
   - Kurtarma dokümantasyonu hazırlayın

## Önemli İpuçları
- Düzenli yedekleme yapın ve yedekleri test edin
- Yedekleri farklı lokasyonlarda saklayın
- Kurtarma prosedürlerini önceden test edin
- Sistem yapılandırmasını dokümante edin
- Kritik verilerin yedeklerini şifreleyin

## Kaynaklar
- [rsync Manual](https://rsync.samba.org/documentation.html)
- [GNU tar Manual](https://www.gnu.org/software/tar/manual/)
- [GRUB Documentation](https://www.gnu.org/software/grub/manual/)
- [Linux System Recovery](https://www.linux.com/training-tutorials/how-rescue-non-booting-grub-2-linux/) 