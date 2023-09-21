import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/result_hotel_screen.dart';
import 'package:travo_demo/features/mobile/widget/pick_options.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0), 
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {} , 
                  icon: const Icon(Icons.notifications_none, size: 25,)
                ),
                
              ],
            ),
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('images/beny.jpg'),
            ),
          ],
          flexibleSpace: Container(
            //width: MediaQuery.of(context).size.width,
            height: 210,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50)),
                image: DecorationImage(
                    image: AssetImage('images/auth_background_appbar.png'),
                    fit: BoxFit.fitWidth
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${"hi".tr()} Giang",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10,),  
                  Text("where".tr(), style: const TextStyle(color: Colors.white, fontSize: 14),)
                ],
              ),
            ),
          ),
         
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(1, 1)
                    )
                  ]
                ),
                width: size.width*0.9,
                child: Center(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'searchDes'.tr(),
                      prefixIcon: const Icon(Icons.search)
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PickOptions(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ResultHotelScreen()));
                      },
                      backgroundColor: Colors.orange[100],
                      imageUrl: 'images/hotel_icon.png',
                    ),
                    const Spacer(),
                    PickOptions(
                      onPressed: (){},
                      backgroundColor: Colors.red[100],
                      imageUrl: 'images/flight_icon.png',
                    ),
                    const Spacer(),
                    PickOptions(
                      onPressed: (){},
                      backgroundColor: Colors.green[100],
                      imageUrl: 'images/all_icon.png',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'pplDes'.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  TextButton(onPressed: (){}, child: Text('seeAll'.tr()))
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('place').snapshots(), 
                builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  
                  return  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1
                    ),
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index){
                      var snap = snapshot.data!.docs[index].data();
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(snap['image']),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          Positioned(
                            top: 120,
                            left: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start  ,
                              children: [
                                Text(
                                  snap['name'], 
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.yellow,),
                                        Text(snap['rating'].toString())
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                          Positioned(
                            left: 140,
                            child: IconButton(
                              onPressed: (){}, 
                              icon: const Icon(Icons.favorite, color: Colors.white, )
                            )
                          )
                        ],
                      );
                      
                    },
                  );
                }
              )
             
            )
          ],
        ),
      ),
    );
  }
}