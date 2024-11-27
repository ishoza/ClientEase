class UnboardingContent {
  String image;
  String title;
  String description;
  UnboardingContent(
      {required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents = [
  UnboardingContent(
      description: 'Pick the given Item here\n     More than 35 times',
      image: "images/footware 1.jpg",
      title: 'Select Footware From \n              Best App'),
  UnboardingContent(
    description:
        'You can pay cash on delivery and\n       Card payment is available',
    image: "images/footware 2.jpg",
    title: 'Easy and Online Payment',
  ),
  UnboardingContent(
    description: 'Deliver your footware at your\n                   Doorstep',
    image: "images/footware 3.png",
    title: 'Quick delivery at your door',
  )
];
