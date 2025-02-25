#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
NORMAL='\033[0m'

echo -e "${MAVI}Kullanıcı ve Grup Yönetimi Alıştırmaları${NORMAL}"
echo "----------------------------------------"

# Test kullanıcı ve grup isimleri
TEST_KULLANICI="test_kullanici"
TEST_GRUP="test_grup"
PROJE_GRUP="proje_grubu"

# 1. Kullanıcı Oluşturma ve Yönetim
echo -e "\n${YESIL}1. Kullanıcı Yönetimi Alıştırmaları${NORMAL}"

echo "a) Yeni kullanıcı oluşturma:"
echo "sudo useradd -m -s /bin/bash -c \"Test Kullanıcı\" $TEST_KULLANICI"
echo "sudo passwd $TEST_KULLANICI"

echo -e "\nb) Kullanıcı bilgilerini görüntüleme:"
echo "id $TEST_KULLANICI"
echo "grep $TEST_KULLANICI /etc/passwd"

echo -e "\nc) Kullanıcı bilgilerini değiştirme:"
echo "sudo usermod -c \"Yeni Test Kullanıcı\" $TEST_KULLANICI"
echo "sudo usermod -s /bin/bash $TEST_KULLANICI"

# 2. Grup Yönetimi
echo -e "\n${YESIL}2. Grup Yönetimi Alıştırmaları${NORMAL}"

echo "a) Yeni grup oluşturma:"
echo "sudo groupadd $TEST_GRUP"
echo "sudo groupadd $PROJE_GRUP"

echo -e "\nb) Kullanıcıyı gruba ekleme:"
echo "sudo usermod -aG $TEST_GRUP $TEST_KULLANICI"
echo "sudo usermod -aG $PROJE_GRUP $TEST_KULLANICI"

echo -e "\nc) Grup üyeliklerini kontrol etme:"
echo "groups $TEST_KULLANICI"
echo "getent group $TEST_GRUP"

# 3. Sudo Yetkileri
echo -e "\n${YESIL}3. Sudo Yetkileri Alıştırmaları${NORMAL}"

echo "a) Sudo yetkisi verme:"
echo "sudo usermod -aG sudo $TEST_KULLANICI"

echo -e "\nb) Sudoers dosyasına özel kural ekleme:"
echo "echo \"$TEST_KULLANICI ALL=(ALL:ALL) ALL\" | sudo EDITOR='tee -a' visudo"

echo -e "\nc) Sudo log kontrolü:"
echo "sudo grep sudo /var/log/auth.log | tail"

# 4. Proje Ortamı Oluşturma
echo -e "\n${YESIL}4. Proje Ortamı Oluşturma${NORMAL}"

echo "a) Proje dizini oluşturma:"
echo "sudo mkdir -p /projeler/test_proje"
echo "sudo chown :$PROJE_GRUP /projeler/test_proje"
echo "sudo chmod 2775 /projeler/test_proje"

echo -e "\nb) Proje dizini izinlerini kontrol etme:"
echo "ls -l /projeler/"
echo "getfacl /projeler/test_proje"

# 5. Güvenlik Ayarları
echo -e "\n${YESIL}5. Güvenlik Ayarları${NORMAL}"

echo "a) Şifre politikası uygulama:"
echo "sudo chage -M 90 -m 7 -W 7 $TEST_KULLANICI"

echo -e "\nb) Şifre durumunu kontrol etme:"
echo "sudo chage -l $TEST_KULLANICI"

echo -e "\nc) Hesap kilitleme/açma:"
echo "sudo usermod -L $TEST_KULLANICI    # Kilitle"
echo "sudo usermod -U $TEST_KULLANICI    # Kilidi aç"

# Temizlik İşlemleri
echo -e "\n${KIRMIZI}Temizlik İşlemleri:${NORMAL}"
echo "# Kullanıcıyı silme:"
echo "sudo userdel -r $TEST_KULLANICI"
echo "# Grupları silme:"
echo "sudo groupdel $TEST_GRUP"
echo "sudo groupdel $PROJE_GRUP"
echo "# Proje dizinini silme:"
echo "sudo rm -rf /projeler/test_proje"

# Önemli Notlar
echo -e "\n${MAVI}Önemli Notlar:${NORMAL}"
echo "1. Bu komutları çalıştırmadan önce sisteminizdeki mevcut kullanıcı ve grup adlarını kontrol edin"
echo "2. Sudo yetkilerini verirken dikkatli olun"
echo "3. Şifre politikalarını kurumunuzun gereksinimlerine göre ayarlayın"
echo "4. Dizin izinlerini projenizin ihtiyaçlarına göre düzenleyin"
echo "5. Temizlik işlemlerini dikkatli uygulayın"

echo -e "\n${MAVI}Alıştırma tamamlandı!${NORMAL}" 