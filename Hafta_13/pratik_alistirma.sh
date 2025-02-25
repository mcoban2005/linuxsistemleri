#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
SARI='\033[1;33m'
NORMAL='\033[0m'

# Çalışma dizini oluştur
CALISMA_DIZINI=~/yedekleme_pratik
mkdir -p $CALISMA_DIZINI
cd $CALISMA_DIZINI

echo -e "${MAVI}#############################################${NORMAL}"
echo -e "${YESIL}Linux Sistem Yedekleme ve Kurtarma Alıştırmaları${NORMAL}"
echo -e "${MAVI}#############################################${NORMAL}"
echo

# Yedekleme alıştırması için test dosyaları oluştur
mkdir -p test_verileri
cd test_verileri
echo "Bu bir test dosyasıdır - 1" > dosya1.txt
echo "Bu bir test dosyasıdır - 2" > dosya2.txt
echo "Bu bir test dosyasıdır - 3" > dosya3.txt
cd ..

# 1. Alıştırma: Temel Yedekleme İşlemleri
echo -e "${SARI}1. Alıştırma: Temel Yedekleme İşlemleri${NORMAL}"
cat > yedekleme.sh << 'EOF'
#!/bin/bash

# Yedekleme dizini
YEDEK_DIZIN="./yedekler"
mkdir -p $YEDEK_DIZIN

# Tarih damgası
TARIH=$(date +%Y%m%d_%H%M%S)

# tar ile yedekleme
echo "tar ile yedekleme yapılıyor..."
tar -czf $YEDEK_DIZIN/yedek_$TARIH.tar.gz test_verileri/

# rsync ile yedekleme
echo "rsync ile yedekleme yapılıyor..."
mkdir -p $YEDEK_DIZIN/rsync_yedek_$TARIH
rsync -av test_verileri/ $YEDEK_DIZIN/rsync_yedek_$TARIH/

echo "Yedekleme tamamlandı!"
ls -lh $YEDEK_DIZIN/
EOF
chmod +x yedekleme.sh

# 2. Alıştırma: Artımlı Yedekleme
echo -e "${SARI}2. Alıştırma: Artımlı Yedekleme${NORMAL}"
cat > artimli_yedekleme.sh << 'EOF'
#!/bin/bash

YEDEK_DIZIN="./artimli_yedekler"
mkdir -p $YEDEK_DIZIN
TARIH=$(date +%Y%m%d_%H%M%S)

# Artımlı yedekleme için snapshot dosyası
SNAPSHOT="$YEDEK_DIZIN/snapshot"

echo "Artımlı yedekleme yapılıyor..."
tar --listed-incremental=$SNAPSHOT \
    -czf $YEDEK_DIZIN/artimli_$TARIH.tar.gz \
    test_verileri/

echo "Artımlı yedekleme tamamlandı!"
ls -lh $YEDEK_DIZIN/
EOF
chmod +x artimli_yedekleme.sh

# 3. Alıştırma: Yedekten Geri Yükleme
echo -e "${SARI}3. Alıştırma: Yedekten Geri Yükleme${NORMAL}"
cat > geri_yukleme.sh << 'EOF'
#!/bin/bash

GERI_YUKLEME_DIZIN="./geri_yukleme"
mkdir -p $GERI_YUKLEME_DIZIN

# En son yedeği bul
SON_YEDEK=$(ls -t ./yedekler/yedek_*.tar.gz | head -n1)

if [ -n "$SON_YEDEK" ]; then
    echo "Son yedek geri yükleniyor: $SON_YEDEK"
    cd $GERI_YUKLEME_DIZIN
    tar -xzf ../$SON_YEDEK
    echo "Geri yükleme tamamlandı!"
    ls -lR
else
    echo "Yedek dosyası bulunamadı!"
fi
EOF
chmod +x geri_yukleme.sh

