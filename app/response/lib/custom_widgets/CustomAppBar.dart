import 'package:flutter/material.dart';
import 'package:response/utilities/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
//  final _drawerController = ZoomDrawerController();

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
//          ZoomDrawer(
//            controller: _drawerController,
//            menuScreen: CustomAppBar(),
//            mainScreen: DetailedNewsPage(),
//            borderRadius: 24.0,
//            showShadow: true,
//            angle: 0.0,
//            backgroundColor: Colors.grey[300],
//            slideWidth: MediaQuery.of(context).size.width *
//                (ZoomDrawer.isRTL() ? .45 : 0.65),
//          ),
          IconButton(
            icon: Icon(Icons.menu, size: 20.0.w, color: Colors.black),
            onPressed: () {
//              _drawerController.open();
            },
          ),
          Text(
            'RESPONSE',
            style: kCustomAppBarResponseLogoTextStyle,
          ),
          IconButton(
            icon: Icon(Icons.settings, size: 20.0.w, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
