import 'package:flutter/material.dart';

class OnboardScreen1 extends StatelessWidget {
  const OnboardScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(flex: 10, child: SizedBox()),
              Image.asset(
                'images/onboard_image1.png',
                width: 500,
              ),
              const Text(
                'Book a flight',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Expanded(flex: 1, child: SizedBox()),
              RichText(
                  text: const TextSpan(
                      text:
                          'Found a flight that matches your destination and schedule? Book it instantly.',
                      style: TextStyle(color: Colors.black))),
              const Expanded(flex: 10, child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: 125,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.purple),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ),
                  ),
                ],
              ),
              const Expanded(flex: 10, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
