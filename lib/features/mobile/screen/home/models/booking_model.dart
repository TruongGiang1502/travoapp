class Booking{
  final String uid;
  final String email;
  final Map<String, String> paymentCard;
  final DateTime dateStart;
  final DateTime dateEnd;
  final List <Map<String,String>> guest;
  final String promoCode;
  final String roomId;
  final String hotelId;
  final String typePayment;

  const Booking ({
    required this.uid,
    required this.email,
    required this.paymentCard,
    required this.dateStart,
    required this.dateEnd,
    required this.guest,
    required this.promoCode,
    required this.roomId,
    required this.hotelId,
    required this.typePayment
  });

  Map<String, dynamic> toJson() => {
    "userId": uid,
    "email": email,
    "payment_card_info": paymentCard,
    "date_start": dateStart,
    "date_end": dateEnd,
    "guest": guest,
    "promo_code": promoCode,
    "room": roomId,
    "hotel": hotelId,
    "type_payment": typePayment
  };
}