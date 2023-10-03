#WRITTEN FILE ON 27/7

from django.urls import path , include


urlpatterns = [
    path('auth/',include('dj_rest_auth.urls')),
    path('auth/registration/',include('dj_rest_auth.registration.urls')),
]
