# wenbao blogs

工欲善其事，必先利其器。 一直有写博客的习惯，苦于没有满意的平台，尽管第三方博客网站 （[本人博客园地址](https://cnblogs.com/wenbao)）和许多开源的博客框架都功能齐全， 但对个人使用来说都太臃肿。 我自己理解的博客应该是这样的地方，它就像一本书一样，用文字记录了一个人的点滴， 里面有对技术的分享和理解、对世界的看法，于是决定自己写一个轻量级的个人博客。

博客基于django框架和sqlite3轻量级数据库实现，只有两个页面，一个是“书”的目录，一个是“书”的内容。

[示例网站](http://www.oabnew.com/myblog)

## 环境安装

python3 + sqlite3

* python3依赖安装

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

## 配置

```shell
# 数据库生成
python3 manage.py makemigrations
python3 manage.py makemigrations blog
python3 manage.py migrate

# 添加用户
python3 manage.py createsuperuser

# 生成静态文件
python3 manage.py collectstatic
```

## 管理

tasks目录

```shell
sh task.sh start  # 启动
sh task.sh stop   # 停止
sh task.sh status # 状态
```

## 数据库备份还原

```shell
# 备份
sqlite3
.open db.sqlite3
.output back.sql
.dump

# 还原
sqlite3
.open test.db
.read back.sql
```
