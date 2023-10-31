import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travo_demo/features/mobile/screen/home/flights/check_out_flight.dart';
import 'package:travo_demo/features/mobile/widget/custom_button.dart';
import 'package:travo_demo/utils/color.dart';

class SelectSeatScreen extends StatefulWidget {
  static const routeName = '/select_seat_screen';
  const SelectSeatScreen({super.key});

  @override
  State<SelectSeatScreen> createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen> {
  ValueNotifier<String> seatNof = ValueNotifier('---');
  ValueNotifier<String> typeClassSeat = ValueNotifier('--------');
  Widget seatFlight(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "bussiness_class".tr(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18 
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('  A'),
                Text(' B'),
                Text(''),
                Text('C '),
                Text('D  ')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            buissinessSeat(seat, 1),
            buissinessSeat(seat, 2),
            buissinessSeat(seat, 3),
            const SizedBox(
              height: 10,
            ),
            Text(
              "economy_class".tr(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18 
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('  A'),
                Text(' B'),
                Text('C'),
                Text(''),
                Text('D'),
                Text('E '),
                Text('F  ')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            economySeat(seat, 1),
            economySeat(seat, 2),
            economySeat(seat, 3),
            economySeat(seat, 4),
            economySeat(seat, 5),
          ],
        ),
      ),
    );
  }

