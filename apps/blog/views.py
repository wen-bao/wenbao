#!/usr/bin/env python3.7.4
# -*- coding: utf-8 -*-
"""
views.py

Author: wsq
Date: 20191223
Description: 视图类
"""
import markdown

from django.http import HttpResponse,HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse

# Create your views here.
from .forms import CommentsForm
from apps.blog.models import Comment
from apps.blog.models import Post


def home(request):
    post_list = Post.objects.filter(status = 'p').order_by('-created_at')
    return render(request, 'blog/home.html', {'post_list':post_list})

def post_detail(request, title):
    post = Post.objects.get(title=title)
    post.content = markdown.markdown(
        post.content.replace("\r\n",' \n'),
        extensions=[
            'markdown.extensions.extra',
            'markdown.extensions.codehilite',#语法高亮拓展
            'markdown.extensions.toc'#自动生成目录
        ])#修改blog.content内容为html

    try:
        comment_list = post.comments.filter()
    except Exception as err:
        comment_list = None

    if request.method == 'POST':
        comment_form = CommentsForm(request.POST)
        if comment_form.is_valid():
            new_comment = comment_form.save(commit=False)
            new_comment.post = post
            new_comment.save()
        return HttpResponseRedirect(
            reverse('blog/post_detail', kwargs={'title': title}))

    comment_form = CommentsForm()

    return render(
        request, 
        'blog/post.html',{
            'post':post, 
            'comment_list': comment_list, 
            'comment_form': comment_form
        })
