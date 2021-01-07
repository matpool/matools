#! /bin/bash

set -e

CONDA_CONF="$HOME/.condarc"

if [ ! -f ${CONDA_CONF} ]; then
    touch ${CONDA_CONF}
fi

SOURCES=(
    "https://mirrors.tuna.tsinghua.edu.cn/anaconda"
    "https://anaconda.mirrors.sjtug.sjtu.edu.cn"
    "https://mirrors.bfsu.edu.cn/anaconda"
    "https://mirrors.nju.edu.cn/anaconda"
)

read -p "请选择您要切换的源的数字编号, 然后按回车
(0) 清华大学(tsinghua)
(1) 上海交通大学(sjtug)
(2) 北京外国语大学(bfsu)
(3) 南京大学(nju)
" INDEX

if [ ${INDEX} -ge ${#SOURCES[@]} ] || [ ${INDEX} -lt 0 ]; then
    echo "请输入有效的源编号"
    exit 1
fi

echo "channels:
  - defaults
show_channel_urls: true
channel_alias: ${SOURCES[${INDEX}]}
default_channels:
  - ${SOURCES[${INDEX}]}/pkgs/main
  - ${SOURCES[${INDEX}]}/pkgs/r
custom_channels:
  conda-forge: ${SOURCES[${INDEX}]}/cloud
  msys2: ${SOURCES[${INDEX}]}/cloud
  bioconda: ${SOURCES[${INDEX}]}/cloud
  menpo: ${SOURCES[${INDEX}]}/cloud
  pytorch: ${SOURCES[${INDEX}]}/cloud
  simpleitk: ${SOURCES[${INDEX}]}/cloud" >${CONDA_CONF}

conda clean -i
echo "写入conda镜像源完成"
