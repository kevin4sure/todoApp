from django.db import models

# Create your models here.


class TaskList(models.Model):
    title = models.CharField(max_length=64)
    
    def natural_key(self):
        return (self.title)

    def __str__(self):
        return self.title
