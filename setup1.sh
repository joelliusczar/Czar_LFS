#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Plase Run as Root"
  exit 1
fi

while [ "$#" -gt 0 ]; do
    case "$1" in
--vg=*)
vgarg="${1#*=}"
volgroup="${vgarg:-vglfs}"
;;
*) : ;;
esac
shift
done

real_user=${SUDO_USER:-$(whoami)}
LFS=${LFS:-/mnt/lfs}
export LFS

MYSH=$(readlink -f /bin/sh)
echo "$MYSH" | grep -q bash || ln -sfn /bin/bash /bin/sh

if cat /proc/version | grep -q 'ubuntu'; then
  apt-get update
  echo 'int main(){}' > dummy.c && g++ -o dummy dummy.c ||
  apt-get -y install g++;
  rm dummy dummy.c;
  makeinfo --version || apt-get -y install texinfo;
  set +o xtrace
  use_profile=.profile
  root_profile=.profile
fi

if [ -e mysetup.sh ]; then
    bash mysetup.sh 
fi 

if [ -z "$(vgdisplay -A)"  ]; then
  vgchange -ay "$volgroup";
fi &&
if [ ! -e $LFS ];then
 mkdir -pv $LFS;
fi &&
if ! mountpoint $LFS -q ;then 
  mount -v /dev/"$volgroup"/root $LFS
fi &&
if [ "0" = "$(free -m | sed -e '1,2d' | awk '{ print $2 }')" ]; then
  swapon /dev/"$volgroup"/swap;
fi &&
if [ ! -e $LFS/sources ]; then
 mkdir -v $LFS/sources
fi &&
chmod -v a+wt $LFS/sources &&
if [ -z "$(shopt -s nullglob dotglob; echo $LFS/sources/*)" ]; then
  wget --input-file=wget-list --continue --directory-prefix=$LFS/sources;
  mydir=pwd
  pushd
  midsum -c ${mydir}/md5sums
  popd
fi &&
if [ ! -e $LFS/tools ]; then
 mkdir -v $LFS/tools
fi &&
if [ ! -e /tools ]; then
  ln -sv $LFS/tools /
fi &&
if ! id -u lfs &>/dev/null; then
  groupadd lfs &&
  useradd -s /bin/bash -g lfs -m -k /dev/null lfs &&
  echo lfs:U6aMy0wojraho | chpasswd -e 
fi &&
chown -R lfs $LFS/tools &&
chown -R lfs $LFS/sources &&

bash -c 'cat > /home/lfs/.bash_profile << "EOF"
if [ -z "$auto_lfs" ]; then
  exec env -i HOME=$HOME TERM=$TERM PS1="'"\u:\w\$ "'" /bin/bash
else
  echo "'"Hi, from lfs .bash_profile "'"
  set +h
  umask 022
  LFS=/mnt/lfs
  LC_ALL=POSIX
  LFS_TGT=$(uname -m)-lfs-linux-gnu
  PATH=/tools/bin:/bin:/usr/bin
  export LFS LC_ALL LFS_TGT PATH
fi
EOF' &&

bash -c 'cat > /home/lfs/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
EOF' &&

export_line="export LFS=$LFS" &&
if ! grep -F "$export_line" /home/"$real_user"/"$use_profile"; then
  echo "$export_line" >> /home/"$real_user"/"$use_profile"
fi &&
if ! grep -F "$export_line" /root/"$root_profile"; then
  bash -c "echo '$export_line' >> /root/$root_profile"
fi &&



echo "winner!" || echo "Loser!"


