from django.db import models
from mdeditor.fields import MDTextField #必须导入

# Create your models here.
class Post(models.Model):
    title = models.CharField(max_length=100)
    content = MDTextField()
    created_at = models.DateTimeField(auto_now_add=True)
