#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
SARI='\033[1;33m'
NORMAL='\033[0m'

# Rapor dizini ve tarihi
RAPOR_DIZIN="./guvenlik_raporlari"
TARIH=$(date +%Y%m%d_%H%M%S)
mkdir -p $RAPOR_DIZIN

echo -e "${MAVI}#############################################${NORMAL}"
echo -e "${YESIL}Linux Güvenlik Denetim Raporu${NORMAL}"
echo -e "${MAVI}#############################################${NORMAL}"
echo

# Ana rapor dosyası
RAPOR_DOSYA="$RAPOR_DIZIN/guvenlik_raporu_$TARIH.txt"

# Başlık bilgisi
cat > $RAPOR_DOSYA << EOF
===========================================
Linux Güvenlik Denetim Raporu
Tarih: $(date)
Sistem: $(uname -a)
===========================================

EOF

# 1. Sistem Bilgileri
echo -e "${SARI}1. Sistem Bilgileri Toplanıyor...${NORMAL}"
cat >> $RAPOR_DOSYA << EOF
1. SİSTEM BİLGİLERİ
-------------------
Hostname: $(hostname)
Kernel: $(uname -r)
İşletim Sistemi: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)
CPU: $(grep "model name" /proc/cpuinfo | head -n1 | cut -d':' -f2)
Bellek: $(free -h | grep Mem | awk '{print $2}')
Disk Kullanımı:
$(df -h /)

EOF

# 2. Güvenlik Denetimi
echo -e "${SARI}2. Güvenlik Denetimi Yapılıyor...${NORMAL}"
cat >> $RAPOR_DOSYA << EOF
2. GÜVENLİK DENETİMİ
--------------------
2.1 Açık Portlar:
$(netstat -tuln | grep LISTEN)

2.2 Çalışan Servisler:
$(systemctl list-units --type=service --state=running | head -n 10)

2.3 Son Başarısız Giriş Denemeleri:
$(grep "Failed password" /var/log/auth.log 2>/dev/null | tail -n 5)

2.4 SUID/SGID Dosyaları:
$(find / -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null | head -n 10)

EOF

# 3. Kullanıcı Güvenliği
echo -e "${SARI}3. Kullanıcı Güvenliği Kontrol Ediliyor...${NORMAL}"
cat >> $RAPOR_DOSYA << EOF
3. KULLANICI GÜVENLİĞİ
----------------------
3.1 Sudo Yetkisi Olan Kullanıcılar:
$(grep -Po '^sudo.+:\K.*$' /etc/group)

3.2 Son Başarılı Girişler:
$(last | head -n 5)

3.3 Parola Politikası:
$(grep "^PASS_" /etc/login.defs)

EOF

# 4. Sistem Güvenlik Yapılandırması
echo -e "${SARI}4. Sistem Güvenlik Yapılandırması Kontrol Ediliyor...${NORMAL}"
cat >> $RAPOR_DOSYA << EOF
4. SİSTEM GÜVENLİK YAPILANDIRMASI
--------------------------------
4.1 SSH Yapılandırması:
$(grep -v "^#" /etc/ssh/sshd_config | grep -v "^$")

4.2 Firewall Durumu:
$(ufw status verbose 2>/dev/null || echo "UFW not installed")

4.3 Önemli Dosya İzinleri:
/etc/passwd: $(ls -l /etc/passwd)
/etc/shadow: $(ls -l /etc/shadow)
/etc/sudoers: $(ls -l /etc/sudoers)

EOF

# 5. Güvenlik Tavsiyeleri
echo -e "${SARI}5. Güvenlik Tavsiyeleri Oluşturuluyor...${NORMAL}"
cat >> $RAPOR_DOSYA << EOF
5. GÜVENLİK TAVSİYELERİ
-----------------------
5.1 Sistem Sıkılaştırma Önerileri:
- Gereksiz servisleri devre dışı bırakın
- SSH root girişini kapatın
- Güvenlik duvarı kurallarını güncelleyin
- Düzenli güvenlik güncellemelerini yapın
- Güçlü parola politikası uygulayın

5.2 Düzenli Kontrol Edilmesi Gerekenler:
- Sistem logları
- Kullanıcı aktiviteleri
- Disk kullanımı
- Açık portlar
- Başarısız giriş denemeleri

5.3 Güvenlik En İyi Uygulamaları:
- İki faktörlü kimlik doğrulama kullanın
- Kritik verileri yedekleyin
- Güvenlik denetimlerini otomatikleştirin
- Güvenlik olaylarını izleyin ve raporlayın
- Kullanıcı eğitimlerini düzenli yapın

EOF

# 6. Özet ve Öneriler
echo -e "${SARI}6. Özet ve Öneriler Ekleniyor...${NORMAL}"
cat >> $RAPOR_DOSYA << EOF
6. ÖZET VE ÖNERİLER
-------------------
Denetim Tarihi: $(date)
Rapor Oluşturan: $USER

Kritik Bulgular:
1. Açık port sayısı: $(netstat -tuln | grep LISTEN | wc -l)
2. Sudo yetkili kullanıcı sayısı: $(grep -Po '^sudo.+:\K.*$' /etc/group | tr ',' '\n' | wc -l)
3. Son 24 saatteki başarısız giriş sayısı: $(grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l)

Önerilen Aksiyonlar:
1. Gereksiz servislerin kapatılması
2. Güvenlik duvarı kurallarının gözden geçirilmesi
3. Kullanıcı yetkilerinin kontrol edilmesi
4. Sistem güncellemelerinin yapılması
5. Güvenlik politikalarının güncellenmesi

EOF

echo -e "${YESIL}Rapor oluşturuldu: $RAPOR_DOSYA${NORMAL}"

# HTML raporu oluştur
RAPOR_HTML="$RAPOR_DIZIN/guvenlik_raporu_$TARIH.html"
echo -e "${SARI}HTML raporu oluşturuluyor...${NORMAL}"

cat > $RAPOR_HTML << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Linux Güvenlik Denetim Raporu</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        h1 { color: #2c3e50; }
        h2 { color: #34495e; margin-top: 30px; }
        .section { margin: 20px 0; padding: 10px; background-color: #f9f9f9; }
        .warning { color: #c0392b; }
        .success { color: #27ae60; }
        pre { background-color: #f1f1f1; padding: 10px; }
    </style>
</head>
<body>
    <h1>Linux Güvenlik Denetim Raporu</h1>
    <p>Tarih: $(date)</p>
    <div class="section">
        $(cat $RAPOR_DOSYA | sed 's/$/<br>/')
    </div>
</body>
</html>
EOF

echo -e "${YESIL}HTML rapor oluşturuldu: $RAPOR_HTML${NORMAL}"

# Rapor özeti
echo -e "\n${MAVI}Rapor Özeti:${NORMAL}"
echo "1. Detaylı rapor: $RAPOR_DOSYA"
echo "2. HTML rapor: $RAPOR_HTML"
echo -e "\n${KIRMIZI}Önemli:${NORMAL} Raporları güvenli bir yerde saklayın ve düzenli olarak yedekleyin." 