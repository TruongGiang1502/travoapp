import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/flights/result_flight_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/options_flight.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/utils/color.dart';

class MultiCityList extends StatelessWidget {
  const MultiCityList({super.key});
  
  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      child: SingleChildScrollView(
        child: Column(
          children: [
            selectFlight(context,1),
            selectFlight(context,2),
            CustomButton(
              onPressed: (){
                Navigator.pushNamed(context, ResultFlightScreen.routeName);
              }, 
              text: 'Search', 
              width: 1
            )
          ],
        ),
      )
    );
  }
}

Widget selectFlight(BuildContext context, int flyNum){
  ValueNotifier<String> fromAirport = ValueNotifier('Jarkatar');
  ValueNotifier<String> toAirport = ValueNotifier('Surabaya');
  final size = MediaQuery.of(context).size;
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Flight $flyNum',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ),
        Stack(
          children: [
            Column(
              children: [
                ValueListenableBuilder(
                    valueListenable: fromAirport,
                    builder: (context, name, child) {
                      return OptionToFlight(
                          onPressed: () {},
                          context: context,
                          title: 'From',
                          text: name,
                          icon: Icons.airplanemode_active_outlined,
                          isAngleIcon: true,
                          iconColor: indigo!);
                    }),
                ValueListenableBuilder(
                  valueListenable: toAirport,
                  builder: (context, name, child) {
                    return OptionToFlight(
                        onPressed: () {},
                        context: context,
                        title: 'To',
                        text: toAirport.value,
                        icon: Icons.location_on,
                        iconColor: Colors.orange
                      );
                  }
                ),
              ],
            ),
            Positioned(
                left: size.width * 0.75,
                top: size.height * 0.05,
                child: Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: linkWater),
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          String text = fromAirport.value;
                          fromAirport.value = toAirport.value;
                          toAirport.value = text;
                        },
                        icon: Icon(
                          Icons.swap_vert_rounded,
                          color: indigo,
                          size: 35,
                        ),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                    ),
                  ),
                )
              ),
          ],
        ),
        OptionToFlight(
          onPressed: (){}, 
          context: context, 
          title: 'Depature', 
          text: 'Select Date',
          iconColor: Colors.red,
          iconSvgUrl: 'images/flight_screen_icon/time_flight.svg' 
        ),
        OptionToFlight(
          onPressed: (){}, 
          context: context, 
          title: 'Passenger', 
          text: '1 Passenger',
          iconColor: Colors.red,
          iconSvgUrl: 'images/flight_screen_icon/passenger.svg' 
        ),
        OptionToFlight(
          onPressed: (){}, 
          context: context, 
          title: 'Class', 
          text: 'Economy',
          iconColor: Colors.red,
          iconSvgUrl: 'images/flight_screen_icon/class.svg' 
        ),
      ],
    );
}