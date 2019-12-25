#!/usr/bin/env python3.7.4
# -*- coding: utf-8 -*-
"""
forms.py

Author: wsq
Date: 20191223
Description: 表单类
"""
from django import forms

from .models import Comment


class CommentsForm(forms.ModelForm):

    class Meta:
        model=Comment
        fields=('name','email','body')
