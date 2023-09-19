import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travo_demo/features/home/widget/pick_options.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), 
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
            height: 170,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(50)),
                image: DecorationImage(
                    image: AssetImage('images/auth_background_appbar.png'),
                    fit: BoxFit.fitWidth
                )
            ),
            child: const Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi Giang",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),  
                  Text("Where you want to go?", style: TextStyle(color: Colors.white, fontSize: 14),)
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
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search your destination',
                      prefixIcon: Icon(Icons.search)
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
                      onPressed: (){},
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
                  const Text(
                    'Popular Destinations',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  TextButton(onPressed: (){}, child: const Text('See All'))
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1
                ),
                itemCount: 8,
                itemBuilder: (BuildContext context, int index){
                  //double imageSize = index % 2 == 0 ? 200.0 : 150.0;
                  return Image.asset(
                    'images/testgridview/image${index+1}.jpg',
                    // width: imageSize,
                    // height: imageSize,
                    fit: BoxFit.cover,
                  ); 
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50)
          ),
          boxShadow: [
              BoxShadow(
                color: Colors.black26, // Màu của bóng
                blurRadius: 10.0, // Độ mờ của bóng
                offset: Offset(0.0, 0.0), // Vị trí của bóng (có thể điều chỉnh)
              ),
            ],
        ),
        
        child: CupertinoTabBar(
          onTap: (int pageNumber){},
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon:  Icon(Icons.home, color: Colors.black),
            ),
            BottomNavigationBarItem(
              label: 'Favourite',
              icon:  Icon(Icons.favorite, color: Colors.black),
            ),
            BottomNavigationBarItem(
              label: 'Payment',
              icon:  Icon(Icons.cases_rounded, color: Colors.black,),
            ),
            BottomNavigationBarItem(
              label: 'User',
              icon:  Icon(Icons.person, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}