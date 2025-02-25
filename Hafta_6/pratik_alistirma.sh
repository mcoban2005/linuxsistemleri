#!/bin/bash

# Renk kodları
KIRMIZI='\033[0;31m'
YESIL='\033[0;32m'
MAVI='\033[0;34m'
NORMAL='\033[0m'

echo -e "${MAVI}Metin Editörleri Alıştırmaları${NORMAL}"
echo "--------------------------------"

# Çalışma dizini oluşturma
CALISMA_DIZINI=~/editor_pratik
echo -e "${YESIL}1. Çalışma dizini oluşturuluyor...${NORMAL}"
mkdir -p $CALISMA_DIZINI
cd $CALISMA_DIZINI

# Vim alıştırmaları için örnek dosya
echo -e "${YESIL}2. Vim Alıştırmaları${NORMAL}"
echo "a) vim_pratik.txt dosyasını oluşturun ve düzenleyin:"
echo "vim vim_pratik.txt"
echo "İçeriğe şunları ekleyin:"
echo "1. Bu bir test dosyasıdır"
echo "2. Vim ile düzenleme yapıyoruz"
echo "3. Bu satırı değiştireceğiz"
echo "4. Bu satırı sileceğiz"
echo "5. Bu satırın sonuna ekleme yapacağız"

echo -e "\nb) Temel Vim komutları:"
echo "- i tuşu ile düzenleme moduna geçin"
echo "- ESC tuşu ile normal moda dönün"
echo "- :w ile kaydedin"
echo "- :q ile çıkın"

echo -e "\nc) Düzenleme alıştırmaları:"
echo "1. 3. satırı değiştirin (dd ve i kullanarak)"
echo "2. 4. satırı silin (dd kullanarak)"
echo "3. 5. satırın sonuna ekleme yapın (A kullanarak)"
echo "4. Yeni bir satır ekleyin (o kullanarak)"
echo "5. Tüm değişiklikleri kaydedin (:wq)"

# Nano alıştırmaları için örnek dosya
echo -e "\n${YESIL}3. Nano Alıştırmaları${NORMAL}"
echo "a) nano_pratik.txt dosyasını oluşturun:"
echo "nano nano_pratik.txt"

# Örnek yapılandırma dosyaları
echo -e "\n${YESIL}4. Yapılandırma Dosyası Örnekleri${NORMAL}"

# .vimrc örneği
echo 'syntax on
set number
set autoindent
set tabstop=4
set expandtab
set hlsearch' > vimrc_ornek

# .nanorc örneği
echo 'set linenumbers
set autoindent
set tabsize 4
set mouse
set smooth' > nanorc_ornek

echo "a) Vim yapılandırması (.vimrc):"
cat vimrc_ornek

echo -e "\nb) Nano yapılandırması (.nanorc):"
cat nanorc_ornek

# Pratik alıştırmalar
echo -e "\n${YESIL}5. Pratik Alıştırmalar${NORMAL}"

echo "1. Vim ile metin düzenleme:"
echo "   vim pratik1.txt"
echo "   - Metin ekleyin"
echo "   - Metni düzenleyin"
echo "   - Kaydedin ve çıkın"

echo -e "\n2. Nano ile yapılandırma düzenleme:"
echo "   nano pratik2.txt"
echo "   - Metin ekleyin"
echo "   - Ctrl+O ile kaydedin"
echo "   - Ctrl+X ile çıkın"

echo -e "\n3. Vim kopyala/yapıştır:"
echo "   vim pratik3.txt"
echo "   - Birkaç satır yazın"
echo "   - yy ile satır kopyalayın"
echo "   - p ile yapıştırın"

echo -e "\n4. Nano arama/değiştirme:"
echo "   nano pratik4.txt"
echo "   - Metin ekleyin"
echo "   - Ctrl+W ile arama yapın"
echo "   - Ctrl+\ ile değiştirme yapın"

# Yapılandırma dosyalarını kopyalama
echo -e "\n${YESIL}6. Yapılandırma Dosyalarını Yükleme${NORMAL}"
echo "Vim yapılandırmasını yüklemek için:"
echo "cp vimrc_ornek ~/.vimrc"

echo -e "\nNano yapılandırmasını yüklemek için:"
echo "cp nanorc_ornek ~/.nanorc"

# Temizlik
echo -e "\n${KIRMIZI}Temizlik İşlemleri:${NORMAL}"
echo "# Çalışma dizinini temizlemek için:"
echo "rm -rf $CALISMA_DIZINI"

# Önemli notlar
echo -e "\n${MAVI}Önemli Notlar:${NORMAL}"
echo "1. Vim'den çıkmak için önce ESC'ye basın, sonra :q! veya :wq kullanın"
echo "2. Nano'da alt menüdeki komutları takip edin"
echo "3. Yapılandırma dosyalarını değiştirmeden önce yedek alın"
echo "4. Düzenli kaydetme alışkanlığı edinin"

echo -e "\n${MAVI}Alıştırma tamamlandı!${NORMAL}" 