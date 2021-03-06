#!/bin/bash
apt-get update
apt-get -y install unzip libapache2-mod-php5 git build-essential wget build-essential libpcre3 libpcre3-dev libssl-dev php5-cli
cd /usr/local/src
wget http://nginx.org/download/nginx-1.7.7.tar.gz
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
tar -zxvf nginx-1.7.7.tar.gz
unzip master.zip
cd nginx-1.7.7
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
make
make install
wget -O cfgpatch.txt 'http://quinnebert.net/oss/setuputils/nginx-http-port-autoswap.php.txt'
cat cfgpatch.txt | php
echo 'rtmp {
  server {
    listen 1935;
    chunk_size 4096;
    application live {
      live on;
      record all;
      record_path /tmp/av;
      record_unique on;
    }
    application play {
      play /tmp/av;
    }
  }
}' >> '/usr/local/nginx/conf/nginx.conf'
/usr/local/nginx/sbin/nginx
mkdir -p /tmp/av
chmod 0777 /tmp/av
rm -f /var/www/html/index.html
echo '<?php header("Location: /oss/");' > /var/www/html/index.php
cd /var/www/html
git clone 'https://github.com/QuinnEbert/OpenStreamSystem.git' 'oss'