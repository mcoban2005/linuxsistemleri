#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
NORMAL='\033[0m'

echo -e "${MAVI}İleri Seviye Kabuk Programlama Alıştırmaları${NORMAL}"
echo "------------------------------------------------"

# Çalışma dizini oluşturma
CALISMA_DIZINI=~/ileri_bash_pratik
echo -e "${YESIL}1. Çalışma dizini oluşturuluyor...${NORMAL}"
mkdir -p $CALISMA_DIZINI
cd $CALISMA_DIZINI

# Örnek 1: Fonksiyon Kütüphanesi
echo -e "\n${YESIL}2. Fonksiyon Kütüphanesi Örneği${NORMAL}"
cat > utils.sh << 'EOF'
#!/bin/bash
# Yardımcı fonksiyonlar kütüphanesi

# Log fonksiyonu
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Hata kontrolü
kontrol_et() {
    if [ $? -ne 0 ]; then
        log "Hata: $1"
        return 1
    fi
    return 0
}

# Matematik işlemleri
topla() {
    echo $(($1 + $2))
}

cikar() {
    echo $(($1 - $2))
}

carp() {
    echo $(($1 * $2))
}

bol() {
    if [ $2 -eq 0 ]; then
        echo "Hata: Sıfıra bölme hatası" >&2
        return 1
    fi
    echo $(($1 / $2))
}

# Dosya işlemleri
dosya_kontrol() {
    if [ -f "$1" ]; then
        echo "$1 bir dosyadır"
        return 0
    else
        echo "$1 bir dosya değildir" >&2
        return 1
    fi
}

dizin_olustur() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        kontrol_et "Dizin oluşturulamadı: $1"
    fi
}
EOF

chmod +x utils.sh
echo "utils.sh oluşturuldu ve çalıştırma izni verildi."

# Örnek 2: Argüman İşleme
echo -e "\n${YESIL}3. Argüman İşleme Örneği${NORMAL}"
cat > arguman_isle.sh << 'EOF'
#!/bin/bash

# Varsayılan değerler
VERBOSE=0
OUTPUT="output.txt"
INPUT=""

# Kullanım bilgisi
kullanim() {
    echo "Kullanım: $0 [-v] [-o dosya] -i dosya"
    echo "  -v         Ayrıntılı çıktı"
    echo "  -o dosya   Çıktı dosyası (varsayılan: output.txt)"
    echo "  -i dosya   Girdi dosyası (zorunlu)"
    echo "  -h         Bu yardım mesajını göster"
}

# Argümanları işle
while getopts "vo:i:h" opt; do
    case $opt in
        v) VERBOSE=1 ;;
        o) OUTPUT="$OPTARG" ;;
        i) INPUT="$OPTARG" ;;
        h)
            kullanim
            exit 0
            ;;
        ?)
            kullanim
            exit 1
            ;;
    esac
done

# Zorunlu argüman kontrolü
if [ -z "$INPUT" ]; then
    echo "Hata: Girdi dosyası belirtilmedi (-i)" >&2
    kullanim
    exit 1
fi

# İşlem
[ $VERBOSE -eq 1 ] && echo "Girdi dosyası: $INPUT"
[ $VERBOSE -eq 1 ] && echo "Çıktı dosyası: $OUTPUT"

# Dosya işleme
if [ -f "$INPUT" ]; then
    cat "$INPUT" > "$OUTPUT"
    echo "Dosya kopyalandı: $INPUT -> $OUTPUT"
else
    echo "Hata: Girdi dosyası bulunamadı: $INPUT" >&2
    exit 1
fi
EOF

chmod +x arguman_isle.sh
echo "arguman_isle.sh oluşturuldu ve çalıştırma izni verildi."

# Örnek 3: Girdi/Çıktı İşlemleri
echo -e "\n${YESIL}4. Girdi/Çıktı İşlemleri Örneği${NORMAL}"
cat > dosya_isle.sh << 'EOF'
#!/bin/bash

# Örnek veri dosyası oluştur
cat << 'END' > veriler.txt
Ahmet,25,İstanbul
Mehmet,30,Ankara
Ayşe,28,İzmir
Fatma,35,Bursa
END

