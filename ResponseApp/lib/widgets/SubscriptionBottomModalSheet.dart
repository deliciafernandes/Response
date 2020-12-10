import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:response/utilities/constants.dart';

import 'ReusableTextField.dart';

class SubscriptionBottomModalSheet extends StatefulWidget {
  @override
  _SubscriptionBottomModalSheetState createState() =>
      _SubscriptionBottomModalSheetState();
}

class _SubscriptionBottomModalSheetState
    extends State<SubscriptionBottomModalSheet> {
  @override
  Widget build(BuildContext context) {
    String email = '';
    String phoneNumber = '';
    String name = '';

    bool _isClicked = false;

    final _firestore = Firestore.instance;

//    String _validateName(String value) {
//      if (value.isEmpty) {
//        return 'Please enter a Name ';
//      }
//      return null;
//    }
//
//    String _validateEmail(String value) {
//      if (value.isEmpty) {
//        return 'Please enter an Email Address';
//      } else if (!validator.isEmail(email)) {
//        return 'Please enter a valid Email';
//      }
//      return null;
//    }
//
//    String validatePhoneNum(String value) {
//      String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
//      RegExp regExp = RegExp(pattern);
//
//      if (value.contains('+91', 0)) {
//        return null;
//      } else {
//        if (value.isEmpty) {
//          return 'Please enter a phone number';
//        } else if (!regExp.hasMatch(value)) {
//          return 'Please enter a valid phone number';
//        }
//      }
//
//      return null;
//    }

    ScreenUtil.init(
      context,
      width: 375.0,
      height: 667.0,
      allowFontScaling: true,
    );
    return Container(
      padding: EdgeInsets.all(25.0.w),
      margin: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.0.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45.0.w),
          topRight: Radius.circular(45.0.w),
          bottomRight: Radius.circular(45.0.w),
        ),
      ),
      child: Material(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45.0.w),
            topRight: Radius.circular(45.0.w),
            bottomRight: Radius.circular(45.0.w),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(30.0.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45.0.w),
              topRight: Radius.circular(45.0.w),
              bottomRight: Radius.circular(45.0.w),
            ),
            border: Border.all(
              color: Colors.black12,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _isClicked ? 'DONE' : 'Subscribe',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30.0),
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Merriweather',
                ),
              ),
              SizedBox(height: 20.0.h),
              Text('Fill in your details to subscribe to SMS and Email Alerts',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(15.0),
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Merriweather',
                  )),
              SizedBox(height: 20.0.h),
              ReusableTextField(
                hintText: 'Name',
                icon: Icons.face,
                keyboardType: TextInputType.name,
                errorText: _isClicked
                    ? (name.isEmpty ? 'Please input your name' : null)
                    : null,
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(height: 20.0.h),
              ReusableTextField(
                hintText: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                errorText: _isClicked
                    ? (email.isEmpty ? 'Please input your email' : null)
                    : null,
                onChanged: (value) {
                  email = value.trim();
                },
              ),
              SizedBox(height: 20.0.h),
              ReusableTextField(
                hintText: 'Phone no.',
                keyboardType: TextInputType.number,
                icon: Icons.phone,
                errorText: _isClicked
                    ? (phoneNumber.isEmpty ? 'Please input your name' : null)
                    : null,
                onChanged: (value) {
                  phoneNumber = value.trim();
                },
              ),
              SizedBox(height: 30.0.h),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                spacing: 15.0.w,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0.w, vertical: 10.0.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0.w),
                        border: Border.all(
                          color: Colors.black54,
                        ),
                      ),
                      child: Text(
                        'Clear',
                        style: kCustomNewsTileDisasterTextStyle.copyWith(
                            fontSize: ScreenUtil().setSp(13.0),
                            color: Colors.black54),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print(_isClicked);
                      setState(() {
                        _isClicked = true;
                        try {
                          _firestore.collection('Users').add({
                            'contact': phoneNumber,
                            'email': email,
                            'name': name,
                          });
                        } catch (e) {
                          print('$e on sign in button inside try catch');
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0.w, vertical: 10.0.h),
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20.0.w),
                        border: Border.all(
                          color: Colors.pinkAccent,
                        ),
                      ),
                      child: Text(
                        'Subscribe',
                        style: kCustomNewsTileDisasterTextStyle.copyWith(
                            fontSize: ScreenUtil().setSp(13.0),
                            color: Colors.pinkAccent),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
