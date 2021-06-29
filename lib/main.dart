import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'screens/splash_screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bible Quiz',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xff333256),
        scaffoldBackgroundColor: Color(0xff333256),
      ),
      home: MySplashScreen(),
    );
  }
}
