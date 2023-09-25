import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/checkout_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/container_decor.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/services_option.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';

class SelectRoomScreen extends StatelessWidget {
  static const routeName = '/select_room_screen';
  final Stream<QuerySnapshot<Map<String, dynamic>>> streamsnap;
  const SelectRoomScreen({super.key, required this.streamsnap});

  @override
  Widget build(BuildContext context) {
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
                        "Select Room".tr(),
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
          stream: streamsnap, 
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.size,
              itemBuilder: (BuildContext context, int index){
                var snap = snapshot.data!.docs[index].data();
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
                                    snap['name'], 
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Text(
                                    'Max guest: ${snap['max_guest']}',
                                  ),
                                  Text(
                                    snap['type_price'],
                                  ),
                                ],
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  snap['image'],
                                  width: 70,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: SizedBox(
                              height: 100,
                              child: ServicesOption(context: context ,services: snap['services'])
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
                                    '\$${snap['price']}',
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
                                  Navigator.pushNamed(context, CheckOutScreen.routeName, arguments: snap);
                                },
                                text: 'Choose'.tr(), 
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
}