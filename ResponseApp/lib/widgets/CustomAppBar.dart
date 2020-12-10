import 'package:flutter/material.dart';
import 'package:response/custom_icons/emergency_icons.dart';
import 'package:response/utilities/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:response/views/SOS.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375.0,
      height: 667.0,
      allowFontScaling: true,
    );
    return SafeArea(
      top: true,
      bottom: false,
      left: false,
      right: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(Icons.menu, size: 20.0.w, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
          Text(
            'RESPONSE',
            style: kCustomAppBarResponseLogoTextStyle,
          ),
          IconButton(
            icon: Icon(Emergency.warning, size: 20.0.w, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, SOS.id);
            },
          ),
        ],
      ),
    );
  }
}
