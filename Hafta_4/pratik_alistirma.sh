#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
NORMAL='\033[0m'

echo -e "${MAVI}Paket Yönetimi Alıştırmaları${NORMAL}"
echo "--------------------------------"

# Sistem güncelleme kontrolü
echo -e "${YESIL}1. Sistem Güncelleme Durumu${NORMAL}"
echo "Son güncelleme kontrolü:"
ls -l /var/log/apt/history.log | cut -d' ' -f6,7,8

# Yüklü paket sayısı
echo -e "\n${YESIL}2. Yüklü Paket Bilgileri${NORMAL}"
echo "Toplam yüklü paket sayısı:"
dpkg -l | grep "^ii" | wc -l

# Popüler paketlerin durumu
echo -e "\n${YESIL}3. Bazı Önemli Paketlerin Durumu${NORMAL}"
for paket in git vim htop curl wget tree; do
    if dpkg -l | grep -q "^ii  $paket "; then
        echo -e "$paket: ${YESIL}Yüklü${NORMAL}"
    else
        echo -e "$paket: ${KIRMIZI}Yüklü değil${NORMAL}"
    fi
done

# Depo listesi
echo -e "\n${YESIL}4. Aktif Depolar${NORMAL}"
echo "sources.list içeriği:"
grep -v '^#' /etc/apt/sources.list | grep -v '^$'

echo -e "\nPPA Depoları:"
ls -l /etc/apt/sources.list.d/

# Bağımlılık örneği
echo -e "\n${YESIL}5. Örnek Bağımlılık Analizi${NORMAL}"
echo "Python3 paketinin bağımlılıkları:"
apt-cache depends python3 | grep Depends | head -n 5

# Alıştırmalar
echo -e "\n${YESIL}6. Alıştırmalar${NORMAL}"
echo "a) Sistem güncelleme:"
echo "   sudo apt update && sudo apt upgrade"

echo -e "\nb) Yeni paket kurulumu:"
echo "   sudo apt install htop tree curl"

echo -e "\nc) Paket bilgisi sorgulama:"
echo "   apt show nginx"
echo "   dpkg -l | grep nginx"

echo -e "\nd) Paket kaldırma:"
echo "   sudo apt remove paket_adi"
echo "   sudo apt autoremove  # Kullanılmayan bağımlılıkları temizle"

echo -e "\ne) PPA ekleme/kaldırma:"
echo "   sudo add-apt-repository ppa:kullanici/depo"
echo "   sudo add-apt-repository --remove ppa:kullanici/depo"

# Önemli dizinler
echo -e "\n${YESIL}7. Önemli Dizinler${NORMAL}"
echo "- /etc/apt/sources.list: Ana depo dosyası"
echo "- /etc/apt/sources.list.d/: Ek depo dosyaları"
echo "- /var/lib/apt/lists/: Depo indeksleri"
echo "- /var/cache/apt/archives/: İndirilen paket dosyaları"

# İpuçları
echo -e "\n${MAVI}Önemli İpuçları:${NORMAL}"
echo "1. Paket kurulmadan önce her zaman 'apt update' çalıştırın"
echo "2. Güvenilir olmayan depolar sisteminize zarar verebilir"
echo "3. Önemli sistem paketlerini kaldırırken dikkatli olun"
echo "4. Düzenli sistem güncellemesi yapın"
echo "5. /etc/apt/sources.list dosyasını değiştirmeden önce yedekleyin"

# Temizlik
echo -e "\n${KIRMIZI}Sistem Temizliği için:${NORMAL}"
echo "sudo apt clean        # Önbelleği temizle"
echo "sudo apt autoremove   # Kullanılmayan paketleri kaldır"
echo "sudo apt autoclean   # Eski paket versiyonlarını temizle"

echo -e "\n${MAVI}Alıştırma tamamlandı!${NORMAL}" 