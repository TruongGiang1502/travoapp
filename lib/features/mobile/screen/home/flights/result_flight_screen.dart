import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travo_demo/features/mobile/screen/home/flights/select_seat_screen.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/utils/color.dart';
import 'package:travo_demo/widgets/container_decor.dart';

class ResultFlightScreen extends StatelessWidget {
  static const routeName = '/result_fly_screen';
  const ResultFlightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50)),
                  image: DecorationImage(
                      image: AssetImage('images/auth_background_appbar.png'),
                      fit: BoxFit.cover)),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select Flight',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            toolbarHeight: 30,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: (){
                  chooseFilterSheet(context);
                }, 
                icon: const Icon(Icons.view_timeline_rounded), 
                iconSize: 25,
              )
            ],
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16
        ),
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, SelectSeatScreen.routeName);
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                              size: Size(size.width, (size.width*0.3*1).toDouble()),
                              painter: RPSCustomPainterHeader(),
                          ),
                          Center(
                            child: Image.asset(
                              'images/flight_screen_icon/test_logo_air.png',
                              width: size.width*0.25,
                            )
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                              size: Size(size.width, (size.width*0.54*0.555956678700361).toDouble()), 
                              painter: RPSCustomPainterBody(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    infoText('Depature', '05:21 am'),
                                    const SizedBox(height: 10,),
                                     infoText('Flight No.', 'NNS24'),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  
                                  children: [
                                    infoText('Arrive', '08:43 am'),
                                    const SizedBox(height: 10,),
                                    infoText('Price', '\$215'),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                
              ],
            ),
          ),
        )
      ),
    );
  }
}

//Add this CustomPaint widget to the Widget Tree


//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainterHeader extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
    Path path_0 = Path();
        path_0.moveTo(size.width*0.9091429,0);
        path_0.lineTo(size.width*0.06493506,0);
        path_0.cubicTo(size.width*0.02907240,0,0,size.height*0.02907247,0,size.height*0.06493506);
        path_0.lineTo(0,size.height*0.9350649);
        path_0.cubicTo(0,size.height*0.9709286,size.width*0.02907247,size.height,size.width*0.06493506,size.height);
        path_0.lineTo(size.width*0.9091429,size.height);
        path_0.cubicTo(size.width*0.9091104,size.height*0.9989221,size.width*0.9090909,size.height*0.9978377,size.width*0.9090909,size.height*0.9967532);
        path_0.cubicTo(size.width*0.9090909,size.height*0.9458377,size.width*0.9495000,size.height*0.9043636,size.width,size.height*0.9026494);
        path_0.lineTo(size.width,size.height*0.09734740);
        path_0.cubicTo(size.width*0.9495000,size.height*0.09563636,size.width*0.9090909,size.height*0.05416097,size.width*0.9090909,size.height*0.003246753);
        path_0.cubicTo(size.width*0.9090909,size.height*0.002160104,size.width*0.9091104,size.height*0.001077753,size.width*0.9091429,0);
        path_0.close();

    Paint paint0fill = Paint()..style=PaintingStyle.fill;
    paint0fill.color = whiteColor!;
    canvas.drawPath(path_0,paint0fill);

    }

    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) {
        return true;
    }
}



class RPSCustomPainterBody extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
      Path path_0 = Path();
      path_0.moveTo(size.width*0.001805054,size.height*0.09740260);
      path_0.cubicTo(size.width*0.03071527,size.height*0.09740260,size.width*0.05415162,size.height*0.05524760,size.width*0.05415162,size.height*0.003246753);
      path_0.cubicTo(size.width*0.05415162,size.height*0.002160104,size.width*0.05414152,size.height*0.001077753,size.width*0.05412094,0);
      path_0.lineTo(size.width*0.9638989,0);
      path_0.cubicTo(size.width*0.9838375,0,size.width,size.height*0.02907240,size.width,size.height*0.06493506);
      path_0.lineTo(size.width,size.height*0.9350649);
      path_0.cubicTo(size.width,size.height*0.9709286,size.width*0.9838375,size.height,size.width*0.9638989,size.height);
      path_0.lineTo(size.width*0.05412094,size.height);
      path_0.cubicTo(size.width*0.05414152,size.height*0.9989221,size.width*0.05415162,size.height*0.9978377,size.width*0.05415162,size.height*0.9967532);
      path_0.cubicTo(size.width*0.05415162,size.height*0.9447532,size.width*0.03071527,size.height*0.9025974,size.width*0.001805054,size.height*0.9025974);
      path_0.cubicTo(size.width*0.001200924,size.height*0.9025974,size.width*0.0005991841,size.height*0.9026169,0,size.height*0.9026494);
      path_0.lineTo(0,size.height*0.09734740);
      path_0.cubicTo(size.width*0.0005991841,size.height*0.09738442,size.width*0.001200924,size.height*0.09740260,size.width*0.001805054,size.height*0.09740260);
      path_0.close();

      Paint paint0fill = Paint()..style=PaintingStyle.fill;
      paint0fill.color = whiteColor!;
      canvas.drawPath(path_0,paint0fill);
    }

    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) {
        return true;
    }
}

