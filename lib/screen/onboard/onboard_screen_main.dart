import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/auth/screens/login_screen.dart';
import 'package:travo_demo/screen/onboard/utils/onboard_items.dart';
import 'package:travo_demo/screen/onboard/widget/dotindicator.dart';
import 'package:travo_demo/widgets/blocs/btn_color_bloc/btn_color_bloc.dart';
import 'package:travo_demo/widgets/blocs/btn_color_bloc/btn_color_event.dart';
import 'package:travo_demo/widgets/blocs/language_bloc/language_bloc.dart';
import 'package:travo_demo/widgets/blocs/language_bloc/language_event.dart';
import 'package:travo_demo/widgets/blocs/theme_bloc/theme_bloc.dart';
import 'package:travo_demo/widgets/blocs/theme_bloc/theme_event.dart';


class OnboardScreenMain extends StatefulWidget {
  const OnboardScreenMain({super.key});

  @override
  State<OnboardScreenMain> createState() => _OnboardScreenMainState();
}

class _OnboardScreenMainState extends State<OnboardScreenMain> {
  late PageController _pageController;
  int pageNumber = 0;

  _changeTheme (BuildContext context){
    context.read<ThemeBloc>().add(ChangeThemeEvent());
  }

  _changeBtnColor (BuildContext context){
    context.read<ButtonColorBloc>().add(ButtonColorEvent());
  }

  _changeLocale (BuildContext context){
    context.read<LanguageBloc>().add(LanguageChangeEvent());
  }

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

    return  
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions:  [
            BlocBuilder <ButtonColorBloc, Color>(
              builder: (
                (context, color){
                  return Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _changeBtnColor(context);
                          _changeTheme(context);
                        }, 
                        icon: Icon(Icons.brightness_6, color: color,),
                        
                         
                      ),
                      IconButton(
                        onPressed: (){
                          _changeLocale(context);
                        },
                        icon: Icon(Icons.translate, color: color,)
                      ),
                    ],
                  );
                }
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  flex: 6,
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
                        child: Text("next".tr()),
                      )
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
          ),
        ),
        // floatingActionButton:  FloatingActionButton(
        //     child: const Icon(Icons.brightness_6),
        //     onPressed: () => _changeTheme(context)
        //   ),
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
