import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travo_demo/features/mobile/screen/home/models/booking_model.dart';
import 'package:travo_demo/features/mobile/screen/home/models/card_info_model.dart';
import 'package:travo_demo/features/mobile/screen/home/models/guest_info_model.dart';
import 'package:uuid/uuid.dart';

class BookingFirestoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future <String> bookRoom(
    {
      required String roomId,
      required String hotelId,
      required String userId,
      required String email,
      required PayCard paymentCard,
      required DateTime dateStart,
      required DateTime dateEnd,
      required List<InfoGuest> guests,
      required String promoCode,
      required String typePayment
    }
  )async{
    List<Map<String, String>> guestData = guests.map((guest) => guest.toJson()).toList();
    String res = 'Some error occurred';
    try{
      String bookId = const Uuid().v1();
      Booking bookInfo = Booking(
        uid: userId, 
        email: email, 
        paymentCard: paymentCard.toJson(), 
        dateStart: dateStart, 
        dateEnd: dateEnd, 
        guest: guestData, 
        promoCode: promoCode, 
        roomId: roomId, 
        hotelId: hotelId, 
        typePayment: typePayment);
      _firestore.collection('booking').doc(bookId).set(bookInfo.toJson());
      res = 'success';
    }catch(error){
      res = error.toString();
    }
    return res;
  }
}