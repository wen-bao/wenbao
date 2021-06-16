#!/usr/bin/env python3.7.4
# -*- coding: utf-8 -*-
"""
urls.py

Author: wsq
Date: 20191223
Description: urls类
"""
from django.conf.urls import url
from django.urls import path
from django.urls import re_path

from blog.core.views import home
from blog.core.views import blog_detail

urlpatterns = [
    path('', home),
    re_path(r'^(?P<title>[\w\W]+)/$', blog_detail, name='blog_detail'),
]
