# !/bin/sh

# # 设置中文环境变量
# locale-gen zh_CN.UTF-8
# export LANG='zh_CN.utf8' 
# export LANGUAGE='zh_CN:zh' 
# export LC_ALL='zh_CN.utf8'
# update-locale LANG=zh_CN.utf8


# 设置vncserver密码，你可以将这行修改成你喜欢的密码
mkdir -p /root/.vnc
echo  ${VNC_PASSWORD} | vncpasswd -f > /root/.vnc/passwd

# 设置权限
chmod 600 /root/.vnc/passwd

# 配置TigerVNC以使用Xfce 
cat > /root/.vnc/xstartup <<EOF
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4
EOF

chmod a+x /root/.vnc/xstartup

vncserver -geometry $VNC_GEOMETRY -depth 24 -localhost no

# 设置不锁屏，防止vnc黑屏
export DISPLAY=:1
xset s noblank
xset s off


# ./novnc/utils/novnc_proxy --vnc localhost:5901
websockify --web=novnc 6080 0.0.0.0:5901