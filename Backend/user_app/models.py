from django.db import models
#written  new content
from django.contrib.auth.models import AbstractUser
from django_resized import ResizedImageField # installed this package 

def upload_to(inst,filename):
    return "/profile/"+str(filename)

class User(AbstractUser):
    username=models.CharField(max_length=55,unique=False)
    nickname=models.CharField(max_length=55)
    profile_picture=ResizedImageField(upload_to=upload_to,null=True,blank=True)

def __str__(self)->str:
    return str(self.id)
    
       
#till here content written

# Create your models here.
