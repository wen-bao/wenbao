#!/usr/bin/env python3.7.4
# -*- coding: utf-8 -*-
"""
views.py

Author: wsq
Date: 20191223
Description: 视图类
"""
import markdown

from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse

# Create your views here.
from .forms import CommentsForm
from apps.blog.models import Comment
from apps.blog.models import Blog


def home(request):
    blog_list = Blog.objects.filter(status='p').order_by('-created_at')
    return render(request, 'blog/home.html', {'blog_list': blog_list})


def blog_detail(request, title):
    blog = Blog.objects.get(title=title)
    blog.content = markdown.markdown(
        blog.content.replace("\r\n", ' \n'),
        extensions=[
            'markdown.extensions.abbr',
            'markdown.extensions.extra',
            'markdown.extensions.abbr',
            'markdown.extensions.attr_list',
            'markdown.extensions.def_list',
            'markdown.extensions.fenced_code',
            'markdown.extensions.footnotes',
            'markdown.extensions.tables',
            'markdown.extensions.admonition',
            # 语法高亮拓展
            'markdown.extensions.codehilite',
            'markdown.extensions.meta',
            'markdown.extensions.nl2br',
            'markdown.extensions.sane_lists',
            'markdown.extensions.smarty',
            # 自动生成目录
            'markdown.extensions.toc',
            'markdown.extensions.wikilinks',
        ])  # 修改blog.content内容为html

    try:
        comment_list = blog.comments.filter()
    except Exception as err:
        comment_list = None

    if request.method == 'POST':
        comment_form = CommentsForm(request.POST)
        if comment_form.is_valid():
            new_comment = comment_form.save(commit=False)
            new_comment.blog = blog
            new_comment.save()
        return HttpResponseRedirect(
            reverse('blog_detail', kwargs={'title': title}))

    comment_form = CommentsForm()

    return render(request, 'blog/blog.html', {
        'blog': blog,
        'comment_list': comment_list,
        'comment_form': comment_form
    })
