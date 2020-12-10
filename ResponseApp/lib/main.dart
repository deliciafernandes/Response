import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'views/DetailedNewsPage.dart';
import 'views/HomePage.dart';
import 'views/MapsBody.dart';
import 'views/NewsBody.dart';
import 'views/OnboardingScreen.dart';
import 'views/SOS.dart';
import 'views/SOSselect.dart';
import 'views/WhatToDoBody.dart';
import 'package:response/views/Flood.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Platform.isAndroid ? Colors.black : null,
      systemNavigationBarDividerColor: Colors.black,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(ResponseApp());
}

class ResponseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.id,
      routes: {
        OnboardingScreen.id: (context) => OnboardingScreen(),

        //Home Screens
        HomePage.id: (context) => HomePage(),
        WhatToDoBody.id: (context) => WhatToDoBody(),
        NewsBody.id: (context) => NewsBody(),
        MapsBody.id: (context) => MapsBody(),
        Flood.id: (context) => Flood(),

        //SOS page
        SOS.id: (context) => SOS(),
        SOSselect.id: (context) => SOSselect(),

        //Detailed Screens
        DetailedNewsPage.id: (context) => DetailedNewsPage(),
      },
    );
  }
}
