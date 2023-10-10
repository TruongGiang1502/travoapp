import 'package:flutter/material.dart';
import 'package:travo_demo/utils/color.dart';
import 'package:travo_demo/widgets/container_decor.dart';

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
                      return optionToFlight(
                          onPressed: () {},
                          context: context,
                          title: 'From',
                          text: name,
                          icon: Icons.airplanemode_active_outlined,
                          isAngleIcon: true);
                    }),
                const SizedBox(
                  height: 10,
                ),
                ValueListenableBuilder(
                  valueListenable: toAirport,
                  builder: (context, name, child) {
                    return optionToFlight(
                        onPressed: () {},
                        context: context,
                        title: 'To',
                        text: toAirport.value,
                        icon: Icons.location_city_outlined);
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
                ))
          ],
        ),
      ],
    );
  }
}

Widget optionToFlight(
    {bool isAngleIcon = false,
    required VoidCallback onPressed,
    required BuildContext context,
    required String title,
    required String text,
    required IconData icon}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: ContainerBoxDecor(
        child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                children: [
                  Transform.rotate(
                      angle: isAngleIcon ? 3.1415 : 0,
                      child: Icon(
                        icon,
                        color: indigo,
                      ))
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ],
              )
            ],
          )),
    )),
  );
}
