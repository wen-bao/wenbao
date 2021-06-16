# wenbao blogs

工欲善其事，必先利其器。 一直有写博客的习惯，苦于没有满意的平台，尽管第三方博客网站 （[本人博客园地址](https://cnblogs.com/wenbao)）和许多开源的博客框架都功能齐全， 但对个人使用来说都太臃肿。 我自己理解的博客应该是这样的地方，它就像一本书一样，用文字记录了一个人的点滴， 里面有对技术的分享和理解、对世界的看法，于是决定自己写一个轻量级的个人博客。

博客基于django框架和sqlite3轻量级数据库实现，只有两个页面，一个是“书”的目录，一个是“书”的内容。

[示例网站](http://www.oabnew.com/myblog)

## 环境安装

python3 + sqlite3

目前，几乎所有版本的 Linux 操作系统都附带 SQLite

* python3依赖安装

python3 -m pip install -r requirements.txt

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
