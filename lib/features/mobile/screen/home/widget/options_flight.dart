import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travo_demo/widgets/container_decor.dart';

class OptionToFlight extends StatelessWidget {
  final bool isAngleIcon;
  final VoidCallback onPressed;
  final BuildContext context;
  final String title;
  final String text;
  final IconData? icon;
  final String iconSvgUrl;
  final Color iconColor;
  const OptionToFlight(
      {super.key,
      this.isAngleIcon = false,
      required this.onPressed,
      required this.context,
      required this.title,
      required this.text,
      this.icon,
      this.iconSvgUrl = '',
      this.iconColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      SizedBox(
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
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.rotate(
                          angle: isAngleIcon ? 3.1415 : 0,
                          child: icon != null ?Icon(
                            icon,
                            color: iconColor,
                          ):Center(child: SvgPicture.asset(iconSvgUrl))
                      )
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
      ),
      const SizedBox(height: 10,)
    ],
  );
  }
}
