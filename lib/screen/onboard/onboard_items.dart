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
    title: 'Book a flight',
    decription:
        'Found a flight that matches your destination and schedule? Book it instantly.'
  ),
  OnboardItem(
    imageUrl: 'images/onboard_image2.png',
    title: 'Find a hotel room',
    decription:
        'Select the day, book your room. We give you the best price.'
  ),
  OnboardItem(
    imageUrl: 'images/onboard_image3.png',
    title: 'Enjoy your trip',
    decription:
        'Easy discovering new places and share these between your friends and travel together.'
  )
];

