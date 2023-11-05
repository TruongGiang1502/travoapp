import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/utils/date_time_custom.dart';
import 'package:travo_demo/features/mobile/screen/home/models/snap_model.dart';
import 'package:travo_demo/features/mobile/screen/main_screen.dart';
import 'package:travo_demo/features/mobile/utils/show_dialog.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/widgets/container_decor.dart';

class DetailBookingInfo extends StatelessWidget {
  static const routeName = '/detail_booking_info';
  final SnapBookingShowModel snapBookingShowModel;
  final SnapRoomModel snapRoomModel;
  final String idBooking;
  const DetailBookingInfo({super.key, required this.snapBookingShowModel, required this.snapRoomModel, required this.idBooking});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    Future <void> deleteBooking() async {
    try{
      await firestore.collection('booking').doc(idBooking).delete();
      // ignore: use_build_context_synchronously
      ShowDialog.showSimpleDialog(context, 'Deleted', 'Delete successful');
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, MainScreen.routeName, (route) => false);
    }catch (error) {
      // ignore: use_build_context_synchronously
      ShowDialog.showSimpleDialog(context, 'ERROR!', error.toString());
    }
  }
    final size = MediaQuery.of(context).size;
    double fontSizeContent = 16;
    var timeStart = snapBookingShowModel.timeStart!.toDate();
    var timeEnd = snapBookingShowModel.timeEnd!.toDate();
    Duration durationTime = timeEnd.difference(timeStart);
    Duration checkTime = timeStart.difference(DateTime.now());
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
                      Text(
                        "Detail Booking".tr(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      
                    ],
                  ),
            ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ContainerBoxDecor(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          snapRoomModel.imageUrl!,
                          width: size.width*0.8,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapRoomModel.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ContainerBoxDecor(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Book Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'Time: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeContent,
                              color: Colors.black
                            ),
                          ),
                          Text(
                            timeWithShortNameMonth(timeStart),
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeContent
                            ),
                          ),
                          Text(
                            ' to ',
                            style: TextStyle(
                              fontSize: fontSizeContent,
                              color: Colors.black
                            ),
                          ),
                          Text(
                            timeWithShortNameMonth(timeEnd),
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeContent
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'People: ',
                            style: TextStyle(
                              fontSize: fontSizeContent,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                          Text(
                            '${snapBookingShowModel.guest!.length}',
                            style: TextStyle(
                              fontSize: fontSizeContent,
                              color: Colors.black
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Total price: ',
                            style: TextStyle(
                              fontSize: fontSizeContent,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                          Text(
                            '${durationTime.inDays*int.parse(snapRoomModel.price!)}',
                            style: TextStyle(
                              fontSize: fontSizeContent,
                              color: Colors.black
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Payment methods: ',
                            style: TextStyle(
                              fontSize: fontSizeContent,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                          Text(
                            '${snapBookingShowModel.paymentMethod}',
                            style: TextStyle(
                              fontSize: fontSizeContent,
                              color: Colors.black
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      checkTime.inDays >=3 ? 
                        CustomButton(
                          onPressed: (){
                            ShowDialog.showConfirmationDialog(
                              context,
                              'Delete Booking',
                              'Do you want to delete your booking? Your money will be refund a least 2 days?',
                              'Delete',
                              deleteBooking
                            );
                          }, 
                          text: 'Cancel Booking', 
                          width: 0.4
                        ): 
                        const SizedBox()
                    ],
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}