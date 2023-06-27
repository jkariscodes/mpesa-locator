from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.permissions import IsAuthenticated
from rest_framework import viewsets
from .models import MpesaPoints
from .serializers import MpesaPointsSerializer
from .filters import MpesaPointsFilter


class MpesaPointsViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = [IsAuthenticated]
    queryset = MpesaPoints.objects.all()
    serializer_class = MpesaPointsSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = '__all__'
    filterset_class = MpesaPointsFilter
