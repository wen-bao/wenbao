from django.shortcuts import render

# Create your views here.
import pytz
import datetime
import time
import markdown

from django.http import HttpResponse
from django.shortcuts import render

from blog.models import Post

def hello_world(request):
    return render(request, 'hello_world.html', {'current_time': datetime.datetime.fromtimestamp(int(time.time()), pytz.timezone('Asia/Shanghai')).strftime('%Y-%m-%d %H:%M:%S')})

def home(request):
    post_list = Post.objects.all()
    return render(request, 'home.html', {'post_list':post_list})

def post_detail(request, id):
    post = Post.objects.get(id=id)
    post.content=markdown.markdown(post.content.replace("\r\n",' \n'),extensions=[
        'markdown.extensions.extra',
        'markdown.extensions.codehilite',#语法高亮拓展
        'markdown.extensions.toc'#自动生成目录
    ])#修改blog.content内容为html
    return render(request, 'post.html', {'post':post})
