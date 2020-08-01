import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:response/custom_widgets/CustomAppBar.dart';
import 'package:response/custom_widgets/CustomNewsTile.dart';
import 'package:response/utilities/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsBody extends StatefulWidget {
  static const String id = '/NewsBody';

  @override
  _NewsBodyState createState() => _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> {
  String _isClicked = 'national';

  //New firestore instance
  final _firestore = Firestore.instance;

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
          CustomAppBar(),
          Padding(
            padding: EdgeInsets.only(left: 20.0.w, top: 10.0.h, bottom: 10.0.h),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isClicked = 'national';
                    });
                  },
                  child: Text('National News',
                      style: _isClicked == 'national'
                          ? kActiveTitleNewsPageTextStyle
                          : kInactiveTitleNewsPageTextStyle),
                ),
                SizedBox(width: 20.0.w),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isClicked = 'local';
                    });
                  },
                  child: Text('Local News',
                      style: _isClicked == 'local'
                          ? kActiveTitleNewsPageTextStyle
                          : kInactiveTitleNewsPageTextStyle),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              // ignore: missing_return
              stream: _firestore.collection('RealNews').snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent),
                  );
                }
                final realNews = snapshot.data.documents;

                List<CustomNewsTile> newsWidgets = [];

                for (var news in realNews) {
                  final Timestamp testDate = news.data['date'];

//                  print(testDate.seconds);

                  final String date = 'July 31, 2020';

                  final String description = news.data['description'];
                  final String distype = news.data['distype'];
                  final String headline = news.data['headline'];
                  final String imageurl = news.data['imageurl'];
                  final String location = news.data['location'];
                  final String url = news.data['url'];

                  newsWidgets.add(CustomNewsTile(
                    date: date,
                    description: description,
                    distype: distype[0].toUpperCase() +
                        distype.substring(1).toLowerCase(),
                    headline: headline,
                    imageurl: imageurl,
                    location: location,
                    url: url,
                  ));
                }
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(
                        bottom: 70.0.w, top: 0.0, right: 0.0, left: 0.0),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    children: newsWidgets,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
