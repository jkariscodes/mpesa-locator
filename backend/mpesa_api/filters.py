from django.contrib.gis.db.models import MultiPointField
from rest_framework_gis.filterset import GeoFilterSet
from rest_framework_gis.filters import GeometryFilter
from .models import MpesaPoints


class MpesaPointsFilter(GeoFilterSet):
    class Meta:
        model = MpesaPoints
        fields = '__all__'
        filter_overrides = {
            MultiPointField: {
                'filter_class': GeometryFilter,
                'extra': lambda f: {
                    'lookup_expr': 'equals',
                },
            },
        }
