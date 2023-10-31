import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/flights/list_flight_pageview/multi_city_list.dart';
import 'package:travo_demo/features/mobile/screen/home/flights/list_flight_pageview/one_way_list.dart';
import 'package:travo_demo/features/mobile/screen/home/flights/list_flight_pageview/round_trip_list.dart';
import 'package:travo_demo/utils/color.dart';

class BookFlightScreen extends StatefulWidget {
  static const routeName = '/flight_screen';
  const BookFlightScreen({super.key});

  @override
  State<BookFlightScreen> createState() => _BookFlightScreenState();
}

class _BookFlightScreenState extends State<BookFlightScreen> {
  final ValueNotifier<int> pageNumber = ValueNotifier(0);
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50)),
                  image: DecorationImage(
                      image: AssetImage('images/auth_background_appbar.png'),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "book_flight".tr(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            toolbarHeight: 30,
            centerTitle: true,
          ),
        ),
      body: Padding(
        padding: const  EdgeInsets.only(
          bottom: 8,
          right: 8,
          left: 8
        ),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: pageNumber,
                  builder: (BuildContext context, int pagenum, Widget? child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: selectTypeFlightButton(
                            isChosen: pagenum == 0, 
                            onPressed: (){
                              pageController.jumpToPage(0);
                            }, text: "one_way".tr()
                          ),
                        ),
                        Expanded(
                          child: selectTypeFlightButton(
                            isChosen: pagenum == 1, 
                            onPressed: (){
                              pageController.jumpToPage(1);
                            }, 
                            text: "round_trip".tr()
                          ),
                        ),
                        Expanded(
                          child: selectTypeFlightButton(
                            isChosen: pagenum == 2, 
                            onPressed: (){
                              pageController.jumpToPage(2);
                            }, 
                            text: "multi_city".tr()
                          ),
                        )
                      ],
                    );
                  }
                ),
              ),
              Expanded(
                flex: 8,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (index){
                      pageNumber.value = index;
                    },
                    children: const [
                      OneWayList(),
                      RoundTripList(),
                      MultiCityList()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



Widget selectTypeFlightButton(
    {required bool isChosen,
    required VoidCallback onPressed,
    required String text}) {
  
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isChosen ? Colors.orange : linkWater),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
          ) 
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isChosen?Colors.white:indigo,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    ),
  );
}
