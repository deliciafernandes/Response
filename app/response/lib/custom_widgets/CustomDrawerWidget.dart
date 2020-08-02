import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:response/custom_icons/drawer_icon_icons.dart';
import 'package:response/custom_icons/share_icons.dart';
import 'package:response/utilities/constants.dart';

import 'CustomZoomScaffold.dart';

class CustomDrawerWidget extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;

    ScreenUtil.init(
      context,
      width: 375.0,
      height: 667.0,
      allowFontScaling: true,
    );

    return GestureDetector(
      onPanUpdate: (details) {
        //on swiping left
        if (details.delta.dx < -6) {
          Provider.of<MenuController>(context, listen: true).toggle();
        }
      },
      child: Container(
        padding: EdgeInsets.only(
            top: 55.h, left: 20.w, bottom: 8.h, right: _width / 2.9.w),
        color: Color(0xff061254),
//        color: Color(0xff3691CD), too blue
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/images/logo.png', width: 150.0, height: 100.0),
            SizedBox(height: 15.h),
            Column(
              children: options1.map((item) {
                return GestureDetector(
                  onTap: item.onPressed,
                  child: ListTile(
                    leading: Icon(
                      item.icon,
                      color: Colors.white,
                      size: 20.w,
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
                    size: 20.w,
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
                    fontSize: ScreenUtil().setSp(12.0), color: Colors.white54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;
  Function onPressed;

  MenuItem(this.icon, this.title, this.onPressed);
}
