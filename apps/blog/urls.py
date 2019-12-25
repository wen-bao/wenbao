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
from apps.blog.views import post_detail

urlpatterns = [
    path('', home),
    re_path(r'^(?P<title>\w+)/$', post_detail, name='post_detail'),
]
