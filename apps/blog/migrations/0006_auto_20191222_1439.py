# Generated by Django 2.2.7 on 2019-12-22 14:39

from django.db import migrations
import mdeditor.fields


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0005_comment'),
    ]

    operations = [
        migrations.AlterField(
            model_name='comment',
            name='body',
            field=mdeditor.fields.MDTextField(),
        ),
    ]
