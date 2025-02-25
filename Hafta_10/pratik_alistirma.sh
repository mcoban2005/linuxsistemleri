#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
NORMAL='\033[0m'

echo -e "${MAVI}Ağ Yönetimi ve Güvenlik Alıştırmaları${NORMAL}"
echo "----------------------------------------"

# Çalışma dizini oluşturma
CALISMA_DIZINI=~/ag_guvenlik_pratik
echo -e "${YESIL}1. Çalışma dizini oluşturuluyor...${NORMAL}"
mkdir -p $CALISMA_DIZINI
cd $CALISMA_DIZINI

# Örnek 1: Ağ İzleme Scripti
echo -e "\n${YESIL}2. Ağ İzleme Scripti${NORMAL}"
cat > ag_izleme.sh << 'EOF'
#!/bin/bash

# Ağ durumu kontrolü fonksiyonu
ag_durumu() {
    echo "=== Ağ Arayüzleri ==="
    ip addr show

    echo -e "\n=== Yönlendirme Tablosu ==="
    ip route show

    echo -e "\n=== DNS Sunucuları ==="
    cat /etc/resolv.conf

    echo -e "\n=== Açık Portlar ==="
    netstat -tuln

    echo -e "\n=== Aktif Bağlantılar ==="
    netstat -tn | grep ESTABLISHED
}

# Bağlantı testi fonksiyonu
baglanti_testi() {
    local hedef=$1
    echo "=== Bağlantı Testi: $hedef ==="
    ping -c 4 $hedef
    
    echo -e "\n=== Yol İzleme: $hedef ==="
    traceroute $hedef
}

# Ana menü
while true; do
    echo -e "\nAğ İzleme Menüsü:"
    echo "1. Ağ Durumu Göster"
    echo "2. Bağlantı Testi Yap"
    echo "3. DNS Sorgusu Yap"
    echo "4. Çıkış"
    
    read -p "Seçiminiz (1-4): " secim
    
    case $secim in
        1) ag_durumu ;;
        2)
            read -p "Hedef adres: " hedef
            baglanti_testi $hedef
            ;;
        3)
            read -p "Sorgulanacak domain: " domain
            nslookup $domain
            ;;
        4) break ;;
        *) echo "Geçersiz seçim!" ;;
    esac
    
    read -p "Devam etmek için ENTER'a basın..."
done
EOF

chmod +x ag_izleme.sh
echo "ag_izleme.sh oluşturuldu ve çalıştırma izni verildi."

# Örnek 2: Güvenlik Duvarı Yönetimi
echo -e "\n${YESIL}3. Güvenlik Duvarı Yönetimi Scripti${NORMAL}"
cat > guvenlik_duvari.sh << 'EOF'
#!/bin/bash

# UFW durumu kontrolü
ufw_durumu() {
    echo "=== UFW Durumu ==="
    sudo ufw status verbose
}

# Temel güvenlik kuralları
temel_kurallar() {
    echo "Temel güvenlik kuralları uygulanıyor..."
    
    # Varsayılan politikalar
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    
    # SSH erişimi
    sudo ufw allow ssh
    
    # HTTP ve HTTPS
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
    
    # UFW'yi etkinleştir
    sudo ufw enable
}

# Kural yönetimi
kural_ekle() {
    local port=$1
    local aksiyon=$2
    
    if [[ $aksiyon == "allow" ]]; then
        sudo ufw allow $port
    elif [[ $aksiyon == "deny" ]]; then
        sudo ufw deny $port
    fi
}

# Ana menü
while true; do
    echo -e "\nGüvenlik Duvarı Yönetimi:"
    echo "1. UFW Durumunu Göster"
    echo "2. Temel Kuralları Uygula"
    echo "3. Port İzni Ver"
    echo "4. Port Engelle"
    echo "5. Çıkış"
    
    read -p "Seçiminiz (1-5): " secim
    
    case $secim in
        1) ufw_durumu ;;
        2) temel_kurallar ;;
        3)
            read -p "İzin verilecek port: " port
            kural_ekle $port "allow"
            ;;
        4)
            read -p "Engellenecek port: " port
            kural_ekle $port "deny"
            ;;
        5) break ;;
        *) echo "Geçersiz seçim!" ;;
    esac
    
    read -p "Devam etmek için ENTER'a basın..."
