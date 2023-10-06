class InfoGuest{
  final String name;
  final String email;
  final String phoneNumber;

  const InfoGuest({
    required this.name,
    required this.email,
    required this.phoneNumber
  });


  Map<String, String> toJson() =>{
    "name": name,
    "email": email,
    "phone_num": '+$phoneNumber'
  };


}