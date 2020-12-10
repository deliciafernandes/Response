import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

EdgeInsetsGeometry kStandardPadding =
    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h);

const Color kLightPinkColor = Color(0xffF7C7CC);
const Color kFadedWhiteColour = Colors.white70;
const Color kPrimaryRed = Color(0xffED4C61);
const Color kDarkPinkRedColor = Color(0xff8D1D1A);

const Color kLightRed = Color(0xffEC6C6D);

TextStyle kWhatToDoTitleStyle = TextStyle(
  fontSize: ScreenUtil().setSp(20.0),
  fontFamily: 'WorkSans',
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

TextStyle kCustomAppBarResponseLogoTextStyle = TextStyle(
    fontSize: ScreenUtil().setSp(20.0),
    fontFamily: 'BungeeShade',
    color: kPrimaryRed,
    fontWeight: FontWeight.w500);

TextStyle kWhatToDoPageTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(15.0),
  color: Colors.black87,
  fontWeight: FontWeight.bold,
  fontFamily: 'Merriweather',
);

TextStyle kActiveTitleNewsPageTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(28.0),
  fontFamily: 'PlayfairDisplay-Bold',
);

TextStyle kInactiveTitleNewsPageTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(25.0),
  color: Colors.black38,
  fontFamily: 'PlayfairDisplay-Regular',
);

TextStyle kCustomNewsTileDisasterTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(13.0),
  color: Colors.black38,
  fontFamily: 'Merriweather',
);

TextStyle kCustomNewsTileHeadlineTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(13.0),
  color: Colors.black,
  fontFamily: 'Merriweather',
  fontWeight: FontWeight.bold,
);

TextStyle kCustomNewsTileDateTimeTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(12.0),
  color: Colors.black38,
  fontFamily: 'WorkSans',
);

TextStyle kCustomNewsTileDropCapTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(50.0),
  color: Colors.black,
  fontFamily: 'Lora',
);

TextStyle kCustomNewsTileDropCapBodyTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(18.0),
  color: Colors.black,
  fontFamily: 'Lora',
);

TextStyle kDrawerItemTextStyle = TextStyle(
    fontSize: ScreenUtil().setSp(14.0),
    fontWeight: FontWeight.bold,
    fontFamily: 'WorkSans',
    color: Colors.white);
