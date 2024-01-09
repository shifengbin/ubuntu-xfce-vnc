#!/bin/sh

mkdir -p /root/.pip

cat > /root/.pip/pip.conf << EOF
[global]
trusted-host =  mirrors.aliyun.com
index-url = http://mirrors.aliyun.com/pypi/simple
EOF

#安装websockify 需要的包
apt install -y python3-jwcrypto python3-redis python3-async-timeout python3-websockify