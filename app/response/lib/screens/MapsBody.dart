import 'package:flutter/material.dart';
import 'package:response/custom_widgets/CustomAppBar.dart';

class MapsBody extends StatefulWidget {
  static const String id = '/MapsBody';

  @override
  _MapsBodyState createState() => _MapsBodyState();
}

class _MapsBodyState extends State<MapsBody>
    with SingleTickerProviderStateMixin {
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
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
//          FadeAnimationY(
//            delay: 1.0,
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: [
//                Text('You need help?', style: kWhatToDoTitleStyle),
//                Text('We\'re here for you 😌', style: kWhatToDoTitleStyle),
//              ],
//            ),
//          ),
//          GestureDetector(
//            onTap: () {
//              //TODO: Implement SOS functionality!
//            },
//            child: Container(
//              width: 150,
//              height: 140,
//              margin: EdgeInsets.only(top: 20.0, bottom: 15.0),
//              child: Image.asset('assets/images/alert_icon.png'),
//              decoration: BoxDecoration(
//                shape: BoxShape.circle,
//                boxShadow: [
//                  BoxShadow(
//                    color: Color(0xffFCEDEE),
//                    blurRadius: _animation.value * 4.5,
//                    spreadRadius: _animation.value * 1.5,
//                  )
//                ],
//              ),
//            ),
//          ),
//          Text(
//            'Tap in case of an emergency',
//            style: TextStyle(
//              fontSize: 17.5,
//              fontFamily: 'WorkSans',
//              color: Colors.black38,
//            ),
//          ),
        ],
      ),
    );
  }
}
