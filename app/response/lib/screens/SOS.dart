import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:response/custom_icons/emergency_icons.dart';
import 'package:response/utilities/constants.dart';

class SOS extends StatefulWidget {
  static const String id = '/SOS';

  @override
  _SOSState createState() => _SOSState();
}

class _SOSState extends State<SOS> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375.0,
      height: 667.0,
      allowFontScaling: true,
    );

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            top: true,
            bottom: false,
            left: false,
            right: false,
            child: Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10),
                  left: ScreenUtil().setWidth(10),
                  right: ScreenUtil().setWidth(10),
                  bottom: ScreenUtil().setHeight(5)),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        size: ScreenUtil().setWidth(20.0), color: Colors.black),
                    onPressed: () {},
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                        vertical: ScreenUtil().setHeight(10)),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(20)),
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Text(
                      'SAFETY SERVICES',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(20.0),
                        color: Colors.black38,
                        fontFamily: 'Merriweather',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
