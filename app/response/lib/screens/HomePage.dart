import 'package:flutter/material.dart';
import 'package:response/custom_icons/drawer_icon_icons.dart';

import 'package:response/custom_icons/idea_icons.dart';
import 'package:response/custom_icons/maps_icons.dart';
import 'package:response/custom_icons/news_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:response/custom_icons/share_icons.dart';
import 'package:response/models/MenuItem.dart';
import 'package:response/utilities/constants.dart';

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

class _HomePageState extends State<HomePage> {
  List<Widget> _widgetList = [
    WhatToDoBody(),
    NewsBody(),
    MapsBody(), //TODO
    MapsBody(), //todo settings screen
  ];

  final List<MenuItem> options1 = [
    MenuItem(DrawerIcon.home_run, 'Home', () {}),
    MenuItem(DrawerIcon.subscribe, 'Subscribe for Alerts', () {}),
  ];

  final List<MenuItem> options2 = [
    MenuItem(DrawerIcon.question_mark, 'How to use?', () {}),
    MenuItem(Share.icons8_share, 'Tell a friend', () {}),
    MenuItem(DrawerIcon.speak, 'Feedback', () {}),
    MenuItem(Icons.phone, 'Contact Us', () {}),
    MenuItem(DrawerIcon.terms_and_conditions, 'Terms & Conditions', () {}),
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

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.only(
              top: 55.h, bottom: 8.h, left: 20.w, right: 20.0.w),
          color: Color(0xff061254),
//        color: Color(0xff3691CD), too blue
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/images/logo.png',
                  width: 150.0, height: 100.0),
              SizedBox(height: 15.h),
              Column(
                children: options1.map((item) {
                  return GestureDetector(
                    onTap: item.onPressed,
                    child: ListTile(
                      leading: Icon(
                        item.icon,
                        color: Colors.white,
                        size: 25.w,
                      ),
                      title: Text(item.title, style: kDrawerItemTextStyle),
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
                  return ListTile(
                    leading: Icon(
                      item.icon,
                      color: Colors.white,
                      size: 25.w,
                    ),
                    title: Text(
                      item.title,
                      style: kDrawerItemTextStyle,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 35.h),
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
              title: Text('What to do?',
                  style: TextStyle(fontFamily: 'WorkSans'))),
          BottomNavigationBarItem(
              icon: Icon(News.icons8_news),
              title: Text('News', style: TextStyle(fontFamily: 'WorkSans'))),
          BottomNavigationBarItem(
              icon: Icon(Maps.location),
              title: Text('Map', style: TextStyle(fontFamily: 'WorkSans'))),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title:
                  Text('Settings', style: TextStyle(fontFamily: 'WorkSans'))),
        ],
      ),
    );
  }
}

//appBar: AppBar(
//automaticallyImplyLeading: false,
//backgroundColor: Colors.white,
//elevation: 0.0,
//title: Text(
//'RESPONSE',
//style: kCustomAppBarResponseLogoTextStyle,
//),
//leading: IconButton(
//icon: Icon(Icons.menu, size: 20.0.w, color: Colors.black),
//onPressed: () {
//_drawerController.open();
//},
//),
//actions: [
//IconButton(
//icon: Icon(Emergency.warning, size: 20.0.w, color: Colors.black),
//onPressed: () {
//Navigator.pushNamed(context, SOS.id);
//},
//),
//],
//),
