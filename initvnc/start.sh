#!/bin/sh

# # 设置中文环境变量
locale-gen zh_CN.UTF-8
export LANG='zh_CN.utf8' 
export LANGUAGE='zh_CN:zh' 
export LC_ALL='zh_CN.utf8'
# update-locale LANG=zh_CN.utf8

#切换用户
su - $USER

# 设置vncserver密码，你可以将这行修改成你喜欢的密码
VNC_DIR=$HOME/.vnc
mkdir -p $VNC_DIR
echo  ${VNC_PASSWORD} | vncpasswd -f > $VNC_DIR/passwd

# 设置权限
chmod 600 $VNC_DIR/passwd

# 配置TigerVNC以使用Xfce 
cat > $VNC_DIR/xstartup <<EOF
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4
EOF

chmod a+x $VNC_DIR/xstartup


vncserver -geometry $VNC_GEOMETRY -depth 24 -localhost no

# 设置不锁屏，防止vnc黑屏
export DISPLAY=:1
xset s noblank
xset s off

# 重启桌面
# xfce4-panel -r

# ./novnc/utils/novnc_proxy --vnc localhost:5901
# websockify --web=/initvnc/novnc 6080 0.0.0.0:5901

#监控vncserver是否启动
while :
do
  output=$(vncserver -list | grep 5901)
  if [[ -n "$output" ]]; then
    sleep 1
  else
    break  # 如果结果为假，跳出循环
  fi
done