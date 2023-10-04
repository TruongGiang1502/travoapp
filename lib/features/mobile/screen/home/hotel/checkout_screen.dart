import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/checkout_pageview/book_and_review.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/checkout_pageview/checkout_payment.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/checkout_pageview/confirm_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/models/snap_model.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/text_name_checkout.dart';

class CheckOutScreen extends StatefulWidget {
  static const routeName = '/checkout_screen';
  final SnapRoomModel snapInfo;
  const CheckOutScreen({super.key, required this.snapInfo});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
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
          curve: Curves.ease);
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      "CheckOut".tr(),
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
                                  text: 'Book and review', 
                                  curPageNumber: value, 
                                  thisPageNumber: 0
                                ),
                                linesAppbarPageView(),
                                TextNameCheckOutPageView(
                                  text: 'Payment', 
                                  curPageNumber: value, 
                                  thisPageNumber: 1
                                ),
                                linesAppbarPageView(),
                                TextNameCheckOutPageView(
                                  text: 'Confirm', 
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
        controller: pageController,
        onPageChanged: (index){
          pageNumber.value = index;
        },
        children: [
          BookAndReview(
            onPressed: nextScreen ,
            snapInfo: widget.snapInfo
          ),
          CheckOutPayment(
            onPressed: nextScreen,
          ),
          const ConfirmScreen(),
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
