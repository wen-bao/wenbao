# django blogs


## 环境安装

* django安装

```shell
pip3 install django==2.2.3
pip3 install gunicorn==19.9.0
```

* sqlite3安装

```shell
# 下载源码
wget https://www.sqlite.org/2019/sqlite-autoconf-3290000.tar.gz
# 编译
tar zxvf sqlite-autoconf-3290000.tar.gz 
cd sqlite-autoconf-3290000/
./configure --prefix=/usr/local
make && make install

# 替换系统低版本 sqlite3
mv /usr/bin/sqlite3  /usr/bin/sqlite3_old
ln -s /usr/local/bin/sqlite3   /usr/bin/sqlite3
echo "/usr/local/lib" > /etc/ld.so.conf.d/sqlite3.conf
ldconfig
sqlite3 -version
```

## 编码

初始化django

```shell
python3 /usr/local/python3/lib/python3.7/site-packages/django/bin/django-admin.py startproject myblog
python3 manage.py startapp blog
python3 manage.py runserver 0.0.0.0:8888
```

```shell
# 数据库生成
python3 manage.py makemigrations
python3 manage.py migrate

# 添加用户
python3 manage.py createsuperuser

# 生成静态文件
python3 manage.py collectstatic
```

# fix django bugs

* 修复admin页面css不能正常加载问题
```shell
vi /usr/local/lib/python3.7/site-packages/django/contrib/staticfiles/urls.py
18 - if setting.DEBUG and not urlpatterns:
18 + if not urlpatterns
```

# 启动
```shell
gunicorn -w 5 --preload -b 0.0.0.0:8888 myblog.wsgi:application

gunicorn -c /root/code/myblog/config/gunicorn.conf myblog.wsgi app

ps -ef | grep gunicorn | grep -v grep | awk '{print $2}' | xargs kill -9
```

## 其他

git 显示跟踪的文件
```shell
git ls-files
```
