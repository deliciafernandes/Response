import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:response/custom_widgets/CustomAppBar.dart';
import 'package:response/custom_widgets/CustomNewsTile.dart';
import 'package:response/utilities/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:response/utilities/location.dart';

String newsLocation = 'INDIA';

Future<bool> check;

class NewsBody extends StatefulWidget {
  static const String id = '/NewsBody';

  @override
  _NewsBodyState createState() => _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> {
  String _isClicked = 'national';

  //New firestore instance
  final _firestore = Firestore.instance;

  Location variable = Location();

  Future<bool> status() async {
    Location location = Location();

    check = location.checkMatch(newsLocation);
    print(check);

    if (await check) {
      print('yes');
    }

    return check;
  }

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
            stream: _firestore.collection('RealNews').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent),
                );
              }
              final realNews = snapshot.data.documents;

              List<CustomNewsTile> newsWidgets = [];
              List<CustomNewsTile> nationalNewsWidgets = [];
              List<CustomNewsTile> localNewsWidgets = [];

              for (var news in realNews) {
                //date conversion
                DateTime myDateTime =
                    DateTime.parse(news.data['date'].toDate().toString());

                final String date = DateFormat('d LLLL, y').format(myDateTime);
                final String description = news.data['description'];
                final String distype = news.data['distype'];
                final String headline = news.data['headline'];
                final String imageurl = news.data['imageurl'];
                final String url = news.data['url'];
                final String location = (news.data['location'] == null
                    ? 'India'
                    : news.data['location']);

                newsLocation = location.toUpperCase();

                status();

                nationalNewsWidgets.add(CustomNewsTile(
                  date: date == null ? '' : date,
                  description: description.isEmpty
                      ? 'Take action if you know an earthquake is going to hit before strikes. Secure items that might fall and cause injuries (e.g, bookshelves, mirrors, light fixtures). Practice how to Drop, Cover, and Hold On. Store critical supplies and documents. Plan how you will communicate with family members. Refer to the news link below to find out more. Be healthy, be safe!'
                      : description,
                  distype: distype == null
                      ? 'Disaster'
                      : distype[0].toUpperCase() +
                          distype.substring(1).toLowerCase(),
                  headline: headline.isEmpty
                      ? 'Disaster occurred : Refer news for further details.'
                      : headline,
                  imageurl: imageurl == null
                      ? 'https://images.pexels.com/photos/70573/fireman-firefighter-rubble-9-11-70573.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                      : imageurl,
                  location: location == null ? 'India' : location,
                  url: url == null
                      ? 'https://immohann.github.io/Crisis-Management/index.html'
                      : url,
                ));
              }
              return Expanded(
                child: ListView(
                  padding: EdgeInsets.only(
                      bottom: 70.0.w, top: 0.0, right: 0.0, left: 0.0),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: _isClicked == 'national'
                      ? nationalNewsWidgets
                      : localNewsWidgets,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}