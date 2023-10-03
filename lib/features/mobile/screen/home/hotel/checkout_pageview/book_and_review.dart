import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/add_contact_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/add_promo_code.dart';
import 'package:travo_demo/features/mobile/screen/home/models/guest_info_model.dart';
import 'package:travo_demo/features/mobile/screen/home/models/snap_model.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/add_widget_custom.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_info_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_promo_cubit.dart';
import 'package:travo_demo/widgets/container_decor.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/services_option.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';

class BookAndReview extends StatelessWidget {
  final SnapRoomModel snapInfo;
  final VoidCallback onPressed;
  const BookAndReview({super.key, required this.onPressed,required this.snapInfo});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            roomInfo(context, snapInfo),
            BlocBuilder<GetInfoCubit, List <InfoGuest>>(
              builder: (context, info) {
                return AddInfoGuestCustom(
                  onPressed: () { 
                    gotoAddContact(context);
                  },
                  imageUrl: 'images/checkout_icon/addcontact_icon.svg', 
                  title: 'Contact Details',
                  defaultText: 'AddContact', 
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
                  title: 'Promo Code',
                  defaultText: 'Add Promo Code', 
                  textFunction: promoCode,
                  heroTag: 'promo_hero',
                  sizeText: 20,
                );
              }
            ),
            dateBooking(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                onPressed: onPressed,
                text: 'Payment', 
                width: MediaQuery.of(context).size.width
              ),
            ),
          ],
        ),
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
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Max guest: ${snapInfo.maxGuest}',
                    ),
                    Text(
                      snapInfo.typePrice!,
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
                        fontWeight: FontWeight.bold
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
                const Text('1 room')
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget dateBooking(BuildContext context){
  DateTime now = DateTime.now();
  //DateTime pickDate = DateTime.now();
  ValueNotifier <DateTime> pickedDate = ValueNotifier(DateTime.now());
  return Padding(
    padding: const EdgeInsets.all(16),
    child: ContainerBoxDecor(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          child: Column(
            children: [
              const Text(
                'Booking Date', 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('images/checkout_icon/date1_icon.svg'),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Check-in'),
                          Text(DateFormat('E, d/MM').format(now), style: const TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(1, 1)
                        )
                      ]
                    ),
                    child: ElevatedButton(
                      onPressed: ()async{
                        pickedDate.value = (await showSelectDate(context));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('images/checkout_icon/date2_icon.svg'),
                          const SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Check-out', style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),),
                              ValueListenableBuilder(
                                valueListenable: pickedDate,
                                builder: (BuildContext context, DateTime value, Widget? child) {
                                  return Text(
                                    DateFormat('E, d/MM').format(pickedDate.value), 
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                  );
                                }
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    ),
  );
}

Future <DateTime> showSelectDate(BuildContext context)async{
  final DateTime picked = (
      await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime(2030),
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
  return picked;
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