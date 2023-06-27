from django.contrib.gis.db import models


class MpesaPoints(models.Model):
    formatted_field = models.CharField(max_length=254)
    latitude = models.FloatField()
    longitude = models.FloatField()
    input_stri = models.CharField(max_length=254)
    county = models.CharField(max_length=20)
    geom = models.MultiPointField(srid=4326)