done
EOF

chmod +x guvenlik_duvari.sh
echo "guvenlik_duvari.sh oluşturuldu ve çalıştırma izni verildi."

# Örnek 3: Güvenlik İzleme
echo -e "\n${YESIL}4. Güvenlik İzleme Scripti${NORMAL}"
cat > guvenlik_izleme.sh << 'EOF'
#!/bin/bash

# Log analizi
log_analizi() {
    echo "=== Son Başarısız Giriş Denemeleri ==="
    sudo grep "Failed password" /var/log/auth.log | tail -n 10
    
    echo -e "\n=== Şüpheli IP'ler ==="
    sudo grep "Invalid user" /var/log/auth.log | \
        awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | head -5
}

# Fail2ban durumu
fail2ban_durumu() {
    echo "=== Fail2ban Durumu ==="
    sudo fail2ban-client status
    
    echo -e "\n=== SSH Jail Durumu ==="
    sudo fail2ban-client status sshd
}

# Port tarama
port_tarama() {
    local hedef=$1
    echo "=== Port Tarama: $hedef ==="
    nmap -sT -p- $hedef
}

# Ana menü
while true; do
    echo -e "\nGüvenlik İzleme Menüsü:"
    echo "1. Log Analizi"
    echo "2. Fail2ban Durumu"
    echo "3. Port Tarama"
    echo "4. Rootkit Tarama"
    echo "5. Çıkış"
    
    read -p "Seçiminiz (1-5): " secim
    
    case $secim in
        1) log_analizi ;;
        2) fail2ban_durumu ;;
        3)
            read -p "Hedef IP/hostname: " hedef
            port_tarama $hedef
            ;;
        4)
            echo "Rootkit taraması başlatılıyor..."
            sudo rkhunter --check
            ;;
        5) break ;;
        *) echo "Geçersiz seçim!" ;;
    esac
    
    read -p "Devam etmek için ENTER'a basın..."
done
EOF

chmod +x guvenlik_izleme.sh
echo "guvenlik_izleme.sh oluşturuldu ve çalıştırma izni verildi."

# Alıştırmalar
echo -e "\n${YESIL}5. Alıştırmalar${NORMAL}"
echo "1. Ağ İzleme:"
echo "   - ag_izleme.sh'i çalıştırın ve ağ durumunu inceleyin"
echo "   - Farklı hedeflere bağlantı testi yapın"
echo "   - DNS sorgularını test edin"
echo "   - Yeni izleme özellikleri ekleyin"

echo -e "\n2. Güvenlik Duvarı:"
echo "   - guvenlik_duvari.sh ile temel kuralları uygulayın"
echo "   - Özel portlar için kurallar ekleyin"
echo "   - IP bazlı erişim kuralları ekleyin"
echo "   - Kural listesini yedekleyin"

echo -e "\n3. Güvenlik İzleme:"
echo "   - guvenlik_izleme.sh ile log analizini inceleyin"
echo "   - Fail2ban durumunu kontrol edin"
echo "   - Port taraması yapın"
echo "   - Rootkit taraması yapın"

echo -e "\n4. Özel Görevler:"
echo "   - Otomatik güvenlik raporu oluşturun"
echo "   - Şüpheli aktiviteleri e-posta ile bildirin"
echo "   - Periyodik güvenlik taraması ayarlayın"
echo "   - Özel güvenlik politikaları oluşturun"

# Temizlik
echo -e "\n${KIRMIZI}Temizlik İşlemleri:${NORMAL}"
echo "# Çalışma dizinini temizlemek için:"
echo "rm -rf $CALISMA_DIZINI"

# Önemli notlar
echo -e "\n${MAVI}Önemli Notlar:${NORMAL}"
echo "1. Scriptleri root yetkisiyle çalıştırmanız gerekebilir"
echo "2. Güvenlik duvarı kurallarını dikkatli uygulayın"
echo "3. SSH erişimini engellememeye dikkat edin"
echo "4. Sistem loglarını düzenli kontrol edin"
echo "5. Test ortamında deneyin"

echo -e "\n${MAVI}Alıştırma tamamlandı!${NORMAL}" 