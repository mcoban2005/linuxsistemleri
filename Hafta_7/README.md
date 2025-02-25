# Hafta 7: Kabuk Programlama Temelleri

## İçerik
1. Kabuk Programlamaya Giriş
2. Değişkenler ve Veri Türleri
3. Koşullu İfadeler
4. Döngüler

## 1. Kabuk Programlamaya Giriş

### Script Oluşturma
\`\`\`bash
#!/bin/bash          # Shebang satırı
# Bu bir yorum satırı

echo "Merhaba Dünya" # İlk komut
\`\`\`

### Script Çalıştırma
\`\`\`bash
# Çalıştırma izni verme
chmod +x script.sh

# Çalıştırma yöntemleri
./script.sh
bash script.sh
source script.sh
\`\`\`

## 2. Değişkenler ve Veri Türleri

### Değişken Tanımlama
\`\`\`bash
# Değişken atama (eşittir işaretinin yanında boşluk olmamalı)
isim="Ahmet"
yas=25
tarih=$(date)
dizi=(1 2 3 4 5)

# Değişken kullanma
echo "Merhaba $isim"
echo "Yaşınız: ${yas}"
echo "Tarih: $tarih"
echo "Dizinin ilk elemanı: ${dizi[0]}"
\`\`\`

### Özel Değişkenler
\`\`\`bash
$0      # Script adı
$1, $2  # Komut satırı parametreleri
$#      # Parametre sayısı
$*      # Tüm parametreler (tek string)
$@      # Tüm parametreler (dizi)
$?      # Son komutun çıkış kodu
$$      # Mevcut process ID
\`\`\`

### Aritmetik İşlemler
\`\`\`bash
# let komutu
let "a = 5 + 3"
let "b = $a * 2"

# expr komutu
c=$(expr 10 + 5)
d=$(expr $c \* 2)  # Çarpma için escape karakteri gerekli

# $(()) yapısı
e=$((10 + 5))
f=$((e * 2))
\`\`\`

## 3. Koşullu İfadeler

### if Yapısı
\`\`\`bash
if [ koşul ]; then
    komutlar
elif [ koşul ]; then
    komutlar
else
    komutlar
fi
\`\`\`

### Karşılaştırma Operatörleri
\`\`\`bash
# Sayısal karşılaştırma
[ $a -eq $b ]  # Eşit
[ $a -ne $b ]  # Eşit değil
[ $a -gt $b ]  # Büyük
[ $a -lt $b ]  # Küçük
[ $a -ge $b ]  # Büyük eşit
[ $a -le $b ]  # Küçük eşit

# String karşılaştırma
[ "$a" = "$b" ]   # Eşit
[ "$a" != "$b" ]  # Eşit değil
[ -z "$a" ]       # Boş string
[ -n "$a" ]       # Boş olmayan string

# Dosya kontrolleri
[ -f dosya ]  # Düzenli dosya
[ -d dizin ]  # Dizin
[ -r dosya ]  # Okunabilir
[ -w dosya ]  # Yazılabilir
[ -x dosya ]  # Çalıştırılabilir
\`\`\`

### case Yapısı
\`\`\`bash
case $degisken in
    deger1)
        komutlar
        ;;
    deger2)
        komutlar
        ;;
    *)
        komutlar
        ;;
esac
\`\`\`

## 4. Döngüler

### for Döngüsü
\`\`\`bash
# Dizi üzerinde döngü
for eleman in "${dizi[@]}"; do
    echo "$eleman"
done

# Sayı aralığında döngü
for i in {1..5}; do
    echo "$i"
done

# C tarzı for döngüsü
for ((i=0; i<5; i++)); do
    echo "$i"
done
\`\`\`

### while Döngüsü
\`\`\`bash
# Sayaç ile döngü
sayac=0
while [ $sayac -lt 5 ]; do
    echo "$sayac"
    let sayac++
done

# Dosya okuma
while read satir; do
    echo "$satir"
done < dosya.txt
\`\`\`

### until Döngüsü
\`\`\`bash
sayac=0
until [ $sayac -ge 5 ]; do
    echo "$sayac"
    let sayac++
done
\`\`\`

## Pratik Örnekler

### Örnek 1: Parametre Kontrolü
\`\`\`bash
#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Kullanım: $0 parametre1 [parametre2 ...]"
    exit 1
fi

echo "Toplam $# parametre aldınız:"
for param in "$@"; do
    echo "- $param"
done
\`\`\`

### Örnek 2: Dosya İşlemleri
\`\`\`bash
#!/bin/bash
for dosya in *.txt; do
    if [ -f "$dosya" ]; then
        echo "$dosya dosyasında $(wc -l < "$dosya") satır var"
    fi
done
\`\`\`

### Örnek 3: Menü Sistemi
\`\`\`bash
#!/bin/bash
while true; do
    echo "1. Dosya Listele"
    echo "2. Dizin Oluştur"
    echo "3. Çıkış"
    read -p "Seçiminiz: " secim
    
    case $secim in
        1) ls -l ;;
        2) read -p "Dizin adı: " dizin
           mkdir -p "$dizin" ;;
        3) break ;;
        *) echo "Geçersiz seçim!" ;;
    esac
done
\`\`\`

## Alıştırmalar

1. Temel Script Yazma:
   - Shebang satırı içeren bir script oluşturun
   - Değişkenler tanımlayın ve kullanın
   - Komut satırı parametrelerini işleyin

2. Koşullu İfadeler:
   - if-elif-else yapısı kullanan bir script yazın
   - case yapısı ile menü oluşturun
   - Dosya ve dizin kontrolleri yapın

3. Döngüler:
   - Diziler üzerinde for döngüsü kullanın
   - while ile dosya okuma yapın
   - until döngüsü ile sayaç oluşturun

## Önemli İpuçları
- Script dosyalarına her zaman çalıştırma izni verin
- Değişken kullanırken süslü parantez kullanmayı alışkanlık edinin
- Hata kontrolü yapmayı unutmayın
- Çıkış kodlarını uygun şekilde kullanın
- Kodlarınızı yorum satırları ile belgelendirin

## Kaynaklar
- [Bash Guide for Beginners](https://tldp.org/LDP/Bash-Beginners-Guide/html/)
- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)
- [GNU Bash Manual](https://www.gnu.org/software/bash/manual/) 