# 4. Alıştırma: Yedek Doğrulama ve Test
echo -e "${SARI}4. Alıştırma: Yedek Doğrulama ve Test${NORMAL}"
cat > yedek_test.sh << 'EOF'
#!/bin/bash

# Yedek dosyalarını kontrol et
check_backup() {
    local yedek_dosya=$1
    echo "Yedek dosyası kontrolü: $yedek_dosya"
    
    # tar dosyası bütünlük kontrolü
    if tar -tzf "$yedek_dosya" > /dev/null 2>&1; then
        echo "✓ Yedek dosyası sağlam"
        
        # İçerik listesi
        echo "İçerik listesi:"
        tar -tvf "$yedek_dosya"
    else
        echo "✗ Yedek dosyası bozuk!"
    fi
}

# Tüm yedekleri kontrol et
for yedek in ./yedekler/yedek_*.tar.gz; do
    if [ -f "$yedek" ]; then
        check_backup "$yedek"
        echo "-------------------"
    fi
done
EOF
chmod +x yedek_test.sh

# 5. Alıştırma: Yedekleme Rotasyonu
echo -e "${SARI}5. Alıştırma: Yedekleme Rotasyonu${NORMAL}"
cat > yedek_rotasyon.sh << 'EOF'
#!/bin/bash

YEDEK_DIZIN="./yedekler"
MAX_YEDEK=5

# Eski yedekleri temizle
cleanup_old_backups() {
    # Yedek sayısını kontrol et
    yedek_sayisi=$(ls -1 $YEDEK_DIZIN/yedek_*.tar.gz 2>/dev/null | wc -l)
    
    # Maksimum sayıyı aşan yedekleri sil
    if [ "$yedek_sayisi" -gt "$MAX_YEDEK" ]; then
        echo "Eski yedekler temizleniyor..."
        ls -t $YEDEK_DIZIN/yedek_*.tar.gz | tail -n +$((MAX_YEDEK+1)) | xargs rm -f
        echo "Temizleme tamamlandı!"
    fi
}

# Mevcut yedekleri listele
echo "Mevcut yedekler:"
ls -lh $YEDEK_DIZIN/yedek_*.tar.gz 2>/dev/null

# Temizleme işlemini çalıştır
cleanup_old_backups

echo "Kalan yedekler:"
ls -lh $YEDEK_DIZIN/yedek_*.tar.gz 2>/dev/null
EOF
chmod +x yedek_rotasyon.sh

# Alıştırma talimatları
echo -e "\n${YESIL}Alıştırma Talimatları:${NORMAL}"
echo -e "1. Temel yedekleme alıştırması için:"
echo -e "   ${MAVI}./yedekleme.sh${NORMAL}"
echo -e "2. Artımlı yedekleme için:"
echo -e "   ${MAVI}./artimli_yedekleme.sh${NORMAL}"
echo -e "3. Yedekten geri yükleme için:"
echo -e "   ${MAVI}./geri_yukleme.sh${NORMAL}"
echo -e "4. Yedek doğrulama için:"
echo -e "   ${MAVI}./yedek_test.sh${NORMAL}"
echo -e "5. Yedek rotasyonu için:"
echo -e "   ${MAVI}./yedek_rotasyon.sh${NORMAL}"

echo -e "\n${KIRMIZI}Önemli Notlar:${NORMAL}"
echo "- Her alıştırmayı sırayla çalıştırın"
echo "- Yedekleme işlemlerini kontrol edin"
echo "- Geri yükleme işlemlerini test edin"
echo "- Yedek dosyalarının bütünlüğünü doğrulayın"
echo "- Rotasyon işleminin düzgün çalıştığından emin olun"

echo -e "\n${MAVI}Temizlik:${NORMAL}"
echo "Alıştırmaları tamamladıktan sonra çalışma dizinini temizlemek için:"
echo -e "${MAVI}rm -rf $CALISMA_DIZINI${NORMAL}" 