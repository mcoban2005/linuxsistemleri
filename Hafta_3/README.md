# Hafta 3: Dosya İzinleri ve Metin İşleme

## İçerik
1. Dosya İzinleri ve Yönetimi
2. Dosya Arşivleme ve Sıkıştırma
3. Dosya Arama
4. Metin Dosyalarıyla Çalışma

## 1. Dosya İzinleri

### İzin Türleri
- `r` (read): Okuma izni
- `w` (write): Yazma izni
- `x` (execute): Çalıştırma izni

### İzin Grupları
- Owner (Sahip)
- Group (Grup)
- Others (Diğerleri)

### chmod Komutu
\`\`\`bash
# Sayısal (Octal) Gösterim
chmod 755 dosya    # rwxr-xr-x
chmod 644 dosya    # rw-r--r--
chmod 700 dosya    # rwx------

# Sembolik Gösterim
chmod u+x dosya    # Sahibine çalıştırma izni ekle
chmod g-w dosya    # Gruptan yazma iznini kaldır
chmod o=r dosya    # Diğerlerine sadece okuma izni ver
chmod a+x dosya    # Herkese çalıştırma izni ekle
\`\`\`

### chown ve chgrp Komutları
\`\`\`bash
# Sahip değiştirme
chown yeni_sahip dosya
chown yeni_sahip:yeni_grup dosya

# Grup değiştirme
chgrp yeni_grup dosya
\`\`\`

## 2. Dosya Arşivleme ve Sıkıştırma

### tar Komutu
\`\`\`bash
# Arşiv oluşturma
tar -cf arsiv.tar dosyalar/
tar -czf arsiv.tar.gz dosyalar/    # gzip ile sıkıştırma
tar -cjf arsiv.tar.bz2 dosyalar/   # bzip2 ile sıkıştırma

# Arşiv içeriğini görüntüleme
tar -tf arsiv.tar
tar -tzf arsiv.tar.gz

# Arşivi açma
tar -xf arsiv.tar
tar -xzf arsiv.tar.gz
tar -xjf arsiv.tar.bz2
\`\`\`

### gzip ve bzip2
\`\`\`bash
# gzip
gzip dosya           # dosya.gz oluşturur
gunzip dosya.gz      # Sıkıştırmayı açar

# bzip2
bzip2 dosya          # dosya.bz2 oluşturur
bunzip2 dosya.bz2    # Sıkıştırmayı açar
\`\`\`

## 3. Dosya Arama

### find Komutu
\`\`\`bash
# İsme göre arama
find /dizin -name "*.txt"
find . -iname "*.jpg"      # Büyük/küçük harf duyarsız

# Boyuta göre arama
find . -size +1M           # 1MB'dan büyük
find . -size -100k         # 100KB'dan küçük

# İzinlere göre arama
find . -perm 644
find . -executable

# Zamana göre arama
find . -mtime -7           # Son 7 günde değiştirilmiş
\`\`\`

### locate Komutu
\`\`\`bash
# Veritabanında arama
locate dosya_adi

# Veritabanını güncelleme
sudo updatedb
\`\`\`

### grep Komutu
\`\`\`bash
# Metin arama
grep "aranacak" dosya
grep -i "aranacak" dosya    # Büyük/küçük harf duyarsız
grep -r "aranacak" dizin    # Alt dizinlerde de ara
grep -v "aranacak" dosya    # Eşleşmeyen satırları göster
\`\`\`

## 4. Metin Dosyalarıyla Çalışma

### Görüntüleme Komutları
\`\`\`bash
cat dosya           # Tüm içeriği göster
less dosya          # Sayfa sayfa görüntüle
head dosya          # İlk 10 satırı göster
head -n 5 dosya     # İlk 5 satırı göster
tail dosya          # Son 10 satırı göster
tail -f dosya       # Canlı olarak son satırları izle
\`\`\`

## Pratik Örnekler

### Örnek 1: İzin Yönetimi
\`\`\`bash
# Script dosyası oluşturma ve çalıştırılabilir yapma
touch script.sh
echo '#!/bin/bash' > script.sh
echo 'echo "Merhaba Dünya"' >> script.sh
chmod +x script.sh
./script.sh
\`\`\`

### Örnek 2: Arşivleme ve Sıkıştırma
\`\`\`bash
# Proje dizinini arşivleme
mkdir proje
touch proje/{dosya1,dosya2,dosya3}
tar -czf proje.tar.gz proje/
ls -lh proje.tar.gz
\`\`\`

### Örnek 3: Dosya Arama ve Metin İşleme
\`\`\`bash
# Log dosyasında hata arama
echo "Hata: Bağlantı başarısız" > sistem.log
echo "Bilgi: İşlem tamamlandı" >> sistem.log
grep "Hata" sistem.log
\`\`\`

## Alıştırmalar

1. Aşağıdaki görevleri yapın:
   - Yeni bir dizin oluşturun ve içine birkaç dosya ekleyin
   - Dosyalara farklı izinler atayın
   - Dosyaları bir arşiv dosyasında toplayın
   - Arşivi sıkıştırın
   - Sıkıştırılmış arşivi başka bir dizine açın

2. Metin işleme alıştırması:
   - Bir log dosyası oluşturun
   - İçine çeşitli mesajlar ekleyin
   - grep ile belirli mesajları arayın
   - tail ile son mesajları izleyin

## Önemli İpuçları
- Dosya izinlerini değiştirirken dikkatli olun
- Önemli sistem dosyalarının izinlerini değiştirmeyin
- Büyük dosyaları sıkıştırırken disk alanını kontrol edin
- Düzenli olarak yedekleme yapın

## Kaynaklar
- [Linux File Permissions](https://www.linux.com/training-tutorials/understanding-linux-file-permissions/)
- [GNU tar Manual](https://www.gnu.org/software/tar/manual/)
- [grep Manual](https://www.gnu.org/software/grep/manual/) 