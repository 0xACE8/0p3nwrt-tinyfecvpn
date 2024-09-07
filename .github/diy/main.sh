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
git clone --depth 1 https://github.com/kiddin9/openwrt-packages tinyfecvpn1 && mv -n tinyfecvpn1/tinyfecvpn ./;rm -rf tinyfecvpn1
git clone --depth 1 https://github.com/kiddin9/openwrt-packages tinyfecvpn2 && mv -n tinyfecvpn2/luci-app-tinyfecvpn  ./; rm -rf tinyfecvpn2
git clone --depth 1 https://github.com/kiddin9/openwrt-packages tinyportmapper1 && mv -n tinyportmapper1/tinyportmapper ./;rm -rf tinyportmapper1
git clone --depth 1 https://github.com/kiddin9/openwrt-packages tinyportmapper2 && mv -n tinyportmapper2/luci-app-tinyfilemanager ./; rm -rf tinyportmapper2

exit 0
