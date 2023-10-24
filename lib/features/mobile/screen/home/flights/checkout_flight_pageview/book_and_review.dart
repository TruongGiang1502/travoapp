import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/add_widget_custom.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/custom_flight_info.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/utils/color.dart';

class BookReviewFlightScreen extends StatelessWidget {
  final VoidCallback onPressed;
  const BookReviewFlightScreen({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TopChildWidget(child: topContentCheckout('JKT', 'Jakarta', 'SBY', 'Surabaya', size)),
                MiddleChildWidget(
                  child: midContentCheckout(
                      iconFlightBrandUrl: 'images/flight_screen_icon/test_logo_air.png',
                      flightBrandName: 'Air Asia',
                      passengerName: 'James Christin',
                      time: '24 Mar 2020',
                      gate: '24A',
                      flightNo: 'NNS24',
                      boardingTime: '02:39pm',
                      seat: '5A',
                      seatClass: 'Economy'
                    ),
                ),
                BottomChildWidget(child: bottomContentCheckout('215')),
                const SizedBox(height: 10,),
                AddInfoGuestCustom(
                  onPressed: () {},
                  imageUrl: 'images/flight_screen_icon/contact_detail.svg', 
                  title: 'Contact Details',
                  defaultText: 'Add Contact', 
                  listInfoGuest: const [],
                  heroTag: 'contact_flight_hero',
                  textSize: 13,
                ),
                AddInfoGuestCustom(
                  onPressed: () {},
                  imageUrl: 'images/flight_screen_icon/passenger_icon.svg', 
                  title: 'Passengers & Seats',
                  defaultText: 'Add Passenger', 
                  listInfoGuest: const [],
                  heroTag: 'passenger_flight_hero',
                  textSize: 13,
                ),
                AddPromoCodeCustom(
                    onPressed: (){},
                    imageUrl: 'images/flight_screen_icon/promo_code.svg', 
                    title: 'Promo Code',
                    defaultText: 'Add Promo Code', 
                    textFunction: '',
                    heroTag: 'promo_hero',
                    sizeText: 20,
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    onPressed: onPressed, 
                    text: 'Payment', 
                    width: 1),
                )
              ],
            ),
          ),
    );
  }
}


//Widget
Widget topContentCheckout(String shortNameFrom, String fullNameFrom, String shortNameTo, String fullNameTo, Size size){
  Widget airPortName(String shortName, String fullName){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              shortName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              fullName,
              style: TextStyle(
                fontSize: 15,
                color: greyColor
              ),
            ),
          ],
        );
  }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 64.0),
    child: Row(
      children: [
        airPortName(shortNameFrom, fullNameFrom),
        linesCustom(),
        Transform.rotate(
          angle: 3.1415/2,
          child: const Icon(
            Icons.flight,
            color: Colors.black,
            size: 30,
          ),
        ),
        linesCustom(),
        airPortName(shortNameTo, fullNameTo)
      ],
    ),
  );
}

Widget linesCustom(){
  return const Expanded(
    flex: 1,
    child: Divider(
      height: 5,
      indent: 10,
      endIndent: 10,
      thickness: 1,
      color: Colors.black,
    ),
  );
}

Widget midContentCheckout(
  {
    required String iconFlightBrandUrl,
    required String flightBrandName,
    required String passengerName,
    required String time,
    required String gate,
    required String flightNo,
    required String boardingTime,
    required String seat,
    required String seatClass,
  }
){
  Widget infoText(String title, String text){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: greyColor
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),
        ),
        
      ],
    );
  }
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 32.0,
      vertical: 4
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              iconFlightBrandUrl,
              scale: 2,
            ),
            infoText('Airline', flightBrandName),
            infoText('Passengers', passengerName)
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoText('Date', time),
                const SizedBox(
                  height: 20,
                ),
                infoText('Boarding Time', boardingTime),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoText('Gate', gate),
                const SizedBox(
                  height: 20,
                ),
                infoText('Seat', seat),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoText('Flight No.', flightNo),
                const SizedBox(
                  height: 20,
                ),
                infoText('Class', seatClass),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget bottomContentCheckout(String price){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Text(
              '\$$price',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),
            ),
            const Text(
              '/passenger'
            )
          ],
        ),
        const Text('1 passenger')
      ],
    ),
  );
}


