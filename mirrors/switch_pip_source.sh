#! /bin/bash

set -e

# pip folder and file
PIP_PATH=${HOME}/".pip"
PIP_CONF=${HOME}/".pip/pip.conf"

# make sure the folder and file are exist
if [ ! -f ${PIP_CONF} ]; then
    mkdir ${PIP_PATH}
    touch ${PIP_CONF}
else
    if [ ! -f ${PIP_CONF}_bk ]; then
        cp ${PIP_CONF} ${PIP_CONF}_bk
    fi
fi

if [ ! -f ${PIP_CONF} ]; then
    touch ${PIP_CONF}
fi

# source array
SOURCES=(
    "http://mirrors.aliyun.com/pypi/simple/"
    "https://pypi.mirrors.ustc.edu.cn/simple/"
    "https://pypi.doubanio.com/simple/"
    "https://pypi.tuna.tsinghua.edu.cn/simple/"
    "https://mirrors.cloud.tencent.com/pypi/simple/"
    "http://mirrors.zju.edu.cn/pypi/web/simple/"
    "http://mirrors.163.com/pypi/simple/"
    "https://repo.huaweicloud.com/repository/pypi/simple"
    "https://mirrors.bfsu.edu.cn/pypi/web/simple/"
    "https://mirrors.sjtug.sjtu.edu.cn/pypi/web/simple"
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
    "mirrors.zju.edu.cn"
    "mirrors.163.com"
    "repo.huaweicloud.com"
    "mirrors.bfsu.edu.cn"
    "mirrors.sjtug.sjtu.edu.cn"
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
(5) 浙江大学(zju)
(6) 网易(163)
(7) 华为云(huawei)
(8) 北京外国语大学(bfsu)
(9) 上海交通大学(sjtug)
(10) 南京大学(nju)
(11) 北京大学(pku)
(12) 官方源(不推荐pypi)
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
