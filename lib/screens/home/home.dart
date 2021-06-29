import 'package:bible_quiz/components/adds_widgets.dart';
import 'package:bible_quiz/components/colors.dart';
import 'package:bible_quiz/screens/challenge_screen/challenge_screen.dart';
import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'home_controller.dart/home_controller.dart';
import 'home_controller.dart/home_state.dart';
import 'widgets/quiz_card/quiz_card_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = HomeController();

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  void initState() {
    super.initState();
    myBanner.load();
    controller.getQuizzes();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.success) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Bible Quiz',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: controller.quizzes!
                      .map(
                        (e) => QuizCardWidget(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChallengeScreen(
                                  questions: e.questions,
                                  title: e.title,
                                ),
                              ),
                            );
                            print('object');
                          },
                          title: e.title,
                          picture: e.image,
                          progress: 'Questões: ${e.questions.length}',
                          percent: e.questionAnswerd / e.questions.length,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            // ignore: unnecessary_null_comparison
            if (myBanner == null)
              SizedBox(
                height: 50,
              )
            else
              AddsWidgets(
                myWidget: AdWidget(ad: myBanner),
              ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );
    }
  }
}
