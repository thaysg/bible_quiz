import 'package:bible_quiz/models/quiz_model.dart';
import 'package:bible_quiz/screens/home/repository/home_repository.dart';
import 'package:flutter/widgets.dart';

import 'home_state.dart';

class HomeController {
  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  List<QuizModel>? quizzes;

  final repository = HomeRepository();

  void getQuizzes() async {
    state = HomeState.loading;

    quizzes = await repository.getQuizzes();
    state = HomeState.success;
  }
}
