#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
NORMAL='\033[0m'

echo -e "${MAVI}Linux Dosya Sistemi Alıştırmaları${NORMAL}"
echo "----------------------------------------"

# Çalışma dizini oluşturma
echo -e "${YESIL}1. Çalışma dizini oluşturuluyor...${NORMAL}"
mkdir -p ~/calisma
cd ~/calisma

# Alt dizinleri oluşturma
echo -e "${YESIL}2. Alt dizinler oluşturuluyor...${NORMAL}"
mkdir -p projeler/{proje1,proje2}
mkdir -p belgeler/{notlar,raporlar}
mkdir yedekler

# Örnek dosyalar oluşturma
echo -e "${YESIL}3. Örnek dosyalar oluşturuluyor...${NORMAL}"
echo "Bu bir örnek Python dosyasıdır." > projeler/proje1/ornek.py
echo "Bu bir örnek metin dosyasıdır." > belgeler/notlar/not.txt
echo "Bu bir rapor dosyasıdır." > belgeler/raporlar/rapor.txt

# Dosya kopyalama örneği
echo -e "${YESIL}4. Dosya kopyalama işlemi...${NORMAL}"
cp projeler/proje1/ornek.py yedekler/ornek_yedek.py

# Dizin yapısını gösterme
echo -e "${YESIL}5. Oluşturulan dizin yapısı:${NORMAL}"
tree

# Mutlak ve göreceli yol örnekleri
echo -e "${YESIL}6. Yol örnekleri:${NORMAL}"
echo "Mutlak yol: $HOME/calisma/projeler/proje1/ornek.py"
echo "Göreceli yol: ./projeler/proje1/ornek.py"

# Pratik alıştırmalar
echo -e "${YESIL}7. Alıştırmalar için yapılacaklar:${NORMAL}"
echo "a) cd komutu ile projeler/proje1 dizinine gidin"
echo "b) pwd komutu ile bulunduğunuz dizini kontrol edin"
echo "c) cd ../../belgeler/notlar ile notlar dizinine geçin"
echo "d) ls -l komutu ile dizin içeriğini listeleyin"
echo "e) cd - komutu ile önceki dizine dönün"

# Temizlik için komutlar
echo -e "${KIRMIZI}Not: Çalışma dizinini temizlemek için:${NORMAL}"
echo "rm -rf ~/calisma"

echo -e "${MAVI}Alıştırma tamamlandı!${NORMAL}" 