# pacman-installer
在任意Linux发行版安装ArchLinux的pacman软件包管理器

主要针对apt用户，dnf用户可以直接
`$sudo dnf installer pacman`

pacman-installer使用方法：

`$su -`

`#git clone https://github.com/LGY07/pacman-installer.git`

`#chmod +x ./pacman-installer.sh`

`#./pacman-install.sh`

[从这里下载](https://github.com/LGY07/pacman-installer/releases)

### 更新可能不及时，下载速度可能慢，可以手动更改一些内容:

1.version=[[这里可以更改为用****.**.**格式的日期](http://mirror.rackspace.com/archlinux/iso/latest/)]

2.dir=[这里可以手动指定Pacman的根目录，注意不要在后面加上/]

3."http://mirror.rackspace.com/archlinux/iso/" 可以手动更改到速度较快的镜像站的"/archlinux/iso/"目录
