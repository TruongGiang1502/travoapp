import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travo_demo/features/mobile/screen/home/models/card_info_model.dart';
import 'package:travo_demo/features/mobile/screen/home/models/guest_info_model.dart';
import 'package:travo_demo/features/mobile/screen/home/models/snap_model.dart';
import 'package:travo_demo/features/mobile/screen/home/services/book_firestore_method.dart';
import 'package:travo_demo/features/mobile/screen/home/utils/date_time_custom.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_card_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_info_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_paytype_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_promo_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/time_check_cubit.dart';
import 'package:travo_demo/features/mobile/screen/main_screen.dart';
import 'package:travo_demo/features/mobile/utils/show_dialog.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/utils/color.dart';
import 'package:travo_demo/widgets/container_decor.dart';

class ConfirmScreen extends StatefulWidget {
  final SnapRoomModel snapInfo;
  final String roomId;
  final VoidCallback previousPage;
  const ConfirmScreen(
      {super.key, required this.snapInfo, required this.roomId, required this.previousPage});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  Future<ConnectivityResult> checkInternet () async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult;
  }
  @override
  Widget build(BuildContext context) {
    String? userEmail = FirebaseAuth.instance.currentUser?.email.toString();
    String? userId = FirebaseAuth.instance.currentUser?.uid.toString();
    ConnectivityResult connection = ConnectivityResult.none;
    return FutureBuilder<ConnectivityResult>(
      future: checkInternet(),
      builder: (context, snapInternet) {
        if(snapInternet.connectionState == ConnectionState.waiting && connection != snapInternet.data){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        else if(snapInternet.data == ConnectivityResult.none || snapInternet.data == ConnectivityResult.other || userEmail == null){
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No internet found! Please try again!'),
                TextButton(onPressed: (){
                  setState(() {});
                }, child: const Text('Try again'))
              ],
            )
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              roomInfo(context, widget.snapInfo),
              BlocBuilder<TimeCheckinCubit, DateTime>(
                  builder: (context, checkinTime) {
                return BlocBuilder<TimeCheckoutCubit, DateTime>(
                    builder: (context, checkoutTime) {
                  return payCalulate(
                      checkinTime: checkinTime,
                      checkoutTime: checkoutTime,
                      snapInfo: widget.snapInfo);
                });
              }),
              BlocBuilder<PayTypeCubit, String>(
                builder: (context, payMethod) {
                  return paymentMethod(payMethod, widget.previousPage);
                },
              ),
              payNowButton(context, widget.roomId, widget.snapInfo.hotelId!, userId, userEmail),
            ],
          ),
        );
      }
    );
  }
}

