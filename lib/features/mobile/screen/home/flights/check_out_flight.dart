import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/flights/checkout_flight_pageview/book_and_review.dart';
import 'package:travo_demo/features/mobile/screen/home/flights/checkout_flight_pageview/flight_confirm.dart';
import 'package:travo_demo/features/mobile/screen/home/flights/checkout_flight_pageview/flight_payment.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/text_name_checkout.dart';

class CheckOutFlight extends StatefulWidget {
  static const routeName = '/check-out-flight';
  const CheckOutFlight({super.key});

  @override
  State<CheckOutFlight> createState() => _CheckOutFlightState();
}

class _CheckOutFlightState extends State<CheckOutFlight> {
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

  void nextScreen(){
    if (pageNumber.value < 2) {
      pageController.nextPage(
          duration: const Duration(microseconds: 900),
          curve: Curves.ease
      );
    } else {
    }
  }

  void previousScreen(){
    if (pageNumber.value > 0) {
      pageController.previousPage(
          duration: const Duration(microseconds: 900),
          curve: Curves.ease
      );
    } else {
    }
  }
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
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
                Column(
                  children: [
                    Text(
                      "checkout".tr(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ValueListenableBuilder(
                        valueListenable: pageNumber,
                        builder: (BuildContext context, int value, Widget? child) {
                          return SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextNameCheckOutPageView(
                                  text: "fly_book".tr(), 
                                  curPageNumber: value, 
                                  thisPageNumber: 0
                                ),
                                linesAppbarPageView(),
                                TextNameCheckOutPageView(
                                  text: "payment_check".tr(), 
                                  curPageNumber: value, 
                                  thisPageNumber: 1
                                ),
                                linesAppbarPageView(),
                                TextNameCheckOutPageView(
                                  text: "confirm".tr(), 
                                  curPageNumber: value, 
                                  thisPageNumber: 2
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        //physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index){
          pageNumber.value = index;
        },
        children: [
          BookReviewFlightScreen(
            onPressed: nextScreen ,
            // snapInfo: widget.snapInfo
          ),
          PaymentFlight(
            onPressed: nextScreen,
          ),
          FlightConfirm(onPressed: (){},),
        ],
      )
    );
  }
}

Widget linesAppbarPageView(){
  return const Expanded(
    flex: 1,
    child: Divider(
      height: 5,
      indent: 10,
      endIndent: 10,
      thickness: 2,
      color: Colors.white,
    ),
  );
}
