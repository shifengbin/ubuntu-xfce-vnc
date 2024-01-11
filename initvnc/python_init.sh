#!/bin/sh

mkdir -p /root/.pip

cat > /root/.pip/pip.conf << EOF
[global]
trusted-host =  mirrors.aliyun.com
index-url = http://mirrors.aliyun.com/pypi/simple
EOF

add-apt-repository -y ppa:deadsnakes/ppa 
apt update
apt-get install -y python3.12 python3-pip

#更新python3版本
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12  1

#安装websockify 需要的包
# apt install -y python3-jwcrypto python3-redis python3-async-timeout python3-websockify