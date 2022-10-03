from django.db import models
from django.contrib.auth.models import User


class Task(models.Model):

    author = models.ForeignKey(to=User, on_delete=models.CASCADE)
    description = models.CharField(max_length=255)
    created_at = models.DateTimeField(auto_now_add=True)
    done = models.BooleanField(default=False)
