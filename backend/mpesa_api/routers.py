from rest_framework.routers import SimpleRouter
from .viewsets import MpesaPointsViewSet


routes = SimpleRouter()

# MPESA
routes.register(r'gis', MpesaPointsViewSet, basename='mpesa-points')


urlpatterns = [
    *routes.urls
]
