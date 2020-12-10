import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart' as ShareFunction;

class CustomSOSTile extends StatelessWidget {
  final String disaster;

  CustomSOSTile({@required this.disaster});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375.0,
      height: 667.0,
      allowFontScaling: true,
    );

    // ${NewsBody.disasterType}  _sendSMS();
//    _sendSMS() async {
//      List<String> recipients = [
//        "9920238345", //del
//        "9869200737", //jay
//        '80804 08783', //dwy
//      ];
//      String _result = await FlutterSms.sendSMS(
//              message:
//                  " Hi, Right now I am in a disaster zone of Earthquake, Please help me, My location is <location>, call an ambulance at my location. The nearest hospital is <hospital name> and contact no of it is <number>. Thank you.",
//              recipients: recipients)
//          .catchError((onError) {
//        print(onError);
//      });
//      print(_result);
//    }

    return Padding(
      padding: EdgeInsets.only(bottom: 10.0.h, left: 15.0.w, right: 15.0.w),
      child: GestureDetector(
        onTap: () {
          ShareFunction.Share.share(
              "Hi Vinit, Right now I am in a Flood disaster zone, Please help me, My location is Jp road, Andheri East, Mumbai. Call an ambulance at my location. The nearest hospital is HolySpirit hospital, Mahakali east and contact no of it is  02228248500 . Thank you.",
              subject: 'Message from Response App');
        },
        child: Material(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0.w)),
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
                child: Text(
                  '$disaster',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(18.0),
                    fontFamily: 'WorkSans-Black',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
