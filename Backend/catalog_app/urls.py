from django.urls import path
from .views import CatalogList, CatalogCreate, CatalogUpdate, CatalogDelete

urlpatterns = [
    path('cataloglist/', CatalogList.as_view(), name='catalog-List'),
    # path('', CatalogList.as_view(), name='catalog-list'),
    path('create/', CatalogCreate.as_view(), name='catalog-create'),
    path('update/<int:pk>/', CatalogUpdate.as_view(), name='catalog-update'),
    path('delete/<int:pk>/', CatalogDelete.as_view(), name='catalog-delete'),
]