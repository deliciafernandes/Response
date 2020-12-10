//import 'package:flutter/material.dart';
//import 'package:response/screens/LoginPage.dart';
//import 'package:response/screens/OnboardingScreen.dart';
//import 'package:response/screens/SignInWithPhone.dart';
//import 'package:response/screens/SignUpWithEmail.dart';
//import 'package:response/utilities/constants.dart';
//
//class HelloPage extends StatefulWidget {
//  static String id = '/HelloPage';
//
//  @override
//  _HelloPageState createState() => _HelloPageState();
//}
//
//class _HelloPageState extends State<HelloPage>
//    with SingleTickerProviderStateMixin {
//  AnimationController _animationController;
//  Animation _animation;
//
//  void initState() {
//    super.initState();
//
//    _animationController =
//        AnimationController(vsync: this, duration: Duration(seconds: 1));
//    _animationController.repeat(reverse: true);
//    _animation = Tween(begin: 2.0, end: 15.0).animate(_animationController)
//      ..addListener(() {
//        setState(() {});
//      });
//  }
//
//  @override
//  void dispose() {
//    _animationController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    var _width = MediaQuery.of(context).size.width;
//    var _height = MediaQuery.of(context).size.height;
//
//    return Scaffold(
//      backgroundColor: Colors.transparent,
//      body: Container(
//        width: _width,
//        height: _height,
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            colors: [kLightRed, kPrimaryRed],
//            stops: [0.4, 0.9],
//            begin: Alignment.topCenter,
//          ),
//        ),
//        child: Stack(
//          children: [
//            Positioned(
//              left: _width / 2.8,
//              top: 40.0,
//              child: Container(
//                width: 100,
//                height: 120,
//                child: Image.asset('assets/images/appicon.png',
//                    width: 100, height: 100),
//                decoration: BoxDecoration(
//                  shape: BoxShape.circle,
//                  boxShadow: [
//                    BoxShadow(
//                      color: Colors.white30,
//                      blurRadius: _animation.value * 4.5,
//                      spreadRadius: _animation.value * 2,
//                    )
//                  ],
//                ),
//              ),
//            ),
//            Positioned(
//              top: 160.0,
//              left: 50.0, //center
//              child: Text(
//                'RESPONSE',
//                textAlign: TextAlign.center,
//                style: TextStyle(
//                  fontSize: 50.0,
//                  fontFamily: 'Bungee',
//                  color: Colors.white,
//                ),
//              ),
//            ),
//            Align(
//              alignment: Alignment.bottomCenter,
//              child: Container(
//                width: _width,
//                height: 140.0,
//                decoration: BoxDecoration(
//                  color: Colors.white,
//                  borderRadius: BorderRadius.only(
//                      topRight: Radius.circular(35),
//                      topLeft: Radius.circular(35)),
//                ),
//              ),
//            ),
//            Positioned(
//              bottom: _height / 2.3,
//              left: _width / 5.5,
//              child: RaisedButton(
//                color: Colors.white,
//                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 90.0),
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                ),
//                onPressed: () {
//                  Navigator.pushNamed(context, SignUpWithEmail.id);
//                },
//                child: Text(
//                  'SIGN UP',
//                  style: TextStyle(
//                    color: Colors.black,
//                    fontWeight: FontWeight.bold,
//                    fontFamily: 'WorkSans',
//                    fontSize: 15.0,
//                  ),
//                ),
//              ),
//            ),
//            Positioned(
//              bottom: _height / 3,
//              left: _width / 5.5,
//              child: RaisedButton(
//                color: Colors.white,
//                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 97.0),
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                ),
//                onPressed: () {
//                  Navigator.pushNamed(context, LoginPage.id);
//                },
//                child: Text(
//                  'LOGIN',
//                  style: TextStyle(
//                    color: Colors.black,
//                    fontWeight: FontWeight.bold,
//                    fontFamily: 'WorkSans',
//                    fontSize: 15.0,
//                  ),
//                ),
//              ),
//            ),
//            Positioned(
//              bottom: _height / 3.65,
//              left: _width / 2.65,
//              child: GestureDetector(
//                onTap: () {
//                  Navigator.pushNamed(context, OnboardingScreen.id);
//                },
//                child: Text(
//                  'Skip for now',
//                  style: TextStyle(
//                    color: Colors.white70,
//                    fontFamily: 'WorkSans',
//                    fontSize: 15.0,
//                  ),
//                ),
//              ),
//            ),
//            Positioned(
//              bottom: 110.0,
//              left: _width / 2.35,
//              child: FloatingActionButton(
//                backgroundColor: Colors.white,
//                onPressed: () {},
//                child: Text(
//                  'OR',
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                    fontSize: 20.0,
//                    color: Colors.black,
//                  ),
//                ),
//              ),
//            ),
//            Positioned(
//              bottom: 43.0,
//              child: Container(
//                width: _width,
//                child: Row(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: [
//                    Stack(
//                      children: [
//                        MaterialButton(
//                          color: Colors.blue,
//                          padding: EdgeInsets.only(left: 55.0, right: 15.0),
//                          shape: RoundedRectangleBorder(
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(20.0))),
//                          onPressed: () {
//                            //TODO: Implement Google login functionality.
//                          },
//                          height: 50,
//                          child: Text(
//                            'Sign In with Google',
//                            style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold,
//                              fontFamily: 'WorkSans',
//                              fontSize: 10.0,
//                            ),
//                          ),
//                        ),
//                        Align(
//                          alignment: Alignment.bottomLeft,
//                          child: Container(
//                            width: 50.0,
//                            height: 50.0,
//                            decoration: BoxDecoration(
//                              image: DecorationImage(
//                                scale: 2,
//                                image: AssetImage('assets/images/google.png'),
//                              ),
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(20.0)),
//                              color: Colors.white,
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                    Stack(
//                      children: [
//                        MaterialButton(
//                          color: Colors.black,
//                          onPressed: () {
//                            Navigator.pushNamed(context, SignInWithPhone.id);
//                          },
//                          padding: EdgeInsets.only(left: 55.0, right: 10.0),
//                          shape: RoundedRectangleBorder(
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(20.0))),
//                          height: 50,
//                          child: Text(
//                            'Sign In with Phone no.',
//                            style: TextStyle(
//                              color: Colors.white,
//                              fontWeight: FontWeight.bold,
//                              fontFamily: 'WorkSans',
//                              fontSize: 10.0,
//                            ),
//                          ),
//                        ),
//                        Align(
//                          alignment: Alignment.bottomLeft,
//                          child: Container(
//                            width: 50.0,
//                            height: 50.0,
//                            decoration: BoxDecoration(
//                              image: DecorationImage(
//                                scale: 3.5,
//                                image: AssetImage('assets/images/phone.png'),
//                              ),
//                              borderRadius:
//                                  BorderRadius.all(Radius.circular(20.0)),
//                              color: Colors.white,
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            Positioned(
//              bottom: 10.0,
//              left: _width / 3.1,
//              child: GestureDetector(
//                onTap: () {
//                  //TODO: Navigate to 'Terms & Conditions' page
//                },
//                child: Text(
//                  'Terms & Conditions',
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                    fontSize: 15.0,
//                    fontFamily: 'WorkSans',
//                    color: Colors.black,
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
