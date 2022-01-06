#!/usr/bin/env bash
# RELEASE_DATE=2022.01.01
# INSTALL_DIRECTORY=/.pacman
# FILENAME="archlinux-bootstrap-"$RELEASE_DATE"-x86_64.tar.gz"
# LINK="http://mirror.rackspace.com/archlinux/iso/"$RELEASE_DATE"/"$FILENAME
# log file
LOG="/tmp/pacman-installer-${RANDOM}.log"
touch $LOG	
# necessary checks
if which wget >>/dev/null
then
	GET_CMD="wget -O"
	GETSTDOUT_CMD="wget -O-"
	# wget is better than curl
	# because wget binary has the ability to follow 301/302
elif which curl >>/dev/null
then
	GET_CMD="curl -O"
	GETSTDOUT_CMD="curl"
else 
	echo -e "\033[31m::\033[0m Please install \`curl\` or \`wget\` first!"
	exit 1
fi
# if someone has wget installed but wants to use curl
if [[ $CURL == "true" ]] ; then 
	GET_CMD="curl -O"
	GETSTDOUT_CMD="curl"
fi

if ! [ -z $RELEASE_DATE ] ; then
	if ! [ -z $MIRROR_SITE ] ; then
		FILENAME=$($GETSTDOUT_CMD $MIRROR_SITE/iso/$RELEASE_DATE/md5sums.txt | grep -Go  '\S*tar\S*$' )
		LINK=$MIRROR_SITE/iso/$RELEASE_DATE/$FILENAME
	else
		MIRROR_SITE="https://america.mirror.pkgbuild.com"#Global rackspace.com mirror seems to be down
		FILENAME=$($GETSTDOUT_CMD $MIRROR_SITE/iso/$RELEASE_DATE/md5sums.txt | grep -Go  '\S*tar\S*$')
		LINK=$MIRROR_SITE/iso/$RELEASE_DATE/$FILENAME
	fi
else
		RELEASE_DATE="latest"
		MIRROR_SITE="https://america.mirror.pkgbuild.com"
		FILENAME=$($GETSTDOUT_CMD $MIRROR_SITE/iso/$RELEASE_DATE/md5sums.txt | grep -Go  '\S*tar\S*$')
		LINK=$MIRROR_SITE/iso/$FILENAME
fi
# We'd better get the filename from the cloud
if ! [ -z $INSTALL_DIRECTORY ] 
then
	INSTALL_DIRECTORY="/.pacman"
	if [ $(id -u) -ne 0 ] ; then
		echo -e "\033[31m::\033[0m Please run this script as root or set \$INSTALL_DIRECTORY environment variable to a directory you can write into"
		exit 1
	fi
else
	if ! [ -w $INSTALL_DIRECTORY ] && [ -d $INSTALL_DIRECTORY ] ; then
		echo -e "\033[31m::\033[0m Please run this script as root or set \$INSTALL_DIRECTORY environment variable to a directory you can write into"
		exit 1
	fi
fi


echo -e "\033[34mUrsus's Pacman installer v\033[36m3\033[0m"
echo -e "\033[32m::\033[0m Bootstrap filename: $FILENAME" | tee -a $LOG
echo -e "\033[32m::\033[0m Download link: $LINK" | tee -a $LOG
echo -e "\033[32m::\033[0m Getting file from cloud..."
echo -e "  \033[34m>>\033[0m $GET_CMD /tmp/$FILENAME $LINK" | tee -a $LOG
$GET_CMD /tmp/$FILENAME $LINK 2>&1 | tee -a $LOG
echo -e "\033[32m::\033[0m Excrating file to /tmp/..."
if [ -d /tmp/pacman-installer ] || [ -a /tmp/pacman-installer ] ; then
	echo -e "\033[31m::\033[0m /tmp/pacman-installer exists!"| tee -a $LOG

	exit 1
else echo -e "\033[32m::\033[0m $(mkdir -v /tmp/pacman-installer)" 2>&1 | tee -a $LOG
fi
tar -x -f /tmp/$FILENAME -C /tmp/pacman-installer -v | tee -a $LOG
mv /tmp/pacman-installer/root.x86_64/ $INSTALL_DIRECTORY 2>&1 | tee -a $LOG

echo -e "\033[32m::\033[0m Modifying pacman.conf..."| tee -a $LOG
sed -i "s|/var|$INSTALL_DIRECTORY/var|" $INSTALL_DIRECTORY/pacman.conf 2>&1 | tee -a $LOG
sed -i "s|/usr|$INSTALL_DIRECTORY/usr|" $INSTALL_DIRECTORY/pacman.conf 2>&1 | tee -a $LOG
sed -i "s|/etc|$INSTALL_DIRECTORY/etc|" $INSTALL_DIRECTORY/pacman.conf 2>&1 | tee -a $LOG
sed -i "s|/|$INSTALL_DIRECTORY/|" $INSTALL_DIRECTORY/pacman.conf 2>&1 | tee -a $LOG
echo -e "\033[32m::\033[0m Finished!"| tee -a $LOG

echo -e "\033[32m::\033[0m Please run"
echo    "     $INSTALL_DIRECTORY/usr/bin/pacman-key --init"
echo    "     $INSTALL_DIRECTORY/usr/bin/pacman-key --populate"
echo    "   to get the new pacman database usable"
echo -e "\033[32m::\033[0m And"
echo    "     $INSTALL_DIRECTORY/usr/bin/pacman -Syyu"
echo    "   to get your new Arch Linux updated"
echo -e "\033[32m::\033[0m Cleaning up..."
rm -vr /tmp/$FILENAME /tmp/pacman-installer | tee -a $LOG
echo -e "\033[32m::\033[0m Log written to $LOG"