Widget roomInfo(BuildContext context, SnapRoomModel snapInfo) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ContainerBoxDecor(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      snapInfo.name!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${"max_guest".tr()}: ${snapInfo.maxGuest}',
                      style: const TextStyle(
                        color: Colors.black
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      snapInfo.typePrice!,
                      style: const TextStyle(
                        color: Colors.black
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    snapInfo.imageUrl!,
                    width: 70,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.withOpacity(0.3),
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<TimeCheckinCubit, DateTime>(
                      builder: (context, chekinTime) {
                    return timeChosen(
                        iconUrl: 'images/checkout_icon/date1_icon.svg',
                        text: "check_in".tr(),
                        time: chekinTime);
                  }),
                  BlocBuilder<TimeCheckoutCubit, DateTime>(
                      builder: (context, chekoutTime) {
                    return timeChosen(
                        iconUrl: 'images/checkout_icon/date2_icon.svg',
                        text: "check_out".tr(),
                        time: chekoutTime);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget timeChosen(
    {required String iconUrl, required String text, required DateTime time}) {
  return Row(
    children: [
      SvgPicture.asset(
        iconUrl,
        width: 40,
        height: 40,
      ),
      const SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          Text(
            timeWithShortNameMonth(time),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
          ),
        ],
      )
    ],
  );
}

Widget payCalulate(
    {required DateTime checkinTime,
    required DateTime checkoutTime,
    required SnapRoomModel snapInfo}) {
  int days = checkoutTime.difference(checkinTime).inDays + 1;
  int price = int.parse(snapInfo.price!);
  return Padding(
    padding: const EdgeInsets.all(16),
    child: ContainerBoxDecor(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      days.toString(),
                      style: const TextStyle(
                        color: Colors.black
                      ),
                    ), 
                    const Text(
                      ' nights',
                      style: TextStyle(
                        color: Colors.black
                      ),
                    )],
                ),
                Text(
                  '\$${price * days}',
                  style: const TextStyle(
                      color: Colors.black
                    ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "taxefee".tr(),
                  style: const TextStyle(
                    color: Colors.black
                  ),
                ), 
                Text(
                  "free".tr(),
                  style: const TextStyle(
                    color: Colors.black
                  ),
                )],
            ),
            Divider(
              color: Colors.grey.withOpacity(0.3),
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "total".tr(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  '\$${int.parse(snapInfo.price!) * days}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

String namePayMethod(String methodName) {
  String payMethodFullName;
  switch (methodName) {
    case 'cash':
      payMethodFullName = "cash".tr();
    case 'card':
      payMethodFullName = "credit/debit".tr();
    default:
      payMethodFullName = "bank".tr();
  }
  return payMethodFullName;
}

Widget paymentMethod(String methodName, VoidCallback previousPage) {
  String payIconUrl;
  String payMethodFullName = namePayMethod(methodName);
  switch (methodName) {
    case 'cash':
      payIconUrl = 'images/checkout_icon/mini_market.svg';
    case 'card':
      payIconUrl = 'images/checkout_icon/credit_card.svg';
    default:
      payIconUrl = 'images/checkout_icon/bank_transfer.svg';
  }

  return Padding(
    padding: const EdgeInsets.all(16),
    child: ContainerBoxDecor(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(payIconUrl),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  payMethodFullName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                )
              ],
            ),
            TextButton(
                onPressed: previousPage,
                child: Text(
                  "change".tr(),
                  style:
                      TextStyle(fontWeight: FontWeight.normal, color: indigo),
                ))
          ],
        ),
      ),
    ),
  );
}

void paynow(
    BuildContext context,
    String roomId,
    String hotelId,
    String userId,
    String email,
    PayCard paymentCard,
    DateTime dateStart,
    DateTime dateEnd,
    List<InfoGuest> guest,
    String promoCode,
    String typePayment) async {
  try {
    String res = await BookingFirestoreMethod().bookRoom(
        roomId: roomId,
        hotelId: hotelId,
        userId: userId,
        email: email,
        paymentCard: paymentCard,
        dateStart: dateStart,
        dateEnd: dateEnd,
        guests: guest,
        promoCode: promoCode,
        typePayment: typePayment);

    if (res == 'success') {
      // ignore: use_build_context_synchronously
      ShowDialog.showSimpleDialogAndNavigate(
          context, 'Book room successful', 'Your booking is successful', MainScreen.routeName);
      // ignore: use_build_context_synchronously
      //Navigator.popAndPushNamed(context, MainScreen.routeName);
    }
  } catch (error) {
    // ignore: use_build_context_synchronously
    ShowDialog.showSimpleDialog(context, 'ERROR!', error.toString());
  }
}

Widget payNowButton(BuildContext context, String roomId,
    String hotelId, String? userId, String? userEmail) {
  return BlocBuilder<GetInfoCubit, List<InfoGuest>>(
      builder: (context, info) {
    return BlocBuilder<GetPromoCodeCubit, String>(
        builder: (context, promoCode) {
      return BlocBuilder<TimeCheckinCubit, DateTime>(
          builder: (context, checkinTime) {
        return BlocBuilder<TimeCheckoutCubit, DateTime>(
            builder: (context, checkoutTime) {
          return BlocBuilder<PayTypeCubit, String>(
              builder: (context, payMethod) {
            return BlocBuilder<GetCardCubit, PayCard>(
                builder: (context, cardInfo) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                    onPressed: () {
                      if(userEmail!= null && userId!=null){
                        paynow(
                          context,
                          roomId,
                          hotelId,
                          userId,
                          userEmail,
                          cardInfo,
                          checkinTime,
                          checkoutTime,
                          info,
                          promoCode,
                          namePayMethod(payMethod));
                      }
                      else{
                        ShowDialog.showSimpleDialog(context, 'Failed', 'Some error occured! Please try again later');
                      }
                    },
                    text: "paynow".tr(),
                    width: 1),
              );
            });
          });
        });
      });
    });
  });
}
