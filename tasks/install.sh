#!/bin/bash

#说明：安装requirements目录下的环境依赖
#requirements/pip/requirements.list    存放requirements.list文件
#requirements/rpm/XXX                存放rpm包按软件名分目录
#requirements/source/XXX            存放源码包按软件名分目录

#设置环境变量

    set -e
    set -x
   

    # TODO 因为部分精简版系统并没有防火墙，因此不再自动关闭防火墙
    # 关闭防火墙
#    systemctl stop firewalld.service

    # 关闭防护墙开机启动
#    systemctl disable firewalld.service

    # 临时关闭SELINUX
#    setenforce 0

    # 永久关闭SELINUX
#    sed -i "s/SELINUX=[^d]*/SELINUX=disabled/g" /etc/selinux/config


    # 保留当前安装目录
    INSTALL_DIR=$(cd $(dirname $0); pwd)
	
	# 增加用户
    if ! id -u assets; then
        adduser assets
    fi


#安装依赖环境依赖
##安装yum
###示例：yum install -y xxx

    # 安装扩展源
    yum install -y epel-release

    # 安装pip
    yum install -y python-pip python-devel

    # 安装libffi-devel
    yum install -y libffi-devel

    # 安装git
    yum install -y git

    # 安装openssl
    yum install -y openssl openssl-devel

    # 安装编译软件
    yum install -y cmake make gcc gcc-c++

    # 安装pcre
    yum install -y pcre pcre-devel
	
	# 安装curl开发包
    yum -y install curl-devel
	
	# 安装mysql驱动
    yum -y install mysql-devel

    # 安装解压包
    yum install -y zlib zlib-devel
    yum install -y unzip zip
	
	# 安装常用基础工具
    yum -y install dos2unix rsync vim-enhanced htop lsof iotop iftop

    # 安装supervisor
    yum install -y supervisor

##安装rpm
###示例安装docker：rpm -i --force --nodeps ../requirements/rpm/docker/*rpm
###示例：rpm -i --force -- nodeps ../requirements/rpm/XXX/*rpm

##安装源码包
###示例安装nginx：source ../requirements/source/nginx/nginx.sh
###示例：source ../requirements/XXX/XXX.sh
    #检查是否已安装
    if [ ! -f /saas/softs/nginx/sbin/nginx ]; then
        cd ../requirements/source/nginx-1.14.0/
        sh ./nginx-1.14.0.sh
        cd ${INSTALL_DIR}
    fi

    ##安装pip
    ###示例：请查看requirements/pip/requirements.list文件
    python3 -m pip install --upgrade pip
    pip3 install -r ../requirements/pip/requirements.list

#安装/etc/cron.X脚本

    if [ -d ./etc ]; then
        cp -fr ./etc/* /etc/ || (echo -e "cp /etc/cron.X ERROR\n"; exit 1) 
        echo -e "cp /etc/cron.X\n"
    fi

#安装zabbix监控项
    
    if [ -d ./zabbix ]; then
        cp -fr ./zabbix/* / || (echo -e "cp /zabbix ERROR\n"; exit 1)
        echo -e "cp /zabbix\n"
    fi

    echo -e "INSTALL SUCCESS"

#调用upgrade.sh脚本

    cd ${INSTALL_DIR}
    source ./upgrade.sh
