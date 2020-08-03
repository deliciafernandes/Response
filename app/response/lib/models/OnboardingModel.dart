class OnboardingPageModel {
  String image;
  String title;
  String info;

  OnboardingPageModel({this.image, this.title, this.info});
}

class OnboardingPage {
  static List<OnboardingPageModel> _page = [
    OnboardingPageModel(
        image: 'assets/images/news.png',
        title: 'DISASTER NEWS',
        info:
            'Based on your location, Response shows national and local news on News Screen'),
    OnboardingPageModel(
        image: 'assets/images/doctors.png',
        title: 'HEALTH CARE FACILITIES',
        info:
            'Be prepared before, during and after a disaster with steps from top doctors'),
    OnboardingPageModel(
        image: 'assets/images/map.png',
        title: 'MAP SERVICES',
        info:
            'Locate closest helpline facilities in your periphery & be informed of any incoming fatal situations via gps.'),
    OnboardingPageModel(
        image: 'assets/images/sos.png',
        title: 'SOS BUTTON',
        info:
            'Use the emergency SOS button to notify your contacts when you\'re in need.'),
  ];

  String getImage(int pageNumber) {
    return _page[pageNumber].image;
  }

  String getTitle(int pageNumber) {
    return _page[pageNumber].title;
  }

  String getInfo(int pageNumber) {
    return _page[pageNumber].info;
  }

  static int getNumOfPages() {
    return _page.length;
  }
}
