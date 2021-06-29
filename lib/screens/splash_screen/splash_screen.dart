import 'package:bible_quiz/components/constants.dart';
import 'package:bible_quiz/components/images.dart';
import 'package:bible_quiz/screens/home/home.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then(
      (_) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      ),
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quiz Bíblico',
            textAlign: TextAlign.center,
            style: splashText,
          ),
          Center(
            child: Image.asset(
              AppImages.logo,
            ),
          ),
        ],
      ),
    );
  }
}
