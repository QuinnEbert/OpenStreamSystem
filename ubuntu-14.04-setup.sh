#!/bin/bash
apt-get update
apt-get -y install git build-essential wget build-essential libpcre3 libpcre3-dev libssl-dev
cd /usr/local/src
wget http://nginx.org/download/nginx-1.7.7.tar.gz
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
tar -zxvf nginx-1.7.7.tar.gz
unzip master.zip
cd nginx-1.7.7
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
make
make install
echo 'rtmp {
        server {
                listen 1935;
                chunk_size 4096;

                application live {
                        live on;
                        record off;
                }
        }
}' >> '/usr/local/nginx/conf/nginx.conf'
/usr/local/nginx/sbin/nginx
