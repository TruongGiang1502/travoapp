class PayCard {
  final String name;
  final String cardNumber;
  final String expDate;
  final String cvv;
  final String country;

  const PayCard({
    required this.name,
    required this.cardNumber,
    required this.expDate,
    required this.cvv,
    required this.country
  });

  Map<String, String> toJson() =>{
    "name": name,
    "cardNumber": cardNumber,
    "exp_date": expDate,
    "cvv": cvv,
    "country": country 
  };

}