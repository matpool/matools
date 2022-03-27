#! /bin/bash

set -e

# pip folder and file
PIP_PATH=${HOME}/".pip"
PIP_CONF=${HOME}/".pip/pip.conf"

# make sure the folder and file exist
if [ ! -f ${PIP_CONF} ]; then
    mkdir -p ${PIP_PATH}
else
    if [ ! -f ${PIP_CONF}_bk ]; then
        cp ${PIP_CONF} ${PIP_CONF}_bk
    fi
fi

# source array
SOURCES=(
    "https://mirrors.aliyun.com/pypi/simple/"
    "https://pypi.mirrors.ustc.edu.cn/simple/"
    "https://pypi.doubanio.com/simple/"
    "https://pypi.tuna.tsinghua.edu.cn/simple/"
    "https://mirrors.cloud.tencent.com/pypi/simple/"
    "http://mirrors.163.com/pypi/simple/"
    "https://repo.huaweicloud.com/repository/pypi/simple"
    "https://mirrors.bfsu.edu.cn/pypi/web/simple/"
    "https://mirrors.nju.edu.cn/pypi/web/simple/"
    "https://mirrors.pku.edu.cn/pypi/simple"
    "https://pypi.org/simple/"
)

# trust-host array
HOST=(
    "mirrors.aliyun.com"
    "pypi.mirrors.ustc.edu.cn"
    "pypi.doubanio.com"
    "pypi.tuna.tsinghua.edu.cn"
    "mirrors.cloud.tencent.com"
    "mirrors.163.com"
    "repo.huaweicloud.com"
    "mirrors.bfsu.edu.cn"
    "mirrors.nju.edu.cn"
    "mirrors.pku.edu.cn"
    "pypi.org"
)

read -p "请选择您要切换的源的数字编号, 然后按回车
(0) 阿里云(aliyun)
(1) 中国科技大学(ustc)
(2) 豆瓣(douban)
(3) 清华大学(tsinghua)
(4) 腾讯云(tencent)
(5) 网易(163)
(6) 华为云(huawei)
(7) 北京外国语大学(bfsu)
(8) 南京大学(nju)
(9) 北京大学(pku)
(10) 官方源(不推荐pypi)
" INDEX

if [ ${INDEX} -ge ${#SOURCES[@]} ] || [ ${INDEX} -lt 0 ]; then
    echo "请输入有效的源编号"
    exit 1
fi

# overwrite file
echo "[global]
timeout = 6000
index-url = ${SOURCES[${INDEX}]}
trusted-host = ${HOST[${INDEX}]}" >${PIP_CONF}

echo "切换完成"
