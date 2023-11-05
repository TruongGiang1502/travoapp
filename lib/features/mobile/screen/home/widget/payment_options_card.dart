import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travo_demo/widgets/container_decor.dart';
import 'package:travo_demo/utils/color.dart';

class PaymentOptionsCard extends StatelessWidget {
  final ValueNotifier<bool> isChosen;
  final Widget? child;
  final String iconUrl;
  final String text;
  final Function onChanged;
  const PaymentOptionsCard(
      {super.key,
      required this.isChosen,
      this.child,
      required this.iconUrl,
      required this.text,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ContainerBoxDecor(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(iconUrl),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              ValueListenableBuilder(
                valueListenable: isChosen,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      side: BorderSide.none,
                      value: value,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      checkColor: indigo,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return linkWater!;
                        }
                      ),
                      onChanged: (index) {
                        isChosen.value = index!;
                        onChanged();
                      }
                    ),
                  );
                }
              ),
            ],
          ),
          addCard(child)
        ],
      ),
    ));
  }
}

Widget addCard(Widget? child) {
  if (child == null) {
    return const SizedBox();
  }
  return child;
}
