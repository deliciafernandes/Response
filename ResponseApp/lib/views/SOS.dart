import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:response/utilities/constants.dart';

import 'SOSselect.dart';

class SOS extends StatefulWidget {
  static const String id = '/SOS';

  @override
  _SOSState createState() => _SOSState();
}

class _SOSState extends State<SOS> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation _animation;

  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 15.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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

//    ScreenUtil().setWidth()
//    ScreenUtil().setHeight()

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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(52),
                        bottom: ScreenUtil().setHeight(10.0)),
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
                      'Safety Services',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(20.0),
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Anton-Regular',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20))),
            child: Container(
              width: _width - ScreenUtil().setWidth(40),
              height: ScreenUtil().setHeight(215),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20)),
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SOSselect.id);
                    },
                    child: Container(
                      width: ScreenUtil().setWidth(200),
                      height: ScreenUtil().setHeight(130),
                      margin: EdgeInsets.only(top: 20.0, bottom: 15.0),
                      child: Image.asset('assets/images/alert_icon.png'),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffFCEDEE),
                            blurRadius: _animation.value * 4.5,
                            spreadRadius: _animation.value * 1.5,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(8),
                        bottom: ScreenUtil().setHeight(5),
                        left: ScreenUtil().setWidth(8.0),
                        right: ScreenUtil().setWidth(8.0)),
                    child: Text('Tap in case of an emergency',
                        textAlign: TextAlign.center,
                        style: kWhatToDoPageTextStyle.copyWith(
                            color: Colors.black38)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(25.0)),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
              width: _width - ScreenUtil().setWidth(40),
              height: ScreenUtil().setHeight(230),
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20)),
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Choose 5 Emergency Contacts',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(19.0),
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  GestureDetector(
                    onTap: () {
//                      getContacts();
                    },
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(10.0)),
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(30),
                            vertical: ScreenUtil().setHeight(10)),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.08),
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(20)),
                          border: Border.all(
                            color: Colors.blue,
                          ),
                        ),
                        child: Text(
                          'Choose Contacts',
                          style: kCustomNewsTileDisasterTextStyle.copyWith(
                              fontSize: ScreenUtil().setSp(15.0),
                              color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(50),
                              color: Colors.black38,
                              fontFamily: 'WorkSans',
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(15.0)),
                          Image.asset('assets/images/phone2.png',
                              width: ScreenUtil().setWidth(35.0),
                              height: ScreenUtil().setHeight(35.0))
                        ],
                      ),
                      Text('Contacts Added',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(13.5),
                            color: Colors.black38,
                            fontFamily: 'WorkSans',
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//  Iterable<Contact> _contacts;
//
//  getContacts() async {
//    PermissionStatus permissionStatus = await _getPermission();
//    PermissionStatus permissionStatus = PermissionStatus.granted;
//
//    if (permissionStatus == PermissionStatus.granted) {
//      var contacts = await ContactsService.getContacts();
//      setState(() {
//        _contacts = contacts;
//      });
//    } else {
//      throw PlatformException(
//        code: 'PERMISSION_DENIED',
//        message: 'Access to location data denied',
//        details: null,
//      );
//    }
//  }
//
//  Future<PermissionStatus> _getPermission() async {
//    PermissionStatus permission = await PermissionHandler()
//        .checkPermissionStatus(PermissionGroup.contacts);
//    if (permission != PermissionStatus.granted &&
//        permission != PermissionStatus.disabled) {
//      Map<PermissionGroup, PermissionStatus> permisionStatus =
//      await PermissionHandler()
//          .requestPermissions([PermissionGroup.contacts]);
//      return permisionStatus[PermissionGroup.contacts] ??
//          PermissionStatus.unknown;
//    } else {
//      return permission;
//    }
//}

//_contacts != null
}
