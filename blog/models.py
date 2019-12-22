from django.db import models
from mdeditor.fields import MDTextField #必须导入
import django.utils.timezone as timezone

# Create your models here.
STATUS_CHOICES = (
    ('d', 'Draft'),
    ('p', 'Published'),
    ('w', 'Withdrawn')
)

class Post(models.Model):
    title = models.CharField(max_length=100)
    content = MDTextField()
    created_at = models.DateTimeField(default = timezone.now)
    modified_at = models.DateTimeField(auto_now_add = True)
    status = models.CharField(max_length=1, choices=STATUS_CHOICES, default='p')

    def __str__(self):
        return self.title

class Comment(models.Model):
    post=models.ForeignKey(Post,related_name='comments', on_delete=models.CASCADE)
    name=models.CharField(max_length=80)
    email=models.EmailField()
    body=models.TextField()
    created=models.DateTimeField(auto_now_add=True)
    updated=models.DateTimeField(auto_now=True)
    active=models.BooleanField(default=True)

    class Meta:
        ordering = ('created',)

    def __str__(self):
        return 'Comments by {} on {}'.format(self.name, self.post)
