import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

(String, String) stringService(String servicesName){
  if(servicesName == "FREE_WIFI"){
    return ("images/services/free_wifi.svg" ,"Free\nWiFi");
  }
  else if (servicesName == "NON_REFUNDABLE"){
    return ("images/services/non_refund.svg" , "Non-\nRefundable");
  }
  else if (servicesName == "FREE_BREAKFAST"){
    return ("images/services/free_breakfast.svg" , "Free\nBreakast");
  }
  else if (servicesName == "NON_SMOKING"){
    return ("images/services/none_smoking.svg" , "Non-\nSmoking");
  }
  else {
    return ("images/services/24_hour.svg" , "Room\nService");
  }
}

class ServicesOption extends StatelessWidget {
  final BuildContext context;
  final List<dynamic> services;
  const ServicesOption({super.key, required this.services, required this.context});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: services.length,
      itemBuilder: (BuildContext context, int index){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [         
                SvgPicture.asset(
                  stringService(services[index]).$1,
                  width: 40,
                  height: 40,
                ),
                const SizedBox(height: 3,),
                Text(stringService(services[index]).$2, textAlign: TextAlign.center,)
              ],
            ),
        );
      },
    );
  }
}