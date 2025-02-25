#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
NORMAL='\033[0m'

echo -e "${MAVI}Kabuk Programlama Alıştırmaları${NORMAL}"
echo "--------------------------------"

# Çalışma dizini oluşturma
CALISMA_DIZINI=~/bash_pratik
echo -e "${YESIL}1. Çalışma dizini oluşturuluyor...${NORMAL}"
mkdir -p $CALISMA_DIZINI
cd $CALISMA_DIZINI

# Örnek 1: Temel Script
echo -e "\n${YESIL}2. Temel Script Örneği${NORMAL}"
cat > ornek1.sh << 'EOF'
#!/bin/bash
# Bu bir örnek script

# Değişkenler
AD="Dünya"
TARIH=$(date)

# Ekrana yazdırma
echo "Merhaba $AD!"
echo "Bugünün tarihi: $TARIH"

# Parametre kullanımı
echo "Script adı: $0"
echo "Parametre sayısı: $#"
echo "Tüm parametreler: $@"
EOF

chmod +x ornek1.sh
echo "ornek1.sh oluşturuldu. Şu şekilde çalıştırın:"
echo "./ornek1.sh parametre1 parametre2"

# Örnek 2: Koşullu İfadeler
echo -e "\n${YESIL}3. Koşullu İfadeler Örneği${NORMAL}"
cat > ornek2.sh << 'EOF'
#!/bin/bash
# Koşullu ifadeler örneği

# Sayı kontrolü
read -p "Bir sayı girin: " SAYI

if [ $SAYI -gt 0 ]; then
    echo "Pozitif sayı"
elif [ $SAYI -lt 0 ]; then
    echo "Negatif sayı"
else
    echo "Sıfır"
fi

# Dosya kontrolü
read -p "Bir dosya adı girin: " DOSYA

if [ -f "$DOSYA" ]; then
    echo "$DOSYA bir dosyadır"
elif [ -d "$DOSYA" ]; then
    echo "$DOSYA bir dizindir"
else
    echo "$DOSYA bulunamadı"
fi
EOF

chmod +x ornek2.sh
echo "ornek2.sh oluşturuldu. Şu şekilde çalıştırın:"
echo "./ornek2.sh"

# Örnek 3: Döngüler
echo -e "\n${YESIL}4. Döngüler Örneği${NORMAL}"
cat > ornek3.sh << 'EOF'
#!/bin/bash
# Döngüler örneği

# For döngüsü
echo "For döngüsü:"
for i in {1..5}; do
    echo "Sayı: $i"
done

# While döngüsü
echo -e "\nWhile döngüsü:"
sayac=1
while [ $sayac -le 3 ]; do
    echo "Sayaç: $sayac"
    let sayac++
done

# Until döngüsü
echo -e "\nUntil döngüsü:"
sayac=5
until [ $sayac -le 0 ]; do
    echo "Geri sayım: $sayac"
    let sayac--
done
EOF

chmod +x ornek3.sh
echo "ornek3.sh oluşturuldu. Şu şekilde çalıştırın:"
echo "./ornek3.sh"

# Örnek 4: Menü Sistemi
echo -e "\n${YESIL}5. Menü Sistemi Örneği${NORMAL}"
cat > ornek4.sh << 'EOF'
#!/bin/bash
# Menü sistemi örneği

while true; do
    echo -e "\nMenü:"
    echo "1. Dizin Listele"
    echo "2. Tarih Göster"
    echo "3. Disk Kullanımı"
    echo "4. Çalışan Süreçler"
    echo "5. Çıkış"
    
    read -p "Seçiminiz (1-5): " secim
    
    case $secim in
        1)
            ls -l
            ;;
        2)
            date
            ;;
        3)
            df -h
            ;;
        4)
            ps aux | head -5
            ;;
        5)
            echo "Program sonlandırılıyor..."
            exit 0
            ;;
        *)
            echo "Geçersiz seçim!"
            ;;
    esac
    
    read -p "Devam etmek için ENTER'a basın..."
done
EOF

chmod +x ornek4.sh
echo "ornek4.sh oluşturuldu. Şu şekilde çalıştırın:"
echo "./ornek4.sh"

# Alıştırmalar
echo -e "\n${YESIL}6. Alıştırmalar${NORMAL}"
echo "1. Temel Script Alıştırması:"
echo "   - ornek1.sh'i inceleyin ve benzer bir script yazın"
echo "   - Kendi değişkenlerinizi ekleyin"
echo "   - Farklı parametrelerle test edin"

echo -e "\n2. Koşullu İfadeler Alıştırması:"
echo "   - ornek2.sh'i genişletin"
echo "   - Yeni koşullar ekleyin"
echo "   - case yapısı kullanın"

echo -e "\n3. Döngüler Alıştırması:"
echo "   - ornek3.sh'e yeni döngüler ekleyin"
echo "   - Dizi üzerinde döngü yapın"
echo "   - Dosya okuma döngüsü ekleyin"

echo -e "\n4. Menü Sistemi Alıştırması:"
echo "   - ornek4.sh'e yeni menü seçenekleri ekleyin"
echo "   - Her seçenek için hata kontrolü ekleyin"
echo "   - Yeni fonksiyonlar ekleyin"

# Temizlik
echo -e "\n${KIRMIZI}Temizlik İşlemleri:${NORMAL}"
echo "# Çalışma dizinini temizlemek için:"
echo "rm -rf $CALISMA_DIZINI"

# Önemli notlar
echo -e "\n${MAVI}Önemli Notlar:${NORMAL}"
echo "1. Her scripti çalıştırmadan önce chmod +x ile çalıştırma izni verin"
echo "2. Scriptleri düzenlerken bir metin editörü kullanın (vim veya nano)"
echo "3. Hata ayıklama için 'bash -x script.sh' kullanın"
echo "4. Değişkenleri tırnak içinde kullanmayı unutmayın"
echo "5. Her zaman hata kontrolü yapın"

echo -e "\n${MAVI}Alıştırma tamamlandı!${NORMAL}" 