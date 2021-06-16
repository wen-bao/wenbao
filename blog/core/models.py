#!/usr/bin/env python3.7.4
# -*- coding: utf-8 -*-
"""
models.py

Author: wsq
Date: 20191223
Description: 模型类
"""
import django.utils.timezone as timezone

from django.db import models
from mdeditor.fields import MDTextField  #必须导入

# Create your models here.
STATUS_CHOICES = (('d', 'Draft'), ('p', 'Published'), ('w', 'Withdrawn'))


class Blog(models.Model):
    title = models.CharField(max_length=100)
    content = MDTextField()
    created_at = models.DateTimeField(default=timezone.now)
    modified_at = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=1,
                              choices=STATUS_CHOICES,
                              default='p')

    def __str__(self):
        return self.title


class Comment(models.Model):
    blog = models.ForeignKey(Blog,
                             related_name='comments',
                             on_delete=models.CASCADE)
    name = models.CharField(max_length=80)
    email = models.EmailField()
    body = models.TextField()
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    active = models.BooleanField(default=True)

    class Meta:
        ordering = ('created', )

    def __str__(self):
        return 'Comments by {} on {}'.format(self.name, self.blog)
