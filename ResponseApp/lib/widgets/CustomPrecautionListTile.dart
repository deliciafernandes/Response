import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../views/Flood.dart';
//import 'package:url_launcher/url_launcher.dart';

class CustomPrecautionListTile extends StatelessWidget {
  final String disaster;
  final Function onPressed;

  CustomPrecautionListTile({@required this.disaster, this.onPressed});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375.0,
      height: 667.0,
      allowFontScaling: true,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 10.0.h, left: 15.0.w, right: 15.0.w),
      child: Material(
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0.w)),
        child: Container(
          height: 100.0.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0.w),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/$disaster.jpg'),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0.w),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                stops: [0.1, 0.9],
                colors: [
                  Colors.black.withOpacity(.8),
                  Colors.black.withOpacity(.1)
                ],
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$disaster',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(18.0),
                      fontFamily: 'WorkSans-Black',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      print(disaster);

                      Navigator.pushNamed(context, Flood.id);
//                      try {
//                        await launch(
//                            'https://immohann.github.io/Crisis-Management/earthquake.html');
//                      } catch (e) {
//                        print('$e : Could not launch urk on DetailedNewsPage');
//                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
