//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter/services.dart';
//import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:validators/validators.dart' as validator;
//import 'package:response/utilities/constants.dart';
//import 'package:giffy_dialog/giffy_dialog.dart';
//
//class ForgotYourPasswordPage extends StatefulWidget {
//  static String id = '/ForgotYourPasswordPage';
//  @override
//  _ForgotYourPasswordPageState createState() => _ForgotYourPasswordPageState();
//}
//
//class _ForgotYourPasswordPageState extends State<ForgotYourPasswordPage> {
//  bool _showSpinner = false;
//
//  String email = '';
//  bool _isClicked = false;
//
//  final _auth = FirebaseAuth.instance;
//
//  String _validateEmail(String value) {
//    if (value == 'ERROR_USER_NOT_FOUND') {
//      return 'User does not exist, Please check your email';
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
//  @override
//  Widget build(BuildContext context) {
//    var _width = MediaQuery.of(context).size.width;
//    var _height = MediaQuery.of(context).size.height;
//    return Scaffold(
//      backgroundColor: Colors.white,
//      resizeToAvoidBottomPadding: false,
//      body: ModalProgressHUD(
//        inAsyncCall: _showSpinner,
//        color: Colors.white,
//        child: GestureDetector(
//          onTap: () => FocusScope.of(context).unfocus(),
//          child: Container(
//            width: _width,
//            height: _height,
//            //background image
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                fit: BoxFit.cover,
//                colorFilter: ColorFilter.mode(
//                    Colors.white.withOpacity(0.05), BlendMode.dstATop),
//                image: AssetImage('assets/images/questions.png'),
//              ),
//            ),
//            child: Stack(
//              children: [
//                SafeArea(
//                  child: Padding(
//                    padding: EdgeInsets.only(top: 8.0),
//                    child: IconButton(
//                      icon: Icon(
//                        Icons.arrow_back_ios,
//                        color: Colors.black,
//                      ),
//                      onPressed: () => Navigator.pop(context),
//                    ),
//                  ),
//                ),
//                SafeArea(
//                  child: Padding(
//                    padding: EdgeInsets.only(top: 18.0, left: _width / 4.5),
//                    child: Text(
//                      'Forgot Password?',
//                      style: TextStyle(
//                        fontSize: 25.0,
//                        fontFamily: 'WorkSans',
//                        fontWeight: FontWeight.bold,
//                        color: kPrimaryRed,
//                      ),
//                    ),
//                  ),
//                ),
//                Positioned(
//                  top: 45.0,
//                  left: _width / 4,
//                  child: Container(
//                    width: 200,
//                    height: 200,
//                    child: Image.asset('assets/images/forgot.png'),
//                  ),
//                ),
//                Positioned(
//                  top: 260.0,
//                  left: 20.0,
//                  right: 20.0,
//                  child: Text(
//                    'Enter the email address of your account.',
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                      fontSize: 18.0,
//                      fontFamily: 'WorkSans',
//                      fontWeight: FontWeight.w600,
//                      color: Colors.black,
//                    ),
//                  ),
//                ),
//                Positioned(
//                  top: 335.0,
//                  left: _width / 11,
//                  child: Container(
//                    width: _width / 1.2,
//                    child: TextField(
//                      keyboardType: TextInputType.emailAddress,
//                      onChanged: (value) {
//                        email = value;
//                      },
//                      decoration: InputDecoration(
//                        hintText: 'Email',
//                        hintStyle: TextStyle(
//                          color: kTextFieldForgotPageBorderColor,
//                          fontSize: 15.0,
//                          fontFamily: 'WorkSans',
//                        ),
//                        errorText: _isClicked ? _validateEmail(email) : null,
//                        errorStyle: TextStyle(
//                          color: Colors.red,
//                          fontSize: 12.0,
//                          fontFamily: 'WorkSans',
//                        ),
//                        errorBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.red, width: 2.5),
//                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                        ),
//                        border: OutlineInputBorder(
//                          borderSide: BorderSide(
//                              color: kTextFieldForgotPageBorderColor,
//                              width: 1.0),
//                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                        ),
//                        enabledBorder: OutlineInputBorder(
//                          borderSide: BorderSide(
//                              color: kTextFieldForgotPageBorderColor,
//                              width: 1.0),
//                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                        ),
//                        focusedBorder: OutlineInputBorder(
//                          borderSide: BorderSide(
//                              color: kTextFieldForgotPageBorderColor,
//                              width: 1.0),
//                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                        ),
//                        filled: true,
//                        fillColor: kTextFieldForgotPageColor,
//                        contentPadding: EdgeInsets.symmetric(
//                            vertical: 10.0, horizontal: 20.0),
//                      ),
//                    ),
//                  ),
//                ),
//                Positioned(
//                  bottom: 75.0,
//                  left: _width / 5,
//                  child: MaterialButton(
//                    color: kPrimaryRed,
//                    padding: EdgeInsets.symmetric(horizontal: 30.0),
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                    ),
//                    onPressed: () async {
//                      try {
//                        setState(() {
//                          _showSpinner = true;
//                        });
//                        await _auth.sendPasswordResetEmail(email: email);
//                        setState(() {
//                          _showSpinner = false;
//                        });
//
//                        showDialog(
//                            context: context,
//                            builder: (_) => AssetGiffyDialog(
//                                  image: Image.asset('assets/images/mail.gif'),
//                                  title: Text(
//                                    'Email Sent!',
//                                    style: TextStyle(
//                                      fontSize: 22.0,
//                                      fontWeight: FontWeight.w600,
//                                    ),
//                                  ),
//                                  description: Text(
//                                    'Please check your email and click on the reset password link.',
//                                    textAlign: TextAlign.center,
//                                    style: TextStyle(),
//                                  ),
//                                  entryAnimation: EntryAnimation.DEFAULT,
//                                  onlyOkButton: true,
//                                  onOkButtonPressed: () {
//                                    Navigator.pop(context);
//                                  },
//                                ));
//                      } catch (e) {
//                        print('$e : Forgot your pswd PAGE');
//
//                        setState(() {
//                          _showSpinner = false;
//                        });
//
//                        if (e.code == 'ERROR_USER_NOT_FOUND') {
//                          //Test case when user doesn't exist!
//                          setState(() {
//                            _isClicked = true;
//                            email = e.code;
//                          });
//                        }
//                      }
//                    },
//                    height: 50,
//                    child: Text(
//                      'RESET PASSWORD',
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
//                        color: Colors.black,
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
