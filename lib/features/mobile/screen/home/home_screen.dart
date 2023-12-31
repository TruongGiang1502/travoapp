import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/mobile/screen/home/flights/book_flight_screen.dart';
import 'package:travo_demo/features/mobile/screen/home/models/snap_model.dart';
import 'package:travo_demo/features/mobile/utils/list_favor.dart';
import 'package:travo_demo/features/mobile/screen/home/hotel/result_hotel_screen.dart';
import 'package:travo_demo/features/mobile/widget/pick_options.dart';
import 'package:travo_demo/utils/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email.toString();
  ConnectivityResult connection = ConnectivityResult.none;
  Future<ConnectivityResult> checkInternet () async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult;
  }

  Future <String> getLastName(String name) async {
    int nameLen = name.length;
    //int index = nameLen-1;
    String getCharLastName = '';
    String lastName = '';
    for (int index = nameLen -1; index >= 0 && name[index].toString()!= ' '; index--){
      getCharLastName += name[index];
    }
   
    for (int index = getCharLastName.length-1; index>=0; index--){
      lastName += getCharLastName[index];
    }
    return lastName;
  }

  ValueNotifier <int> placeCount = ValueNotifier(8);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder<ConnectivityResult>(
      future: checkInternet(),
      builder: (context, snapInternet) {
        connection = snapInternet.data??ConnectivityResult.none;
        if(snapInternet.connectionState == ConnectionState.waiting && connection != snapInternet.data){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        else if(snapInternet.data == ConnectivityResult.none || snapInternet.data == ConnectivityResult.other || userEmail == null){
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
        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('user').doc(userEmail).snapshots(),
          builder: (context, snapshotUser) {
            var snapUser = snapshotUser.data?.data();
            //String lastname = aw
            SnapUserModel user = SnapUserModel.fromSnap(snapUser);
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
                          FutureBuilder(
                            future: getLastName(user.userName!),
                            builder: (context, snapShotName) {
                              return Text(
                                "${"hi".tr()} ${snapShotName.data}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              );
                            }
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
                              hintStyle: TextStyle(
                                color: greyColor
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: greyColor,
                              )
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PickOptions(
                                  onPressed: (){
                                    Navigator.pushNamed(context, ResultHotelScreen.routeName);
                                  },
                                  backgroundColor: Colors.orange[100],
                                  imageUrl: 'images/hotel_icon.png',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'hotel'.tr(), 
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.orange[500]
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                PickOptions(
                                  onPressed: (){
                                    Navigator.pushNamed(context, BookFlightScreen.routeName);
                                  },
                                  backgroundColor: Colors.red[100],
                                  imageUrl: 'images/flight_icon.png',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'fli'.tr(), 
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red[500]
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                PickOptions(
                                  onPressed: (){},
                                  backgroundColor: Colors.green[100],
                                  imageUrl: 'images/all_icon.png',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'all'.tr(), 
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.green[500]
                                  ),
                                ),
                              ],
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
                          TextButton(
                            onPressed: (){
                              ConnectivityResult? conState = snapInternet.data;
                              if(conState != ConnectivityResult.none){
                                placeCount.value += 8;
                              }
                              
                            }, 
                            child: Text(
                              'see_more'.tr(),
                              style: TextStyle(
                                color: indigo
                              ),
                            ),

                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('place').snapshots(), 
                        builder: (context, snapshot){                          
                          int totalDataSnap = snapshot.data?.docs.length ?? 8 ;

                          if(snapshot.connectionState == ConnectionState.waiting && connection != snapInternet.data){
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          else if(snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty){
                            return const Center(
                              child: Text('We have some error! Please try again'),
                            );
                          }
        
                          return  ValueListenableBuilder(
                            valueListenable: placeCount,
                            builder: (context, count, child) {
                              int maxCount = count > totalDataSnap ? totalDataSnap : count;
                              return GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1
                                ),
                                itemCount: maxCount,
                                itemBuilder: (BuildContext context, int index){
                                  var snap = snapshot.data?.docs[index].data();
                                  if(snap==null){
                                    return const Center(
                                      child: Text('No data found'),
                                    );
                                  }

                                  // if(index == count-1){
                                  //   loadmore();
                                  // }

                                  SnapPlaceModel snapInfo = SnapPlaceModel.fromSnap(snap);
                                  
                                  ValueNotifier<Color> favorBtnColor = ValueNotifier(isFavor(snapInfo.name!));
                                  return Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: NetworkImage(snapInfo.imageUrl!),
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
                                              snapInfo.name!, 
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
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
                                                    Text(snapInfo.rating!)
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ),
                                      Positioned(
                                        left: 140,
                                        child: ValueListenableBuilder(
                                          valueListenable: favorBtnColor,
                                          builder: (BuildContext context, Color value, Widget?child) {
                                            return IconButton(
                                              onPressed: (){
                                                 favorOnpressed(favorBtnColor, snap, snapInfo);
                                              }, 
                                              icon: Icon(Icons.favorite, color: favorBtnColor.value,)
                                            );
                                          }
                                        )
                                      )
                                    ],
                                  );
                                  
                                },
                              );
                            }
                          );
                        }
                      )
                     
                    ),
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}

Color isFavor (String nameDes){
  for (int i=0; i<desFavor.length; i++){
    if(nameDes == desFavor[i].name){
      return Colors.red;
    }
  }
  return Colors.white;
}

void favorOnpressed (ValueNotifier <Color> color, Map<String, dynamic>? snap, SnapPlaceModel snapInfo){
  if(snap == null) {}
  else if(color.value == Colors.white){
    color.value = Colors.red;
    //desNameFavor.add((snap['name'], c, snap['rating'].toString()));
    desFavor.add(DesInfo(name: snapInfo.name!, imageUrl: snapInfo.imageUrl!, rating:snapInfo.rating.toString()));
  }
  else {
    color.value = Colors.white;
    desFavor.removeWhere((element) => 
      element.name == snap['name'] && 
      element.imageUrl == snap['image'] && 
      element.rating == snap['rating'].toString()
    );
  }
}
