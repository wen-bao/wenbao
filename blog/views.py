from django.shortcuts import render

# Create your views here.
import pytz
import datetime
import time
import markdown

from django.http import HttpResponse,HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse

from blog.models import Comment
from blog.models import Post

from .forms import CommentsForm

def hello_world(request):
    return render(request, 'hello_world.html', {'current_time': datetime.datetime.fromtimestamp(int(time.time()), pytz.timezone('Asia/Shanghai')).strftime('%Y-%m-%d %H:%M:%S')})

def home(request):
    post_list = Post.objects.filter(status = 'p')
    return render(request, 'home.html', {'post_list':post_list})

def post_detail(request, title):
    post = Post.objects.get(title=title)
    post.content = markdown.markdown(post.content.replace("\r\n",' \n'),extensions=[
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
        return HttpResponseRedirect(reverse(
            'post_detail', 
            kwargs={'title': title}))

    comment_form = CommentsForm()

    return render(request, 
                  'post.html', 
                  {'post':post, 
                   'comment_list': comment_list,
                   'comment_form': comment_form})
