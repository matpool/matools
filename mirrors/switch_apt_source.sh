#! /bin/bash

set -e

source /etc/os-release

if [ "${NAME}" != "Ubuntu" ]; then
    echo "APT镜像源切换当前仅支持Ubuntu系统"
    exit 1
fi

APT_SOURCE="/etc/apt/sources.list"

if [ ! -f ${APT_SOURCE}_bk ]; then
    cp ${APT_SOURCE} ${APT_SOURCE}_bk
fi

SOURCES=(
    "https://mirrors.aliyun.com/ubuntu/"
    "https://mirrors.ustc.edu.cn/ubuntu/"
    "https://mirrors.163.com/ubuntu/"
    "https://mirrors.tuna.tsinghua.edu.cn/ubuntu/"
    "https://mirrors.zju.edu.cn/ubuntu/"
    "https://mirrors.cloud.tencent.com/ubuntu"
    "https://repo.huaweicloud.com/ubuntu/"
    "https://mirrors.bfsu.edu.cn/ubuntu/"
    "http://cn.archive.ubuntu.com/ubuntu/"
)

read -p "请选择您要切换的源的数字编号, 然后按回车
(0) 阿里云(aliyun)
(1) 中国科技大学(ustc)
(2) 网易(163)
(3) 清华大学(tsinghua)
(4) 浙江大学(zju)
(5) 腾讯云(tencent)
(6) 华为云(huawei)
(7) 北京外国语大学(bfsu)
(8) 官方源(ubuntu)
" INDEX

if [ ${INDEX} -ge ${#SOURCES[@]} ] || [ ${INDEX} -lt 0 ]; then
    echo "请输入有效的源编号"
    exit 1
fi

echo "deb ${SOURCES[${INDEX}]} ${VERSION_CODENAME} main restricted universe multiverse
deb ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-updates main restricted universe multiverse
deb ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-security main restricted universe multiverse
deb ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-proposed main restricted universe multiverse
deb ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-backports main restricted universe multiverse

deb-src ${SOURCES[${INDEX}]} ${VERSION_CODENAME} main restricted universe multiverse
deb-src ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-security main restricted universe multiverse
deb-src ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-updates main restricted universe multiverse
deb-src ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-proposed main restricted universe multiverse
deb-src ${SOURCES[${INDEX}]} ${VERSION_CODENAME}-backports main restricted universe multiverse" >${APT_SOURCE}

apt update
echo "写入apt镜像源完成"
