# Hafta 8: İleri Seviye Kabuk Programlama

## İçerik
1. Fonksiyonlar
2. Komut Satırı Argümanları
3. Girdi/Çıktı İşlemleri
4. Hata Yönetimi

## 1. Fonksiyonlar

### Fonksiyon Tanımlama ve Çağırma
\`\`\`bash
# Temel fonksiyon tanımlama
function merhaba() {
    echo "Merhaba!"
}

# Alternatif tanımlama
selamla() {
    echo "Merhaba $1!"
}

# Fonksiyon çağırma
merhaba
selamla "Ahmet"
\`\`\`

### Parametreler ve Dönüş Değerleri
\`\`\`bash
# Parametreli fonksiyon
topla() {
    local sonuc=$(($1 + $2))
    echo $sonuc
    return 0
}

# Fonksiyonu kullanma
sonuc=$(topla 5 3)
echo "Toplam: $sonuc"

# Dönüş değeri kontrolü
if topla 5 3; then
    echo "Fonksiyon başarılı"
else
    echo "Fonksiyon başarısız"
fi
\`\`\`

### Yerel Değişkenler
\`\`\`bash
# local kullanımı
hesapla() {
    local x=10
    local y=20
    echo $((x + y))
}

# Global ve yerel değişkenler
x=5
test_fonksiyon() {
    local x=10
    echo "Yerel x: $x"
}
test_fonksiyon
echo "Global x: $x"
\`\`\`

## 2. Komut Satırı Argümanları

### getopts Kullanımı
\`\`\`bash
#!/bin/bash
while getopts "hf:v" opt; do
    case $opt in
        h)
            echo "Yardım"
            ;;
        f)
            dosya="$OPTARG"
            echo "Dosya: $dosya"
            ;;
        v)
            verbose=1
            echo "Ayrıntılı mod açık"
            ;;
        \?)
            echo "Geçersiz seçenek: -$OPTARG"
            exit 1
            ;;
    esac
done
\`\`\`

### Argüman İşleme
\`\`\`bash
# Argüman sayısı kontrolü
if [ $# -lt 2 ]; then
    echo "En az 2 argüman gerekli"
    exit 1
fi

# Argümanları kaydırma
shift
echo "Kalan argümanlar: $@"

# Argüman dizisi işleme
for arg in "$@"; do
    echo "Argüman: $arg"
done
\`\`\`

## 3. Girdi/Çıktı İşlemleri

### Dosya İşlemleri
\`\`\`bash
# Dosya okuma
while IFS= read -r satir; do
    echo "$satir"
done < "girdi.txt"

# Dosyaya yazma
{
    echo "İlk satır"
    echo "İkinci satır"
} > "cikti.txt"

# Dosyaya ekleme
echo "Yeni satır" >> "cikti.txt"
\`\`\`

### Yönlendirme ve Borular
\`\`\`bash
# Standart çıktı ve hata yönlendirme
komut > cikti.txt 2> hata.txt
komut &> tum_cikti.txt

# Boru hattı kullanımı
cat dosya.txt | grep "ara" | sort > sonuc.txt

# Here Document
cat << EOF > config.txt
Sunucu: localhost
Port: 8080
Kullanıcı: admin
EOF
\`\`\`

## 4. Hata Yönetimi

### Hata Kodları ve Kontrol
\`\`\`bash
# Hata kontrolü
if ! komut; then
    echo "Hata oluştu!"
    exit 1
fi

# Özel hata kodları
function test_fonksiyon() {
    # Hata durumu
    return 1
}

if ! test_fonksiyon; then
    echo "Fonksiyon başarısız oldu"
fi
\`\`\`

### Hata Yakalama ve İşleme
\`\`\`bash
# trap kullanımı
trap 'echo "Ctrl+C basıldı"; exit 1' INT
trap 'echo "Script sonlandırılıyor"; cleanup' EXIT

# Hata mesajları
error() {
    echo "HATA: $1" >&2
    exit 1
}

# Kullanım
[ -z "$dosya" ] && error "Dosya adı belirtilmedi"
\`\`\`

## Pratik Örnekler

### Örnek 1: Fonksiyon Kütüphanesi
\`\`\`bash
#!/bin/bash

# Matematik fonksiyonları
mat_topla() {
    echo $(($1 + $2))
}

mat_cikar() {
    echo $(($1 - $2))
}

mat_carp() {
    echo $(($1 * $2))
}

mat_bol() {
    if [ $2 -eq 0 ]; then
        return 1
    fi
    echo $(($1 / $2))
}

# Test
echo "5 + 3 = $(mat_topla 5 3)"
echo "10 - 4 = $(mat_cikar 10 4)"
echo "6 * 2 = $(mat_carp 6 2)"
if sonuc=$(mat_bol 10 2); then
    echo "10 / 2 = $sonuc"
fi
\`\`\`

### Örnek 2: Argüman İşleme
\`\`\`bash
#!/bin/bash

# Varsayılan değerler
VERBOSE=0
OUTPUT="output.txt"

# Kullanım bilgisi
usage() {
    echo "Kullanım: $0 [-v] [-o dosya] dosya"
    exit 1
}

# Argümanları işle
while getopts "vo:h" opt; do
    case $opt in
        v) VERBOSE=1 ;;
        o) OUTPUT="$OPTARG" ;;
        h) usage ;;
        ?) usage ;;
    esac
done

# Kalan argümanları kontrol et
shift $((OPTIND-1))
if [ $# -ne 1 ]; then
    usage
fi

INPUT=$1
[ $VERBOSE -eq 1 ] && echo "İşleniyor: $INPUT -> $OUTPUT"
\`\`\`

## Alıştırmalar

1. Fonksiyonlar:
   - Matematik işlemleri yapan fonksiyonlar yazın
   - Dosya işlemleri için yardımcı fonksiyonlar oluşturun
   - Fonksiyonlarınızı bir kütüphane dosyasında toplayın

2. Argüman İşleme:
   - getopts ile kompleks bir komut satırı arayüzü oluşturun
   - Zorunlu ve isteğe bağlı parametreleri kontrol edin
   - Yardım ve versiyon bilgisi ekleyin

3. Girdi/Çıktı:
   - Dosya okuma ve yazma işlemleri yapın
   - Hata yönlendirmelerini kullanın
   - Here document ile yapılandırma dosyaları oluşturun

4. Hata Yönetimi:
   - Kapsamlı hata kontrolü yapın
   - Temizlik işlemleri için trap kullanın
   - Hata mesajları için fonksiyon yazın

## Önemli İpuçları
- Fonksiyonlarda local değişkenler kullanın
- Argüman kontrollerini dikkatli yapın
- Hata durumlarını her zaman kontrol edin
- Çıkış kodlarını uygun şekilde kullanın
- Kodunuzu modüler ve tekrar kullanılabilir yazın

## Kaynaklar
- [Bash Functions](https://tldp.org/LDP/abs/html/functions.html)
- [Bash Getopts](https://wiki.bash-hackers.org/howto/getopts_tutorial)
- [Bash I/O Redirection](https://tldp.org/LDP/abs/html/io-redirection.html)
- [Bash Error Handling](https://www.davidpashley.com/articles/writing-robust-shell-scripts/) 