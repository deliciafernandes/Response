//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:response/custom_widgets/CustomAppBar.dart';
//import 'package:response/custom_widgets/CustomDrawerWidget.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//import 'custom_icons/idea_icons.dart';
//import 'custom_icons/maps_icons.dart';
//import 'custom_icons/news_icons.dart';
//import 'screens/MapsBody.dart';
//import 'screens/NewsBody.dart';
//import 'screens/WhatToDoBody.dart';
//
//class Test extends StatefulWidget {
//  static const String id = '/Test';
//
//  @override
//  _TestState createState() => _TestState();
//}
//
//class _TestState extends State<Test> with TickerProviderStateMixin {
//  MenuController menuController;
//
//  @override
//  void initState() {
//    super.initState();
//
//    menuController = new MenuController(
//      vsync: this,
//    )..addListener(() => setState(() {}));
//  }
//
//  @override
//  void dispose() {
//    menuController.dispose();
//    super.dispose();
//  }
//
//  List<Widget> _widgetList = [
//    WhatToDoBody(),
//    NewsBody(),
//    MapsBody(), //TODO
//    MapsBody(),
//  ];
//
//  int _index = 1;
//
//  @override
//  Widget build(BuildContext context) {
//    ScreenUtil.init(
//      context,
//      width: 375.0,
//      height: 667.0,
//      allowFontScaling: true,
//    );
//
//    return Scaffold(
//      extendBody: true,
//      backgroundColor: Colors.white,
//      body: ChangeNotifierProvider.value(
//          value: menuController,
//          child: CustomAppBar(
//            menuScreen: CustomDrawerWidget(),
//            contentScreen: Layout(
//              contentBuilder: (cc) => _widgetList[_index],
//            ),
//          )),
//      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: _index,
//        type: BottomNavigationBarType.fixed,
//        backgroundColor: Colors.black87,
//        selectedItemColor: Colors.white,
//        unselectedItemColor: Colors.white54,
//        iconSize: 20.0.w,
//        onTap: (int index) {
//          setState(() {
//            _index = index;
//          });
//        },
//        items: [
//          BottomNavigationBarItem(
//              icon: Icon(Idea.icons8_idea),
//              title: Text('What to do?',
//                  style: TextStyle(fontFamily: 'WorkSans'))),
//          BottomNavigationBarItem(
//              icon: Icon(News.icons8_news),
//              title: Text('News', style: TextStyle(fontFamily: 'WorkSans'))),
//          BottomNavigationBarItem(
//              icon: Icon(Maps.location),
//              title: Text('Map', style: TextStyle(fontFamily: 'WorkSans'))),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.settings),
//              title: Text('Temp', style: TextStyle(fontFamily: 'WorkSans'))),
//        ],
//      ),
//    );
//  }
//}
