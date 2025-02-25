# Hafta 14: Linux Güvenliği ve Sıkılaştırma

## İçerik
1. Temel Güvenlik Kavramları
2. Sistem Sıkılaştırma
3. Güvenlik Duvarı Yapılandırması
4. Güvenlik İzleme ve Denetim
5. Şifreleme ve SSL/TLS

## 1. Temel Güvenlik Kavramları

### Kimlik Doğrulama ve Yetkilendirme
```bash
# Kullanıcı Yönetimi
useradd -m -s /bin/bash kullanici
passwd kullanici
usermod -aG sudo kullanici

# Parola Politikaları
chage -l kullanici
chage -M 90 -m 7 -W 14 kullanici  # 90 gün max, 7 gün min, 14 gün uyarı

# Sudo Yapılandırması
visudo
# %sudo   ALL=(ALL:ALL) ALL
```

### Dosya İzinleri ve Sahiplik
```bash
# Temel İzinler
chmod 750 dosya  # rwxr-x---
chmod u+x dosya  # Kullanıcıya çalıştırma izni
chmod g-w dosya  # Gruptan yazma iznini kaldır

# Özel İzinler
chmod 4755 dosya  # SUID biti
chmod 2755 dosya  # SGID biti
chmod 1755 dosya  # Sticky bit

# ACL Kullanımı
setfacl -m u:kullanici:rx dosya
getfacl dosya
```

## 2. Sistem Sıkılaştırma

### Servis Güvenliği
```bash
# Servis Durumu Kontrolü
systemctl list-units --type=service
systemctl status ssh

# Gereksiz Servisleri Devre Dışı Bırakma
systemctl disable telnet
systemctl mask telnet

# SSH Güvenliği
vim /etc/ssh/sshd_config
# PermitRootLogin no
# PasswordAuthentication no
# Protocol 2
```

### Kernel Sıkılaştırma
```bash
# Kernel Parametreleri
vim /etc/sysctl.conf

# Network Güvenliği
net.ipv4.tcp_syncookies = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.conf.all.accept_redirects = 0

# Bellek Koruması
kernel.randomize_va_space = 2
vm.mmap_min_addr = 65536

# Değişiklikleri Uygula
sysctl -p
```

## 3. Güvenlik Duvarı Yapılandırması

### UFW (Uncomplicated Firewall)
```bash
# UFW Etkinleştirme
ufw enable
ufw status verbose

# Temel Kurallar
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 80/tcp
ufw allow from 192.168.1.0/24

# Kural Yönetimi
ufw status numbered
ufw delete 2
```

### iptables
```bash
# Temel Kurallar
iptables -L
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# SSH İzni
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Kuralları Kaydet
iptables-save > /etc/iptables/rules.v4
```

## 4. Güvenlik İzleme ve Denetim

### Sistem Logları
```bash
# Önemli Log Dosyaları
tail -f /var/log/auth.log
tail -f /var/log/syslog
tail -f /var/log/secure

# Log Analizi
grep "Failed password" /var/log/auth.log
grep "authentication failure" /var/log/auth.log
```

### Audit Sistemi
```bash
# Audit Kurulum ve Yapılandırma
apt install auditd
systemctl enable auditd
systemctl start auditd

# Audit Kuralları
auditctl -w /etc/passwd -p wa -k passwd_changes
auditctl -w /etc/sudoers -p wa -k sudoers_changes

# Log İnceleme
ausearch -k passwd_changes
aureport --summary
```

## 5. Şifreleme ve SSL/TLS

### Dosya Şifreleme
```bash
# GPG Kullanımı
gpg --gen-key
gpg -e -r "kullanici@domain.com" dosya.txt
gpg -d dosya.txt.gpg

# LUKS Disk Şifreleme
cryptsetup luksFormat /dev/sdb1
cryptsetup luksOpen /dev/sdb1 secure_disk
mkfs.ext4 /dev/mapper/secure_disk
```

### SSL/TLS Sertifikaları
```bash
# Öz İmzalı Sertifika
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout private.key -out certificate.crt

# Let's Encrypt
apt install certbot
certbot certonly --standalone -d domain.com
certbot renew --dry-run
```

## Pratik Örnekler

### Örnek 1: Sistem Sıkılaştırma Scripti
```bash
#!/bin/bash

# Güvenlik güncellemelerini yükle
apt update && apt upgrade -y

# SSH güvenliği
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart ssh

# Firewall kuralları
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

# Sistem sıkılaştırma
echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf
sysctl -p
```

### Örnek 2: Güvenlik Denetim Scripti
```bash
#!/bin/bash

# Açık portları kontrol et
echo "Açık Portlar:"
netstat -tuln

# Başarısız giriş denemeleri
echo "Başarısız Giriş Denemeleri:"
grep "Failed password" /var/log/auth.log

# SUID bitleri
echo "SUID Dosyaları:"
find / -type f -perm -4000 2>/dev/null

# Zayıf parolalar
echo "Parola Politikası:"
grep "^PASS_" /etc/login.defs
```

## Alıştırmalar

1. Sistem Sıkılaştırma:
   - SSH servisini güvenli yapılandırın
   - Gereksiz servisleri devre dışı bırakın
   - Kernel parametrelerini sıkılaştırın
   - Parola politikalarını güçlendirin

2. Güvenlik Duvarı:
   - UFW ile temel güvenlik kuralları oluşturun
   - Belirli IP adresleri için özel kurallar ekleyin
   - Servis bazlı filtreleme yapın
   - Kural setini yedekleyin

3. Güvenlik Denetimi:
   - Sistem loglarını analiz edin
   - Audit kuralları oluşturun
   - Güvenlik açıklarını tarayın
   - Denetim raporu hazırlayın

4. Şifreleme:
   - GPG ile dosya şifreleyin
   - SSL sertifikası oluşturun
   - Disk bölümü şifreleyin
   - Güvenli iletişim kanalı kurun

## Önemli İpuçları
- Düzenli güvenlik güncellemelerini yapın
- Güvenlik politikalarını dokümante edin
- Yedekleme ve kurtarma planı oluşturun
- Güvenlik denetimlerini periyodik olarak yapın
- Kullanıcı eğitimini önemseyin

## Kaynaklar
- [Linux Security Guide](https://www.linux.com/training-tutorials/linux-security-guide/)
- [UFW Guide](https://help.ubuntu.com/community/UFW)
- [OpenSSL Documentation](https://www.openssl.org/docs/)
- [Audit System Documentation](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/chap-system_auditing) 