import 'package:flutter/material.dart';
import 'package:response/utilities/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:response/views/DetailedNewsPage.dart';

class CustomNewsTile extends StatefulWidget {
  final String date;
  final String description;
  final String distype;
  final String headline;
  final String imageurl;
  final String location;
  final String url;

  CustomNewsTile(
      {this.distype,
      this.imageurl,
      this.headline,
      this.date,
      this.location,
      this.description,
      this.url});

  @override
  _CustomNewsTileState createState() => _CustomNewsTileState();
}

class _CustomNewsTileState extends State<CustomNewsTile>
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

//  String imageUrl;
//  NetworkImage _buildImage() {
//    imageUrl = widget.imageurl;
//    try {
//      return NetworkImage(widget.imageurl);
//    } catch (e) {
//      imageUrl =
//          'https://images.pexels.com/photos/70573/fireman-firefighter-rubble-9-11-70573.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940';
//      return NetworkImage(
//          'https://images.pexels.com/photos/70573/fireman-firefighter-rubble-9-11-70573.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940');
//    }
//  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375.0,
      height: 667.0,
      allowFontScaling: true,
    );

    return GestureDetector(
      onTap: () {
        //TODO: Navigate to the respective DetailedNewsPage
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailedNewsPage(
                    date: widget.date,
                    description: widget.description,
                    distype: widget.distype,
                    headline: widget.headline,
                    imageurl: widget.imageurl,
                    location: widget.location,
                    url: widget.url,
                  )),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 15.0.w),
        child: Material(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0.w)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0.w),
              border: Border.all(
                color: Colors.black12,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.distype}',
                      style: kCustomNewsTileDisasterTextStyle,
                    ),
                    Visibility(
                      visible: true, //TODO: Visible if the news is live
                      child: FadeTransition(
                        opacity: _animationController
                            .drive(CurveTween(curve: Curves.easeOut)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0.h, horizontal: 10.0.w),
                          decoration: BoxDecoration(
                            color: Color(0xff92F0AD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0.w)),
                          ),
                          child: Text(
                            'LIVE',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              fontFamily: 'FredokaOne',
                              fontWeight: FontWeight.w500,
                              color: Color(0xff132418),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 100.0.h,
                  margin: EdgeInsets.only(top: 8.0.h, bottom: 15.0.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0.w),
                        topRight: Radius.circular(10.0.w)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.imageurl),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0.h),
                          topRight: Radius.circular(10.0.h)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        stops: [0.1, 0.9],
                        colors: [
                          Colors.black.withOpacity(.8),
                          Colors.black.withOpacity(.1)
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.headline,
                  style: kCustomNewsTileHeadlineTextStyle,
                ),
                SizedBox(height: 10.0.h),
                Text(
                  '${widget.date}  •  ${widget.location}',
//                  '•  ${widget.location}',
                  style: kCustomNewsTileDateTimeTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
