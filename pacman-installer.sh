#!/bin/bash
title="Pacman inatall script"
echo -e '\033]2;'$title'\007'
printf "\033c"
if [ $(whoami) == "root" ]
then echo "Pacman inatall script v2"
else echo -e "\033[31mERROR:\033[0m Please run this script as root，are you root?" & exit
fi

version=2022.01.01

filename="archlinux-bootstrap-"$version"-x86_64.tar.gz"
download="http://mirror.rackspace.com/archlinux/iso/"$version"/"$filename
echo "rootfs :"$filename
echo "download form :"$download
echo "Please wait"
wget $download 2>log.txt || curl -O $download 2.log.txt || echo -e "\033[31mERROR:\033[0m Please make sure wget is installed!"
rm -f ./log.txt 2>/dev/null
touch ./log.txt
tar -xvf ./pacman/ "./"$filename 2>./log.txt
echo "Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch">./pacman/root.x86_64/etc/pacman.d/archlinuxcn-mirrorlist
cp -r ./pacman/root.x86_64/etc/pacman.d/ /etc/pacman.d/ 2>>./log.txt

dir=/.pacman

mv ./pacman/root.x86_64/ $dir 2>>./log.txt
rm -r ./pacman/ 2>/dev/null
wget https://raw.githubusercontent.com/LGY07/pacman-installer/main/pacman.conf 2>>./log.txt || curl -O https://raw.githubusercontent.com/LGY07/pacman-installer/main/pacman.conf 2>>./log.txt
mv ./pacman.conf /etc/pacman.conf 2>>./log.txt
echo "[archlinuxcn]">>$dir"/etc/pacman.conf"
echo "SigLevel = Optional TrustAll">>$dir"/etc/pacman.conf"
echo "Include = /etc/pacman.d/archlinuxcn-mirrorlist">>$dir"/etc/pacman.conf"
ln -sf $dir"/usr/bin/pacman" /usr/bin/t-pacman 2>>./log.txt

echo -e "\033[32mFinish\033[0m ,the number of errors that occurred is:"
wc -l ./log.txt
$dir"/usr/bin/pacman-key" --init
pacman -Syyu && echo -e "\033[32mSuccess\033[0m \033[33m use \033[0m "$dir"\033[33m/usr/bin[Software Name] to run the Software was installed by Pacman.\033[0m"