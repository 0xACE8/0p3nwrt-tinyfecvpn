#!/bin/bash
function git_clone() {
  git clone --depth 1 $1 $2 || true
 }
function git_sparse_clone() {
  branch="$1" rurl="$2" localdir="$3" && shift 3
  git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
  cd $localdir
  git sparse-checkout init --cone
  git sparse-checkout set $@
  mv -n $@ ../
  cd ..
  rm -rf $localdir
  }
function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}
git clone --depth 1 https://github.com/mgz0227/OP-Packages tinyfecvpn1 && mv -n tinyfecvpn1/tinyfecvpn ./;rm -rf tinyfecvpn1
git clone --depth 1 https://github.com/mgz0227/OP-Packages tinyfecvpn2 && mv -n tinyfecvpn2/luci-app-tinyfecvpn  ./; rm -rf tinyfecvpn2

exit 0
