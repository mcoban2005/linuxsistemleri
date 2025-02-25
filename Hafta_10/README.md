# Hafta 10: Ağ Yönetimi ve Güvenlik

## İçerik
1. Ağ Yapılandırması
2. Ağ İzleme ve Sorun Giderme
3. Güvenlik Duvarı (Firewall)
4. Güvenlik İzleme ve Saldırı Tespiti

## 1. Ağ Yapılandırması

### Ağ Arayüzleri
\`\`\`bash
# Arayüz bilgileri
ip addr show          # IP adresleri
ifconfig             # Arayüz durumu (eski)
iwconfig             # Kablosuz arayüzler
nmcli device show    # NetworkManager bilgileri

# Arayüz yönetimi
ip link set eth0 up   # Arayüzü aç
ip link set eth0 down # Arayüzü kapat
\`\`\`

### IP Yapılandırması
\`\`\`bash
# IP ayarları
ip addr add 192.168.1.10/24 dev eth0  # IP ekle
ip addr del 192.168.1.10/24 dev eth0  # IP sil
ip route show                         # Yönlendirme tablosu
ip route add default via 192.168.1.1  # Varsayılan ağ geçidi

# DHCP
dhclient eth0        # DHCP ile IP al
dhclient -r eth0     # IP bırak
\`\`\`

### DNS Yapılandırması
\`\`\`bash
# DNS ayarları
cat /etc/resolv.conf     # DNS sunucuları
systemd-resolve --status # Systemd DNS durumu

# DNS değiştirme
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
\`\`\`

## 2. Ağ İzleme ve Sorun Giderme

### Ağ Bağlantı Testi
\`\`\`bash
# Temel testler
ping host            # ICMP echo testi
traceroute host      # Yol izleme
mtr host            # Sürekli traceroute

# Port kontrolü
nc -zv host port    # Port testi
telnet host port    # Telnet bağlantısı
\`\`\`

### Ağ İzleme
\`\`\`bash
# Bağlantı durumu
netstat -tuln       # Açık portlar
ss -tuln           # Socket durumu
lsof -i            # Açık dosyalar/portlar

# Trafik izleme
tcpdump -i eth0    # Paket yakalama
iftop             # Ağ trafiği izleme
nethogs           # Süreç bazlı trafik
\`\`\`

### Sorun Giderme
\`\`\`bash
# DNS sorunları
nslookup domain    # DNS sorgusu
dig domain        # Detaylı DNS bilgisi
host domain       # Basit DNS sorgusu

# Ağ sorunları
ethtool eth0      # Arayüz durumu
ip neighbor show  # ARP tablosu
\`\`\`

## 3. Güvenlik Duvarı (Firewall)

### UFW (Uncomplicated Firewall)
\`\`\`bash
# Temel komutlar
ufw status         # Durum kontrolü
ufw enable         # Firewall'ı etkinleştir
ufw disable        # Firewall'ı devre dışı bırak

# Kural yönetimi
ufw allow 22       # SSH portunu aç
ufw deny 80        # HTTP portunu kapat
ufw allow from 192.168.1.0/24  # Ağdan erişime izin ver
ufw delete deny 80 # Kuralı sil
\`\`\`

### iptables
\`\`\`bash
# Kural listeleme
iptables -L        # Tüm kurallar
iptables -S        # Kural formatında göster

# Kural ekleme
iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # SSH izin ver
iptables -A INPUT -p tcp --dport 80 -j DROP    # HTTP engelle

# Kural kaydetme
iptables-save > /etc/iptables/rules.v4  # Kuralları kaydet
iptables-restore < /etc/iptables/rules.v4  # Kuralları yükle
\`\`\`

## 4. Güvenlik İzleme ve Saldırı Tespiti

### Log İzleme
\`\`\`bash
# Güvenlik logları
tail -f /var/log/auth.log    # Kimlik doğrulama
tail -f /var/log/secure      # Güvenlik olayları
tail -f /var/log/fail2ban.log # Fail2ban logları

# Log analizi
grep "Failed password" /var/log/auth.log  # Başarısız girişler
grep "Invalid user" /var/log/auth.log     # Geçersiz kullanıcılar
\`\`\`

### Fail2ban
\`\`\`bash
# Durum kontrolü
fail2ban-client status         # Genel durum
fail2ban-client status sshd    # SSH durumu

# Yönetim
fail2ban-client set sshd banip 192.168.1.100    # IP engelle
fail2ban-client set sshd unbanip 192.168.1.100  # IP engeli kaldır
\`\`\`

### Rootkit Tarama
\`\`\`bash
# rkhunter
rkhunter --check              # Sistem taraması
rkhunter --update            # Veritabanı güncelleme

# chkrootkit
chkrootkit                   # Sistem taraması
\`\`\`

## Pratik Örnekler

### Örnek 1: Ağ İzleme Scripti
\`\`\`bash
#!/bin/bash

# Ağ durumu kontrolü
echo "=== Ağ Arayüzleri ==="
ip addr show

echo -e "\n=== Açık Portlar ==="
netstat -tuln

echo -e "\n=== Ağ Trafiği ==="
iftop -t -s 5 2>/dev/null

echo -e "\n=== DNS Sunucuları ==="
cat /etc/resolv.conf
\`\`\`

### Örnek 2: Güvenlik Duvarı Yapılandırması
\`\`\`bash
#!/bin/bash

# UFW temel yapılandırma
ufw reset
ufw default deny incoming
ufw default allow outgoing

# Temel servisler için kurallar
ufw allow ssh
ufw allow http
ufw allow https

# Özel kurallar
ufw allow from 192.168.1.0/24 to any port 3306
ufw deny 21

# Firewall'ı etkinleştir
ufw enable
\`\`\`

### Örnek 3: Güvenlik İzleme
\`\`\`bash
#!/bin/bash

# Son başarısız giriş denemeleri
echo "=== Başarısız Giriş Denemeleri ==="
grep "Failed password" /var/log/auth.log | tail -n 10

# Şüpheli IP'ler
echo -e "\n=== Şüpheli IP'ler ==="
grep "Invalid user" /var/log/auth.log | \
    awk '{print $(NF-3)}' | sort | uniq -c | sort -nr

# Fail2ban durumu
echo -e "\n=== Fail2ban Durumu ==="
fail2ban-client status
\`\`\`

## Alıştırmalar

1. Ağ Yapılandırması:
   - Statik IP yapılandırması yapın
   - DNS sunucularını değiştirin
   - Ağ arayüzlerini yönetin
   - NetworkManager ile kablosuz ağ yapılandırın

2. Ağ İzleme:
   - tcpdump ile paket yakalama yapın
   - Ağ trafiğini izleyin ve analiz edin
   - Port taraması yapın
   - Bağlantı sorunlarını giderin

3. Güvenlik Duvarı:
   - UFW ile temel kurallar oluşturun
   - iptables ile detaylı kurallar yazın
   - Port yönlendirme yapın
   - Güvenlik duvarı loglarını inceleyin

4. Güvenlik İzleme:
   - Fail2ban yapılandırması yapın
   - Log analizi yapın
   - Rootkit taraması yapın
   - Güvenlik raporu oluşturun

## Önemli İpuçları
- Ağ yapılandırmasını değiştirmeden önce yedek alın
- Güvenlik duvarı kurallarını test ortamında deneyin
- Uzak erişim için SSH portunu açık tutun
- Güvenlik loglarını düzenli kontrol edin
- Sistem güncellemelerini ihmal etmeyin

## Kaynaklar
- [Linux Networking Documentation](https://www.kernel.org/doc/html/latest/networking/index.html)
- [UFW Guide](https://help.ubuntu.com/community/UFW)
- [iptables Tutorial](https://www.frozentux.net/iptables-tutorial/iptables-tutorial.html)
- [Fail2ban Documentation](https://www.fail2ban.org/wiki/index.php/Main_Page) 