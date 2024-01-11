#!/bin/bash

#安装sudo
apt install sudo
# 创建新用户
adduser $USER --gecos "" --disabled-password

# 设置密码
echo "$USER:$PASS" | chpasswd

# 将用户添加到sudoers组并配置免密码访问
echo "$USER ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/$USER
chmod 0440 /etc/sudoers.d/$USER