Widget infoText(String title, String text){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16
        ),
      ),
      const SizedBox(
        height: 3,
      ),
      Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),
      )
    ],
  );
}

void chooseFilterSheet(BuildContext context){
  ValueNotifier<String> typeChosen = ValueNotifier('direct');
  ValueNotifier<double> transitDuration = ValueNotifier(0);
  ValueNotifier<RangeValues> budgetFlight = ValueNotifier(const RangeValues(0,100));
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
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: size.height*0.7,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose your filter',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10,),
          
                //Select transit
                const Text(
                  'Transit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: typeChosen,
                        builder: (context, chose, child) {
                          return selectTypeButton(
                            isChosen: chose == 'direct', 
                            onPressed: (){
                              typeChosen.value = 'direct';
                            }, 
                            text: 'Direct'
                          );
                        }
                      ),
                    ),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: typeChosen,
                        builder: (context, chose, child) {
                          return selectTypeButton(
                            isChosen: chose == '1transit', 
                            onPressed: (){
                              typeChosen.value = '1transit';
                            }, 
                            text: '1 Transit'
                          );
                        }
                      ),
                    ),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: typeChosen,
                        builder: (context, chose, child) {
                          return selectTypeButton(
                            isChosen: chose == 'overtransit', 
                            onPressed: (){
                              typeChosen.value = 'overtransit';
                            }, 
                            text: '+2 Transit'
                          );
                        }
                      ),
                    )
                  ],
                ),
          
                //Transit duration
                const Text(
                  'Transit Duration',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: transitDuration,
                  builder: (context, time, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${time.toInt()}h',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: indigo
                            ),
                          ),
                        ),
                        Slider(
                          value: time, 
                          onChanged: (newValue){
                            transitDuration.value = newValue;
                          },
                          max: 24,
                          activeColor: indigo,
                        ),
                      ],
                    );
                  }
                ),
                ValueListenableBuilder(
                  valueListenable: budgetFlight, 
                  builder: (context, budget, child) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                            '${budget.start.toInt()}\$ ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: indigo
                            ),
                          ),
                          Text(
                            ' - ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: indigo
                            ),
                          ),
                          Text(
                            ' ${budget.end.toInt()}\$',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: indigo
                            ),
                          ),
                          ],
                        ),
                        RangeSlider(
                          values: budget, 
                          onChanged: (newValue){
                            budgetFlight.value = newValue;
                          },
                          max: 5000,
                          activeColor: indigo,
                        ),
                        utilityButton(
                          onPressed: (){}, 
                          iconUrl: 'images/flight_screen_icon/facilities.svg', 
                          text: 'Facilities'
                        ),
                        utilityButton(
                          onPressed: (){}, 
                          iconUrl: 'images/flight_screen_icon/sort_by.svg', 
                          text: 'Sort by'
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: CustomButton(
                            onPressed: (){}, 
                            text: 'Apply', 
                            width: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: CustomButtonOption2(
                            onPressed: (){}, 
                            text: 'Reset', 
                            width: 1),
                        )
                      ],
                    );
                  })
              ],
            ),
          ),
        )
      );
    });
}

Widget utilityButton({
  required VoidCallback onPressed,
  required String iconUrl,
  required String text
}){
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 6.0),
    child: ContainerBoxDecor(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                SvgPicture.asset(iconUrl),
                const SizedBox(width: 10,),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                )
              ],
            ),
          )
        ),
      ),
  );
}

Widget selectTypeButton(
    {required bool isChosen,
    required VoidCallback onPressed,
    required String text}) {
  
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isChosen ? Colors.orange : linkWater),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
          ) 
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isChosen?Colors.white:indigo,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    ),
  );
}