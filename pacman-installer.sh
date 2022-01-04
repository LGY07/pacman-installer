#!/usr/bin/env bash
title="Pacman inatall script"
echo -e '\033]2;'$title'\007'
printf "\033c"
if [ $(whoami) == "root" ]
then echo "Pacman inatall script v2"
else echo -e "\033[31mERROR:\033[0m Please run this script as root，are you root?" & exit
fi

#You can change here
version=2022.01.01
dir=/.pacman

filename="archlinux-bootstrap-"$version"-x86_64.tar.gz"

#You can change here
download="http://mirror.rackspace.com/archlinux/iso/"$version"/"$filename

echo "rootfs :"$filename
echo "download form :"$download
echo "Please wait"
wget $download || curl -O $download || echo -e "\033[31mERROR:\033[0m Please make sure wget is installed!"
rm -f ./log.txt 2>/dev/null
touch ./log.txt
tar -xvf "./"$filename 2>./log.txt
cp -r ./root.x86_64/etc/pacman.d/ /etc/pacman.d/ 2>>./log.txt
echo "Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch">./pacman/root.x86_64/etc/pacman.d/archlinuxcn-mirrorlist
wget https://huashijituan.coding.net/p/liuzhierzhong/d/liuzhierzhong/git/raw/master/pacman.conf || curl -O https://huashijituan.coding.net/p/liuzhierzhong/d/liuzhierzhong/git/raw/master/pacman.conf 2>>./log.txt
mv ./pacman.conf /etc/pacman.conf 2>>./log.txt
mv ./root.x86_64/ $dir 2>>./log.txt
echo "[archlinuxcn]">>$dir"/etc/pacman.conf"
echo "SigLevel = Optional TrustAll">>$dir"/etc/pacman.conf"
echo "Include = /etc/pacman.d/archlinuxcn-mirrorlist">>$dir"/etc/pacman.conf"
ln -sf $dir"/usr/bin/pacman" /usr/bin/t-pacman 2>>./log.txt

echo -e "\033[32mFinish\033[0m ,the number of lines in the log file:"
wc -l ./log.txt
$dir"/usr/bin/pacman-key" --init
pacman -Syyu && echo -e "\033[32mSuccess\033[0m \033[33m use \033[0m "$dir"\033[33m/usr/bin[Software Name] to run the Software was installed by Pacman.\033[0m"

