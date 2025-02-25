# Hafta 12: Sistem İzleme ve Performans Analizi

## İçerik
1. Sistem Kaynakları İzleme
2. Log Dosyaları ve Analizi
3. Performans İzleme Araçları
4. Sistem Optimizasyonu

## 1. Sistem Kaynakları İzleme

### Temel İzleme Komutları
```bash
# CPU ve Bellek Kullanımı
top
htop
ps aux
free -h

# Disk Kullanımı
df -h
du -sh *
iostat
iotop

# Ağ Kullanımı
netstat -tuln
ss -tuln
iftop
nethogs
```

### Sistem Bilgileri
```bash
# Donanım Bilgileri
lscpu           # CPU bilgisi
lsmem           # Bellek bilgisi
lspci           # PCI aygıtları
lsusb           # USB aygıtları
dmidecode       # Detaylı donanım bilgisi

# Sistem Bilgileri
uname -a        # Kernel bilgisi
cat /proc/cpuinfo   # CPU detayları
cat /proc/meminfo   # Bellek detayları
uptime          # Çalışma süresi
```

## 2. Log Dosyaları ve Analizi

### Önemli Log Dosyaları
```bash
# Sistem Logları
/var/log/syslog      # Genel sistem logları
/var/log/auth.log    # Kimlik doğrulama logları
/var/log/kern.log    # Kernel logları
/var/log/dmesg       # Boot logları

# Servis Logları
/var/log/apache2/    # Apache web sunucu logları
/var/log/mysql/      # MySQL veritabanı logları
/var/log/nginx/      # Nginx web sunucu logları
```

### Log Analiz Araçları
```bash
# Log İzleme
tail -f /var/log/syslog
less /var/log/auth.log

# Log Analizi
grep "error" /var/log/syslog
awk '/Failed password/ {print $1,$2}' /var/log/auth.log
sed -n '/Jan 1/,/Jan 31/p' /var/log/syslog
```

## 3. Performans İzleme Araçları

### CPU ve Bellek İzleme
```bash
# CPU Profili
mpstat 1          # CPU istatistikleri
sar -u 1 10       # CPU kullanım raporu
perf top          # CPU performans analizi

# Bellek Profili
vmstat 1          # Sanal bellek istatistikleri
sar -r 1 10       # Bellek kullanım raporu
slabtop          # Kernel bellek kullanımı
```

### Disk ve I/O İzleme
```bash
# Disk Performansı
iostat -x 1       # Disk I/O istatistikleri
iotop            # Disk I/O izleme
fio              # Disk performans testi

# Dosya Sistemi
inotifywait      # Dosya sistemi olaylarını izleme
lsof             # Açık dosyaları listeleme
fatrace          # Dosya erişim izleme
```

## 4. Sistem Optimizasyonu

### Sistem Ayarları
```bash
# Kernel Parametreleri
sysctl -a                    # Tüm parametreleri göster
sysctl vm.swappiness=60     # Swap kullanımını ayarla
sysctl net.core.somaxconn=1024  # Ağ bağlantı limitini ayarla

# Servis Yönetimi
systemctl list-units        # Aktif servisleri listele
systemctl disable servis    # Gereksiz servisleri devre dışı bırak
systemctl mask servis       # Servisi tamamen engelle
```

### Kaynak Limitleri
```bash
# Kullanıcı Limitleri
ulimit -a                   # Mevcut limitleri göster
ulimit -n 4096             # Açık dosya limitini ayarla

# Sistem Limitleri
/etc/security/limits.conf   # Kalıcı limitler
```

## Pratik Örnekler

### Örnek 1: Sistem İzleme Scripti
```bash
#!/bin/bash
# Sistem kaynak kullanımını izleme

echo "CPU Kullanımı:"
top -bn1 | grep "Cpu(s)" | awk '{print $2}'

echo "Bellek Kullanımı:"
free -m | grep "Mem:" | awk '{print $3/$2 * 100}'

echo "Disk Kullanımı:"
df -h / | tail -1 | awk '{print $5}'

echo "Yük Ortalaması:"
uptime | awk -F'load average:' '{print $2}'
```

### Örnek 2: Log Analiz Scripti
```bash
#!/bin/bash
# Güvenlik log analizi

echo "Son başarısız giriş denemeleri:"
grep "Failed password" /var/log/auth.log | tail -5

echo "Yüksek CPU kullanan işlemler:"
ps aux | sort -rn -k 3 | head -5

echo "Disk alanı uyarıları:"
df -h | awk '$5 > "80%" {print $0}'
```

## Alıştırmalar

1. Sistem İzleme:
   - top ve htop ile sistem kaynaklarını izleyin
   - Disk kullanımını analiz edin
   - Ağ trafiğini izleyin
   - Donanım bilgilerini toplayın

2. Log Analizi:
   - Sistem loglarını inceleyin
   - Özel log dosyaları oluşturun
   - Log rotasyonu yapılandırın
   - Log analiz scripti yazın

3. Performans Analizi:
   - CPU ve bellek profilini çıkarın
   - Disk I/O performansını ölçün
   - Ağ performansını test edin
   - Darboğaz analizi yapın

## Önemli İpuçları
- Sistem kaynaklarını düzenli olarak izleyin
- Log dosyalarını periyodik olarak analiz edin
- Performans sorunlarını proaktif olarak tespit edin
- Sistem optimizasyonunu düzenli olarak yapın
- Kritik servisleri sürekli izleyin

## Kaynaklar
- [Linux Performance](http://www.brendangregg.com/linuxperf.html)
- [System Monitoring Tools](https://www.linux.com/training-tutorials/system-monitoring-tools/)
- [Linux System Analysis](https://www.kernel.org/doc/html/latest/admin-guide/sysctl/) 