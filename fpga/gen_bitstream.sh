#! /usr/bin/env zsh
# Usage: zsh gen_bs.sh bsDir verilogDir

set -v

bsDir=$1
verilogDir=$2

cp -r /nfs/home/share/fpga/vivado/scripts_v2 $bsDir
cd $bsDir
cp -r $verilogDir build
if [ ! -f $(pwd)/build/XSTop.v ]; then
  echo "XSTop.v does not exist, exit"
  exit
fi
make add_sys_option CORE_DIR=$(pwd)/build
make update_core_flist CORE_DIR=$(pwd)/build
make nanhu CORE_DIR=$(pwd)/build
make bitstream CORE_DIR=$(pwd)/build
