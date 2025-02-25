# Hafta 6: Metin Editörleri

## İçerik
1. Metin Editörlerine Giriş
2. Vim Editörü
3. Nano Editörü
4. Yapılandırma Dosyaları

## 1. Metin Editörlerine Giriş

Linux sistemlerde en yaygın kullanılan metin editörleri:
- vim (vi improved)
- nano
- emacs
- gedit (GUI)
- kate (GUI)

## 2. Vim Editörü

### Vim Modları
- Normal Mod (ESC ile geçilir)
- Insert Mod (i, I, a, A ile geçilir)
- Visual Mod (v, V, Ctrl+v ile geçilir)
- Command Mod (: ile geçilir)

### Temel Vim Komutları
\`\`\`bash
# Dosya İşlemleri
:w              # Kaydet
:q              # Çık
:wq veya :x     # Kaydet ve çık
:q!             # Kaydetmeden çık
:w dosya.txt    # Farklı kaydet

# Gezinme
h, j, k, l      # Sol, aşağı, yukarı, sağ
w               # Sonraki kelimenin başına
b               # Önceki kelimenin başına
0               # Satır başı
$               # Satır sonu
gg              # Dosya başı
G               # Dosya sonu
:n              # n. satıra git
\`\`\`

### Düzenleme Komutları
\`\`\`bash
# Ekleme
i               # İmleçten önce ekle
a               # İmleçten sonra ekle
I               # Satır başında ekle
A               # Satır sonunda ekle
o               # Alt satıra ekle
O               # Üst satıra ekle

# Silme
x               # Karakter sil
dd              # Satır sil
dw              # Kelime sil
d$              # İmleçten satır sonuna kadar sil
d0              # İmleçten satır başına kadar sil

# Kopyalama/Yapıştırma
yy              # Satır kopyala
yw              # Kelime kopyala
p               # İmleçten sonra yapıştır
P               # İmleçten önce yapıştır
\`\`\`

### Arama ve Değiştirme
\`\`\`bash
/kelime         # İleriye doğru ara
?kelime         # Geriye doğru ara
n               # Sonraki eşleşme
N               # Önceki eşleşme
:%s/eski/yeni/g # Tüm dosyada değiştir
\`\`\`

## 3. Nano Editörü

### Temel Nano Komutları
\`\`\`bash
# Dosya İşlemleri
Ctrl+O          # Kaydet
Ctrl+X          # Çık
Ctrl+R          # Dosya aç

# Düzenleme
Ctrl+K          # Satır kes
Ctrl+U          # Yapıştır
Ctrl+W          # Ara
Ctrl+\          # Değiştir
Alt+U           # Geri al
Alt+E           # Yinele
\`\`\`

### Nano Kısayolları
\`\`\`bash
# Gezinme
Ctrl+A          # Satır başı
Ctrl+E          # Satır sonu
Ctrl+Y          # Önceki sayfa
Ctrl+V          # Sonraki sayfa
Ctrl+_          # Satır numarasına git

# İşaretleme
Alt+A           # Blok işaretlemeyi başlat
Ctrl+6          # İşaretli bloğu kopyala
Ctrl+K          # İşaretli bloğu kes
\`\`\`

## 4. Yapılandırma Dosyaları

### Vim Yapılandırması
\`\`\`bash
# ~/.vimrc dosyası
syntax on               # Sözdizimi renklendirme
set number             # Satır numaraları
set autoindent         # Otomatik girinti
set tabstop=4         # Tab genişliği
set expandtab         # Tab'ları boşluğa çevir
set hlsearch          # Arama vurgulama
\`\`\`

### Nano Yapılandırması
\`\`\`bash
# ~/.nanorc dosyası
set linenumbers       # Satır numaraları
set autoindent       # Otomatik girinti
set tabsize 4        # Tab genişliği
set mouse           # Fare desteği
set smooth          # Yumuşak kaydırma
\`\`\`

## Pratik Örnekler

### Örnek 1: Vim ile Metin Düzenleme
\`\`\`bash
# Yeni dosya oluşturma
vim yeni_dosya.txt

# Metin ekleme
i
Merhaba Dünya!
[ESC]

# Kaydet ve çık
:wq
\`\`\`

### Örnek 2: Nano ile Yapılandırma Dosyası Düzenleme
\`\`\`bash
# Yapılandırma dosyası açma
nano ~/.bashrc

# Alias ekleme
alias ll='ls -la'
alias update='sudo apt update && sudo apt upgrade'

# Kaydet (Ctrl+O) ve çık (Ctrl+X)
\`\`\`

## Alıştırmalar

1. Vim Alıştırmaları:
   - Yeni bir dosya oluşturun
   - Metin ekleyin ve düzenleyin
   - Arama ve değiştirme yapın
   - Blok işlemleri yapın
   - Değişiklikleri kaydedin

2. Nano Alıştırmaları:
   - Yapılandırma dosyası düzenleyin
   - Metin kopyalama/yapıştırma yapın
   - Arama ve değiştirme yapın
   - Dosyayı farklı kaydedin

3. Yapılandırma:
   - Vim için .vimrc dosyası oluşturun
   - Nano için .nanorc dosyası oluşturun
   - Editör ayarlarını özelleştirin

## Önemli İpuçları
- Vim'den çıkmak için önce ESC'ye basın, sonra :q! veya :wq kullanın
- Nano'da alt menüdeki komutları takip edin
- Düzenli olarak kaydetme alışkanlığı edinin
- Yapılandırma dosyalarını yedekleyin

## Kaynaklar
- [Vim Tutorial](https://www.openvim.com/)
- [Nano Editor Basics](https://www.nano-editor.org/dist/latest/nano.html)
- [Vim Cheat Sheet](https://vim.rtorr.com/) 