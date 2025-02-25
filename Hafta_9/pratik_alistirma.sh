#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
NORMAL='\033[0m'

echo -e "${MAVI}Sistem Yönetimi ve İzleme Alıştırmaları${NORMAL}"
echo "----------------------------------------"

# Çalışma dizini oluşturma
CALISMA_DIZINI=~/sistem_izleme_pratik
echo -e "${YESIL}1. Çalışma dizini oluşturuluyor...${NORMAL}"
mkdir -p $CALISMA_DIZINI
cd $CALISMA_DIZINI

# Örnek 1: Sistem İzleme Scripti
echo -e "\n${YESIL}2. Sistem İzleme Scripti${NORMAL}"
cat > sistem_izleme.sh << 'EOF'
#!/bin/bash

# Sistem bilgilerini toplama fonksiyonu
sistem_bilgileri() {
    echo "=== Sistem Bilgileri ==="
    echo "Tarih: $(date)"
    echo "Uptime: $(uptime)"
    echo "Kernel: $(uname -r)"
    
    echo -e "\n=== CPU Bilgileri ==="
    echo "CPU Kullanımı:"
    top -bn1 | head -n 3
    
    echo -e "\n=== Bellek Kullanımı ==="
    free -h
    
    echo -e "\n=== Disk Kullanımı ==="
    df -h
    
    echo -e "\n=== En Çok Kaynak Kullanan Süreçler ==="
    ps aux --sort=-%cpu | head -6
}

# Rapor oluştur
sistem_bilgileri > sistem_raporu_$(date +%Y%m%d_%H%M%S).txt
echo "Sistem raporu oluşturuldu."
EOF

chmod +x sistem_izleme.sh
echo "sistem_izleme.sh oluşturuldu ve çalıştırma izni verildi."

# Örnek 2: Süreç İzleme Scripti
echo -e "\n${YESIL}3. Süreç İzleme Scripti${NORMAL}"
cat > surec_izleme.sh << 'EOF'
#!/bin/bash

# Süreç izleme fonksiyonları
cpu_yogun_surecler() {
    echo "=== CPU Yoğun Süreçler ==="
    ps aux --sort=-%cpu | head -6
}

ram_yogun_surecler() {
    echo "=== RAM Yoğun Süreçler ==="
    ps aux --sort=-%mem | head -6
}

zombie_surecler() {
    echo "=== Zombie Süreçler ==="
    ps aux | awk '$8=="Z"'
}

# Ana menü
while true; do
    echo -e "\nSüreç İzleme Menüsü:"
    echo "1. CPU Yoğun Süreçler"
    echo "2. RAM Yoğun Süreçler"
    echo "3. Zombie Süreçler"
    echo "4. Çıkış"
    
    read -p "Seçiminiz (1-4): " secim
    
    case $secim in
        1) cpu_yogun_surecler ;;
        2) ram_yogun_surecler ;;
        3) zombie_surecler ;;
        4) break ;;
        *) echo "Geçersiz seçim!" ;;
    esac
    
    read -p "Devam etmek için ENTER'a basın..."
done
EOF

chmod +x surec_izleme.sh
echo "surec_izleme.sh oluşturuldu ve çalıştırma izni verildi."

# Örnek 3: Servis İzleme Scripti
echo -e "\n${YESIL}4. Servis İzleme Scripti${NORMAL}"
cat > servis_izleme.sh << 'EOF'
#!/bin/bash

# İzlenecek servisler
SERVISLER=(
    "ssh"
    "cron"
    "ufw"
)

# Servis durumu kontrolü
servis_kontrol() {
    local servis=$1
    echo "=== $servis Servisi ==="
    if systemctl is-active --quiet $servis; then
        echo "Durum: Çalışıyor"
        systemctl status $servis | grep Active
    else
        echo "Durum: Çalışmıyor"
    fi
    echo "-------------------"
}

# Tüm servisleri kontrol et
echo "Servis Durumları:"
for servis in "${SERVISLER[@]}"; do
    servis_kontrol $servis
done

# Servis istatistikleri
echo -e "\nServis İstatistikleri:"
systemctl list-units --type=service --state=running | head -n 5
EOF

chmod +x servis_izleme.sh
echo "servis_izleme.sh oluşturuldu ve çalıştırma izni verildi."

# Örnek 4: Log Analiz Scripti
echo -e "\n${YESIL}5. Log Analiz Scripti${NORMAL}"
cat > log_analiz.sh << 'EOF'
#!/bin/bash

# Log dosyaları
AUTH_LOG="/var/log/auth.log"
SYSLOG="/var/log/syslog"

# Log analiz fonksiyonları
basarisiz_girisler() {
    echo "=== Son Başarısız Giriş Denemeleri ==="
    grep "Failed password" $AUTH_LOG | tail -n 5
}

sistem_hatalari() {
    echo "=== Son Sistem Hataları ==="
    grep -i "error" $SYSLOG | tail -n 5
}

guvenlik_olaylari() {
    echo "=== Güvenlik Olayları ==="
    grep -i "security" $SYSLOG | tail -n 5
}

# Rapor oluştur
echo "Log Analiz Raporu ($(date))" > log_raporu.txt
echo "================================" >> log_raporu.txt
basarisiz_girisler >> log_raporu.txt
echo >> log_raporu.txt
sistem_hatalari >> log_raporu.txt
echo >> log_raporu.txt
guvenlik_olaylari >> log_raporu.txt

echo "Log analiz raporu oluşturuldu: log_raporu.txt"
EOF

chmod +x log_analiz.sh
echo "log_analiz.sh oluşturuldu ve çalıştırma izni verildi."

# Alıştırmalar
echo -e "\n${YESIL}6. Alıştırmalar${NORMAL}"
echo "1. Sistem İzleme:"
echo "   - sistem_izleme.sh'i çalıştırın ve raporu inceleyin"
echo "   - Yeni metrikler ekleyin (ağ kullanımı, disk I/O vb.)"
echo "   - Belirli eşik değerlerini aşan durumları raporlayın"

echo -e "\n2. Süreç Yönetimi:"
echo "   - surec_izleme.sh'i çalıştırın ve süreçleri inceleyin"
echo "   - Belirli bir sürecin kaynak kullanımını izleyin"
echo "   - Otomatik süreç temizleme özelliği ekleyin"

echo -e "\n3. Servis Yönetimi:"
echo "   - servis_izleme.sh'e yeni servisler ekleyin"
echo "   - Servis başlatma/durdurma özellikleri ekleyin"
echo "   - Servis loglarını analiz eden fonksiyonlar ekleyin"

echo -e "\n4. Log Analizi:"
echo "   - log_analiz.sh'i çalıştırın ve raporu inceleyin"
echo "   - Yeni log dosyaları ekleyin"
echo "   - İstatistiksel analiz özellikleri ekleyin"

# Temizlik
echo -e "\n${KIRMIZI}Temizlik İşlemleri:${NORMAL}"
echo "# Çalışma dizinini temizlemek için:"
echo "rm -rf $CALISMA_DIZINI"

# Önemli notlar
echo -e "\n${MAVI}Önemli Notlar:${NORMAL}"
echo "1. Scriptleri root yetkisiyle çalıştırmanız gerekebilir"
echo "2. Log dosyalarına erişim için sudo kullanın"
echo "3. Sistem kaynaklarını izlerken performans etkisine dikkat edin"
echo "4. Kritik servisleri durdurmadan önce dikkatli olun"
echo "5. Test ortamında deneyin"

echo -e "\n${MAVI}Alıştırma tamamlandı!${NORMAL}" 