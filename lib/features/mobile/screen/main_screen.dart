import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/mobile/utils/bottom_bar.dart';
import 'package:travo_demo/features/mobile/utils/global_variables.dart';
import 'package:travo_demo/widgets/blocs/language_bloc/language_bloc.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageNumber = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int pageNum){
    pageController.jumpToPage(pageNum);
  }

  void onPageChanged(int pageNum){
    setState(() {
      pageNumber = pageNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return BlocConsumer<LanguageBloc, (String, String)>(
      listener: (BuildContext context, (String, String) state){},
      builder: (BuildContext context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: onPageChanged,
            children: mainScreenItems,
          ),
          bottomNavigationBar: Container(
            height: 60,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50)
              ),
              boxShadow: [
                  BoxShadow(
                    color: Colors.black26, 
                    blurRadius: 10.0, 
                    offset: Offset(0.0, 0.0), 
                  ),
                ],
            ),
            
            child: CupertinoTabBar(
              onTap: navigationTapped,
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  label: '',
                  icon:  BottomBar(
                    curPageNumber: pageNumber, 
                    widgetNumber: 0, 
                    text: "home".tr(),
                    icon: Icons.home_rounded,
                  ),
                
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: BottomBar(
                    curPageNumber: pageNumber, 
                    widgetNumber: 1, 
                    text: "fav".tr(), 
                    icon: Icons.favorite_rounded
                  ),
                
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon:  BottomBar(
                    curPageNumber: pageNumber, 
                    widgetNumber: 2, 
                    text: "payment".tr(), 
                    icon: Icons.cases_rounded
                  ),
              
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon:  BottomBar(
                    curPageNumber: pageNumber, 
                    widgetNumber: 3, 
                    text: "user".tr(), 
                    icon: Icons.person_rounded
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}