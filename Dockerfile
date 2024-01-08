FROM ubuntu:20.04

RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list

ENV \
    LANG='en_US.UTF-8' \
    LANGUAGE='en_US:en' \
    LC_ALL='en_US.UTF-8'


# inetutils-ping: 提供了用于在网络上发送 ICMP 回显请求（ping）的工具。
# lsb-release: 用于检查 Linux 发行版及其版本的软件包。
# net-tools: 提供了一组用于配置和监视网络的基本工具，例如 ifconfig 和 netstat。
# unzip: 用于解压缩 zip 文件。
# vim: 一个强大的文本编辑器。
# zip: 用于创建和管理 zip 文件。
# curl: 用于与服务器进行数据传输的工具。
# git: 用于版本控制和协作的分布式版本控制系统。
# wget: 用于从 Web 上下载文件的命令行工具。
# nano: 一个易于使用的文本编辑器。
# bc: 用于进行数学运算的任意精度计算器。
# mousepad: Xfce 桌面环境的文本编辑器。
# xfce4: Xfce 桌面环境的主要软件包。
# xfce4-terminal: Xfce 桌面环境的终端模拟器。
# pm-utils: 提供电源管理工具，用于控制计算机的电源状态,拆卸后可防止黑屏
# xscreensaver*: Xscreensaver相关的软件包,屏保之类的,拆卸后可防止黑屏
# software-properties-common: 提供了一些软件包的属性文件,添加软件源.

#这将设置DEBIAN_FRONTEND环境变量为"noninteractive"，告诉apt-get在安装软件包时不需要用户交互，apt-get安装过程将不会等待任何用户输入参数，而是自动选择默认选项进行安装。

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    inetutils-ping \
    lsb-release \
    net-tools \
    unzip \
    vim \
    zip \
    curl \
    git \
    wget \
    nano \
    wget \
    bc \ 
    mousepad \
    locales \
    software-properties-common \
    xfce4 \
    xfce4-terminal \
    tigervnc-standalone-server \
    && apt-get purge -y \
    pm-utils \
    xscreensaver* \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python3-numpy

# RUN wget https://vscode.download.prss.microsoft.com/dbazure/download/stable/0ee08df0cf4527e40edc9aa28f4b5bd38bbff2b2/code_1.85.1-1702462158_amd64.deb

ENV VNC_PASSWORD=12345678

COPY start.sh start.sh
RUN  chmod a+x  start.sh

COPY noVNC-1.4.0 novnc

EXPOSE 5901 6080 

CMD [ "./start.sh"]

#vncserver -geometry 1024x768 -depth 24 -localhost no