String failImage = 'https://cdn.dribbble.com/users/936407/screenshots/2536049/media/f2087724b9d677904b39212de99726bc.gif';
String failData = 'Failed load data';

class SnapPlaceModel {
  String? name, imageUrl, rating;

  SnapPlaceModel.fromSnap(Map<String, dynamic>? snap) {
    if (snap == null) {
      name = failData;
      imageUrl = failImage;
      rating = '0';
    } else {
      name = snap['name'];
      imageUrl = snap['image'];
      rating = snap['rating'].toString();
    }
  }
}

class SnapHotelModel {
  String? imageUrl,
      information,
      location,
      locationDesc,
      name,
      price,
      rating,
      totalReview;
  SnapHotelModel.fromSnap(Map<String, dynamic>? snap){
    if(snap == null){
      imageUrl = failImage;
      information = failData;
      location = failData;
      locationDesc = failData;
      name = failData;
      price = '0';
      rating = '0';
      totalReview = '0';
    }
    else {
      imageUrl = snap['image'];
      information = snap['information'];
      location = snap['location'];
      locationDesc = snap['location_description'];
      name = snap['name'];
      price = snap['price'].toString();
      rating = snap['rating'].toString();
      totalReview = snap['total_review'].toString();
    }
  }
}

class SnapRoomModel {
  String? hotelId ,imageUrl, maxGuest, name, price, total, typePrice;
  List<dynamic>? services;

  SnapRoomModel.fromSnap(Map<String, dynamic>? snap){
    if(snap == null){
      hotelId = '';
      imageUrl = failImage;
      maxGuest = '0';
      name = failData;
      price = '0';
      total = '0';
      typePrice = failData;
      services = [];
    }
    else {
      hotelId = snap['hotel'];
      imageUrl = snap['image'];
      maxGuest = snap['max_guest'].toString();
      name = snap['name'];
      price = snap['price'].toString();
      total = snap['total'].toString();
      typePrice = snap['type_price'];
      services = snap['services'];
    }
  }
}
