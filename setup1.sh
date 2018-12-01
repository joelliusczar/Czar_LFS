#!/bin/bash

export LFS=/mnt/lfs

MYSH=$(readlink -f /bin/sh)
echo "$MYSH" | grep -q bash || sudo ln -sfn /bin/bash /bin/sh

if cat /proc/version | grep -q 'ubuntu'; then
  set -o xtrace
  sudo apt-get update
  echo 'int main(){}' > dummy.c && g++ -o dummy dummy.c ||
  sudo apt-get -y install g++;
  rm dummy dummy.c;
  makeinfo --version || sudo apt-get -y install texinfo;
  set +o xtrace
  use_profile=.profile
  root_profile=.profile
fi

if [ -z "$(sudo vgdisplay -A)"  ]; then
  sudo vgchange -ay vglfs;
fi &&
if [ ! -e $LFS ];then
 sudo mkdir -pv $LFS;
fi &&
if ! mountpoint $LFS -q ;then 
  sudo mount -v /dev/vglfs/root $LFS
fi &&
if [ "0" = "$(free -m | sed -e '1,2d' | awk '{ print $2 }')" ]; then
  sudo swapon /dev/vglfs/swap;
fi &&
if [ ! -e $LFS/sources ]; then
 sudo mkdir -v $LFS/sources
fi &&
sudo chmod -v a+wt $LFS/sources &&
if [ -z "$(shopt -s nullglob dotglob; echo $LFS/sources/*)" ]; then
  wget --input-file=wget-list --continue --directory-prefix=$LFS/sources;
  mydir=pwd
  pushd
  midsum -c ${mydir}/md5sums
  popd
fi &&
if [ ! -e $LFS/tools ]; then
 sudo mkdir -v $LFS/tools
fi &&
if [ ! -e /tools ]; then
  sudo ln -sv $LFS/tools /
fi &&
if ! id -u lfs &>/dev/null; then
  sudo groupadd lfs &&
  sudo useradd -s /bin/bash -g lfs -m -k /dev/null lfs &&
  echo lfs:U6aMy0wojraho | sudo chpasswd -e
fi &&
sudo chown -R lfs $LFS/tools &&
sudo chown -R lfs $LFS/sources &&

sudo bash -c 'cat > /home/lfs/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1="'"\u:\w\$ "'" /bin/bash
EOF' &&

sudo bash -c 'cat > /home/lfs/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
EOF' &&

export_line="export LFS=$LFS" &&
if ! grep -F "$export_line" "$use_profile"; then
  (echo "$export_line" >> ~/"$use_profile")
fi &&
if ! sudo grep -F "$export_line" "$root_profile"; then
  (sudo bash -c "echo '$export_line' >> /root/$root_profile") 
fi &&

bash mysetup.sh &&

echo "winner!" || echo "Loser!"


