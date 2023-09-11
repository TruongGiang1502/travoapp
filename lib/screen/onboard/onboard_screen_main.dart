import 'package:flutter/material.dart';
import 'package:travo_demo/features/auth/screens/login_screen.dart';
import 'package:travo_demo/screen/onboard/onboard_items.dart';
import 'package:travo_demo/screen/onboard/widget/dotindicator.dart';

class OnboardScreenMain extends StatefulWidget {
  const OnboardScreenMain({super.key});

  @override
  State<OnboardScreenMain> createState() => _OnboardScreenMainState();
}

class _OnboardScreenMainState extends State<OnboardScreenMain> {
  late PageController _pageController;
  int pageNumber = 0;

  void pageChangeScreen(){
    if (pageNumber < 2) {
      _pageController.nextPage(
          duration: const Duration(microseconds: 900),
          curve: Curves.ease);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginScreen()));
    }
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: 3,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      pageNumber = index;
                    });
                  },
                  itemBuilder: (context, index) => OnboardContent(
                      imageUrl: onboardItem[index].imageUrl,
                      title: onboardItem[index].title,
                      decription: onboardItem[index].decription),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                      onboardItem.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: DotIndicator(active: index == pageNumber),
                          )),
                  const Spacer(),
                  SizedBox(
                      child: ElevatedButton(
                    onPressed: pageChangeScreen,
                    child: const Text('Next'),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  final String imageUrl, title, decription;
  const OnboardContent(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.decription});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(imageUrl),
          const Spacer(
            flex: 1,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          const Spacer(flex: 1),
          Text(
            decription,
            textAlign: TextAlign.center,
          ),
          const Spacer(
            flex: 20,
          )
        ],
      ),
    );
  }
}
