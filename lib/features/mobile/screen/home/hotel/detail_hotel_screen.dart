import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/select_room_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/models/snap_model.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/utils/color.dart';

class DetailHotelScreen extends StatefulWidget {
  static const routeName = '/detail_hotel_screen';
  final SnapHotelModel snapInfo;
  final String snapId;
  const DetailHotelScreen({super.key, required this.snapInfo, required this.snapId});

  @override
  State<DetailHotelScreen> createState() => _DetailHotelScreenState();
}

class _DetailHotelScreenState extends State<DetailHotelScreen> {
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      showBottomSheetCustom(context);
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(widget.snapInfo.imageUrl!), fit: BoxFit.fill),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(143, 103, 232, 1),
              Color.fromRGBO(99, 87, 204, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
          borderRadius: BorderRadius.circular(50)
        ),
        child: FloatingActionButton(
          onPressed: (){
            showBottomSheetCustom(context);
          },
          backgroundColor: Colors.transparent,
          elevation: 0, 
          child: const Icon(Icons.arrow_circle_up),
        ),
      ),
    );
  }

void showBottomSheetCustom(BuildContext context){
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
      context: context, 
      builder: (context) {
        return Container(
          height: size.height*0.8,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.snapInfo.name!, style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '\$${widget.snapInfo.price}',
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
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red,),
                      Text(widget.snapInfo.location!)
                    ],
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellow,),
                          Text('${widget.snapInfo.rating}'), 
                          Text(' (${widget.snapInfo.totalReview} ${"review".tr()})', style: const TextStyle(color: Colors.grey),),
                        ],
                      ),
                      TextButton(
                        onPressed: (){}, 
                        child: Text(
                          'seeAll'.tr(), 
                          style: TextStyle(
                            color: navigationBarColor,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.3),
                    thickness: 2,
                  ),
                  Text(
                    'information'.tr(), 
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:8.0),
                    child: Text(
                      widget.snapInfo.information!,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DetailIcon(imageUrl: 'images/services/restaurant_icon.svg', text: 'Restaurant\n'''),
                        DetailIcon(imageUrl: 'images/services/wifi.svg', text: 'Wifi\n'''),
                        DetailIcon(imageUrl: 'images/services/exchange.svg', text: 'Currency\nExchange'),
                        DetailIcon(imageUrl: 'images/services/24_hour.svg', text: '24-hour\nFront Desk'),
                        DetailIcon(imageUrl: 'images/services/more.svg', text: 'More\n''')
                      ],
                    ),
                  ),
                  Text(
                    'location'.tr(), 
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      widget.snapInfo.locationDesc!,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
      
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: const DecorationImage(image: AssetImage('images/map.jpg'), fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(20)
                      ),
                    )
                  ),
                  CustomButton(
                    onPressed: (){
                      naviToSelectRoom(context, widget.snapId);
                    },
                    text: 'Select room', 
                    width: size.width*0.9
                  )
                ],
              ),
            ),
          ),
        );
      });
  }
}

class DetailIcon extends StatelessWidget {
  final String imageUrl;
  final String text;
  const DetailIcon({super.key, required this.imageUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [         
          SvgPicture.asset(
            imageUrl,
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 3,),
          Text(text, textAlign: TextAlign.center,)
        ],
      );
  }
}

Stream<QuerySnapshot<Map<String, dynamic>>> setsnapSelectRoom(String snapId) {
    return FirebaseFirestore.instance.collection('room').where('hotel', isEqualTo: snapId).snapshots();
}

void naviToSelectRoom (BuildContext context, String snapId){
  //Navigator.push(context, MaterialPageRoute(builder: (context) => SelectRoomScreen(streamsnap: setsnapSelectRoom(snapId))));
  Navigator.pushNamed(context, SelectRoomScreen.routeName, arguments: setsnapSelectRoom(snapId));
}