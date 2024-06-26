from datetime import datetime
from django.db.models.functions import (
    TruncDate,
)  # Import the TruncDate and Count functions
from django.db.models import Count

from rest_framework import status
from rest_framework.response import Response
from django.db import transaction
from rest_framework.decorators import action
from django.shortcuts import get_object_or_404
from django.db import transaction
from django.http import HttpResponse

from Apps.reservation_billing.models import Booking, PaymentMethod, Bill, CreditCard
from Apps.reservation_billing.serializers import (
    BookingWriteSerializer,
    PaymentMethodSerializer,
    BillSerializer,
    CreditCardSerializer,
    BookingReadSerializer,
)
from Apps.vehicle.models import Vehicle
from Apps.baseViewSet import BaseViewSet
from Apps.authentication.models import User
from Apps.parking.models import Parking, Fee
from Apps.vehicle.models import VehicleType

from helpers.get_helpers import get_current_datetime
from helpers.validate_helpers import validate_credit_card
from helpers.email_helpers import (
    send_mail_confirmation_reservation,
    send_payment_confirmation_mail,
)


def hacer_reserva(user, credit_card, booking):
    return HttpResponse("Reserva exitosa")


class BookingViewSet(BaseViewSet):
    queryset = Booking.objects.all()
    serializer_class = BookingWriteSerializer  # Serializer por defecto

    def get_serializer_class(self):
        if self.action in ["list", "retrieve"]:
            return BookingReadSerializer
        return BookingWriteSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)

        user = get_object_or_404(User, id=request.data.get("user"))
        parking = get_object_or_404(Parking, id=request.data.get("parking"))
        credit_card = get_object_or_404(CreditCard, client=user)

        send_mail_confirmation_reservation(user, parking, serializer.data)

        # TODO: Implementar la fidelización
        # send_payment_confirmation_mail(user, credit_card, booking)

        return Response(
            serializer.data, status=status.HTTP_201_CREATED, headers=headers
        )

    # [GET] api/reservation/bookings/daily_reservations/?admin_id={admin_id}
    @action(detail=False, methods=["GET"])
    def daily_reservations(self, request):
        admin_id = request.query_params.get("admin_id")
        if not admin_id:
            return Response(
                {"error": "Admin ID es requerido"}, status=status.HTTP_400_BAD_REQUEST
            )

        bookings = Booking.objects.filter(parking__admin_id=admin_id)

        daily_reservations = (
            bookings.annotate(date=TruncDate("created_date"))
            .values("date")
            .annotate(value=Count("id"))
            .order_by("-date")[:10]
        )

        response_data = [
            {"date": entry["date"], "value": entry["value"]}
            for entry in daily_reservations
        ]

        return Response({"dailyReservations": response_data})

    # [GET] api/reservation/bookings/parking_bookings/?admin_id={admin_id}
    @action(detail=False, methods=["GET"])
    def parking_bookings(self, request):
        admin_id = request.query_params.get("admin_id")
        bookings = Booking.objects.filter(parking__admin=admin_id)
        serializer = BookingReadSerializer(bookings, many=True)
        return Response(serializer.data)

    # [GET] api/reservation/bookings/today_bookings/
    @action(detail=False, methods=["GET"])
    def today_bookings(self, request):
        admin_id = request.query_params.get("admin_id")
        current_date = datetime.now().date()
        print("current_date : ", current_date)
        bookings = Booking.objects.filter(parking__admin=admin_id)
        print("Booking check-in date : ", bookings[0].check_in.date())
        count = 0
        for booking in bookings:
            print("Booking check-in date : ", booking.check_in.date())

        for booking in bookings:
            if booking.check_in.date() == current_date:
                count += 1

        return Response({"today_bookings": count})

    # [GET] api/reservation/bookings/{user_id}/user_bookings/
    @action(detail=True, methods=["GET"])
    def user_bookings(self, request, pk=None):
        user = get_object_or_404(User, pk=pk)
        bookings = Booking.objects.filter(user=user)
        serializer = self.serializer_class(bookings, many=True)
        return Response(serializer.data)

    # [POST] api/reservation/booking_total/
    @action(detail=False, methods=["POST"])
    def booking_total(self, request, *args, **kwargs):
        data = request.data

        print("Data : ", data)
        vehicle_type_id = data.get(
            "vehicle_type", 3
        )  # Usar el tipo de vehículo predeterminado si no se proporciona

        try:
            vehicle_type = VehicleType.objects.get(id=vehicle_type_id)
        except VehicleType.DoesNotExist:
            return Response({"error": "Invalid vehicle type"}, status=400)

        parking_id = data.get("parking_id")

        try:
            parking = Parking.objects.get(id=parking_id)
        except Parking.DoesNotExist:
            return Response({"error": "Invalid parking ID"}, status=400)

        check_in = datetime.fromisoformat(data.get("check_in"))
        check_out = datetime.fromisoformat(data.get("check_out"))

        fees = parking.fee.filter(vehicle_type=vehicle_type)
        print("Fees : ", fees)
        for fee in fees:
            print("Fee : ", fee.fee_type.description)
        # Obtenemos las tarifas
        try:
            hourly_fee = fees.get(fee_type__description="hora").amount
            daily_fee = fees.get(fee_type__description="día").amount
            minute_fee = fees.get(fee_type__description="minuto").amount
            reservation_fee = fees.get(fee_type__description="reserva").amount
        except Fee.DoesNotExist:
            return Response(
                {"error": "Fee information is incomplete for the given vehicle type"},
                status=400,
            )

        duration = check_out - check_in

        # Cálculo del total
        total = reservation_fee

        if duration.days > 0:
            total += duration.days * daily_fee

        remaining_seconds = duration.seconds
        total += (remaining_seconds // 3600) * hourly_fee
        remaining_seconds %= 3600
        total += (remaining_seconds // 60) * minute_fee

        return Response({"total_amount": total})


class PaymentMethodViewSet(BaseViewSet):
    queryset = PaymentMethod.objects.all()
    serializer_class = PaymentMethodSerializer


class BillViewSet(BaseViewSet):
    queryset = Bill.objects.all()
    serializer_class = BillSerializer


class CreditCardViewSet(BaseViewSet):
    queryset = CreditCard.objects.all()
    serializer_class = CreditCardSerializer

    # [POST] api/reservation/creditCards/
    def create(self, request, *args, **kwargs):
        created_date = get_current_datetime()

        with transaction.atomic():
            serializer = self.serializer_class(data=request.data)

            if serializer.is_valid():
                if not validate_credit_card(request.data):
                    return Response(
                        {"message": "Tarjeta de Credito invalida"},
                        status=status.HTTP_400_BAD_REQUEST,
                    )
                else:
                    serializer.save(created_date=created_date)
                    return Response(serializer.data, status=status.HTTP_201_CREATED)
            else:
                return Response(
                    {"error": "Datos no válidos proporcionados"},
                    status=status.HTTP_400_BAD_REQUEST,
                )

    # [GET] api/reservation/creditCards/{user_id}/user_credit_card/
    @action(detail=True, methods=["GET"])
    def user_credit_card(self, request, pk=None):
        user = get_object_or_404(User, pk=pk)
        credit_card = CreditCard.objects.filter(client=user).first()
        if credit_card:
            serializer = self.serializer_class(credit_card)
            return Response(serializer.data)
        else:
            return Response(
                {
                    "message": "No se encontró ninguna tarjeta de crédito para este usuario"
                },
                status=status.HTTP_404_NOT_FOUND,
            )