# Dosyayı işle ve rapor oluştur
{
    echo "Kişi Raporu"
    echo "------------"
    echo
    
    while IFS=, read -r isim yas sehir; do
        echo "İsim: $isim"
        echo "Yaş: $yas"
        echo "Şehir: $sehir"
        echo "------------"
    done < veriler.txt
} > rapor.txt

echo "Rapor oluşturuldu: rapor.txt"

# Yaş ortalaması hesapla
toplam=0
sayac=0
while IFS=, read -r _ yas _; do
    let toplam+=yas
    let sayac++
done < veriler.txt

echo "Yaş ortalaması: $((toplam / sayac))"
EOF

chmod +x dosya_isle.sh
echo "dosya_isle.sh oluşturuldu ve çalıştırma izni verildi."

# Örnek 4: Hata Yönetimi
echo -e "\n${YESIL}5. Hata Yönetimi Örneği${NORMAL}"
cat > hata_yonetimi.sh << 'EOF'
#!/bin/bash

# Hata log dosyası
HATA_LOG="hatalar.log"

# Hata mesajı fonksiyonu
hata() {
    local mesaj="[$(date '+%Y-%m-%d %H:%M:%S')] HATA: $1"
    echo "$mesaj" >&2
    echo "$mesaj" >> "$HATA_LOG"
}

# Temizlik fonksiyonu
temizlik() {
    echo "Temizlik yapılıyor..."
    rm -f gecici_dosya.txt
}

# Çıkış sinyallerini yakala
trap temizlik EXIT

# Tehlikeli işlemler
{
    # Var olmayan bir dosyayı okumaya çalış
    cat olmayan_dosya.txt > gecici_dosya.txt
} || {
    hata "Dosya okunamadı"
}

# Sıfıra bölme denemesi
sayi=5
for bolen in 2 1 0; do
    if [ $bolen -eq 0 ]; then
        hata "Sıfıra bölme hatası"
        continue
    fi
    echo "$sayi / $bolen = $((sayi / bolen))"
done

# Dizin oluşturma denemesi
if ! mkdir -p "test_dizin"; then
    hata "Dizin oluşturulamadı"
fi
EOF

chmod +x hata_yonetimi.sh
echo "hata_yonetimi.sh oluşturuldu ve çalıştırma izni verildi."

# Alıştırmalar
echo -e "\n${YESIL}6. Alıştırmalar${NORMAL}"
echo "1. Fonksiyon Kütüphanesi (utils.sh):"
echo "   - Yeni matematik fonksiyonları ekleyin (üs alma, kök alma vb.)"
echo "   - Dizi işleme fonksiyonları ekleyin"
echo "   - Tarih/saat işleme fonksiyonları ekleyin"

echo -e "\n2. Argüman İşleme (arguman_isle.sh):"
echo "   - Yeni parametreler ekleyin"
echo "   - Parametre doğrulama kontrolleri ekleyin"
echo "   - Farklı işlem modları ekleyin"

echo -e "\n3. Dosya İşleme (dosya_isle.sh):"
echo "   - CSV dosyası sıralama özelliği ekleyin"
echo "   - Filtreleme özellikleri ekleyin"
echo "   - İstatistik hesaplama özellikleri ekleyin"

echo -e "\n4. Hata Yönetimi (hata_yonetimi.sh):"
echo "   - Farklı hata türleri için özel işleyiciler ekleyin"
echo "   - Hata seviyelerini ekleyin (UYARI, HATA, KRİTİK)"
echo "   - Hata raporlama özelliği ekleyin"

# Temizlik
echo -e "\n${KIRMIZI}Temizlik İşlemleri:${NORMAL}"
echo "# Çalışma dizinini temizlemek için:"
echo "rm -rf $CALISMA_DIZINI"

# Önemli notlar
echo -e "\n${MAVI}Önemli Notlar:${NORMAL}"
echo "1. Her scripti test etmeden önce içeriğini inceleyin"
echo "2. Hata ayıklama için 'bash -x script.sh' kullanın"
echo "3. Değişiklikleri yapmadan önce yedek alın"
echo "4. Tehlikeli komutları test ederken dikkatli olun"
echo "5. Yeni özellikler eklerken hata kontrolü yapmayı unutmayın"

echo -e "\n${MAVI}Alıştırma tamamlandı!${NORMAL}" 