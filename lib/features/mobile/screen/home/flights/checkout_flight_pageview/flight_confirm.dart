import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/custom_flight_info.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/utils/color.dart';
import 'package:travo_demo/widgets/container_decor.dart';

class FlightConfirm extends StatelessWidget {
  final VoidCallback onPressed;
  const FlightConfirm({super.key, required this.onPressed});

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
                totalPayment(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    onPressed: onPressed, 
                    text: 'Pay Now', 
                    width: 1),
                )
              ],
            ),
          ),
    );
  }
}
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
                color: Colors.black
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
            fontSize: 15,
            color: Colors.black
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
    child: Column(
     //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/flight_screen_icon/barcode1.png'),
            Image.asset('images/flight_screen_icon/barcode2.png'),
            Image.asset('images/flight_screen_icon/barcode3.png'),
          ],
        ),
        const Text(
          '1234 5678 90AS 6543 21CV',
          style: TextStyle(
            color: Colors.black
          ),
        )
      ],
    ),
  );
}

Widget totalPayment(){
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: ContainerBoxDecor(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '1 Passenger',
                    style: TextStyle(
                        color: Colors.black
                      ),
                  ),
                  Text(
                    '\$215',
                    style: TextStyle(
                        color: Colors.black
                      ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Insurance',
                    style: TextStyle(
                        color: Colors.black
                      ),
                  ),
                  Text(
                    '-',
                    style: TextStyle(
                        color: Colors.black
                      ),
                  ),
                ],
              ),
              Divider(thickness: 1, color: Colors.grey,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black
                    ),
                  ),
                  Text(
                    '\$215',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ),
  );
}
