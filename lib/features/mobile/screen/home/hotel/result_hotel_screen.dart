import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/detail_hotel_screen.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';

class ResultHotelScreen extends StatelessWidget {
  const ResultHotelScreen({super.key});

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
          return ListView.builder(
            shrinkWrap: true,
            itemCount: 8,
            itemBuilder: (BuildContext context, int index){
              var snap = snapshot.data!.docs[index].data();
              var snapId = snapshot.data!.docs[index].id;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(1, 1)
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [                     
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                        ),
                        child: Image.network(
                          snap['image'],
                          width: 320,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(snap['name'], style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.red,),
                                Text(snap['location']),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.yellow,),
                                Text('${snap['rating']}'), 
                                Text(' (${snap['total_review']} ${"review".tr()})', style: const TextStyle(color: Colors.grey),),
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
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(
                                        builder: (context) => 
                                         DetailHotelScreen(
                                            snap: snap,
                                            snapId: snapId,
                                          ),
                                        )
                                    );
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
      ),
    );
  }
}