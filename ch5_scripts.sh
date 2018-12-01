#!/bin/bash
cd ch5_scripts &&
bash 01_binutils_pass_1.sh &&
bash 02_gcc_pass_1.sh &&
bash 03_linux_api_headers.sh &&
bash 04_glibc.sh &&
bash 05_libstdcpp.sh &&
bash 06_binutils_pass_2.sh &&
bash 07_gcc_pass_2.sh &&
bash 08_tcl.sh &&
bash 09_expect.sh &&
bash 10_dejagnu.sh &&
bash 11_m4.sh &&
bash 12_ncurses.sh &&
bash 13_bash.sh &&
bash 14_bison.sh &&
bash 15_bzip2.sh &&
bash 16_coreutils.sh &&
bash 17_diffutils.sh &&
bash 18_file.sh &&
bash 19_findutils.sh &&
bash 20_gawk.sh &&
bash 21_gettext.sh &&
bash 22_grep.sh &&
bash 23_gzip.sh &&
bash 24_make.sh &&
bash 25_patch.sh &&
bash 26_perl.sh &&
bash 27_sed.sh &&
bash 28_tar.sh &&
bash 29_texinfo.sh &&
bash 30_util_linux.sh &&
bash 31_xz.sh &&
bash 32_stripping.sh &&
{ echo "Ch5 is done!"; exit 0; } ||
{ echo "Something broke in ch5!"; exit 1; }
