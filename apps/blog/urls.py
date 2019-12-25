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

from apps.blog.views import home
from apps.blog.views import blog_detail

urlpatterns = [
    path('', home),
    re_path(r'^(?P<title>\w+)/$', blog_detail, name='blog_detail'),
]
