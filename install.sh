#!/bin/bash
echo "Please enter your root passwd"
su - || exit
tar -xf ./.pacman.tar.xz
mv ./.pacman/ /.pacman/
cp /.pacman/etc/pacman.conf.root /etc/pacman.conf
cp -r /.pacman/etc/pacman.d/ /.pacman/etc/pacman.d/
mkdir /.pacman/var 2>/dev/null
mkdir /.pacman/var/lib 2>/dev/null
mkdir /.pacman/var/lib/pacman 2>/dev/null
mkdir /.pacman/var/cache/pacman/pkg 2>/dev/null
mkdir /.pacman/var/log 2>/dev/null
ln -sf /.pacman/usr/bin/pacman /usr/bin/pacman
/.pacman/usr/bin/pacman-key --init
pacman -Syyu
pacman -S archlinuxcn-keyring
echo "The software will install on /.pacman/usr/bin,please use "/.pacman/usr/bin/***" to run"
echo "The software will install on /.pacman/usr/bin,please use "/.pacman/usr/bin/***" to run">./log.txt
