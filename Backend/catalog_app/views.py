from django.shortcuts import render

# Create your views here.
from rest_framework import generics, permissions
from .models import Catalog
from .serializers import CatalogSerializer

class CatalogList(generics.ListAPIView):
    queryset = Catalog.objects.all()
    serializer_class = CatalogSerializer
    permission_classes = [permissions.AllowAny]

class CatalogCreate(generics.CreateAPIView):
    queryset = Catalog.objects.all()
    serializer_class = CatalogSerializer
    permission_classes = [permissions.IsAuthenticated, permissions.IsAdminUser]

class CatalogUpdate(generics.RetrieveUpdateAPIView):
    queryset = Catalog.objects.all()
    serializer_class = CatalogSerializer
    permission_classes = [permissions.IsAuthenticated, permissions.IsAdminUser]

class CatalogDelete(generics.DestroyAPIView):
    queryset = Catalog.objects.all()
    serializer_class = CatalogSerializer
    permission_classes = [permissions.IsAuthenticated, permissions.IsAdminUser]