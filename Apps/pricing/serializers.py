from rest_framework import serializers
from .models import Loyalty, Fee, Points, FeeType


class FeeTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = FeeType
        fields = ["id", "description"]


class FeeSerializer(serializers.ModelSerializer):
    fee_type = serializers.CharField(source="fee_type.description")
    vehicle_type = serializers.CharField(source="vehicle_type.description")

    class Meta:
        model = Fee
        fields = "__all__"


class LoyaltySerializer(serializers.ModelSerializer):
    class Meta:
        model = Loyalty
        fields = "__all__"


class PointsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Points
        fields = "__all__"
