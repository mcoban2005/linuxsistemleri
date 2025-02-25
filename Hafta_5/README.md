# Hafta 5: Kullanıcı ve Grup Yönetimi

## İçerik
1. Kullanıcı Hesapları Oluşturma ve Yönetimi
2. Grup Yönetimi
3. Sudo ve Yönetici Yetkileri
4. Kullanıcı Kimlik Doğrulama ve Güvenlik

## 1. Kullanıcı Hesapları Yönetimi

### Kullanıcı Oluşturma
\`\`\`bash
# Yeni kullanıcı oluşturma
sudo useradd kullanici_adi
sudo useradd -m -s /bin/bash kullanici_adi  # Ana dizin ve kabuk ile

# Kullanıcı şifresi belirleme
sudo passwd kullanici_adi

# Kullanıcı bilgileri ile oluşturma
sudo useradd -m -s /bin/bash -c "Tam Ad" kullanici_adi
\`\`\`

### Kullanıcı Değiştirme
\`\`\`bash
# Kullanıcı bilgilerini değiştirme
sudo usermod -c "Yeni Tam Ad" kullanici_adi
sudo usermod -s /bin/bash kullanici_adi     # Kabuk değiştirme
sudo usermod -L kullanici_adi               # Hesabı kilitle
sudo usermod -U kullanici_adi               # Kilit kaldır

# Kullanıcı ana dizini değiştirme
sudo usermod -d /yeni/dizin kullanici_adi
\`\`\`

### Kullanıcı Silme
\`\`\`bash
sudo userdel kullanici_adi          # Kullanıcıyı sil
sudo userdel -r kullanici_adi       # Kullanıcı ve ana dizini sil
\`\`\`

## 2. Grup Yönetimi

### Grup Oluşturma ve Silme
\`\`\`bash
# Grup oluşturma
sudo groupadd grup_adi

# Grup silme
sudo groupdel grup_adi

# Grup değiştirme
sudo groupmod -n yeni_ad eski_ad
\`\`\`

### Grup Üyeliği
\`\`\`bash
# Kullanıcıyı gruba ekleme
sudo usermod -aG grup_adi kullanici_adi
sudo gpasswd -a kullanici_adi grup_adi

# Kullanıcıyı gruptan çıkarma
sudo gpasswd -d kullanici_adi grup_adi

# Kullanıcının gruplarını görüntüleme
groups kullanici_adi
id kullanici_adi
\`\`\`

## 3. Sudo ve Yönetici Yetkileri

### Sudo Yapılandırması
\`\`\`bash
# sudoers dosyasını düzenleme
sudo visudo

# Örnek sudo kuralları
kullanici_adi ALL=(ALL:ALL) ALL
kullanici_adi ALL=(ALL:ALL) NOPASSWD: ALL
%grup_adi ALL=(ALL:ALL) ALL
\`\`\`

### Sudo Kullanımı
\`\`\`bash
# Komut çalıştırma
sudo komut
sudo -u kullanici komut    # Başka kullanıcı olarak
sudo -i                    # Root kabuğu
sudo -s                    # Root kabuğu (mevcut dizinde)
\`\`\`

## 4. Kullanıcı Kimlik Doğrulama

### Şifre Politikaları
\`\`\`bash
# Şifre yaşı ayarları
sudo chage -M 90 kullanici_adi    # Maksimum şifre yaşı
sudo chage -m 7 kullanici_adi     # Minimum şifre yaşı
sudo chage -W 7 kullanici_adi     # Uyarı süresi

# Şifre durumu görüntüleme
sudo chage -l kullanici_adi
\`\`\`

### PAM (Pluggable Authentication Modules)
\`\`\`bash
# PAM yapılandırma dosyaları
/etc/pam.d/
/etc/security/

# Örnek PAM kuralı
auth required pam_unix.so
\`\`\`

## Pratik Örnekler

### Örnek 1: Yeni Kullanıcı Oluşturma
\`\`\`bash
# Geliştirici kullanıcısı oluşturma
sudo useradd -m -s /bin/bash -c "Geliştirici Hesabı" developer
sudo passwd developer
sudo usermod -aG sudo developer

# Kullanıcı bilgilerini kontrol etme
id developer
groups developer
\`\`\`

### Örnek 2: Proje Grubu Oluşturma
\`\`\`bash
# Proje grubu oluşturma ve kullanıcı ekleme
sudo groupadd proje_grubu
sudo usermod -aG proje_grubu kullanici1
sudo usermod -aG proje_grubu kullanici2

# Proje dizini oluşturma ve izinleri ayarlama
sudo mkdir /proje
sudo chown :proje_grubu /proje
sudo chmod 2775 /proje
\`\`\`

### Örnek 3: Güvenlik Ayarları
\`\`\`bash
# Şifre politikası uygulama
sudo chage -M 90 -m 7 -W 7 kullanici_adi

# Hesap kilitleme/açma
sudo usermod -L kullanici_adi    # Kilitle
sudo usermod -U kullanici_adi    # Kilidi aç
\`\`\`

## Alıştırmalar

1. Kullanıcı Yönetimi:
   - Yeni bir kullanıcı oluşturun
   - Kullanıcıya şifre atayın
   - Kullanıcı bilgilerini değiştirin
   - Kullanıcıyı silin

2. Grup Yönetimi:
   - Yeni bir grup oluşturun
   - Gruba kullanıcılar ekleyin
   - Grup izinlerini düzenleyin
   - Grup üyeliklerini kontrol edin

3. Sudo Yetkileri:
   - Kullanıcıya sudo yetkisi verin
   - Özel sudo kuralları oluşturun
   - Sudo log kayıtlarını inceleyin

## Önemli İpuçları
- Root şifresini güvenli tutun
- Kullanıcı izinlerini minimum gereksinim prensibiyle verin
- Düzenli olarak kullanıcı ve grup üyeliklerini gözden geçirin
- Şifre politikalarını uygulayın
- Sudo yetkilerini dikkatli dağıtın

## Kaynaklar
- [Ubuntu User Management](https://help.ubuntu.com/community/AddUsersHowto)
- [Sudo Manual](https://www.sudo.ws/man/sudo.man.html)
- [Linux PAM Documentation](http://www.linux-pam.org/Linux-PAM-html/) 