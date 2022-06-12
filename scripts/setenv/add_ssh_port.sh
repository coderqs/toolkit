#! /bin/bash
# 作用
# 增加一个新的 ssh 端口，并且将新的端口添加到防火墙中的 ssh 服务中。  
#
# 参数介绍
#  - 第一参数是要添加的新端口

port=${1:-0}
if [[ ${port} <= 0 ]] || [[ ${port} >= 65535 ]]; then
    echo "error: ${port} is invalid port number!"
    exit    
fi
if [[ ${port} > 0 ]] || [[ ${port} <= 1023 ]] ; then
    echo "warning: 0 - 1023 is reserved ports!"
fi 

# 设置新的 ssh 端口
sed -i "/Port 22/a\Port $port" /etc/ssh/sshd_config

# 修改防火墙服务中的端口
sed -i "/<port protocol=\"tcp\" port=\"22\"\/>/a\  <port protocol=\"tcp\" port=\"$port\"\/>" /usr/lib/firewalld/services/ssh.xml

echo "restart firewalld"
# 重启防火墙
firewall-cmd --reload
