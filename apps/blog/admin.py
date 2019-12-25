#!/usr/bin/env python3.7.4
# -*- coding: utf-8 -*-
"""
admin.py

Author: wsq
Date: 20191223
Description: 后台管理类
"""
from django.contrib import admin

# Register your models here.
from apps.blog.models import Comment
from apps.blog.models import Post


@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ('title', 'status', 'created_at',)
    list_filter = ('status', 'created_at', 'modified_at')
    list_editable = ['status']
    actions = ['make_published']
    search_fields = ['title', 'content']
    date_hierarchy = 'created_at'

    def make_published(self, request, queryset):
        rows_updated = queryset.update(status='p')
        if rows_updated == 1:
            message_bit = "1 story was"
        else:
            message_bit = "{} stories were".format(rows_updated)
        self.message_user(request, "{} successfully marked as published."
                                   .format(message_bit))

    make_published.short_description = "将所选标记为 published"

@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display = ('name','email','post','created','active')
    list_filter = ('active','created','updated')
    search_fields = ('name','email','body')

admin.site.site_header = 'wenbao blog'
admin.site.site_title = 'wenbao'
