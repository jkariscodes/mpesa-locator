from django.contrib.gis import admin
from leaflet.admin import LeafletGeoAdmin
from .models import MpesaPoints


@admin.register(MpesaPoints)
class MpesaPoints(LeafletGeoAdmin):
    list_display = ('formatted_field', 'input_stri', 'county',)
    list_filter = ('county',)
    list_per_page = 100
