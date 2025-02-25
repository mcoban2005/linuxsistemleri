# Hafta 2: Linux Dosya Sistemi ve Temel Komutlar

## İçerik
1. Linux Dosya Sistemi Hiyerarşisi
2. Temel Terminal Komutları
3. Dosya ve Dizin Yönetimi
4. Yol (Path) Kavramları

## 1. Linux Dosya Sistemi Hiyerarşisi

### Temel Dizinler ve Görevleri
- `/` (Root): Kök dizin, tüm dosya sisteminin başlangıç noktası
- `/home`: Kullanıcı dizinleri
- `/etc`: Sistem yapılandırma dosyaları
- `/var`: Değişken veriler (log dosyaları, mail kutuları)
- `/usr`: Kullanıcı programları ve verileri
- `/bin`: Temel sistem komutları
- `/sbin`: Sistem yönetimi komutları
- `/tmp`: Geçici dosyalar
- `/boot`: Önyükleme dosyaları
- `/dev`: Aygıt dosyaları
- `/proc`: Sistem bilgileri
- `/mnt`: Geçici bağlama noktaları
- `/media`: Çıkarılabilir medya bağlama noktaları

## 2. Temel Terminal Komutları

### Navigasyon Komutları
\`\`\`bash
pwd     # Mevcut çalışma dizinini göster
ls      # Dizin içeriğini listele
ls -l   # Detaylı liste
ls -a   # Gizli dosyaları da göster
cd      # Dizin değiştir
cd ..   # Üst dizine git
cd ~    # Ana dizine git
\`\`\`

### Dosya/Dizin İşlemleri
\`\`\`bash
mkdir dizin_adi        # Yeni dizin oluştur
mkdir -p a/b/c        # İç içe dizinler oluştur
rmdir dizin_adi       # Boş dizini sil
touch dosya.txt       # Boş dosya oluştur
cp kaynak hedef       # Dosya kopyala
mv eski yeni          # Dosya/dizin taşı veya yeniden adlandır
rm dosya             # Dosya sil
rm -r dizin          # Dizini ve içeriğini sil
\`\`\`

## 3. Pratik Örnekler

### Örnek 1: Dizin Oluşturma ve Navigasyon
\`\`\`bash
# Proje dizini oluşturma
mkdir ~/projeler
cd ~/projeler

# Alt dizinler oluşturma
mkdir kaynak_kodlar
mkdir dokumanlar
mkdir yedekler

# Dizinler arası gezinme
cd kaynak_kodlar
pwd
cd ../dokumanlar
pwd
cd ..
ls -l
\`\`\`

### Örnek 2: Dosya İşlemleri
\`\`\`bash
# Dosya oluşturma ve içerik ekleme
touch program.py
echo "print('Merhaba Dünya')" > program.py

# Dosya kopyalama
cp program.py yedekler/program_yedek.py

# Dosya taşıma
mv program.py kaynak_kodlar/

# Dizin içeriğini listeleme
ls -R
\`\`\`

## 4. Mutlak ve Göreceli Yollar

### Mutlak (Absolute) Yol
- Kök dizinden (`/`) başlar
- Her zaman aynı konumu gösterir
- Örnek: `/home/kullanici/belgeler/dosya.txt`

### Göreceli (Relative) Yol
- Mevcut konuma göre belirlenir
- `./` : Mevcut dizin
- `../` : Üst dizin
- Örnek: `../../projeler/dosya.txt`

## Alıştırmalar

1. Aşağıdaki dizin yapısını oluşturun:
\`\`\`
~/calisma/
    ├── projeler/
    │   ├── proje1/
    │   └── proje2/
    ├── belgeler/
    │   ├── notlar/
    │   └── raporlar/
    └── yedekler/
\`\`\`

2. Her dizine örnek dosyalar ekleyin ve şu işlemleri yapın:
   - Dosya kopyalama
   - Dosya taşıma
   - Dizin içeriğini listeleme
   - Göreceli ve mutlak yolları kullanarak gezinme

## Önemli İpuçları
- Tab tuşunu kullanarak otomatik tamamlama yapabilirsiniz
- Yukarı/aşağı ok tuşları ile komut geçmişinde gezinebilirsiniz
- `history` komutu ile önceki komutları görebilirsiniz
- `man` komutu ile herhangi bir komutun kılavuzunu görüntüleyebilirsiniz

## Kaynaklar
- [Linux Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html)
- [GNU Coreutils Manual](https://www.gnu.org/software/coreutils/manual/) 