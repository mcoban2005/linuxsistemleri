# Hafta 4: Paket Yönetimi

## İçerik
1. Paket Yöneticileri
2. Yazılım Kurulumu ve Kaldırma
3. Depolarla Çalışma
4. Bağımlılık Yönetimi

## 1. Paket Yöneticileri

### Debian Tabanlı Sistemler (Ubuntu, Debian, Linux Mint)
\`\`\`bash
# APT (Advanced Package Tool)
apt update              # Paket listesini güncelle
apt upgrade            # Yüklü paketleri güncelle
apt install paket      # Paket kur
apt remove paket       # Paket kaldır
apt purge paket        # Paket ve yapılandırma dosyalarını kaldır
apt search paket       # Paket ara
apt show paket         # Paket bilgilerini göster
apt list --installed   # Yüklü paketleri listele
\`\`\`

### Red Hat Tabanlı Sistemler (RHEL, CentOS, Fedora)
\`\`\`bash
# YUM (Yellowdog Updater Modified)
yum update             # Paketleri güncelle
yum install paket      # Paket kur
yum remove paket       # Paket kaldır
yum search paket       # Paket ara
yum info paket         # Paket bilgilerini göster
yum list installed    # Yüklü paketleri listele

# DNF (Dandified YUM)
dnf update             # Paketleri güncelle
dnf install paket      # Paket kur
dnf remove paket       # Paket kaldır
dnf search paket       # Paket ara
\`\`\`

### Arch Linux
\`\`\`bash
# Pacman
pacman -Syu           # Sistemi güncelle
pacman -S paket       # Paket kur
pacman -R paket       # Paket kaldır
pacman -Ss paket      # Paket ara
pacman -Qi paket      # Paket bilgilerini göster
pacman -Q             # Yüklü paketleri listele
\`\`\`

## 2. Yazılım Kurulumu ve Kaldırma

### DEB Paketleri
\`\`\`bash
# .deb dosyasından kurulum
dpkg -i paket.deb     # Paketi kur
dpkg -r paket         # Paketi kaldır
dpkg -l               # Yüklü paketleri listele
dpkg -s paket         # Paket durumunu göster
\`\`\`

### RPM Paketleri
\`\`\`bash
# .rpm dosyasından kurulum
rpm -i paket.rpm      # Paketi kur
rpm -e paket          # Paketi kaldır
rpm -qa               # Yüklü paketleri listele
rpm -qi paket         # Paket bilgilerini göster
\`\`\`

## 3. Depolarla Çalışma

### APT Depo Yönetimi
\`\`\`bash
# Depo dosyası
/etc/apt/sources.list
/etc/apt/sources.list.d/

# PPA ekleme (Ubuntu)
add-apt-repository ppa:kullanici/depo
add-apt-repository --remove ppa:kullanici/depo

# Depo anahtarı ekleme
apt-key add anahtar.gpg
\`\`\`

### YUM/DNF Depo Yönetimi
\`\`\`bash
# Depo dosyaları
/etc/yum.repos.d/
/etc/dnf/repos.d/

# Depo ekleme
yum-config-manager --add-repo URL
dnf config-manager --add-repo URL
\`\`\`

## 4. Bağımlılık Yönetimi

### Bağımlılık Kontrolü
\`\`\`bash
# APT
apt-cache depends paket      # Paketin bağımlılıklarını göster
apt-cache rdepends paket    # Pakete bağımlı paketleri göster

# RPM
rpm -qR paket              # Paketin bağımlılıklarını göster
\`\`\`

### Otomatik Bağımlılık Çözümleme
\`\`\`bash
# APT
apt install -f             # Bozuk bağımlılıkları onar

# YUM/DNF
yum deplist paket         # Paket bağımlılıklarını listele
dnf repoquery --requires paket
\`\`\`

## Pratik Örnekler

### Örnek 1: Temel Paket İşlemleri
\`\`\`bash
# Sistem güncelleme
sudo apt update
sudo apt upgrade

# Popüler araçları kurma
sudo apt install git vim htop
\`\`\`

### Örnek 2: Özel Depo Ekleme
\`\`\`bash
# VSCode deposunu ekleme (Ubuntu)
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code
\`\`\`

### Örnek 3: Paket Bilgisi Sorgulama
\`\`\`bash
# Paket detaylarını görüntüleme
apt show nginx
apt-cache policy nginx

# Yüklü paketleri filtreleme
dpkg -l | grep nginx
\`\`\`

## Alıştırmalar

1. Sistem Güncelleme:
   - Paket listesini güncelleyin
   - Mevcut paketleri güncelleyin
   - Güncelleme geçmişini kontrol edin

2. Paket Yönetimi:
   - Birkaç yararlı araç kurun (htop, tree, curl)
   - Paketlerin bağımlılıklarını kontrol edin
   - Kullanılmayan paketleri temizleyin

3. Depo Yönetimi:
   - Yeni bir PPA ekleyin
   - Depo listesini yedekleyin
   - Eklenen depoyu kaldırın

## Önemli İpuçları
- Güvenilir kaynaklardan paket yükleyin
- Sistem güncellemelerini düzenli yapın
- Kullanılmayan paketleri temizleyin
- Depo eklerken dikkatli olun
- Önemli paketleri kaldırmadan önce bağımlılıkları kontrol edin

## Kaynaklar
- [Ubuntu Package Management](https://help.ubuntu.com/community/AptGet/Howto)
- [Debian Package Management](https://www.debian.org/doc/manuals/debian-reference/ch02.en.html)
- [RPM Package Management](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-rpm) 