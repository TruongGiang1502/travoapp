import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';


class OnboardScreenMain extends StatelessWidget {
  const OnboardScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            image: Image.asset('images/onboard_image1.png',),
            title: 'Booking a flight',
            body: 'Found a flight that matches your destination and schedule? Book it instantly.',
          ),
          PageViewModel(
            title: 'trang thứ hai',
            body: 'Giang'
          ),
        ],
        done: const Text('Next',),
        showNextButton: false,
        onDone: (){},
      ),
    );
  }
}