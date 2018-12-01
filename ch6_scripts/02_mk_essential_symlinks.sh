

ln -sv /tools/bin/{bash,cat,dd,echo,ln,pwd,rm,stty} /bin &&
ln -sv /tools/bin/{env,install,perl} /usr/bin &&
ln -sv /tools/lib/libgcc_s.so{,.1} /usr/lib &&
ln -sv /tools/lib/libstdc++.{a,so{,.6}} /usr/lib &&
for lib in blkid lzma mount uuid
do
    ln -sv /tools/lib/lib$lib.so* /usr/lib ||
    { echo "something fucked up linking!"; exit 1; } 
done &&
ln -svf /tools/include/blkid /usr/include &&
ln -svf /tools/include/libmount /usr/include &&
ln -svf /tools/include/uuid /usr/include &&
install -vdm755 /usr/lib/pkgconfig &&
for pc in blkid mount uuid
do
sed 's@tools@usr@g' /tools/lib/pkgconfig/${pc}.pc \
> /usr/lib/pkgconfig/${pc}.pc ||
{ echo "something fucked up linking!"; exit 1; } 
done &&
ln -sv bash /bin/sh &&
ln -sv /proc/self/mounts /etc/mtab &&



{ echo "Linking was a success!"; exit 0; } ||
{ echo "Something fucked up linking!"; exit 1; } 
