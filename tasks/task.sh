#!/bin/bash
#
#说明：管理程序脚本，包括功能start、stop、restart和status
set -e

alias cp="cp";
alias mv="mv";
alias rm="rm";

PROJECT_NAME='blog'

ARGV="$@"


case $ARGV in
    'start')
    cp -fr /saas/projects/$PROJECT_NAME/config/nginx.conf /saas/softs/nginx/conf/nginx.conf
        
        ##检查进程状态,如进程存在则启动失败
    PCHECK_NAME_LIST="supervisord gunicorn nginx"
        for PCN in $PCHECK_NAME_LIST
        do
            PCHECK_NUM=`ps -ef | grep "$PCN" | grep -v "grep" | awk '{print$1}' | wc -l`
            if [ $PCHECK_NUM -gt 0 ]; then
                echo -e "the $PCN is running \tSTART FAILED"
                exit 1
            fi
        done

        ##启动supervisor进程
        /usr/bin/supervisord -c /saas/projects/$PROJECT_NAME/config/supervisord.conf > /dev/null 2>&1
        sleep 5
        #查看supervisor管理进程状态
        ##查看supervisor关闭的进程
        SUPERVISOR_STOPPED=`supervisorctl -c /saas/projects/$PROJECT_NAME/config/supervisord.conf status all | grep STOPPED | awk '{print$1}'`
        for PNAME in $SUPERVISOR_STOPPED
        do
            echo -e "the $PNAME is stoped \t\tSTART FAILED"
            exit 1
        done
        ##查看supervisor无法启动的进程
        SUPERVISOR_FATAL=`supervisorctl -c /saas/projects/$PROJECT_NAME/config/supervisord.conf status all | grep FATAL | awk '{print$1}'`
        for PNAME in $SUPERVISOR_FATAL
        do
            echo -e "the $PNAME is fatal \t\tSTART FAILED"
            exit 1
        done
        echo -e "START \t\t\t\tSUCCESS"
        ;;

        'stop')
        #关闭所有进程包括superviosr、gunicorn、nginx
        PKILL_NAME_LIST="supervisord gunicorn nginx"
        for PKN in $PKILL_NAME_LIST
        do
            PKILL_NUM=`ps aux | grep $PKN | grep -v "grep" | awk {'print$2'} | wc -l`
            if [ $PKILL_NUM -gt 0 ]; then
                ps aux | grep $PKN | grep -v "grep" | awk {'print$2'} | xargs kill -9
            fi
        done
        echo -e "STOP \t\t\t\tSUCCESS"
        ;;

        'restart')
        #重启进程
        ##关闭所有进程包括superviosr、gunicorn、nginx
        PKILL_NAME_LIST="supervisord gunicorn nginx"
        for PKN in $PKILL_NAME_LIST
        do
            PKILL_NUM=`ps aux | grep $PKN | grep -v "grep" | awk {'print$2'} | wc -l`
            if [ $PKILL_NUM -gt 0 ]; then
                ps aux | grep $PKN | grep -v "grep" | awk {'print$2'} | xargs kill -9
            fi
        done

        ##拷贝或者链接配置
        cp -fr /saas/projects/$PROJECT_NAME/config/config.py /saas/projects/$PROJECT_NAME/app/config.py
        cp -fr /saas/projects/$PROJECT_NAME/config/nginx.conf /saas/softs/nginx/conf/nginx.conf
        
        ##启动supervisor进程
        /usr/bin/supervisord -c /saas/projects/$PROJECT_NAME/config/supervisord.conf > /dev/null 2>&1
        sleep 5

        #查看supervisor管理进程状态
        ##查看supervisor关闭的进程
        SUPERVISOR_STOPPED=`supervisorctl -c /saas/projects/$PROJECT_NAME/config/supervisord.conf status all | grep STOPPED | awk '{print$1}'`
        for PNAME in $SUPERVISOR_STOPPED
        do
            echo -e "the $PNAME is stoped \t\tSTART FAILED"
            exit 1
        done
        ##查看supervisor无法启动的进程
        SUPERVISOR_FATAL=`supervisorctl -c /saas/projects/$PROJECT_NAME/config/supervisord.conf status all | grep FATAL | awk '{print$1}'`
        for PNAME in $SUPERVISOR_FATAL
        do
            echo -e "the $PNAME is fatal \t\tSTART FAILED"
            exit 1
        done
        echo -e "RESTART \t\t\tSUCCESS"
        ;;

        'status')
        #检查任务状态，要求输出程序需要启动的全部进程，并输出所有进程状态
        SUPERVISOR_PID=`ps -ef | grep "/usr/bin/supervisord -c" | grep -v "grep" | awk '{print$2}'`
        if [ ! $SUPERVISOR_PID ]; then
            echo -e "the supervisord is not running \tSTATUS FAILED"
        else
            supervisorctl -c /saas/projects/$PROJECT_NAME/config/supervisord.conf status all
        fi
        ;;

        *)
        #用法介绍
        basename=`basename "$0"`
        echo "Usage: $basename  {start|stop|restart|status}"
        exit 1
        ;;
    esac