import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/flights/result_flight_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/options_flight.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/utils/color.dart';

class OneWayList extends StatelessWidget {
  const OneWayList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ValueNotifier<String> fromAirport = ValueNotifier('Jarkatar');
    ValueNotifier<String> toAirport = ValueNotifier('Surabaya');

    return Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                ValueListenableBuilder(
                    valueListenable: fromAirport,
                    builder: (context, name, child) {
                      return OptionToFlight(
                        onPressed: (){}, 
                        context: context, 
                        title: "from".tr(), 
                        text: name,
                        icon: Icons.airplanemode_active_outlined,
                        isAngleIcon: true,
                        iconColor: indigo,
                      );
                    }),
                ValueListenableBuilder(
                  valueListenable: toAirport,
                  builder: (context, name, child) {
                    return OptionToFlight(
                        onPressed: () {},
                        context: context,
                        title: "to".tr(),
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
          title: "depature".tr(), 
          text: "select_date".tr(),
          iconColor: Colors.red,
          iconSvgUrl: 'images/flight_screen_icon/time_flight.svg' 
        ),
        OptionToFlight(
          onPressed: (){}, 
          context: context, 
          title: "passer_title".tr(), 
          text: '1 ${"passenger".tr()}',
          iconColor: Colors.red,
          iconSvgUrl: 'images/flight_screen_icon/passenger.svg' 
        ),
        OptionToFlight(
          onPressed: (){}, 
          context: context, 
          title: "class".tr(), 
          text: "economy".tr(),
          iconColor: Colors.red,
          iconSvgUrl: 'images/flight_screen_icon/class.svg' 
        ),
        CustomButton(
          onPressed: (){
            Navigator.pushNamed(context, ResultFlightScreen.routeName);
          }, 
          text: "search".tr(), 
          width: 1
        )
      ],
    );
  }
}