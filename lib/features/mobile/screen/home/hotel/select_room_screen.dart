import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/checkout_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/models/snap_model.dart';
import 'package:travo_demo/widgets/container_decor.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/services_option.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';

class SelectRoomScreen extends StatefulWidget {
  static const routeName = '/select_room_screen';
  final Stream<QuerySnapshot<Map<String, dynamic>>> streamsnap;
  const SelectRoomScreen({super.key, required this.streamsnap});

  @override
  State<SelectRoomScreen> createState() => _SelectRoomScreenState();
}

class _SelectRoomScreenState extends State<SelectRoomScreen> {
  Future<ConnectivityResult> checkInternet () async {
      final connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult;
    }
  @override
  Widget build(BuildContext context) {
    

    return FutureBuilder<ConnectivityResult>(
      future: checkInternet(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(snapshot.data == ConnectivityResult.none){
          return Scaffold(
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No internet found! Please try again!'),
                  TextButton(onPressed: (){
                    setState(() {});
                  }, child: const Text('Try again'))
                ],
              )
            ),
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
                          fit: BoxFit.cover)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "select_room".tr(),
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
              stream: widget.streamsnap, 
              builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty){
                  return Center(
                    child: Text("have_some_error".tr()),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (BuildContext context, int index){
                    var snap = snapshot.data?.docs[index].data();
                    SnapRoomModel snapInfo = SnapRoomModel.fromSnap(snap);
                    var snapRoomId = snapshot.data?.docs[index].id;
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
                                        '${"max_guest".tr()}: ${snapInfo.maxGuest}',
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
                                  CustomButton(
                                    onPressed: (){
                                      Navigator.pushNamed(context, CheckOutScreen.routeName, arguments: (snapInfo, snapRoomId));
                                    },
                                    text: 'choose'.tr(), 
                                    width: 0.4
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ),
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