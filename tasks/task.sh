#!/bin/bash

CURR_DIR=$(cd $(dirname $0); pwd)

usage()
{
    cat <<EOF
Usage:
    task.sh < start | stop | restart | status >
EOF
    exit 1
}

start_app()
{
    cd ${CURR_DIR}/../
    gunicorn -c ./config/gunicorn.conf wenbao.wsgi app
    check_app gunicorn
}

stop_app()
{
    ps -ef | grep gunicorn | grep -v grep | awk '{print $2}' | xargs kill -9 >/dev/null 2>&1
    check_app gunicorn
}

restart_app()
{
    stop_app
    start_app
}

check_app()
{
    prog=$1
    result=$(ps -ef | grep ${prog} | grep -v "grep")
    if [[ "$result" != "" ]]; then
        echo "${prog} 正在运行"
    else
        echo "${prog} 停止运行"
    fi
}

# 判断命令长度是否合法
if [ $# -eq 0 ]; then
    usage
    exit 1
fi

# 解析最后一个参数
CMD=${1}
if [[ ${CMD} != start ]] && [[ ${CMD} != stop ]] && [[ ${CMD} != restart ]] && [[ ${CMD} != status ]]; then
    usage
    exit 1
fi

if [ ${CMD} = start ]; then
    start_app
    exit 0
elif [ ${CMD} = stop ]; then
    stop_app
    exit 0
elif [ ${CMD} = restart ]; then
    restart_app
    exit 0
else
    check_app gunicorn
    exit 0
fi
