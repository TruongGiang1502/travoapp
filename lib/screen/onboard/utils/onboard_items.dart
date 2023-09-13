import 'package:easy_localization/easy_localization.dart';

class OnboardItem {
  final String imageUrl, title, decription;

  OnboardItem({
    required this.imageUrl,
    required this.title,
    required this.decription,
  });

}

final List<OnboardItem> onboardItem = [
  OnboardItem(
    imageUrl: 'images/onboard_image1.png',
    title: "title_onboard1".tr(),
    decription:
        "des_onboard1".tr()
  ),
  OnboardItem(
    imageUrl: 'images/onboard_image2.png',
    title: "title_onboard2".tr(),
    decription:
        "des_onboard2".tr()
  ),
  OnboardItem(
    imageUrl: 'images/onboard_image3.png',
    title: "title_onboard3".tr(),
    decription:
        "des_onboard3".tr(),
  )
];

