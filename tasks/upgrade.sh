#!/bin/bash

#说明：该脚本只升级app目录下的代码，其他目录一概不处理。

#设置环境变量

    set -e
    set -x

    UPGRADE_DIR=$(cd $(dirname $0);pwd)
    SAAS_PROJECTS='/saas/projects'
    APP_NAME='app'
    CONFIG_NAME='config'
    DATA_NAME='data'
    LOG_NAME='log'
    TASK_NAME='tasks'
    #根据项目和项目中目录名称替换
    #如无子目录就直接使用${项目名称}，有子目录使用${项目名称}/${子目录}
    PROJECT_NAME='assets_api'

    alias cp="cp";
    alias mv="mv";
    alias rm="rm";

#检查并创建目录

    #创建项目根目录
    if [ ! -d "${SAAS_PROJECTS}" ]; then
        mkdir -p ${SAAS_PROJECTS}
    fi

    #检查项目目录
    if [ ! -d "${SAAS_PROJECTS}/${PROJECT_NAME}" ]; then
        mkdir -p ${SAAS_PROJECTS}/${PROJECT_NAME}
    fi

    #检查数据目录及下属目录
    if [ ! -d "${SAAS_PROJECTS}/${PROJECT_NAME}/${DATA_NAME}" ]; then
        #创建数据目录
        mkdir -p ${SAAS_PROJECTS}/${PROJECT_NAME}/${DATA_NAME}
        #创建supervisor目录
        mkdir -p ${SAAS_PROJECTS}/${PROJECT_NAME}/${DATA_NAME}/supervisor/run
        #创建gunicorn目录
        mkdir -p ${SAAS_PROJECTS}/${PROJECT_NAME}/${DATA_NAME}/gunicorn/run
    fi

    #检查日志目录及下属目录
    if [ ! -d "${SAAS_PROJECTS}/${PROJECT_NAME}/${LOG_NAME}" ]; then
        #创建日志目录
        mkdir -p ${SAAS_PROJECTS}/${PROJECT_NAME}/${LOG_NAME}
        #创建supervisor目录
        mkdir -p ${SAAS_PROJECTS}/${PROJECT_NAME}/${LOG_NAME}/supervisor
        #创建gunicorn目录
        mkdir -p ${SAAS_PROJECTS}/${PROJECT_NAME}/${LOG_NAME}/gunicorn
        #创建nginx目录
        mkdir -p ${SAAS_PROJECTS}/${PROJECT_NAME}/${LOG_NAME}/nginx
        #创建web目录
        mkdir -p ${SAAS_PROJECTS}/${PROJECT_NAME}/${LOG_NAME}/flask
    fi

    #检查项目配置目录
    if [ ! -d "${SAAS_PROJECTS}/${PROJECT_NAME}/${CONFIG_NAME}" ]; then
        cp -r ${UPGRADE_DIR}/../${CONFIG_NAME} ${SAAS_PROJECTS}/${PROJECT_NAME}/${CONFIG_NAME}
    fi

    #检查项目任务目录
    if [ ! -d "${SAAS_PROJECTS}/${PROJECT_NAME}/${TASK_NAME}" ]; then
        cp -r ${UPGRADE_DIR}/../${TASK_NAME} ${SAAS_PROJECTS}/${PROJECT_NAME}/${TASK_NAME}
    fi

#升级app目录下的代码

    #删除上次备份代码目录
    if [ -d "${SAAS_PROJECTS}/${PROJECT_NAME}/${APP_NAME}_bk" ]; then
        rm -fr ${SAAS_PROJECTS}/${PROJECT_NAME}/${APP_NAME}_bk
    fi

    #备份当前代码目录
    if [ -d "${SAAS_PROJECTS}/${PROJECT_NAME}/${APP_NAME}" ]; then
        mv ${SAAS_PROJECTS}/${PROJECT_NAME}/${APP_NAME} ${SAAS_PROJECTS}/${PROJECT_NAME}/${APP_NAME}_bk
    fi

    #升级新包代码目录
    if [ ! -d "${SAAS_PROJECTS}/${PROJECT_NAME}/${APP_NAME}" ]; then
        cp -r ${UPGRADE_DIR}/../${APP_NAME} ${SAAS_PROJECTS}/${PROJECT_NAME}/${APP_NAME}
    fi

    echo -e "UPGRADE SUCCESS"

#调用task.sh脚本

    #cd ${SAAS_PROJECTS}/${PROJECT_NAME}/${TASK_NAME}
    #source ./task.sh restart