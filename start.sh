#!/bin/sh


# 设置vncserver密码，你可以将这行修改成你喜欢的密码
mkdir -p /root/.vnc
echo  ${VNC_PASSWORD} | vncpasswd -f > /root/.vnc/passwd

# 设置权限
chmod 600 /root/.vnc/passwd

# 配置TigerVNC以使用Xfce 
echo "#!/bin/sh\n"\
"unset SESSION_MANAGER\n"\
"unset DBUS_SESSION_BUS_ADDRESS\n"\
"exec startxfce4" > /root/.vnc/xstartup

chmod a+x /root/.vnc/xstartup

vncserver -geometry 1024x768 -depth 24 -localhost no

export DISPLAY=:1
xset s noblank
xset s off

./novnc/utils/novnc_proxy --vnc localhost:5901
