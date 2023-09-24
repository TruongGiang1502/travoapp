import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Map <String, (String, String)> servicesOpts = {
  'FREE_WIFI' : ('images/services/free_wifi.svg', 'Free\nWiFi'),
  'NON_REFUNDABLE' : ('images/services/non_refund.svg', 'Non-\nRefundable'),
  'FREE_BREAKFAST' : ('images/services/free_breakfast.svg', 'Free\nBreakast'),
  'NON_SMOKING' : ('images/services/none_smoking.svg', 'Non-\nSmoking'),
  'ROOM_SERVICE':('images/services/24_hour.svg', 'Room\nService'),
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
                      servicesOpts[services[index]]!.$1,
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(height: 3,),
                    Text(servicesOpts[services[index]]!.$2, textAlign: TextAlign.center,)
                  ],
                ),
            );
          },
        );
      }
    );
  }
}