from rest_framework_gis.serializers import ModelSerializer, GeoFeatureModelSerializer, GeometryField
from .models import MpesaPoints


class MpesaPointsSerializer(GeoFeatureModelSerializer):
    geom = GeometryField()

    class Meta:
        model = MpesaPoints
        geo_field = 'geom'
        fields = '__all__'
