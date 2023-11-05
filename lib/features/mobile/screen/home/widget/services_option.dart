import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServicesOptions{
  String imageUrl;
  String text;

  ServicesOptions({required this.imageUrl, required this.text});
}

Map <String, ServicesOptions> servicesOpts = {
  'FREE_WIFI' : ServicesOptions(imageUrl: 'images/services/free_wifi.svg', text:"free_wifi".tr()),
  'NON_REFUNDABLE' : ServicesOptions(imageUrl: 'images/services/non_refund.svg', text: "non_refund".tr()),
  'FREE_BREAKFAST' : ServicesOptions(imageUrl: 'images/services/free_breakfast.svg', text: "free_breakfast".tr()),
  'NON_SMOKING' : ServicesOptions(imageUrl: 'images/services/none_smoking.svg', text: "non_smoke".tr()),
  'ROOM_SERVICE': ServicesOptions(imageUrl: 'images/services/24_hour.svg', text: "room_service".tr()),
};

class ServicesOption extends StatelessWidget {
  final BuildContext context;
  final List<dynamic> services;
  const ServicesOption({super.key, required this.services, required this.context});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: services.length,
          itemBuilder: (BuildContext context, int index){
            return SizedBox(
              width: constraint.maxWidth/services.length,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [         
                    SvgPicture.asset(
                      servicesOpts[services[index]]!.imageUrl,
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(height: 3,),
                    Text(
                      servicesOpts[services[index]]!.text, 
                      style: const TextStyle(
                        color: Colors.black
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
            );
          },
        );
      }
    );
  }
}