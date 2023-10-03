import os
from django.db import models
from django.contrib.auth import get_user_model

def upload_to(inst,filename):
    return os.path.join('catalog_images',filename)
# Create your models here.
class Catalog(models.Model):
    name=models.CharField(max_length=100, null=False)
    desc=models.TextField(max_length=5000)
    price=models.DecimalField(max_digits=12, decimal_places=2)
    color=models.CharField(max_length=50)
    image=models.ImageField(upload_to=upload_to,null=True,blank=True)

    def __str__(self):
        return self.name

