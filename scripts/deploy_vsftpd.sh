#! /bin/bash
# 功能
# 使用 vsftpd 部署 ftp 功能。  
## 参数介绍
#   - 第一参数是要创建的新用户，默认为 vsftpd
#   - 第二个参数是新用户的密码，默认为 123456

user={$1:-"vsftpd"}
passwd={$2:-"123456"}

yum -y install vsftpd*

sed -i "/anonymous_enable=/canonymous_enable=NO" /etc/vsftpd/vsftpd.conf
sed -i "/chroot_local_user=/cchroot_local_user=YES" /etc/vsftpd/vsftpd.conf
sed -i "/listen=/clisten=YES" /etc/vsftpd/vsftpd.conf
sed -i "/listen_ipv6=/clisten_ipv6=NO" /etc/vsftpd/vsftpd.conf
echo 'allow_writeable_chroot=YES' >> /etc/vsftpd/vsftpd.conf

useradd $user
echo $passwd | passwd vsftpd --stdin

setsebool allow_ftpd_full_access on

systemctl restart vsftpd
