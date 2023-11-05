import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/utils/date_time_custom.dart';
import 'package:travo_demo/features/mobile/screen/home/models/snap_model.dart';
import 'package:travo_demo/features/mobile/screen/payment/detail_booking_info.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/widgets/container_decor.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  ConnectivityResult connection = ConnectivityResult.none;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<ConnectivityResult> checkInternet () async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult;
  }
  
  @override
  Widget build(BuildContext context) {
    String? userId = FirebaseAuth.instance.currentUser?.uid.toString();

    return FutureBuilder<ConnectivityResult>(
      future: checkInternet(),
      builder: (context, snapInternet) {
        connection = snapInternet.data??ConnectivityResult.none;

        if(snapInternet.connectionState == ConnectionState.waiting && connection != snapInternet.data){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        else if(snapInternet.data == ConnectivityResult.none || snapInternet.data == ConnectivityResult.other || userId ==null){
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
                            "payment_check".tr(),
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

          body: StreamBuilder(
            stream: firestore.collection('booking').where('userId', isEqualTo: userId).snapshots(),
            builder: (context, snapshot) {

              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              else if(snapshot.hasError || !snapshot.hasData){
                return const Center(
                  child: Text('We have some error! Please try again'),
                );
              }

              else if(snapshot.data!.docs.isEmpty){
                return const Center(
                  child: Text('No data found'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var snap = snapshot.data!.docs[index].data();
                  SnapBookingShowModel snapBookingShowModel = SnapBookingShowModel.fromSnap(snap);
                  var roomId = snapBookingShowModel.roomId;
                  var snapRoom = FirebaseFirestore.instance.collection('room').doc(roomId).snapshots();
                  DateTime timeStart = snapBookingShowModel.timeStart!.toDate();
                  DateTime timeEnd = snapBookingShowModel.timeEnd!.toDate();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ContainerBoxDecor(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: StreamBuilder(
                          stream: snapRoom,
                          builder: (context, snapshotRoom) {
                            var roomInfo = snapshotRoom.data?.data();
                            SnapRoomModel roomModel = SnapRoomModel.fromSnap(roomInfo);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                roomInfoModel(roomModel),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        infoWidget('Time check-in   : ', Colors.red, timeWithShortNameMonth(timeStart)),
                                        infoWidget('Time check-out: ', Colors.green, timeWithShortNameMonth(timeEnd)),
                                        infoWidget('Number of people: ', Colors.purple, '${snapBookingShowModel.guest!.length}'),
                                      ],
                                    ),
                                    CustomButton(
                                      onPressed: (){
                                        String idBooking = snapshot.data!.docs[index].id;
                                        Navigator.pushNamed(context, DetailBookingInfo.routeName, arguments: (snapBookingShowModel, roomModel, idBooking));
                                      }, 
                                      text: 'Detail', 
                                      width: 0.28
                                    )
                                  ],
                                ),
                              ],
                            );
                          }
                        ),
                      )
                    )
                  );
                }
              );
            } ,
          )
        );
      }
    );
  }
}


Widget roomInfoModel(SnapRoomModel roomModel){

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        flex: 1,
        child: Text(
          roomModel.name!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black
          ),
        ),
      ),
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            roomModel.imageUrl!,
            width: 70,
          ),
        ),
      ),
    ],
  );
}

Widget infoWidget (String title, Color titleColor, String content){
  return Row(
    children: [
      Text(
        title,
        style: TextStyle(
          color: titleColor
        ),
      ),
      Text(
        content,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
      )
    ],
  );
}

