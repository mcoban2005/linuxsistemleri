#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
SARI='\033[1;33m'
NORMAL='\033[0m'

# Çalışma dizini oluştur
CALISMA_DIZINI=~/guvenlik_pratik
mkdir -p $CALISMA_DIZINI
cd $CALISMA_DIZINI

echo -e "${MAVI}#############################################${NORMAL}"
echo -e "${YESIL}Linux Güvenlik ve Sıkılaştırma Alıştırmaları${NORMAL}"
echo -e "${MAVI}#############################################${NORMAL}"
echo

# 1. Alıştırma: Sistem Güvenlik Denetimi
echo -e "${SARI}1. Alıştırma: Sistem Güvenlik Denetimi${NORMAL}"
cat > guvenlik_denetim.sh << 'EOF'
#!/bin/bash

echo "=== Sistem Güvenlik Denetimi ==="

# Sistem bilgisi
echo -e "\n[*] Sistem Bilgisi:"
uname -a
lsb_release -a 2>/dev/null

# Açık portlar
echo -e "\n[*] Açık Portlar:"
netstat -tuln

# Çalışan servisler
echo -e "\n[*] Çalışan Servisler:"
systemctl list-units --type=service --state=running

# SUID/SGID dosyaları
echo -e "\n[*] SUID/SGID Dosyaları:"
find / -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null

# Zayıf dosya izinleri
echo -e "\n[*] Zayıf Dosya İzinleri:"
find /etc -type f -perm /o+w 2>/dev/null

# Başarısız giriş denemeleri
echo -e "\n[*] Başarısız Giriş Denemeleri:"
grep "Failed password" /var/log/auth.log 2>/dev/null
EOF
chmod +x guvenlik_denetim.sh

# 2. Alıştırma: Güvenlik Duvarı Yapılandırması
echo -e "${SARI}2. Alıştırma: Güvenlik Duvarı Yapılandırması${NORMAL}"
cat > guvenlik_duvari.sh << 'EOF'
#!/bin/bash

echo "=== Güvenlik Duvarı Yapılandırması ==="

# UFW durumunu kontrol et
echo -e "\n[*] UFW Durumu:"
ufw status verbose

# Temel kuralları uygula
echo -e "\n[*] Temel Kuralları Uygulama:"
ufw reset
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow http
ufw allow https

# Özel kurallar
echo -e "\n[*] Özel Kurallar Ekleme:"
ufw allow from 192.168.1.0/24 to any port 3306
ufw deny 23

# Kuralları listele
echo -e "\n[*] Tüm Kurallar:"
ufw status numbered
EOF
chmod +x guvenlik_duvari.sh

# 3. Alıştırma: Parola Politikası ve Kullanıcı Güvenliği
echo -e "${SARI}3. Alıştırma: Parola Politikası ve Kullanıcı Güvenliği${NORMAL}"
cat > kullanici_guvenlik.sh << 'EOF'
#!/bin/bash

echo "=== Parola Politikası ve Kullanıcı Güvenliği ==="

# Parola politikası kontrolü
echo -e "\n[*] Mevcut Parola Politikası:"
grep "^PASS_" /etc/login.defs

# Kullanıcı hesap durumu
echo -e "\n[*] Kullanıcı Hesap Durumu:"
for user in $(cut -d: -f1 /etc/passwd); do
    echo "Kullanıcı: $user"
    chage -l $user 2>/dev/null
    echo "-------------------"
done

# Sudo yetkisi olan kullanıcılar
echo -e "\n[*] Sudo Yetkisi Olan Kullanıcılar:"
grep -Po '^sudo.+:\K.*$' /etc/group

# Son başarılı girişler
echo -e "\n[*] Son Başarılı Girişler:"
last | head -n 10
EOF
chmod +x kullanici_guvenlik.sh

# 4. Alıştırma: SSL/TLS Sertifika Yönetimi
echo -e "${SARI}4. Alıştırma: SSL/TLS Sertifika Yönetimi${NORMAL}"
cat > sertifika_yonetim.sh << 'EOF'
#!/bin/bash

echo "=== SSL/TLS Sertifika Yönetimi ==="

# Çalışma dizini
CERT_DIR="./sertifikalar"
mkdir -p $CERT_DIR
cd $CERT_DIR

# Öz imzalı sertifika oluştur
echo -e "\n[*] Öz İmzalı Sertifika Oluşturma:"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout private.key -out certificate.crt \
    -subj "/C=TR/ST=Istanbul/L=Istanbul/O=Linux Egitim/CN=localhost"

# Sertifika bilgilerini görüntüle
echo -e "\n[*] Sertifika Bilgileri:"
openssl x509 -in certificate.crt -text -noout | head -n 15

