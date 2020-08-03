import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:response/custom_icons/arrow_front_icons.dart';
import 'package:response/custom_icons/heart_icon_icons.dart';
import 'package:response/custom_icons/share_icons.dart';
import 'package:response/utilities/constants.dart';
import 'package:drop_cap_text/drop_cap_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart' as ShareFunction;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailedNewsPage extends StatefulWidget {
  static const String id = '/DetailedNewsPage';

  final String date;
  final String description;
  final String distype;
  final String headline;
  final String imageurl;
  final String location;
  final String url;

  DetailedNewsPage(
      {this.distype,
      this.imageurl,
      this.headline,
      this.date,
      this.location,
      this.description,
      this.url});

  @override
  _DetailedNewsPageState createState() => _DetailedNewsPageState();
}

final snackBar = SnackBar(
  content: Text(
    'Unable to access link, check your network connection.',
    style: TextStyle(fontFamily: 'WorkSans'),
  ),
  action: SnackBarAction(
    label: 'RETRY',
    textColor: Color(0xff9B72CD),
    onPressed: () {},
  ),
);

class _DetailedNewsPageState extends State<DetailedNewsPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  NetworkImage _buildImage() {
    try {
      return NetworkImage(widget.imageurl);
    } catch (e) {
      return NetworkImage(
          'https://images.pexels.com/photos/70573/fireman-firefighter-rubble-9-11-70573.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375.0,
      height: 667.0,
      allowFontScaling: true,
    );

    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return SafeArea(
          top: true,
          bottom: false,
          left: false,
          right: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 10.0.h, left: 10.0.w, right: 10.0.w, bottom: 5.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios_outlined,
                          color: Colors.black, size: 15.0.w),
                      backgroundColor: Colors.white,
                      elevation: 5.0,
                      mini: true,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0.w, vertical: 10.0.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0.w),
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Text(
                        widget.distype,
                        style: kCustomNewsTileDisasterTextStyle.copyWith(
                            fontSize: ScreenUtil().setSp(15.0)),
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: null,
                      onPressed: () {
                        ShareFunction.Share.share(
                            "${widget.distype} Alert⚠️️ ${widget.headline}❗Visit the news link: ${widget.url} Do a good thing today😇 Donate to ${widget.distype} Relief funds: https://pmnrf.gov.in/en/online-donation", //TODO: Put link
                            subject: 'News shared from Response App');
                      },
                      child: Icon(Share.icons8_share,
                          color: Colors.black, size: 15.0.w),
                      backgroundColor: Colors.white,
                      elevation: 5.0,
                      mini: true,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(0.0),
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0.h, horizontal: 25.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            widget.headline,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(22.0),
                              color: Colors.black,
                              fontFamily: 'PlayfairDisplay-Bold',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.0.h),
                            child: Material(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0.w)),
                              child: Container(
                                height: 200.0.h,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0.w)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover, image: _buildImage()),
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10.0.w, bottom: 10.0.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0.w)),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      stops: [0.1, 0.9],
                                      colors: [
                                        Colors.black.withOpacity(.8),
                                        Colors.black.withOpacity(.1)
                                      ],
                                    ),
                                  ),
                                  alignment: Alignment.bottomLeft,
                                  child: Visibility(
                                    visible:
                                        true, //TODO: Visible if the news is live
                                    child: FadeTransition(
                                      opacity: _animationController.drive(
                                          CurveTween(curve: Curves.easeOut)),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2.0.h,
                                            horizontal: 10.0.w),
                                        decoration: BoxDecoration(
                                          color: Color(0xff92F0AD),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0.w)),
                                        ),
                                        child: Text(
                                          'LIVE',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(12.0),
                                            fontFamily: 'FredokaOne',
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff132418),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            ' Yesterday, 9:24 PM • ${widget.location}', //todo date
                            style: kCustomNewsTileDateTimeTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 18.0.h, left: 25.0.w, bottom: 40.0.h),
                      child: Material(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0.w),
                            bottomLeft: Radius.circular(5.0.w),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              await launch(
                                  'https://immohann.github.io/Crisis-Management/${widget.distype}.html');
                            } catch (e) {
                              print(
                                  '$e : Could not launch ${widget.url} on DetailedNewsPage');

                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          },
                          child: Container(
                            height: 30.0.h,
                            width: _width,
                            padding: EdgeInsets.only(
                                left: 20.0.w, top: 5.0.h, bottom: 5.0.h),
                            decoration: BoxDecoration(
                              color: Color(0xffF3963E),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0.w),
                                bottomLeft: Radius.circular(5.0.w),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Refer ${widget.distype} Precautions   ',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(15.0),
                                    color: Colors.white54,
                                    fontFamily: 'Merriweather',
                                  ),
                                ),
                                Icon(ArrowFront.right_outline,
                                    color: Colors.white54, size: 13.0.w),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0.w),
                      child: Column(
                        children: [
                          DropCapText(
                            widget.description,
                            mode: DropCapMode.inside,
                            dropCapPadding: EdgeInsets.only(right: 5.0.w),
                            dropCapStyle: kCustomNewsTileDropCapTextStyle,
                            style: kCustomNewsTileDropCapBodyTextStyle,
                          ),
                          SizedBox(height: 30.0.h),
                          Text(
                            'Do a good thing today!',
                            textAlign: TextAlign.center,
                            style: kCustomNewsTileDisasterTextStyle.copyWith(
                                fontSize: ScreenUtil().setSp(15.0)),
                          ),
                          Text(
                            'Donate to ${widget.distype} Relief Funds',
                            textAlign: TextAlign.center,
                            style: kCustomNewsTileDisasterTextStyle.copyWith(
                                fontSize: ScreenUtil().setSp(15.0)),
                          ),
                          GestureDetector(
                            onTap: () async {
                              String donationLink =
                                  'https://pmnrf.gov.in/en/online-donation';
                              try {
                                await launch(donationLink);
                              } catch (e) {
                                print(
                                    '$e : Could not launch $donationLink on DetailedNewsPage');

                                Scaffold.of(context).showSnackBar(snackBar);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 20.0.w),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0.w, vertical: 10.0.h),
                              decoration: BoxDecoration(
                                color: Colors.pinkAccent.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(20.0.w),
                                border: Border.all(
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              child: Wrap(
                                spacing: 15.0.w,
                                alignment: WrapAlignment.center,
                                children: [
                                  Icon(HeartIcon.heart,
                                      color: Colors.pinkAccent, size: 20.0.w),
                                  Text(
                                    'Donate',
                                    style: kCustomNewsTileDisasterTextStyle
                                        .copyWith(
                                            fontSize: ScreenUtil().setSp(15.0),
                                            color: Colors.pinkAccent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              try {
                                await launch(widget.url);
                              } catch (e) {
                                print(
                                    '$e : Could not launch ${widget.url} on DetailedNewsPage');

                                Scaffold.of(context).showSnackBar(snackBar);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 30.0.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0.w, vertical: 10.0.h),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(20.0.w),
                                border: Border.all(
                                  color: Colors.blue,
                                ),
                              ),
                              child: Text(
                                'Click here to visit the news link',
                                style:
                                    kCustomNewsTileDisasterTextStyle.copyWith(
                                        fontSize: ScreenUtil().setSp(15.0),
                                        color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
