//import 'dart:async';
//
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:response/screens/HomePage.dart';
//import 'package:response/utilities/constants.dart';
//import 'package:response/widgets/ReusableTextField.dart';
//import 'package:pin_code_fields/pin_code_fields.dart';
//
//import 'OnboardingScreen.dart';
//
//class SignInWithPhone extends StatefulWidget {
//  static String id = '/SignInWithPhone';
//
//  @override
//  _SignInWithPhoneState createState() => _SignInWithPhoneState();
//}
//
//class _SignInWithPhoneState extends State<SignInWithPhone>
//    with SingleTickerProviderStateMixin {
//  AnimationController _animationController;
//  Animation _animation;
//
//  TextEditingController _phoneNumberController = TextEditingController();
//
//  bool _showSpinner = false;
//  bool _isClicked = false;
//  bool _errorInOTP = false;
//
//  String phoneNumber = '';
//  String smsCode = '';
//
//  FirebaseUser _firebaseUser;
//  AuthCredential _phoneAuthCredential;
//  String _verificationId;
//
//  String validatePhoneNum(String value) {
//    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
//    RegExp regExp = RegExp(pattern);
//
//    if (value.contains('+91', 0)) {
//      return null;
//    } else {
//      if (value.isEmpty) {
//        return 'Please enter a phone number';
//      } else if (!regExp.hasMatch(value)) {
//        return 'Please enter a valid phone number';
//      }
//    }
//
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
//  //Step 1: After the phoneNumber is valid and working, this function will send a otp and handle backend
//  Future<void> _submitPhoneNumber() async {
//    print('inside _submitPhoneNumber');
//    //Assuming Indian Number used!
//    phoneNumber = "+91 " + phoneNumber;
//    print(phoneNumber);
//    void verificationCompleted(AuthCredential phoneAuthCredential) {
//      print('verificationCompleted');
//      _phoneAuthCredential = phoneAuthCredential;
//      print(phoneAuthCredential);
//    }
//
//    void verificationFailed(AuthException authException) {
//      setState(() {
//        _showSpinner = false;
//        errorController.add(ErrorAnimationType.shake);
//      });
//
//      print('verificationFailed');
//      print('Line 81: ${authException.message}');
//
//      String status = '${authException.message}';
//
//      print("Error message: " + status);
//      if (authException.message.contains('not authorized'))
//        status = 'Something has gone wrong, please try later';
//      else if (authException.message.contains('Network'))
//        status = 'Please check your internet connection and try again';
//      else
//        status = 'Something has gone wrong, please try later';
//    }
//
//    void codeSent(String verificationId, [int code]) {
//      print('codeSent');
//      _verificationId = verificationId;
//      print(verificationId);
//      print(code.toString());
//    }
//
//    void codeAutoRetrievalTimeout(String verificationId) {
//      print('codeAutoRetrievalTimeout');
//      _verificationId = verificationId;
//    }
//
//    await FirebaseAuth.instance.verifyPhoneNumber(
//      phoneNumber: phoneNumber,
//
//      timeout: Duration(seconds: 60),
//
//      // If the SIM (with phoneNumber) is in the current device this function is called.
//      verificationCompleted: verificationCompleted,
//
//      // Called when the verification is failed
//      verificationFailed: verificationFailed,
//
//      /// This is called after the OTP is sent. Gives a `verificationId` and `code`
//      codeSent: codeSent,
//
//      /// After automatic code retrieval `timeout` this function is called
//      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
//    );
//
//    setState(() {
//      _showSpinner = false;
//    });
//    _displayDialog(context);
//  }
//
//  //Step 2: To enter otp manually - backend
//  void _submitOTP() {
//    print('inside _submitOTP');
//
//    /// we need to use OTP to get `phoneAuthCredential` which is in turn used to signIn/login
//    _phoneAuthCredential = PhoneAuthProvider.getCredential(
//        verificationId: _verificationId, smsCode: smsCode);
//
//    _login();
//  }
//
//  //Step 3: Finally login
//  Future<void> _login() async {
//    print('inside _login');
//
//    /// This method is used to login the user
//    /// `AuthCredential`(`_phoneAuthCredential`) is needed for the signIn method
//    /// After the signIn method from `AuthResult` we can get `FirebaseUser`(`_firebaseUser`)
//    try {
//      await FirebaseAuth.instance
//          .signInWithCredential(this._phoneAuthCredential)
//          .then((AuthResult authRes) {
//        _firebaseUser = authRes.user;
//        print('firebase user : line 143 ${_firebaseUser.toString()}');
//
//        setState(() {
//          _showSpinner = false;
//        });
//
//        if (authRes.additionalUserInfo.isNewUser) {
//          Navigator.pushNamed(context, OnboardingScreen.id);
//        } else {
//          Navigator.pushNamed(context, HomePage.id);
//        }
//      });
//    } catch (e) {
//      setState(() {
//        _showSpinner = false;
//        _errorInOTP = true;
//        errorController.add(ErrorAnimationType.shake);
//      });
//
//      //TODO : didn't work!
//      print('$e : SIGN IN WITH PHONE');
//    }
//  }
//
//  StreamController<ErrorAnimationType> errorController =
//      StreamController<ErrorAnimationType>.broadcast();
//
//  _displayDialog(BuildContext context) async {
//    print('inside _displayDialog');
//
//    return showDialog(
//        useSafeArea: true,
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.all(Radius.circular(10.0))),
//            title: Text(
//              "Please enter the OTP sent on '$phoneNumber'",
//              textAlign: TextAlign.center,
//              style: TextStyle(
//                color: Colors.black,
//                fontFamily: 'WorkSans',
//                fontWeight: FontWeight.bold,
//                fontSize: 15.0,
//              ),
//            ),
//            content: PinCodeTextField(
//              length: 6,
//              obsecureText: false,
//              animationType: AnimationType.fade,
//              autoDisposeControllers: false,
//              pinTheme: PinTheme(
//                shape: PinCodeFieldShape.underline,
//                borderRadius: BorderRadius.circular(5),
//                fieldHeight: 50,
//                fieldWidth: 30,
//                activeColor: kDarkPinkRedColor,
//                selectedColor: kLightPinkColor,
//              ),
//              animationDuration: Duration(milliseconds: 300),
//              errorAnimationController: errorController,
//              onCompleted: (value) {
//                smsCode = value;
//                print('smsCode: $smsCode');
//
//                //
//              },
//              onChanged: (value) {},
//              beforeTextPaste: (text) {
//                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                return true;
//              },
//            ),
//            actions: <Widget>[
//              FlatButton(
//                splashColor: kLightRed,
//                child: Text(
//                  'SUBMIT',
//                  style: TextStyle(
//                    color: kPrimaryRed,
//                    fontFamily: 'WorkSans',
//                    fontWeight: FontWeight.bold,
//                    fontSize: 15.0,
//                  ),
//                ),
//                onPressed: () {
//                  setState(() {
//                    _showSpinner = true;
//                  });
//                  _submitOTP();
//                  if (!_errorInOTP) {
//                    Navigator.pop(context);
//                  }
//                },
//              )
//            ],
//          );
//        });
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
//                  left: 50.0,
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
//                  top: 290.0,
//                  left: _width / 11,
//                  child: Container(
//                    width: _width / 1.2,
//                    child: ,
//                  ),
//                ),
//                Positioned(
//                  bottom: 75.0,
//                  left: _width / 3.25,
//                  child: MaterialButton(
//                    color: Colors.black87, //TODO: Change color!
//                    padding: EdgeInsets.symmetric(horizontal: 40.0),
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                    ),
//                    onPressed: () async {
//                      setState(() {
//                        _isClicked = true;
//
//                        try {
//                          _showSpinner = true;
//                          if (validatePhoneNum(phoneNumber) == null) {
//                            _submitPhoneNumber();
//                          } else {
//                            _showSpinner = false;
//                          }
//                        } catch (e) {
//                          _showSpinner = false;
//                          print('$e on sign in button inside try catch');
//                        }
//                      });
//                    },
//                    height: 50,
//                    child: Text(
//                      'SIGN IN',
//                      style: TextStyle(
//                        color: Colors.white,
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
