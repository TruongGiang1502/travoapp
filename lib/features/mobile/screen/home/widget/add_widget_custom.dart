import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/container_decor.dart';

class AddWidgetCustom extends StatelessWidget {
  final VoidCallback onPressed;
  final String imageUrl, title, textFunction, heroTag;
  const AddWidgetCustom(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.textFunction,
      required this.onPressed,
      required this.heroTag});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ContainerBoxDecor(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(imageUrl),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              LayoutBuilder(builder: (context, constraint) {
                return Container(
                  width: constraint.maxWidth * 0.75,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(224, 221, 245, 1),
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      FloatingActionButton(
                        heroTag: heroTag,
                        onPressed: onPressed,
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        textFunction,
                        style: const TextStyle(
                            color: Color.fromRGBO(97, 85, 204, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
