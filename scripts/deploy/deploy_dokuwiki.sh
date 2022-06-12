#! /bin/bash
## 作用
# 在 Centos 8 的 dokuwiki 服务的部署脚本(php7.4 + nginx)
## 参数介绍
#   - 第一个参数是 dokuwiki 压缩包的下载地址;
#   - 第二个参数是证书与服务使用的域名或 ip (如果不填默认使用本机的 ipv4 的 ip);

# install php 7.4
yum -y install epel-release
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-8.rpm
dnf -y update
dnf -y install dnf-utils
dnf -y module enable php:remi-7.4
dnf -y install php

# install nginx 
cat>"/etc/yum.repos.d/nginx.repo"<<EOF
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/\$releasever/\$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
EOF
dnf -y install nginx

# install dokuwiki
wget $1
tar zxvf dokuwiki*.tgz -C /var/www/html
chown -R nginx /var/www/html
chgrp -R nginx /var/www/html

dokuwiki_config=/etc/nginx/conf.d/dokuwiki.conf
local_ip={$2:-`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`}
php_sock=/var/run/php-fpm/php-fpm.sock

## Self-signed certificate
mkdir /etc/nginx/ssl && cd /etc/nginx/ssl 
openssl genrsa -des3 -passout pass:123456 -out privkey.pass.key 2048
openssl rsa -in privkey.pass.key -out privkey.key -passin pass:123456
openssl req -new -key privkey.key -out fullchain.csr -subj "/C=CN/ST=Guangdong/L=Guangzhou/O=xdevops/OU=xdevops/CN=$local_ip"
openssl x509 -req -days 365 -in fullchain.csr -signkey privkey.key -out fullchain.crt

cat>"${dokuwiki_config}"<<EOF
server {
    listen 443 ssl;
    server_name $local_ip;
    root /var/www/html/dokuwiki;
    index index.html index.php doku.php;

    access_log /var/log/nginx/dokuwiki.access.log;
    error_log /var/log/nginx/dokuwiki.error.log;

    ssl on;
    ssl_certificate /etc/nginx/ssl/fullchain.crt;
    ssl_certificate_key /etc/nginx/ssl/privkey.key;
    ssl_session_timeout 5m;
    ssl_ciphers 'AES128+EECDH:AES128+EDH:!aNULL';
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_prefer_server_ciphers on;

    location / {
        try_files \$uri \$uri/ @dokuwiki;
    }

    location @dokuwiki {
        rewrite ^/_media/(.*) /lib/exe/fetch.php?media=\$1 last;
        rewrite ^/_detail/(.*) /lib/exe/detail.php?media=\$1 last;
        rewrite ^/_export/([^/]+)/(.*) /doku.php?do=export_\$1&id=\$2 last;
        rewrite ^/(.*) /doku.php?id=\$1 last;
    }

    location ~ /(data|conf|bin|inc)/ {
        deny all;
    }

    location ~* \.(css|js|gif|jpe?g|png)\$ {
        expires 1M;
        add_header Pragma public;
        add_header Cache-Control "public, must-revalidate, proxy-revalidate";
    }

    location ~ \.php\$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)\$;
        fastcgi_pass unix:$php_sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
    }

    location ~ /\.ht {
        deny all;
    }
}

server {
    listen 80;
    server_name $local_ip;
    add_header Strict-Transport-Security max-age=2592000;
    rewrite ^ https://$local_ip\$request_uri? permanent;
}
EOF

# modify /etc/php-fpm.d/www.conf file
sed -i "/user = apache/cuser = nginx" /etc/php-fpm.d/www.conf
sed -i "/group = apache/cgroup = nginx" /etc/php-fpm.d/www.conf
sed -i "/listen = \/run\/php-fpm\/www.sock/clisten = $php_sock" /etc/php-fpm.d/www.conf
sed -i "/;listen.owner = nobody/clisten.owner = nginx" /etc/php-fpm.d/www.conf
sed -i "/;listen.group = nobody/clisten.group = nginx" /etc/php-fpm.d/www.conf
sed -i "/;listen.mode = 0660/clisten.mode = 0660" /etc/php-fpm.d/www.conf

systemctl start php-fpm nginx
systemctl enable php-fpm

firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload  

# Permanently close SELinux
sed -i "/SELINUX=enforcing/cSELINUX=disabled" /etc/sysconfig/selinux
setenforce 0
