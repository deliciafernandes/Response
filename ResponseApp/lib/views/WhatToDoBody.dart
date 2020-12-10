import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:response/utilities/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:response/widgets/CustomAppBar.dart';
import 'package:response/widgets/CustomPrecautionListTile.dart';

class WhatToDoBody extends StatefulWidget {
  static const String id = '/WhatToDoBody';

  @override
  _WhatToDoBodyState createState() => _WhatToDoBodyState();
}

class _WhatToDoBodyState extends State<WhatToDoBody>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<CustomPrecautionListTile> _buildList() {
    List<CustomPrecautionListTile> _list = [];

    List<String> disasters = [
      'Earthquake',
      'Flood',
      'Storm',
      'Pandemic',
      'Wildfire',
      'Violence'
    ];

    for (int index = 0; index < disasters.length; index++) {
      var item = CustomPrecautionListTile(
        disaster: disasters[index],
      );
      _list.add(item);
    }

    return _list;
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    ScreenUtil.init(
      context,
      width: 375.0,
      height: 667.0,
      allowFontScaling: true,
    );

    return Column(
      children: [
        CustomAppBar(),
        Container(
          width: _width - 40.0.w,
          height: 180.0.h,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: _width - 40.0.w,
                  height: 125.0.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0.w),
                    border: Border.all(
                      color: kPrimaryRed,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/doctorTeam.png',
                      width: 200.0.w,
                      height: 130.0.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8.0.h, bottom: 5.0.h, left: 8.0.w, right: 8.0.w),
                      child: Text('Tips & Precautions from top doctors!',
                          textAlign: TextAlign.center,
                          style: kWhatToDoPageTextStyle),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        FadeTransition(
          opacity:
              _animationController.drive(CurveTween(curve: Curves.easeOut)),
          child: Container(
            margin: EdgeInsets.only(top: 10.0.h, bottom: 10.0.h),
            padding: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 40.0.w),
            decoration: BoxDecoration(
              color: Color(0xffe8f4fa),
              borderRadius: BorderRadius.all(Radius.circular(15.0.w)),
            ),
            child: Text(
              'Emergency Drill',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(17.5),
                fontFamily: 'WorkSans',
                color: Colors.black,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(
                bottom: 70.0.w, top: 0.0, right: 0.0, left: 0.0),
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            children: _buildList(),
          ),
        ),
      ],
    );
  }
}
