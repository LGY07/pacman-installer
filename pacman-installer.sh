#!/usr/bin/env bash
RELEASE_DATE=2022.01.01
INSTALL_DIRECTORY=/.pacman
DOWNLOAD_FILENAME="archlinux-bootstrap-"$RELEASE_DATE"-x86_64.tar.gz"
DOWNLOAD_LINK="http://mirror.rackspace.com/archlinux/iso/"$RELEASE_DATE"/"$DOWNLOAD_FILENAME
printf "\033c"
if [ $(whoami) == "root" ]
then echo "Pacman inatall script v2"
else echo -e "\033[31mERROR:\033[0m Please run this script as root，are you root?" & exit
fi

echo "rootfs :"$DOWNLOAD_FILENAME
echo "download form :"$DOWNLOAD_LINK
echo "Please wait"
wget $DOWNLOAD_LINK || curl -O $DOWNLOAD_LINK || echo -e "\033[31mERROR:\033[0m Please make sure wget is installed!"
rm -f ./log.txt 2>/dev/null
touch ./log.txt
tar -xvf "./"$DOWNLOAD_FILENAME 2>./log.txt
cp -r ./root.x86_64/etc/pacman.d/ /etc/pacman.d/ 2>>./log.txt
echo "Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch">./pacman/root.x86_64/etc/pacman.d/archlinuxcn-mirrorlist
wget https://huashijituan.coding.net/p/liuzhierzhong/d/liuzhierzhong/git/raw/master/pacman.conf || curl -O https://huashijituan.coding.net/p/liuzhierzhong/d/liuzhierzhong/git/raw/master/pacman.conf 2>>./log.txt
mv ./pacman.conf /etc/pacman.conf 2>>./log.txt
mv ./root.x86_64/ $INSTALL_DIRECTORY 2>>./log.txt
echo "[archlinuxcn]">>$INSTALL_DIRECTORY"/etc/pacman.conf"
echo "SigLevel = Optional TrustAll">>$INSTALL_DIRECTORY"/etc/pacman.conf"
echo "Include = /etc/pacman.d/archlinuxcn-mirrorlist">>$INSTALL_DIRECTORY"/etc/pacman.conf"
ln -sf $INSTALL_DIRECTORY"/usr/bin/pacman" /usr/bin/t-pacman 2>>./log.txt

echo -e "\033[32mFinish\033[0m ,the number of lines in the log file:"
wc -l ./log.txt
$INSTALL_DIRECTORY"/usr/bin/pacman-key" --init
pacman -Syyu && echo -e "\033[32mSuccess\033[0m \033[33m use \033[0m "$INSTALL_DIRECTORY"\033[33m/usr/bin[Software Name] to run the Software was installed by Pacman.\033[0m"

