#!/bin/bash

LFS=/mnt/lfs bash ch6_scripts.sh &&
{ echo "ch6 win!"; exit 0; } ||
{ echo "ch6 lose!"; exit 1; }
