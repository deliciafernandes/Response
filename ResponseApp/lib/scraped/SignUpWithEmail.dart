//import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/services.dart';
//import 'package:response/utilities/constants.dart';
//import 'package:validators/validators.dart' as validator;
//import 'package:modal_progress_hud/modal_progress_hud.dart';
//
//import 'package:response/widgets/ReusableTextField.dart';
//import 'OnboardingScreen.dart';
//
//class SignUpWithEmail extends StatefulWidget {
//  static String id = '/SignUpWithEmail';
//
//  @override
//  _SignUpWithEmailState createState() => _SignUpWithEmailState();
//}
//
//class _SignUpWithEmailState extends State<SignUpWithEmail>
//    with SingleTickerProviderStateMixin {
//  bool _showSpinner = false;
//
//  String email = '';
//  String password = '';
//
//  bool _isClicked = false;
//
//  final FirebaseAuth _auth = FirebaseAuth.instance;
//
//  AnimationController _animationController;
//  Animation _animation;
//
//  String _validateEmail(String value) {
//    if (value == 'ERROR_EMAIL_ALREADY_IN_USE') {
//      return 'This email is already in use';
//    } else {
//      if (value.isEmpty) {
//        return 'Please enter an Email Address';
//      } else if (!validator.isEmail(email)) {
//        return 'Please enter a valid Email';
//      }
//    }
//    return null;
//  }
//
//  String _validatePassword(String value) {
//    if (value.isEmpty) {
//      return 'Please enter a Password';
//    } else if (value.length < 6) {
//      return 'Please enter a stronger Password';
//    }
//    return null;
//  }
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
//      resizeToAvoidBottomPadding: false,
//      body: ModalProgressHUD(
//        inAsyncCall: _showSpinner,
//        color: Colors.white,
//        child: GestureDetector(
//          onTap: () => FocusScope.of(context).unfocus(),
//          child: Container(
//            width: _width,
//            height: _height,
//            decoration: BoxDecoration(
//              gradient: LinearGradient(
//                colors: [kLightRed, kPrimaryRed],
//                stops: [0.4, 0.9],
//                begin: Alignment.topCenter,
//              ),
//            ),
//            child: Stack(
//              children: [
//                SafeArea(
//                  child: IconButton(
//                    icon: Icon(
//                      Icons.arrow_back_ios,
//                      color: Colors.black,
//                    ),
//                    onPressed: () => Navigator.pop(context),
//                  ),
//                ),
//                Positioned(
//                  left: _width / 2.8,
//                  top: 40.0,
//                  child: Container(
//                    width: 100,
//                    height: 120,
//                    child: Image.asset('assets/images/appicon.png',
//                        width: 100, height: 100),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.white30,
//                          blurRadius: _animation.value * 4.5,
//                          spreadRadius: _animation.value * 2,
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//                Positioned(
//                  top: 160.0,
//                  left: 50.0, //center //TODO test !
//                  child: Text(
//                    'RESPONSE',
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                      fontSize: 50.0,
//                      fontFamily: 'Bungee',
//                      color: Colors.white,
//                    ),
//                  ),
//                ),
//                Positioned(
//                  top: 310.0,
//                  left: _width / 11,
//                  child: Container(
//                    width: _width / 1.2,
//                    child: Column(
//                      children: [
//                        SizedBox(height: 40.0),
//                        ReusableTextField(
//                          hintText: 'Password',
//                          keyboardType: TextInputType.visiblePassword,
//                          errorText:
//                              _isClicked ? _validatePassword(password) : null,
//                          onChanged: (value) {
//                            password = value;
//                          },
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//                Positioned(
//                  bottom: 75.0,
//                  left: _width / 4.25,
//                  child: MaterialButton(
//                    color: Color(0xff44B0F1),
//                    //TODO: Change color!
//                    padding: EdgeInsets.symmetric(horizontal: 60.0),
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                    ),
//                    onPressed: () async {

//                      try {
//                        setState(() {
//                          _showSpinner = true;
//                        });
//                        final newUser =
//                            await _auth.createUserWithEmailAndPassword(
//                          email: email,
//                          password: password,
//                        );
//
//                        if (newUser != null) {
//                          print('user authenticated by registration');
//                          Navigator.pushNamed(context, OnboardingScreen.id);
//                        } else {
//                          //Todo User not authenticated alert box!
//                        }
//                      } catch (e) {
//                        setState(() {
//                          _showSpinner = false;
//                        });
//                        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
//                          print('$e : SIGN UP WITH EMAIL PAGE');
//                          email = e.code;
//                        }
//                      }
//                    },
//                    height: 50,
//                    child: Text(
//                      'SIGN IN',
//                      style: TextStyle(
//                        color: Colors.white, //TODO: Change color!
//                        fontWeight: FontWeight.bold,
//                        fontSize: 18.0,
//                      ),
//                    ),
//                  ),
//                ),
//                Positioned(
//                  bottom: 30.0,
//                  left: _width / 3.13,
//                  child: GestureDetector(
//                    onTap: () {
//                      //TODO: Navigate to 'Terms & Conditions' page
//                    },
//                    child: Text(
//                      'Terms & Conditions',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                        color: Colors.white70,
//                        fontFamily: 'WorkSans',
//                        fontSize: 15.0,
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
