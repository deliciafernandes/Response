import 'package:flutter/material.dart';
import 'package:response/custom_icons/drawer_icon_icons.dart';

import 'package:response/custom_icons/idea_icons.dart';
import 'package:response/custom_icons/maps_icons.dart';
import 'package:response/custom_icons/news_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:response/custom_icons/share_icons.dart';
import 'package:response/models/MenuItem.dart';
import 'package:response/utilities/constants.dart';
import 'package:response/widgets/SubscriptionBottomModalSheet.dart';

import 'package:share/share.dart' as ShareFunction;
import 'package:url_launcher/url_launcher.dart';

import 'HomePageDialogflow.dart';
import 'MapsBody.dart';
import 'NewsBody.dart';
import 'WhatToDoBody.dart';

class HomePage extends StatefulWidget {
  static const String id = '/HomePage';

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

final snackBar = SnackBar(
  content: Text(
    'Unable to access link, check your network connection.',
    style: TextStyle(fontFamily: 'WorkSans'),
  ),
  action: SnackBarAction(
    label: 'RETRY',
    textColor: Color(0xff9B72CD),
    onPressed: () {},
  ),
);

class _HomePageState extends State<HomePage> {
  List<Widget> _widgetList = [
    WhatToDoBody(),
    NewsBody(),
    MapsBody(),
    HomePageDialogflow(),
  ];

  int _index = 1;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375.0,
      height: 667.0,
      allowFontScaling: true,
    );

    final List<MenuItem> options1 = [
      MenuItem(DrawerIcon.home_run, 'Home', () => Navigator.pop(context)),
      MenuItem(
        Icons.notifications_active,
        'Subscribe for Alerts',
        () {
          Navigator.pop(context);
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Wrap(
                  children: [
                    SubscriptionBottomModalSheet(),
                  ],
                );
              });
        },
      ),
    ];

    final List<MenuItem> options2 = [
      MenuItem(DrawerIcon.question_mark, 'How to use?', () {
        //TODO: Bug here
        // Navigator.pushNamed(context, OnboardingScreen.id);
      }),
      MenuItem(
          Share.icons8_share,
          'Tell a friend',
          () => ShareFunction.Share.share(
              "Response is a A Cross Platform Mobile Application for disaster management. Be safe, be alert and always be ready with Response!",
              subject: 'Download Response App')),
      MenuItem(DrawerIcon.speak, 'Feedback', () async {
        String url = 'https://forms.gle/KbumM4K9bx8a3FT29';
        try {
          await launch(url);
          print('y');
        } catch (e) {
          print('n');

          print('$e : Could not launch $url on Homepage');

          Scaffold.of(context).showSnackBar(snackBar); //check
        }
      }),
      MenuItem(Icons.phone, 'Contact Us', () async {
        String url = 'https://immohann.github.io/Crisis-Management/';
        try {
          await launch(url);
          print('y');
        } catch (e) {
          print('n');

          print('$e : Could not launch $url on Homepage');

          Scaffold.of(context).showSnackBar(snackBar); //check
        }
      }),
      MenuItem(DrawerIcon.terms_and_conditions, 'Terms & Conditions', () {}),
    ];

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/drawer.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    stops: [0.5, 1],
                    colors: [
                      Colors.black.withOpacity(.9),
                      Colors.black.withOpacity(.2)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 50.h, bottom: 50.h, left: 20.w, right: 20.0.w),
//          color: Color(0xff061254),
//        color: Color(0xff3691CD), too blue
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('assets/images/logo.png',
                      width: 150.0.w, height: 100.0.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: options1.map((item) {
                          return GestureDetector(
                            onTap: item.onPressed,
                            child: ListTile(
                              leading: Icon(
                                item.icon,
                                color: Colors.white,
                                size: 30.w,
                              ),
                              title:
                                  Text(item.title, style: kDrawerItemTextStyle),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10.h),
                      Divider(color: Colors.white54),
                      Text(
                        'About',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(12.0),
                            fontWeight: FontWeight.bold,
                            color: Colors.white70),
                      ),
                      Column(
                        children: options2.map((item) {
                          return GestureDetector(
                            onTap: item.onPressed,
                            child: ListTile(
                              leading: Icon(
                                item.icon,
                                color: Colors.white,
                                size: 25.w,
                              ),
                              title: Text(
                                item.title,
                                style: kDrawerItemTextStyle,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20.h),
                      Center(
                        child: Text(
                          'Version 1.0.0',
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(12.0),
                              color: Colors.white54),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _widgetList[_index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        backgroundColor: Colors.black87,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        iconSize: 20.0.w,
        onTap: (int index) {
          setState(() {
            _index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Idea.icons8_idea),
            label: 'What to do?',
          ),
          BottomNavigationBarItem(icon: Icon(News.icons8_news), label: 'News'),
          BottomNavigationBarItem(icon: Icon(Maps.location), label: 'Map'),
          BottomNavigationBarItem(
              icon: Icon(DrawerIcon.speak), label: 'ChatBot'),
        ],
      ),
    );
  }
}
