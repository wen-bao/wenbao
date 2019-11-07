# django blogs


## 环境安装

* django安装

```shell
pip3 install django
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
python3 manage.py runserver 0.0.0.0:8000
```