# CSR oluştur
echo -e "\n[*] CSR Oluşturma:"
openssl req -new -newkey rsa:2048 -nodes \
    -keyout server.key -out server.csr \
    -subj "/C=TR/ST=Istanbul/L=Istanbul/O=Linux Egitim/CN=example.com"

# CSR bilgilerini görüntüle
echo -e "\n[*] CSR Bilgileri:"
openssl req -in server.csr -noout -text | head -n 15
EOF
chmod +x sertifika_yonetim.sh

# 5. Alıştırma: Sistem Sıkılaştırma
echo -e "${SARI}5. Alıştırma: Sistem Sıkılaştırma${NORMAL}"
cat > sistem_sikilastirma.sh << 'EOF'
#!/bin/bash

echo "=== Sistem Sıkılaştırma ==="

# SSH güvenlik yapılandırması
echo -e "\n[*] SSH Güvenlik Yapılandırması:"
cat > ssh_guvenlik.conf << 'END'
Protocol 2
PermitRootLogin no
PasswordAuthentication no
X11Forwarding no
MaxAuthTries 3
PermitEmptyPasswords no
ClientAliveInterval 300
ClientAliveCountMax 0
END
echo "SSH yapılandırma örneği oluşturuldu: ssh_guvenlik.conf"

# Kernel parametreleri
echo -e "\n[*] Kernel Sıkılaştırma Parametreleri:"
cat > kernel_sikilastirma.conf << 'END'
# Network güvenliği
net.ipv4.tcp_syncookies = 1
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.all.accept_source_route = 0

# Bellek koruması
kernel.randomize_va_space = 2
vm.mmap_min_addr = 65536

# Core dump devre dışı
fs.suid_dumpable = 0
END
echo "Kernel yapılandırma örneği oluşturuldu: kernel_sikilastirma.conf"

# Dosya sistemi güvenliği
echo -e "\n[*] Dosya Sistemi Güvenlik Önerileri:"
cat > dosya_sistemi_guvenlik.txt << 'END'
1. /tmp dizini için ayrı partition (noexec,nosuid,nodev)
2. /var dizini için ayrı partition
3. /home dizini için ayrı partition (nosuid,nodev)
4. Kritik dosya sistemleri için read-only mount
5. USB depolama kontrolü için udev kuralları
END
echo "Dosya sistemi önerileri oluşturuldu: dosya_sistemi_guvenlik.txt"

# Servis güvenliği
echo -e "\n[*] Servis Güvenlik Tavsiyeleri:"
cat > servis_guvenlik.txt << 'END'
1. Gereksiz servisleri devre dışı bırak:
   systemctl disable telnet.service
   systemctl disable rsh.service
   systemctl disable rlogin.service

2. Sadece gerekli portları aç:
   - SSH (22)
   - HTTP (80)
   - HTTPS (443)

3. Servis izolasyonu için:
   - SELinux/AppArmor kullan
   - Container teknolojilerinden yararlan
   - Chroot kullan
END
echo "Servis güvenlik tavsiyeleri oluşturuldu: servis_guvenlik.txt"
EOF
chmod +x sistem_sikilastirma.sh

# Alıştırma talimatları
echo -e "\n${YESIL}Alıştırma Talimatları:${NORMAL}"
echo -e "1. Sistem güvenlik denetimi için:"
echo -e "   ${MAVI}./guvenlik_denetim.sh${NORMAL}"
echo -e "2. Güvenlik duvarı yapılandırması için:"
echo -e "   ${MAVI}./guvenlik_duvari.sh${NORMAL}"
echo -e "3. Kullanıcı güvenliği kontrolü için:"
echo -e "   ${MAVI}./kullanici_guvenlik.sh${NORMAL}"
echo -e "4. SSL/TLS sertifika yönetimi için:"
echo -e "   ${MAVI}./sertifika_yonetim.sh${NORMAL}"
echo -e "5. Sistem sıkılaştırma için:"
echo -e "   ${MAVI}./sistem_sikilastirma.sh${NORMAL}"

echo -e "\n${KIRMIZI}Önemli Notlar:${NORMAL}"
echo "- Root yetkisi gereken komutları sudo ile çalıştırın"
echo "- Güvenlik duvarı kurallarını dikkatli uygulayın"
echo "- Sistem yapılandırmasını değiştirmeden önce yedek alın"
echo "- Sertifika işlemlerinde private key'leri güvenli saklayın"
echo "- Gerçek sistemlerde test etmeden önce sanal makinede deneyin"

echo -e "\n${MAVI}Temizlik:${NORMAL}"
echo "Alıştırmaları tamamladıktan sonra çalışma dizinini temizlemek için:"
echo -e "${MAVI}rm -rf $CALISMA_DIZINI${NORMAL}" 