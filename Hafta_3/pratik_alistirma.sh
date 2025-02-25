#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
NORMAL='\033[0m'

echo -e "${MAVI}Dosya İzinleri ve Metin İşleme Alıştırmaları${NORMAL}"
echo "------------------------------------------------"

# Çalışma dizini oluşturma
CALISMA_DIZINI=~/hafta3_pratik
echo -e "${YESIL}1. Çalışma dizini oluşturuluyor...${NORMAL}"
mkdir -p $CALISMA_DIZINI
cd $CALISMA_DIZINI

# Örnek dosyalar oluşturma
echo -e "${YESIL}2. Örnek dosyalar oluşturuluyor...${NORMAL}"
echo '#!/bin/bash
echo "Merhaba, bu bir test scriptidir."' > test_script.sh

echo "Bu bir metin dosyasıdır.
İkinci satır
Üçüncü satır
Hata: Bu bir hata mesajıdır.
Bilgi: Bu bir bilgi mesajıdır.
Uyarı: Bu bir uyarı mesajıdır." > ornek.txt

# İzin değiştirme örnekleri
echo -e "${YESIL}3. Dosya izinleri değiştiriliyor...${NORMAL}"
chmod 755 test_script.sh
chmod 644 ornek.txt

echo "Dosya izinleri:"
ls -l

# Arşivleme ve sıkıştırma
echo -e "${YESIL}4. Arşivleme ve sıkıştırma işlemleri...${NORMAL}"
mkdir -p proje/{src,docs,test}
touch proje/src/main.c
touch proje/docs/README.md
touch proje/test/test.c

echo "Proje dizini içeriği:"
tree proje

echo "TAR arşivi oluşturuluyor..."
tar -czf proje.tar.gz proje/

echo "Arşiv bilgisi:"
ls -lh proje.tar.gz

# Metin arama örnekleri
echo -e "${YESIL}5. Metin arama örnekleri...${NORMAL}"
echo "grep ile 'Hata' içeren satırlar:"
grep "Hata" ornek.txt

echo "grep ile 'Bilgi' içeren satırlar:"
grep "Bilgi" ornek.txt

# Dosya içeriği görüntüleme
echo -e "${YESIL}6. Dosya içeriği görüntüleme örnekleri...${NORMAL}"
echo "İlk 3 satır (head):"
head -n 3 ornek.txt

echo "Son 2 satır (tail):"
tail -n 2 ornek.txt

# Alıştırmalar
echo -e "${YESIL}7. Alıştırmalar için görevler:${NORMAL}"
echo "a) test_script.sh dosyasını çalıştırın (./test_script.sh)"
echo "b) ornek.txt dosyasında 'Uyarı' kelimesini arayın (grep 'Uyarı' ornek.txt)"
echo "c) proje.tar.gz arşivini açın (tar -xzf proje.tar.gz)"
echo "d) Yeni bir dizin oluşturun ve içine dosyalar ekleyin"
echo "e) Oluşturduğunuz dosyalara farklı izinler atayın"

# Temizlik bilgisi
echo -e "${KIRMIZI}Not: Çalışma dizinini temizlemek için:${NORMAL}"
echo "rm -rf $CALISMA_DIZINI"

echo -e "${MAVI}Alıştırma tamamlandı!${NORMAL}" 