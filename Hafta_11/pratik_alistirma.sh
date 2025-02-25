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

# Ağ Yapılandırması Örnekleri
echo -e "\n${YESIL}2. Ağ Yapılandırması Örnekleri${NORMAL}"

echo "a) IP yapılandırması komutları:"
echo "ip addr show"
echo "ip route show"
echo "sudo ip addr add 192.168.1.100/24 dev eth0"
echo "sudo ip route add default via 192.168.1.1"

echo -e "\nb) Network Manager komutları:"
echo "nmcli device status"
echo "nmcli connection show"
echo "nmcli device wifi list"

# Ağ İzleme Örnekleri
echo -e "\n${YESIL}3. Ağ İzleme Örnekleri${NORMAL}"

# Ping test script'i
cat > ping_test.sh << 'EOF'
#!/bin/bash
echo "Ping Testi"
echo "---------"
for host in google.com 8.8.8.8 localhost; do
    echo -n "Testing $host: "
    ping -c 1 -W 2 $host > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Başarılı"
    else
        echo "Başarısız"
    fi
done
EOF
chmod +x ping_test.sh

# Port tarama script'i
cat > port_scan.sh << 'EOF'
#!/bin/bash
echo "Açık Port Taraması"
echo "----------------"
netstat -tuln | grep LISTEN
EOF
chmod +x port_scan.sh

# Güvenlik Duvarı Örnekleri
echo -e "\n${YESIL}4. Güvenlik Duvarı Örnekleri${NORMAL}"

# UFW yapılandırma script'i
cat > ufw_config.sh << 'EOF'
#!/bin/bash
echo "UFW Yapılandırması"
echo "-----------------"
echo "# UFW'yi etkinleştirme:"
echo "sudo ufw enable"

echo -e "\n# Temel kurallar:"
echo "sudo ufw allow 22/tcp    # SSH"
echo "sudo ufw allow 80/tcp    # HTTP"
echo "sudo ufw allow 443/tcp   # HTTPS"

echo -e "\n# Belirli IP için kural:"
echo "sudo ufw allow from 192.168.1.0/24 to any port 3306"

echo -e "\n# Kuralları listeleme:"
echo "sudo ufw status verbose"
EOF
chmod +x ufw_config.sh

# Sistem Güvenliği Örnekleri
echo -e "\n${YESIL}5. Sistem Güvenliği Örnekleri${NORMAL}"

# SSH güvenlik yapılandırması
cat > ssh_security.sh << 'EOF'
#!/bin/bash
echo "SSH Güvenlik Yapılandırması"
echo "-------------------------"
echo "# /etc/ssh/sshd_config dosyasında yapılacak değişiklikler:"
echo "PermitRootLogin no"
echo "PasswordAuthentication no"
echo "AllowUsers kullanici1 kullanici2"
echo "Port 2222"

echo -e "\n# Servisi yeniden başlatma:"
echo "sudo systemctl restart sshd"
EOF
chmod +x ssh_security.sh

# Güvenlik kontrol script'i
cat > security_check.sh << 'EOF'
#!/bin/bash
echo "Güvenlik Kontrolü"
echo "----------------"

echo -e "\nAçık Portlar:"
netstat -tuln | grep LISTEN

echo -e "\nAktif Servisler:"
systemctl list-units --type=service --state=running | head -n 5

echo -e "\nBaşarısız Giriş Denemeleri:"
echo "sudo grep 'Failed password' /var/log/auth.log | tail -5"

echo -e "\nGüvenlik Güncellemeleri:"
echo "sudo apt list --upgradable"
EOF
chmod +x security_check.sh

# Alıştırmalar
echo -e "\n${YESIL}6. Alıştırmalar${NORMAL}"

echo "1. Ağ Yapılandırması Alıştırmaları:"
echo "   - ./ping_test.sh ile ağ bağlantısını test edin"
echo "   - ./port_scan.sh ile açık portları kontrol edin"
echo "   - IP yapılandırmasını inceleyin"

echo -e "\n2. Güvenlik Duvarı Alıştırmaları:"
echo "   - ./ufw_config.sh dosyasını inceleyin"
echo "   - UFW kuralları oluşturun ve test edin"
echo "   - Özel servisler için kurallar ekleyin"

echo -e "\n3. Sistem Güvenliği Alıştırmaları:"
echo "   - ./ssh_security.sh ile SSH yapılandırmasını inceleyin"
echo "   - ./security_check.sh ile güvenlik kontrolü yapın"
echo "   - Sistem loglarını analiz edin"

# Temizlik
echo -e "\n${KIRMIZI}Temizlik İşlemleri:${NORMAL}"
echo "# Çalışma dizinini temizlemek için:"
echo "rm -rf $CALISMA_DIZINI"

# Önemli notlar
echo -e "\n${MAVI}Önemli Notlar:${NORMAL}"
echo "1. Ağ yapılandırmasını değiştirmeden önce mevcut yapılandırmayı yedekleyin"
echo "2. Güvenlik duvarı kurallarını test ortamında deneyin"
echo "3. SSH erişimini kapatmadan önce alternatif erişim yönteminiz olduğundan emin olun"
echo "4. Sistem güncellemelerini düzenli olarak kontrol edin"
echo "5. Güvenlik loglarını düzenli olarak inceleyin"

echo -e "\n${MAVI}Alıştırma tamamlandı!${NORMAL}" 