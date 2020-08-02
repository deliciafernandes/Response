import 'package:flutter/material.dart';
import 'package:response/custom_icons/idea_icons.dart';
import 'package:response/custom_icons/maps_icons.dart';
import 'package:response/custom_icons/news_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
//    MapsBody(), //todo settings screen
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
      body: _widgetList[_index],
      bottomNavigationBar: BottomNavigationBar(
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
//          BottomNavigationBarItem(
//              icon: Icon(Icons.settings),
//              title:
//                  Text('Settings', style: TextStyle(fontFamily: 'WorkSans'))),
        ],
      ),
    );
  }
}
