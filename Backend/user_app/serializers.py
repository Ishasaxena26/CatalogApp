from dj_rest_auth.serializers import LoginSerializer

from dj_rest_auth.registration.serializers import RegisterSerializer
from rest_framework import serializers
from dj_rest_auth.serializers import UserDetailsSerializer
from django.contrib.auth import authenticate, get_user_model
from.models import User

UserModel=get_user_model()


class NewUserDetailsSerializer(UserDetailsSerializer):
    class Meta:
        model=UserModel
        fields=["email","last_name","first_name","pk","nickname","username"]


#this much code is not working
class NewRegisterSerializer(RegisterSerializer):
   # first_name=serializers.CharField()
   # last_name=serializers.CharField()
    nickname=serializers.CharField()
    def custom_signup(self, request, user):
     #   user.first_name=request.data['first_name']
     #   user.last_name=request.data['last_name']
        user.nickname=request.data['nickname']
        user.save()
        return user
   # class Meta:
     #model=User
       # fields=('__all__')
#this much code is not working 

class NewLoginSerializer(LoginSerializer):
    pass