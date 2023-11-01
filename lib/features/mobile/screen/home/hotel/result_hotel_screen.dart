import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/detail_hotel_screen.dart';
import 'package:travo_demo/widgets/container_decor.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import '../models/snap_model.dart';

class ResultHotelScreen extends StatefulWidget {
  static const routeName = '/result_hotel_screen';
  const ResultHotelScreen({super.key});

  @override
  State<ResultHotelScreen> createState() => _ResultHotelScreenState();
}

class _ResultHotelScreenState extends State<ResultHotelScreen> {
  Future<ConnectivityResult> checkInternet () async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult;
  }
  @override
  Widget build(BuildContext context) {
    ValueNotifier <int> dataNum = ValueNotifier(9);
    return FutureBuilder<ConnectivityResult>(
      future: checkInternet(),
      builder: (context, snapInternet) {
        if(snapInternet.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(snapInternet.data == ConnectivityResult.none){
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
                            "hotel".tr(),
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
            stream: FirebaseFirestore.instance.collection('hotel').snapshots(), 
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if(snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty){
                return const Center(
                  child: Text('We have some error! Please try again'),
                );
              }
              return ValueListenableBuilder(
                valueListenable: dataNum,
                builder: (context, dataNumber, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: dataNumber,
                    itemBuilder: (BuildContext context, int index){
                      var snap = snapshot.data?.docs[index].data();
                      SnapHotelModel snapInfo = SnapHotelModel.fromSnap(snap);
                      var snapHotelId = snapshot.data?.docs[index].id;
                      int totalDataSnap = snapshot.data!.docs.length;
                      void loadmore(){
                        int dataNotLoad = totalDataSnap - dataNumber;
                        if(dataNotLoad > 8){
                          dataNum.value += 8;
                        }
                        else{
                          dataNum.value += dataNotLoad;
                        }
                      }
                      return (index == dataNum.value - 1 && dataNumber < totalDataSnap)? 
                      TextButton(
                        onPressed: loadmore,
                        child: const Text(
                          'Loadmore'
                        )
                      )
                      :Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ContainerBoxDecor(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [                     
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(20)
                                ),
                                child: Image.network(
                                  snapInfo.imageUrl!,
                                  width: 320,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(snapInfo.name!, style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on, color: Colors.red,),
                                        Text(snapInfo.location!),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.yellow,),
                                        Text('${snapInfo.rating}'), 
                                        Text(' (${snapInfo.totalReview} ${"review".tr()})', style: const TextStyle(color: Colors.grey),),
                                      ],
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
                                        CustomButton(
                                          onPressed: (){
                                            bookAroom(context, snapInfo, snapHotelId);
                                          },
                                          text: 'bookaroom'.tr(), 
                                          width: 0.4
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              );
            }
          ),
        );
      }
    );
  }
}

void bookAroom(BuildContext context, SnapHotelModel? snapInfo, String? snapId){
  if(snapId != null){
    Navigator.pushNamed(context, DetailHotelScreen.routeName, arguments: (snapInfo, snapId));
  }
}