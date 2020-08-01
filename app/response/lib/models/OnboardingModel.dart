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
        info: 'Based on your location, Response shows relevant news.'),
    OnboardingPageModel(
        image: 'assets/images/doctors.png',
        title: 'HELPLINE FACILITIES',
        info: 'Locate closest helpline facilities in your periphery.'),
    OnboardingPageModel(
        image: 'assets/images/map.png',
        title: 'MAP SERVICES',
        info: 'Be informed of any incoming fatal situations via gps.'),
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
