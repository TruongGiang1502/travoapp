import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/add_contact_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/models/snap_model.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/add_widget_custom.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/container_decor.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/get_info_cubit.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/services_option.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';

class CheckOutScreen extends StatefulWidget {
  static const routeName = '/checkout_screen';
  final SnapRoomModel snapInfo;
  const CheckOutScreen({super.key, required this.snapInfo});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  //String contactInfo = '';
  String promoCode = '';
  void gotoAddContact  (BuildContext context)async{
    final contactInfoValue = await Navigator.pushNamed(context, AddContactScreen.routeName);
    if(contactInfoValue != null){  
      // ignore: use_build_context_synchronously
      context.read<GetInfoCubit>().getInfo(contactInfoValue.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckOut Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            roomInfo(context,widget.snapInfo),
            BlocBuilder<GetInfoCubit, String>(
              builder: (context, info) {
                return AddWidgetCustom(
                  onPressed: () { 
                    gotoAddContact(context);
                  },
                  imageUrl: 'images/checkout_icon/addcontact_icon.svg', 
                  title: 'Contact Details',
                  defaultText: 'AddContact', 
                  textFunction: info,
                  heroTag: 'contact_hero'
                );
              }
            ),
            AddWidgetCustom(
              onPressed: (){},
              imageUrl: 'images/checkout_icon/addpromo_icon.svg', 
              title: 'Promo Code',
              defaultText: 'Add Promo Code', 
              textFunction: promoCode,
              heroTag: 'promo_hero',
            ),
            dateBooking(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                onPressed: (){},
                text: 'Payment', 
                width: MediaQuery.of(context).size.width
              ),
            ),
          ],
        ),
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

Widget dateBooking(){
  DateTime now = DateTime.now();
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
                  Row(
                    children: [
                      SvgPicture.asset('images/checkout_icon/date2_icon.svg'),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Check-out'),
                          Text(DateFormat('E, d/MM').format(now), style: const TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ],
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

