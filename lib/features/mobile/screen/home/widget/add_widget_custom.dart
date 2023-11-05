import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travo_demo/features/mobile/screen/home/models/guest_info_model.dart';
import 'package:travo_demo/features/mobile/screen/home/widget/bloc/get_info_cubit.dart';
import 'package:travo_demo/widgets/container_decor.dart';
import 'package:travo_demo/utils/color.dart';

class AddInfoGuestCustom extends StatelessWidget {
  final VoidCallback onPressed;
  final String imageUrl, title, defaultText , heroTag;
  final List<InfoGuest> listInfoGuest;
  final double textSize;
  const AddInfoGuestCustom(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.defaultText,
      required this.listInfoGuest,
      required this.onPressed,
      required this.heroTag, 
      required this.textSize});
      
  Widget textWidget(double width) {
    if(listInfoGuest.isEmpty){
      return Text(
        defaultText,
        style: TextStyle(
          color: indigo,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      );
    }
    else {
      return SizedBox(
        width: width,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listInfoGuest.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 10,
                top: 8,
                bottom: 8
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customer ${index+1}', 
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.red
                        ),
                      ),
                      Text(
                        listInfoGuest[index].name, 
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        listInfoGuest[index].email, 
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: textSize
                        )
                      ),
                      Text(
                        '+${listInfoGuest[index].phoneNumber}', 
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: textSize
                        )
                      )
                    ],
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: IconButton(
                      onPressed: (){
                        context.read<GetInfoCubit>().removeInfo(listInfoGuest[index]);
                      }, 
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.red,
                      )
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: ContainerBoxDecor(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget(imageUrl, title),
              const SizedBox(
                height: 20,
              ),
              childBuilderWidget(
                heroTag, 
                onPressed, 
                textWidget, 
                listInfoGuest.isEmpty? 0.7 :1
              )
            ],
          ),
        ),
      ),
    );
  }
}


class AddPromoCodeCustom extends StatelessWidget {
  final VoidCallback onPressed;
  final String imageUrl, title, defaultText ,textFunction, heroTag;
  final double sizeText;
  const AddPromoCodeCustom(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.defaultText,
      required this.textFunction,
      required this.onPressed,
      required this.heroTag, 
      required this.sizeText});
      
  Widget textWidget(double width) {
    if(textFunction==''){
      return Text(
        defaultText,
        style: TextStyle(
            color: indigo,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      );
    }
    else {
      return Text(
        textFunction,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: sizeText),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ContainerBoxDecor(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget(imageUrl, title),
              const SizedBox(
                height: 20,
              ),
              childBuilderWidget(heroTag, onPressed, textWidget, 0.7)
            ],
          ),
        ),
      ),
    );
  }
}



Widget titleWidget (String imageUrl, String title){
  return Row(
    children: [
      SvgPicture.asset(imageUrl),
      const SizedBox(
        width: 10,
      ),
      Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
      )
    ],
  );
}

Widget childBuilderWidget(String heroTag, VoidCallback onPressed, Function textWidget, double ratio){
  return LayoutBuilder(builder: (context, constraint) {
    return Container(
      width: constraint.maxWidth * ratio,
      decoration: BoxDecoration(
          color: linkWater,
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Transform.scale(
            scale: 0.9,
            child: FloatingActionButton(
              heroTag: heroTag,
              onPressed: onPressed,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          textWidget(constraint.maxWidth*0.75)
        ],
      ),
    );
  });
}