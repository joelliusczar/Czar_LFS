#!/bin/bash

while [ "$#" -gt 0 ]; do
case "$1" in
--skip_setup) skip_setup=1 ;;
--vg=*)
vgarg="${1#*=}"
volgroup="${vgarf:-vglfs}"
;;
*) : ;;
esac
shift
done &&
if [ "$skip_setup" != '1' ]; then
bash setup1.sh "$volgroup" ||
{ echo "Setup 1 crashed!"; exit 1; }
fi &&
exec "$BASH"  -lc '
bash clean_up_lfs_dir.sh &&
sudo cp -v ch5_scripts/*.sh install_help.sh /home/lfs/ &&
sudo -u lfs env -i auto_lfs=t TERM=$TERM PS1="'"\u:\w\$ "'" \
bash -l ch5_scripts.sh &&
bash change_owner.sh &&
bash ch6_scripts.sh &&
{ echo "Everything has been a smashing success!"; exit 0; } ||
{ echo "Damnit fool! You'"'"'ve shot it all to hell! Fix it!"; exit 1; }
' 

