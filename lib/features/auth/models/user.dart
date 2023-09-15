import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String email;
  final String uid;
  final String username;
  final String country;
  final String phoneNumber;

  const Users(
      {required this.email,
      required this.uid,
      required this.username,
      required this.country,
      required this.phoneNumber});

  Map<String, String> toJson() => {
    "email": email,
    "uid": uid,
    "username": username,
    "country": country,
    "phoneNumber": phoneNumber
  };

  static Users fromSnap(DocumentSnapshot snapshot){
    var snapShot = snapshot.data() as Map<String, String>;
    return Users(
      email: snapShot["email"]!,
      uid: snapShot["uid"]!,
      username: snapShot["username"]!,
      country: snapShot["country"]!,
      phoneNumber: snapShot["phoneNumber"]!
    );
  }
}
