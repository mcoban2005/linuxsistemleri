# Hafta 9: Sistem Yönetimi ve İzleme

## İçerik
1. Sistem Kaynakları ve İzleme
2. Süreç (Process) Yönetimi
3. Servis Yönetimi
4. Log Yönetimi

## 1. Sistem Kaynakları ve İzleme

### Sistem Bilgileri
\`\`\`bash
# Sistem bilgileri
uname -a           # Kernel ve sistem bilgisi
lsb_release -a     # Dağıtım bilgisi
cat /etc/os-release # İşletim sistemi bilgisi

# Donanım bilgileri
lscpu              # CPU bilgisi
free -h            # Bellek kullanımı
df -h              # Disk kullanımı
lsblk              # Blok cihazları
lspci              # PCI cihazları
lsusb              # USB cihazları
\`\`\`

### Sistem İzleme
\`\`\`bash
# Sistem yükü
uptime             # Çalışma süresi ve yük
top               # Sistem izleme (interaktif)
htop              # Gelişmiş sistem izleme
vmstat            # Sanal bellek istatistikleri
iostat            # I/O istatistikleri
sar               # Sistem aktivite raporu
\`\`\`

### Ağ İzleme
\`\`\`bash
# Ağ durumu
netstat -tuln     # Açık portlar
ss -tuln          # Socket istatistikleri
iftop             # Ağ trafiği izleme
nethogs           # Süreç bazlı ağ kullanımı
tcpdump           # Ağ paketlerini yakala
\`\`\`

## 2. Süreç (Process) Yönetimi

### Süreç Listeleme ve İzleme
\`\`\`bash
# Süreç listeleme
ps aux            # Tüm süreçler
ps -ef            # Tam format
pstree            # Süreç ağacı
top              # Canlı süreç izleme

# Süreç detayları
pidof program    # Program PID'i
pgrep program    # Program PID'lerini bul
pwdx pid         # Süreç çalışma dizini
\`\`\`

### Süreç Kontrolü
\`\`\`bash
# Sinyal gönderme
kill pid         # SIGTERM sinyali
kill -9 pid      # SIGKILL sinyali
killall program  # İsme göre sonlandır
pkill program    # Desene göre sonlandır

# Öncelik yönetimi
nice -n 10 command    # Düşük öncelikle başlat
renice -n 10 pid     # Önceliği değiştir
\`\`\`

### Arka Plan İşlemleri
\`\`\`bash
# Arka plan yönetimi
command &        # Arka planda başlat
bg              # Arka plana gönder
fg              # Ön plana getir
jobs            # Arka plan işlemleri
nohup command & # Terminal kapansa bile çalış
\`\`\`

## 3. Servis Yönetimi

### Systemd Servisleri
\`\`\`bash
# Servis durumu
systemctl status servis    # Servis durumu
systemctl start servis     # Servisi başlat
systemctl stop servis      # Servisi durdur
systemctl restart servis   # Servisi yeniden başlat
systemctl enable servis    # Açılışta başlat
systemctl disable servis   # Açılışta başlatma

# Servis bilgileri
systemctl list-units --type=service  # Çalışan servisler
systemctl list-unit-files            # Tüm servisler
\`\`\`

### Servis Yapılandırması
\`\`\`bash
# Servis dosyaları
/etc/systemd/system/      # Sistem servisleri
/usr/lib/systemd/system/  # Paket servisleri

# Yapılandırma
systemctl edit servis     # Servis yapılandırması
systemctl daemon-reload   # Yapılandırmayı yenile
\`\`\`

## 4. Log Yönetimi

### Sistem Logları
\`\`\`bash
# Log dosyaları
/var/log/syslog          # Sistem logları
/var/log/auth.log        # Kimlik doğrulama
/var/log/kern.log        # Kernel logları
/var/log/dmesg          # Boot mesajları

# Log izleme
tail -f /var/log/syslog  # Canlı log izleme
less /var/log/auth.log   # Log dosyası görüntüleme
grep ERROR /var/log/*    # Hata mesajları ara
\`\`\`

### Journalctl Kullanımı
\`\`\`bash
# Journal sorgulama
journalctl              # Tüm loglar
journalctl -u servis    # Servis logları
journalctl -f           # Canlı izleme
journalctl --since today # Bugünün logları
journalctl -p err       # Hata mesajları
\`\`\`

### Log Rotasyonu
\`\`\`bash
# Logrotate yapılandırması
/etc/logrotate.conf     # Ana yapılandırma
/etc/logrotate.d/       # Servis yapılandırmaları

# Manuel rotasyon
logrotate -f /etc/logrotate.conf  # Zorla rotasyon
\`\`\`

## Pratik Örnekler

### Örnek 1: Sistem İzleme Scripti
\`\`\`bash
#!/bin/bash

echo "=== Sistem Durumu ==="
uptime
echo -e "\n=== Bellek Kullanımı ==="
free -h
echo -e "\n=== Disk Kullanımı ==="
df -h
echo -e "\n=== CPU Yükü ==="
mpstat 1 3
echo -e "\n=== En Çok Kaynak Kullanan Süreçler ==="
ps aux --sort=-%cpu | head -5
\`\`\`

### Örnek 2: Servis İzleme
\`\`\`bash
#!/bin/bash

SERVISLER="ssh apache2 mysql"

for servis in $SERVISLER; do
    echo "=== $servis Durumu ==="
    systemctl status $servis | grep Active
done
\`\`\`

### Örnek 3: Log Analizi
\`\`\`bash
#!/bin/bash

LOG_DOSYASI="/var/log/auth.log"
echo "Son 1 saatteki başarısız giriş denemeleri:"
grep "Failed password" $LOG_DOSYASI | tail -n 20

echo -e "\nEn çok giriş denemesi yapan IP'ler:"
grep "Failed password" $LOG_DOSYASI | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | head -5
\`\`\`

## Alıştırmalar

1. Sistem İzleme:
   - Sistem kaynaklarını izleyen bir script yazın
   - Belirli bir eşik değerini aşan kaynakları raporlayın
   - Düzenli aralıklarla çalışacak şekilde ayarlayın

2. Süreç Yönetimi:
   - Belirli bir sürecin kaynak kullanımını izleyin
   - Yüksek CPU kullanan süreçleri tespit edin
   - Zombie süreçleri bulun ve temizleyin

3. Servis Yönetimi:
   - Özel bir systemd servisi oluşturun
   - Servis durumunu kontrol eden script yazın
   - Servis loglarını analiz edin

4. Log Analizi:
   - Belirli bir hatayı loglardan ayıklayın
   - Log dosyalarından istatistik çıkarın
   - Şüpheli aktiviteleri tespit edin

## Önemli İpuçları
- Sistem kaynaklarını izlerken performans etkisine dikkat edin
- Kritik servisleri durdurmadan önce dikkatli olun
- Log dosyalarını düzenli olarak yedekleyin
- Güvenlik loglarını düzenli kontrol edin
- Otomasyon scriptlerini test ortamında deneyin

## Kaynaklar
- [Linux System Monitoring Tools](https://www.tecmint.com/linux-performance-monitoring-tools/)
- [Systemd Documentation](https://www.freedesktop.org/software/systemd/man/)
- [Linux Logging Guide](https://www.loggly.com/ultimate-guide/linux-logging-basics/)
- [Process Management in Linux](https://www.thegeekstuff.com/2012/03/linux-processes-environment/) 