import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/add_contact_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/add_promo_code.dart';
import 'package:travo_demo/features/mobile/screen/home/models/guest_info_model.dart';
import 'package:travo_demo/features/mobile/screen/home/models/snap_model.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/add_widget_custom.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_info_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_promo_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/time_check_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/pick_date.dart';
import 'package:travo_demo/features/mobile/utils/show_dialog.dart';
import 'package:travo_demo/widgets/container_decor.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/services_option.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';

class BookAndReview extends StatefulWidget {
  final SnapRoomModel snapInfo;
  final VoidCallback onPressed;
  const BookAndReview({super.key, required this.onPressed,required this.snapInfo});

  @override
  State<BookAndReview> createState() => _BookAndReviewState();
}

class _BookAndReviewState extends State<BookAndReview> {
  Future<ConnectivityResult> checkInternet () async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult;
  }
   ConnectivityResult connection = ConnectivityResult.none;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConnectivityResult>(
      future: checkInternet(),
      builder: (context, snapInternet) {
        if(snapInternet.connectionState == ConnectionState.waiting && connection != snapInternet.data){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        else if(snapInternet.data == ConnectivityResult.none || snapInternet.data == ConnectivityResult.other){
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
                BlocBuilder<GetInfoCubit, List <InfoGuest>>(
                  builder: (context, info) {
                    return AddInfoGuestCustom(
                      onPressed: () {
                        addContactCheck(context, info, widget.snapInfo); 
                      },
                      imageUrl: 'images/checkout_icon/addcontact_icon.svg', 
                      title: "contact_detail".tr(),
                      defaultText: "add_contact".tr(), 
                      listInfoGuest: info,
                      heroTag: 'contact_hero',
                      textSize: 13,
                    );
                  }
                ),
                BlocBuilder<GetPromoCodeCubit, String>(
                  builder: (context, promoCode) {
                    return AddPromoCodeCustom(
                      onPressed: (){
                        gotPromoCode(context);
                      },
                      imageUrl: 'images/checkout_icon/addpromo_icon.svg', 
                      title: "promocode".tr(),
                      defaultText: "add_promocode".tr(), 
                      textFunction: promoCode,
                      heroTag: 'promo_hero',
                      sizeText: 20,
                    );
                  }
                ),
                dateBooking(context),
                BlocBuilder<GetInfoCubit, List<InfoGuest>>(
                  builder: (context, info) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomButton(
                        onPressed: info.isNotEmpty?widget.onPressed : () {showCheckEmptyConsumer(context);},
                        text: "payment_check".tr(), 
                        width: MediaQuery.of(context).size.width
                      ),
                    );
                  }
                ),
              ],
            ),
          );
      }
    );
  }
}

 Widget roomInfo(BuildContext context ,SnapRoomModel snapInfo) {
  
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    Text(
                      'Max guest: ${snapInfo.maxGuest}',
                      style: const TextStyle(
                        color: Colors.black
                      ),
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
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                height: 100,
                child: ServicesOption(context: context ,services: snapInfo.services!)
              ),
            ),
            Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 2,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${snapInfo.price}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    Text(
                      '/${'night'.tr()}',
                      style: const TextStyle(
                        color: Colors.grey
                      ),
                    )
                  ],
                ),
                Text(
                  '${snapInfo.total} ${"room".tr()}',
                  style: const TextStyle(
                    color: Colors.black
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget dateBooking(BuildContext context){
  
  void showSelectCheckinDate(BuildContext context, DateTime timeCheckout)async{
    final DateTime picked = (
      await showDatePicker(
        context: context, 
        initialDate: DateTime.now(), 
        firstDate: DateTime.now(), 
        lastDate: DateTime(DateTime.now().year+1),
        builder: (BuildContext context, Widget? child){
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.pink,
              buttonTheme: ButtonThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1)
                )
              )
            ), 
            child: child!
          );
        }
      )
    )??DateTime.now();
    // ignore: use_build_context_synchronously
    context.read<TimeCheckinCubit>().getCheckinTime(picked);
    if(timeCheckout.difference(picked).inDays < 0){
      // ignore: use_build_context_synchronously
      context.read<TimeCheckoutCubit>().getCheckoutTime(picked);
    }
  }

  void showSelectCheckoutDate(BuildContext context, DateTime checkinDate)async{
    final DateTime picked = (
      await showDatePicker(
        context: context, 
        initialDate: checkinDate, 
        firstDate: checkinDate, 
        lastDate: DateTime(DateTime.now().year+2),
        builder: (BuildContext context, Widget? child){
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.pink,
              buttonTheme: ButtonThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1)
                )
              )
            ), 
            child: child!
          );
        }
      )
    )??DateTime.now();
    // ignore: use_build_context_synchronously
    context.read<TimeCheckoutCubit>().getCheckoutTime(picked);
  }

  return Padding(
    padding: const EdgeInsets.all(16),
    child: ContainerBoxDecor(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          child: Column(
            children: [
              Text(
                "booking_date".tr(), 
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<TimeCheckinCubit, DateTime>(
                builder: (context, timeCheckin) {
                  return BlocBuilder<TimeCheckoutCubit, DateTime>(
                    builder: (context, timeCheckout) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PickDate(
                            onPressed: (){
                              showSelectCheckinDate(context, timeCheckout);
                            }, 
                            iconUrl: 'images/checkout_icon/date1_icon.svg', 
                            text: "check_in".tr(), 
                            dateValueWidget: Text(
                              DateFormat('E, d/MM').format(timeCheckin), 
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                              
                          ), 
                          PickDate(
                            onPressed: (){
                              showSelectCheckoutDate(context, timeCheckin);
                            }, 
                            iconUrl: 'images/checkout_icon/date2_icon.svg', 
                            text: "check_out".tr(), 
                            dateValueWidget: Text(
                                DateFormat('E, d/MM').format(timeCheckout), 
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                              )
                          )
                            
                        ],
                      );
                    }
                  );
                }
              ),
              
            ],
          ),
        ),
      ),
    ),
  );
}

void addContactCheck(BuildContext context ,List<InfoGuest> list, SnapRoomModel snapInfo){
  if(list.length < int.parse(snapInfo.maxGuest!)) {
    gotoAddContact(context);
  }
  else {
    ShowDialog.showSimpleDialog(context, 'Full slot', 'The number of guests has reached the limit.');
  }
}

void gotoAddContact (BuildContext context)async{
  final contactInfoValue = await Navigator.pushNamed(context, AddContactScreen.routeName);
  if(contactInfoValue != null && contactInfoValue is InfoGuest){  
    // ignore: use_build_context_synchronously
    context.read<GetInfoCubit>().getInfo(contactInfoValue);
  }
}

void gotPromoCode (BuildContext context) async {
  final promoCodeValue = await Navigator.pushNamed(context, AddPromoCodeScreen.routeName);
  if(promoCodeValue != null){
    // ignore: use_build_context_synchronously
    context.read<GetPromoCodeCubit>().getPromoCode(promoCodeValue.toString());
  }
}

void showCheckEmptyConsumer(BuildContext context){
  ShowDialog.showSimpleDialog(
    context, 'No Customer', 'You should have add a least customer in "Contact Details" field'
  );
}