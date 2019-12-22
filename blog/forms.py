from .models import Comment
from django import forms

class CommentsForm(forms.ModelForm):
    class Meta:
        model=Comment
        fields=('name','email','body')
