from rest_framework import serializers
from .models import Catalog
# from catalog_app import models
class CatalogSerializer(serializers.ModelSerializer):
    # name=serializers.StringRelatedField()
    class Meta:
        model= Catalog
        fields= ['id','name','desc','price','color','image']
        # model=models.Catalogs