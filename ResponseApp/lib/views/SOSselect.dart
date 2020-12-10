import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:response/widgets/CustomSOSTile.dart';

class SOSselect extends StatelessWidget {
  static const String id = '/SOSselect';

  List<CustomSOSTile> _buildList() {
    List<CustomSOSTile> _list = [];

    List<String> disasters = [
      'Earthquake',
      'Flood',
      'Storm',
      'Pandemic',
      'Wildfire',
      'Violence'
    ];

    for (int index = 0; index < disasters.length; index++) {
      var item = CustomSOSTile(
        disaster: disasters[index],
      );
      _list.add(item);
    }

    return _list;
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
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setWidth(20.0),
            horizontal: ScreenUtil().setHeight(20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(5)),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        size: ScreenUtil().setWidth(20.0), color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Text(
                  'Choose Disaster',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(20.0),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'WorkSans',
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(15.0)),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                    bottom: ScreenUtil().setWidth(70.0),
                    top: 0.0,
                    right: 0.0,
                    left: 0.0),
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                children: _buildList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
