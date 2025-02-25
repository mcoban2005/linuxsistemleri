# Hafta 11: Ağ Yönetimi ve Güvenlik

## İçerik
1. Ağ Yapılandırması
2. Ağ İzleme ve Analiz
3. Güvenlik Duvarı (Firewall)
4. Sistem Güvenliği

## 1. Ağ Yapılandırması

### IP Yapılandırması
```bash
# IP bilgilerini görüntüleme
ip addr show
ifconfig

# IP adresi atama
sudo ip addr add 192.168.1.100/24 dev eth0
sudo ifconfig eth0 192.168.1.100 netmask 255.255.255.0

# Gateway yapılandırması
sudo ip route add default via 192.168.1.1
sudo route add default gw 192.168.1.1
```

### Network Manager
```bash
# Bağlantıları listeleme
nmcli connection show
nmcli device status

# Wi-Fi bağlantıları
nmcli device wifi list
nmcli device wifi connect SSID password PASSWORD

# Bağlantı düzenleme
nmcli connection modify CONN_NAME ipv4.addresses "192.168.1.100/24"
nmcli connection modify CONN_NAME ipv4.gateway "192.168.1.1"
```

## 2. Ağ İzleme ve Analiz

### Temel Ağ Komutları
```bash
# Ping testi
ping -c 4 google.com

# DNS sorgulama
nslookup google.com
dig google.com

# Port tarama
netstat -tuln
ss -tuln

# Ağ trafiği izleme
tcpdump -i eth0
wireshark
```

### Ağ Performans Analizi
```bash
# Bant genişliği testi
iperf3 -s                  # Sunucu modu
iperf3 -c sunucu_ip       # İstemci modu

# Ağ yolu analizi
traceroute google.com
mtr google.com
```

## 3. Güvenlik Duvarı (Firewall)

### UFW (Uncomplicated Firewall)
```bash
# UFW durumu
sudo ufw status
sudo ufw enable
sudo ufw disable

# Kural ekleme
sudo ufw allow 22                # SSH portunu aç
sudo ufw allow 80/tcp           # HTTP portunu aç
sudo ufw deny 3306              # MySQL portunu kapat
sudo ufw allow from 192.168.1.0/24  # Belirli ağdan erişime izin ver

# Kural silme
sudo ufw delete allow 80
```

### iptables
```bash
# Kuralları görüntüleme
sudo iptables -L
sudo iptables -L -v -n

# Kural ekleme
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -j DROP

# Kuralları kaydetme
sudo iptables-save > /etc/iptables/rules.v4
```

## 4. Sistem Güvenliği

### Güvenlik Güncellemeleri
```bash
# Sistem güncellemesi
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade

# Güvenlik güncellemelerini kontrol etme
sudo unattended-upgrades --dry-run
```

### SSH Güvenliği
```bash
# SSH yapılandırması
sudo nano /etc/ssh/sshd_config

# Önemli ayarlar
PermitRootLogin no
PasswordAuthentication no
AllowUsers kullanici1 kullanici2
Port 2222

# Servisi yeniden başlatma
sudo systemctl restart sshd
```

### Sistem İzleme
```bash
# Log dosyalarını izleme
tail -f /var/log/auth.log
tail -f /var/log/syslog

# Başarısız giriş denemeleri
grep "Failed password" /var/log/auth.log

# Aktif bağlantıları izleme
watch netstat -tupan
```

## Pratik Örnekler

### Örnek 1: Güvenlik Duvarı Yapılandırması
```bash
#!/bin/bash
# Temel güvenlik duvarı kuralları

# UFW'yi sıfırla
sudo ufw --force reset

# Varsayılan politikalar
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Temel servisler için kurallar
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https

# UFW'yi etkinleştir
sudo ufw enable
```

### Örnek 2: Sistem Güvenlik Kontrolü
```bash
#!/bin/bash
# Temel güvenlik kontrolü

echo "Açık portlar:"
netstat -tuln

echo "Aktif servisler:"
systemctl list-units --type=service --state=running

echo "Son başarısız giriş denemeleri:"
grep "Failed password" /var/log/auth.log | tail -5
```

## Alıştırmalar

1. Ağ Yapılandırması:
   - Statik IP adresi yapılandırın
   - DNS sunucularını değiştirin
   - Ağ bağlantısını test edin

2. Güvenlik Duvarı:
   - UFW ile temel kurallar oluşturun
   - Belirli IP adresleri için kurallar ekleyin
   - Kuralları test edin

3. Sistem Güvenliği:
   - SSH yapılandırmasını güvenli hale getirin
   - Sistem loglarını analiz edin
   - Güvenlik taraması yapın

## Önemli İpuçları
- Ağ yapılandırmasını değiştirmeden önce yedek alın
- Güvenlik duvarı kurallarını dikkatli test edin
- SSH erişimini kapatmadan önce local erişiminiz olduğundan emin olun
- Sistem loglarını düzenli kontrol edin
- Güvenlik güncellemelerini otomatik yükleyin

## Kaynaklar
- [Ubuntu Networking Guide](https://ubuntu.com/server/docs/network-configuration)
- [UFW Documentation](https://help.ubuntu.com/community/UFW)
- [Linux Security Guide](https://www.linux.com/training-tutorials/linux-security-basics/) 