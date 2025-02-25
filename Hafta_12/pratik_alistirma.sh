#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
NORMAL='\033[0m'

echo -e "${MAVI}Sistem İzleme ve Performans Analizi Alıştırmaları${NORMAL}"
echo "------------------------------------------------"

# Çalışma dizini oluşturma
CALISMA_DIZINI=~/sistem_izleme_pratik
echo -e "${YESIL}1. Çalışma dizini oluşturuluyor...${NORMAL}"
mkdir -p $CALISMA_DIZINI
cd $CALISMA_DIZINI

# Sistem İzleme Örnekleri
echo -e "\n${YESIL}2. Sistem İzleme Örnekleri${NORMAL}"

# Sistem izleme script'i
cat > sistem_izleme.sh << 'EOF'
#!/bin/bash
echo "Sistem Kaynak Kullanımı"
echo "----------------------"

echo -e "\nCPU Kullanımı:"
top -bn1 | grep "Cpu(s)" | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | awk '{print 100 - $1"%"}'

echo -e "\nBellek Kullanımı:"
free -h | grep "Mem:" | awk '{print "Toplam: " $2 "\nKullanılan: " $3 "\nBoş: " $4}'

echo -e "\nDisk Kullanımı:"
df -h / | tail -1 | awk '{print "Kullanılan: " $5 "\nBoş: " $4}'

echo -e "\nYük Ortalaması:"
uptime | awk -F'load average:' '{print $2}'
EOF
chmod +x sistem_izleme.sh

# Log analiz script'i
cat > log_analiz.sh << 'EOF'
#!/bin/bash
echo "Log Analizi"
echo "----------"

echo -e "\nSon sistem olayları:"
tail -5 /var/log/syslog 2>/dev/null || echo "Syslog erişilemedi"

echo -e "\nSon başarısız giriş denemeleri:"
grep "Failed password" /var/log/auth.log 2>/dev/null | tail -3 || echo "Auth.log erişilemedi"

echo -e "\nYüksek CPU kullanan işlemler:"
ps aux | sort -rn -k 3 | head -5

echo -e "\nAçık portlar:"
netstat -tuln | grep LISTEN
EOF
chmod +x log_analiz.sh

# Performans test script'i
cat > performans_test.sh << 'EOF'
#!/bin/bash
echo "Performans Testi"
echo "---------------"

echo -e "\nCPU Testi:"
echo "5 saniye boyunca CPU kullanımı ölçülüyor..."
mpstat 1 5 2>/dev/null || echo "mpstat kurulu değil (sysstat paketi gerekli)"

echo -e "\nBellek Testi:"
echo "5 saniye boyunca bellek kullanımı ölçülüyor..."
vmstat 1 5

echo -e "\nDisk I/O Testi:"
echo "Disk okuma/yazma hızı ölçülüyor..."
dd if=/dev/zero of=test.file bs=1M count=100 2>&1 || echo "Disk testi başarısız"
rm -f test.file
EOF
chmod +x performans_test.sh

# Sistem optimizasyon önerileri script'i
cat > optimizasyon_kontrol.sh << 'EOF'
#!/bin/bash
echo "Sistem Optimizasyon Kontrolü"
echo "--------------------------"

echo -e "\nYüksek CPU kullanan servisler:"
ps aux | awk '$3 > 1.0 {print $0}'

echo -e "\nBellek kullanımı yüksek işlemler:"
ps aux | sort -rn -k 4 | head -5

echo -e "\nDisk alanı uyarıları (>80%):"
df -h | awk '$5 > "80%" {print $0}'

echo -e "\nAktif servisler:"
systemctl list-units --type=service --state=running | head -5
EOF
chmod +x optimizasyon_kontrol.sh

# Alıştırmalar
echo -e "\n${YESIL}3. Alıştırmalar${NORMAL}"

echo "1. Sistem İzleme Alıştırmaları:"
echo "   - ./sistem_izleme.sh ile sistem durumunu kontrol edin"
echo "   - top ve htop komutlarını kullanarak işlemleri izleyin"
echo "   - Disk kullanımını du ve df komutları ile analiz edin"

echo -e "\n2. Log Analizi Alıştırmaları:"
echo "   - ./log_analiz.sh ile sistem loglarını inceleyin"
echo "   - Özel bir log dosyası oluşturun ve analiz edin"
echo "   - Belirli bir hatayı grep ile arayın"

echo -e "\n3. Performans Testi Alıştırmaları:"
echo "   - ./performans_test.sh ile sistem performansını ölçün"
echo "   - Farklı yük senaryoları oluşturun ve test edin"
echo "   - Sonuçları karşılaştırın ve analiz edin"

echo -e "\n4. Optimizasyon Alıştırmaları:"
echo "   - ./optimizasyon_kontrol.sh ile sistem durumunu analiz edin"
echo "   - Gereksiz servisleri tespit edin"
echo "   - Performans iyileştirme önerileri hazırlayın"

# Temizlik
echo -e "\n${KIRMIZI}Temizlik İşlemleri:${NORMAL}"
echo "# Çalışma dizinini temizlemek için:"
echo "rm -rf $CALISMA_DIZINI"

# Önemli notlar
echo -e "\n${MAVI}Önemli Notlar:${NORMAL}"
echo "1. Sistem izleme araçlarını kullanırken sistem performansını etkilememeye dikkat edin"
echo "2. Log dosyalarını incelerken gizlilik ve güvenlik politikalarına uyun"
echo "3. Performans testlerini test ortamında yapın"
echo "4. Optimizasyon önerilerini uygulamadan önce yedek alın"
echo "5. Kritik servisleri izlerken sistem güvenliğini göz önünde bulundurun"

echo -e "\n${MAVI}Alıştırma tamamlandı!${NORMAL}" 