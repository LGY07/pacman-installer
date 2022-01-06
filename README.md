<!-- # Pacman Install Script
在任意Linux发行版安装ArchLinux的pacman软件包管理器

主要针对apt用户，dnf用户可以直接
`$sudo dnf installer pacman`

pacman-installer使用方法：

`$su -`

`#git clone https://github.com/LGY07/pacman-installer.git`

`#cd ./pacman-installer/`

`#chmod +x ./pacman-installer.sh`

`#./pacman-installer.sh`

[方法2：也可以从这里下载，添加执行权限后运行pacman-installer.sh](https://github.com/LGY07/pacman-installer/releases)

### 更新可能不及时，下载速度可能慢，可以手动更改一些内容:

1.version=[[这里可以更改为****.**.**格式的日期(需要镜像站有的)](http://mirror.rackspace.com/archlinux/iso/)]

2.dir=[这里可以手动指定Pacman的根目录，注意不要在后面加上/]

3."http://mirror.rackspace.com/archlinux/iso/" 可以手动更改到速度较快的镜像 站的"/archlinux/iso/"目录
-->

# Pacman-installer
The automantic installer which gets a working Arch Linux rootfs on any Linux distribution.

## Installation
Note: you need a working `wget` or `curl` binary **installed in your** `$PATH` to get this script to work
<br />
Just simply download <a href="https://github.com/LGY07/pacman-installer/raw/main/pacman-installer.sh">the script</a> and run it with bash:
```bash
bash ./pacman-installer.sh
```

## Usage
The script is improved with <b><i>very</i> powerful</b> custom support.
By changing the environment variables, you can install the rootfs with your own customization.

| Variable | Note | Usage | Default |
|----------|------|-------|---------|
| `$CURL`  | Use `curl` even though `wget` is installed | `true` | none |
| `$INSTALL_DIRECTORY` | The directory the rootfs will be installed in | a directory without following `/`, shouldn't include `.` | `/archlinux` |
| `$RELEASE_DATE` | The date which the rootfs released | `xxxx.xx.xx` |`latest` |
| `$MIRROR_SITE` | The site rootfs will be downloaded from | a <b>web</b> link to the root of an arch linux mirror site | `https://america.mirror.pkgbuild.com` |

Note: if `$INSTALL_DIRECTORY` is not set, you aren't able to run the script unless you're root. If set, it have to be an <b><i>existing</i> directory</b>
