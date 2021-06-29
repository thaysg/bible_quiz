import 'package:bible_quiz/components/adds_widgets.dart';
import 'package:bible_quiz/components/colors.dart';
import 'package:bible_quiz/components/constants.dart';
import 'package:bible_quiz/models/question_model.dart';
import 'package:bible_quiz/screens/result_screen/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'widgets/challenge_controller.dart';
import 'widgets/next_button.dart';
import 'widgets/question_indicator_widget.dart';
import 'widgets/quiz_widget.dart';

class ChallengeScreen extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;

  const ChallengeScreen(
      {Key? key, required this.questions, required this.title})
      : super(key: key);

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final controller = ChallengeController();
  final pageController = PageController();

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  CountDownController _controller = CountDownController();
  int _duration = 15;

  void updateQuiz([bool onComplete = false]) {
    setState(() {
      if (controller.currentPage < widget.questions.length /* - 1 */) {
        pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.linear,
        );
        resetTime();
      }
    });
  }

  void onSelectes(bool value) {
    if (value) {
      controller.rightAnswers++;
      updateQuiz();
    } else {
      controller.wrongAnswers++;
      updateQuiz();
    }
  }

  void resetTime({int? duration}) {
    _controller.restart(duration: _duration);
  }

  @override
  void initState() {
    super.initState();
    myBanner.load();
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(),
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIndicatorWidget(
                  currentPage: value,
                  length: widget.questions.length,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions
            .map(
              (e) => ListView(
                children: [
                  QuizWidget(
                    question: e,
                    onSelected: onSelectes,
                  ),
                ],
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => Row(
                  children: [
                    if (value < widget.questions.length)
                      Expanded(
                        child: CircularCountDownTimer(
                          width: MediaQuery.of(context).size.width / 10,
                          height: MediaQuery.of(context).size.height / 10,
                          duration: _duration,
                          fillColor: kRed,
                          ringColor: kDarkBlue,
                          controller: _controller,
                          backgroundColor: Colors.transparent,
                          strokeWidth: 10.0,
                          strokeCap: StrokeCap.round,
                          isTimerTextShown: true,
                          isReverse: false,
                          textStyle: TextStyle(
                            fontSize: 15.0,
                            color: kWhiteColor,
                          ),
                          onComplete: () {
                            updateQuiz(true);
                          },
                        ),
                      ),
                    if (value == widget.questions.length)
                      Expanded(
                        child: NextButtonWidget(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                  title: widget.title,
                                  lenght: widget.questions.length,
                                  result: controller.rightAnswers,
                                ),
                              ),
                            );
                          },
                          colour: kdarkGreen,
                          fontColor: AppColors.white,
                          label: 'Confirmar',
                        ),
                      ),
                  ],
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
      ),
    );
  }
}
