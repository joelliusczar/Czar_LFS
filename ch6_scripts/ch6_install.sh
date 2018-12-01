#!/bin/bash
cd "$LFS_sh" &&
bash 01_creating_dirs.sh &&
bash 02_mk_essential_symlinks.sh &&
bash 03_users_1.sh &&
bash 04_mk_log_files.sh &&
bash 05_linux_api_headers.sh &&
bash 06_man.sh &&
bash 07_glibc.sh &&
{ echo "Ch6 is done!"; exit 0; } ||
{ echo "Something broke in ch6!"; exit 1; }