  Widget buissinessSeat(Function seat, int rowNumber){
    return ValueListenableBuilder(
      valueListenable: seatNof,
      builder: (context, seatPosi, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                seat('A', rowNumber, 'b', seatPosi),
                seat('B', rowNumber, 'b', seatPosi),
                Text(
                  '$rowNumber',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,

                  ),
                ),
                seat('C', rowNumber, 'b', seatPosi),
                seat('D', rowNumber, 'b', seatPosi)
              ],
            ),
            const SizedBox(height: 5,)
          ],
        );
      }
    );
  }

  Widget economySeat(Function seat, int rowNumber){
    return ValueListenableBuilder(
      valueListenable: seatNof,
      builder: (context, seatPosi, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                seat('A', rowNumber, 'e', seatPosi),
                seat('B', rowNumber, 'e', seatPosi),
                seat('C', rowNumber, 'e', seatPosi),
                Text(
                  '$rowNumber',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ), 
                ),
                seat('D', rowNumber, 'e', seatPosi),
                seat('E', rowNumber, 'e', seatPosi),
                seat('F', rowNumber, 'e', seatPosi)
              ],
            ),
            const SizedBox(height: 20,)
          ],
        );
      }
    );
  }

  Widget seat(String type, int rowNumber, String typeSeat, String seatPos){
    String seatChose = '$typeSeat$type$rowNumber';
    bool isChosen = seatChose == seatPos;
    return GestureDetector(
      onTap: () {
        if(isChosen){
          seatNof.value = '---';
          typeClassSeat.value = '--------';
        }
        else{
          seatNof.value = seatChose;
          typeSeat == 'b'? typeClassSeat.value = "bussiness_class".tr():typeClassSeat.value = "economy_class".tr();
        } 
      },
      child: SvgPicture.asset(
        'images/seat_airline/seat_airline.svg',
        height: 25,
        width: 25,
        colorFilter: ColorFilter.mode(seatPos==seatChose?indigo:Colors.red, BlendMode.srcIn)
      ),
    );
  }

  //MAIN
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "select_seat".tr(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                    ),  
                  ),
                ],
              ),
            ),
            toolbarHeight: 30,
            centerTitle: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 10,
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.2,
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whiteColor),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset('images/seat_airline/icon_pick_seat.svg'),
                                  Column(
                                    children: [
                                      Text(
                                        "seat".tr(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: greyColor
                                        ),
                                      ),
                                      ValueListenableBuilder(
                                        valueListenable: seatNof, 
                                        builder: (context, seatValue, child){
                                          return Column(
                                            children: [
                                              Text(
                                                seatValue.substring(1),
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: indigo
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ValueListenableBuilder(
                                valueListenable: typeClassSeat, 
                                builder: (context, typeSeat, child){
                                  return Center(
                                    child: Text(
                                      typeSeat,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  );
                                }
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: linkWater,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '\$215',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: indigo
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 19,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomPaint(
                            size: Size(
                                size.width * 0.5,
                                (size.width * 0.4 * 1.4366197183098592)
                                    .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                            painter: HeadRPSCustomPainter(),
                          ),
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              CustomPaint(
                                size: Size(
                                    size.width * 0.6,
                                    (size.width * 0.8 * 1.6234309623430963)
                                        .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                painter: BodyRPSCustomPainter(),
                              ),
                              seatFlight(context)
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              CustomButton(
                onPressed: (){
                  Navigator.pushNamed(context, CheckOutFlight.routeName);
                }, 
                text: "select".tr(), width: 1)
            ],
          ),
        ));
  }
}

class HeadRPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height);
    path_0.lineTo(size.width * 0.5038310, size.height);
    path_0.lineTo(size.width * 0.5038310, size.height * 0.0004731144);
    path_0.cubicTo(
        size.width * 0.3595070,
        size.height * 0.01931350,
        size.width * 0.1871235,
        size.height * 0.4228235,
        size.width * 0.1871235,
        size.height * 0.4228235);
    path_0.cubicTo(
        size.width * 0.1871235,
        size.height * 0.4228235,
        size.width * 0.08850845,
        size.height * 0.6825425,
        size.width * 0.03075305,
        size.height * 0.8776176);
    path_0.cubicTo(size.width * 0.01927174, size.height * 0.9163987,
        size.width * 0.009034319, size.height * 0.9580882, 0, size.height);
    path_0.close();
    path_0.moveTo(size.width * 0.5084742, size.height * 0.0004731144);
    path_0.cubicTo(
        size.width * 0.5076995,
        size.height * 0.0003720033,
        size.width * 0.5069296,
        size.height * 0.0002819709,
        size.width * 0.5061549,
        size.height * 0.0002031395);
    path_0.cubicTo(
        size.width * 0.5069296,
        size.height * 0.0001241353,
        size.width * 0.5077042,
        size.height * 0.00005638105,
        size.width * 0.5084742,
        0);
    path_0.lineTo(size.width * 0.5084742, size.height * 0.0004731144);
    path_0.close();

    Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint0fill);

    Path path_1 = Path();
    path_1.moveTo(size.width, size.height);
    path_1.lineTo(size.width * 0.4961643, size.height);
    path_1.lineTo(size.width * 0.4961643, size.height * 0.0004731013);
    path_1.cubicTo(
        size.width * 0.6404883,
        size.height * 0.01931330,
        size.width * 0.8128732,
        size.height * 0.4228235,
        size.width * 0.8128732,
        size.height * 0.4228235);
    path_1.cubicTo(
        size.width * 0.8128732,
        size.height * 0.4228235,
        size.width * 0.9114930,
        size.height * 0.6825425,
        size.width * 0.9692488,
        size.height * 0.8776176);
    path_1.cubicTo(
        size.width * 0.9807277,
        size.height * 0.9163987,
        size.width * 0.9909671,
        size.height * 0.9580882,
        size.width,
        size.height);
    path_1.close();
    path_1.moveTo(size.width * 0.4915211, size.height * 0.0004731013);
    path_1.cubicTo(
        size.width * 0.4922958,
        size.height * 0.0003719935,
        size.width * 0.4930704,
        size.height * 0.0002819631,
        size.width * 0.4938404,
        size.height * 0.0002031340);
    path_1.cubicTo(
        size.width * 0.4930657,
        size.height * 0.0001241320,
        size.width * 0.4922911,
        size.height * 0.00005637974,
        size.width * 0.4915211,
        0);
    path_1.lineTo(size.width * 0.4915211, size.height * 0.0004731013);
    path_1.close();

    Paint paint1fill = Paint()..style = PaintingStyle.fill;
    paint1fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_1, paint1fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.1471836, size.height * 0.7379314);
    path_2.lineTo(size.width * 0.2476606, size.height * 0.7063170);
    path_2.lineTo(size.width * 0.2870423, size.height * 0.6103464);
    path_2.lineTo(size.width * 0.1972249, size.height * 0.6103464);
    path_2.lineTo(size.width * 0.1471836, size.height * 0.7379314);
    path_2.close();

    Paint paint2fill = Paint()..style = PaintingStyle.fill;
    paint2fill.color = const Color(0xffE0DDF5).withOpacity(1.0);
    canvas.drawPath(path_2, paint2fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.1984648, size.height * 0.6000000);
    path_3.lineTo(size.width * 0.2957775, size.height * 0.6000000);
    path_3.lineTo(size.width * 0.3336620, size.height * 0.5678301);
    path_3.lineTo(size.width * 0.2875502, size.height * 0.5000000);
    path_3.lineTo(size.width * 0.1984648, size.height * 0.6000000);
    path_3.close();

    Paint paint3fill = Paint()..style = PaintingStyle.fill;
    paint3fill.color = const Color(0xffE0DDF5).withOpacity(1.0);
    canvas.drawPath(path_3, paint3fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.3010282, size.height * 0.4898399);
    path_4.lineTo(size.width * 0.3426836, size.height * 0.5620686);
    path_4.lineTo(size.width * 0.4968310, size.height * 0.4898399);
    path_4.lineTo(size.width * 0.4968310, size.height * 0.3931046);
    path_4.lineTo(size.width * 0.3010282, size.height * 0.4898399);
    path_4.close();

    Paint paint4fill = Paint()..style = PaintingStyle.fill;
    paint4fill.color = const Color(0xffE0DDF5).withOpacity(1.0);
    canvas.drawPath(path_4, paint4fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.8604648, size.height * 0.7379314);
    path_5.lineTo(size.width * 0.7599859, size.height * 0.7063170);
    path_5.lineTo(size.width * 0.7206056, size.height * 0.6103464);
    path_5.lineTo(size.width * 0.8104225, size.height * 0.6103464);
    path_5.lineTo(size.width * 0.8604648, size.height * 0.7379314);
    path_5.close();

    Paint paint5fill = Paint()..style = PaintingStyle.fill;
    paint5fill.color = const Color(0xffE0DDF5).withOpacity(1.0);
    canvas.drawPath(path_5, paint5fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.8091831, size.height * 0.6000000);
    path_6.lineTo(size.width * 0.7118685, size.height * 0.6000000);
    path_6.lineTo(size.width * 0.6739859, size.height * 0.5678301);
    path_6.lineTo(size.width * 0.7200986, size.height * 0.5000000);
    path_6.lineTo(size.width * 0.8091831, size.height * 0.6000000);
    path_6.close();

    Paint paint6fill = Paint()..style = PaintingStyle.fill;
    paint6fill.color = const Color(0xffE0DDF5).withOpacity(1.0);
    canvas.drawPath(path_6, paint6fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.7066197, size.height * 0.4898399);
    path_7.lineTo(size.width * 0.6649624, size.height * 0.5620686);
    path_7.lineTo(size.width * 0.5108169, size.height * 0.4898399);
    path_7.lineTo(size.width * 0.5108169, size.height * 0.3931046);
    path_7.lineTo(size.width * 0.7066197, size.height * 0.4898399);
    path_7.close();

    Paint paint7fill = Paint()..style = PaintingStyle.fill;
    paint7fill.color = const Color(0xffE0DDF5).withOpacity(1.0);
    canvas.drawPath(path_7, paint7fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//Copy this CustomPainter code to the Bottom of the File
class BodyRPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.04781967, 0);
    path_0.cubicTo(size.width * 0.01513992, size.height * 0.1262554, 0,
        size.height * 0.2551969, 0, size.height * 0.2551969);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width * 0.5000084, size.height);
    path_0.lineTo(size.width * 0.5000084, 0);
    path_0.lineTo(size.width * 0.04781967, 0);
    path_0.close();

    Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint0fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9500795, 0);
    path_1.cubicTo(
        size.width * 0.9827615,
        size.height * 0.1262554,
        size.width * 0.9978996,
        size.height * 0.2551969,
        size.width * 0.9978996,
        size.height * 0.2551969);
    path_1.lineTo(size.width * 0.9978996, size.height);
    path_1.lineTo(size.width * 0.4978996, size.height);
    path_1.lineTo(size.width * 0.4978996, 0);
    path_1.lineTo(size.width * 0.9500795, 0);
    path_1.close();

    Paint paint1fill = Paint()..style = PaintingStyle.fill;
    paint1fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_1, paint1fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
