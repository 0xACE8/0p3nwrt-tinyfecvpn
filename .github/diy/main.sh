#!/bin/bash

function merge_package() {
    # 参数1是分支名,参数2是库地址,参数3是所有文件下载到指定路径。
    # 同一个仓库下载多个文件夹直接在后面跟文件名或路径，空格分开。
    if [[ $# -lt 3 ]]; then
        echo "Syntax error: [$#] [$*]" >&2
        return 1
    fi
    trap 'rm -rf "$tmpdir"' EXIT
    branch="$1" curl="$2" target_dir="$3" && shift 3
    rootdir="$PWD"
    localdir="$target_dir"
    [ -d "$localdir" ] || mkdir -p "$localdir"
    tmpdir="$(mktemp -d)" || exit 1
    git clone -b "$branch" --depth 1 --filter=blob:none --sparse "$curl" "$tmpdir"
    cd "$tmpdir"
    git sparse-checkout init --cone
    git sparse-checkout set "$@"
    # 使用循环逐个移动文件夹
    for folder in "$@"; do
        mv -f "$folder" "$rootdir/$localdir"
    done
    cd "$rootdir"
}
merge_package master https://github.com/kiddin9/openwrt-packages . tinyfecvpn
merge_package master https://github.com/kiddin9/openwrt-packages . luci-app-tinyfecvpn
merge_package master https://github.com/kiddin9/openwrt-packages . tinyportmapper
merge_package master https://github.com/kiddin9/openwrt-packages . luci-app-tinyfilemanager


#function git_clone() {
#  git clone --depth 1 $1 $2 || true
# }
#function git_sparse_clone() {
#  branch="$1" rurl="$2" localdir="$3" && shift 3
#  git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
#  cd $localdir
#  git sparse-checkout init --cone
#  git sparse-checkout set $@
#  mv -n $@ ../
#  cd ..
#  rm -rf $localdir
#  }
#function mvdir() {
#mv -n `find $1/* -maxdepth 0 -type d` ./
#rm -rf $1
#}
#git clone --depth 1 https://github.com/kiddin9/openwrt-packages tinyfecvpn1 && mv -n tinyfecvpn1/tinyfecvpn ./;rm -rf tinyfecvpn1
#git clone --depth 1 https://github.com/kiddin9/openwrt-packages tinyfecvpn2 && mv -n tinyfecvpn2/luci-app-tinyfecvpn  ./; rm -rf tinyfecvpn2
#git clone --depth 1 https://github.com/kiddin9/openwrt-packages tinyportmapper1 && mv -n tinyportmapper1/tinyportmapper ./;rm -rf tinyportmapper1
#git clone --depth 1 https://github.com/kiddin9/openwrt-packages tinyportmapper2 && mv -n tinyportmapper2/luci-app-tinyfilemanager ./; rm -rf tinyportmapper2

exit 0
