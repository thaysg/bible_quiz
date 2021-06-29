import 'package:bible_quiz/components/colors.dart';
import 'package:bible_quiz/components/text_style.dart';
import 'package:bible_quiz/screens/challenge_screen/widgets/next_button.dart';
import 'package:bible_quiz/screens/home/home.dart';

import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

class ResultScreen extends StatefulWidget {
  final String title;
  final int lenght;
  final int result;

  const ResultScreen(
      {Key? key,
      required this.title,
      required this.lenght,
      required this.result})
      : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  score() {
    if ((widget.result / widget.lenght) * 100 >= 80) {
      return 'Incrível, continue assim!';
    } else if ((widget.result / widget.lenght) * 100 >= 60) {
      return 'Muito Bom, continue estudando';
    } else {
      return 'Você precisa ler a bíblia';
    }
  }

  /* List<String> imagePaths = [
    'assets/images/6.jpeg',
  ];

  Future<void> shareApp() async {
    try {
      await Share.shareFiles(
        imagePaths,
        text:
            'Hey! Eu Acertei ${widget.result} questões. \nVocê consegue bater meu record? \n'
            'https://play.google.com/store/apps/details?id=com.thays_garcia.bible_quiz',
      );
    } catch (e) {
      print('error: $e');
    }
  } */

  AssetImage gold = AssetImage('assets/images/gold-cup.png');
  AssetImage silver = AssetImage('assets/images/silver-cup.png');
  AssetImage sad = AssetImage('assets/images/sad.png');

  getImage() {
    if ((widget.result / widget.lenght) * 100 >= 80) {
      return gold;
    } else if ((widget.result / widget.lenght) * 100 >= 60) {
      return silver;
    } else {
      return sad;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.only(top: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Image(
                image: getImage(),
              ),
            ),
            Spacer(),
            Expanded(
              flex: 2,
              child: Text(
                score(),
                style: AppTextStyles.heading40,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text.rich(
                TextSpan(
                  text: 'Você concluiu',
                  style: AppTextStyles.conclui,
                  children: [
                    TextSpan(
                      text: '\nNível ${widget.title}',
                      style: AppTextStyles.level,
                      children: [
                        TextSpan(
                            text:
                                '\ncom ${widget.result} de ${widget.lenght} acertos',
                            style: AppTextStyles.conclui),
                      ],
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: NextButtonWidget(
                label: 'Compartilhar',
                colour: AppColors.purple,
                fontColor: AppColors.white,
                onTap: () {
                  //CORRETO
                  Share.share(
                    'Hey! Eu Acertei ${widget.result} questões. \nVocê consegue bater meu record? \n'
                    'https://play.google.com/store/apps/details?id=com.thays_garcia.bible_quiz',
                  );
                },
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: NextButtonWidget(
                label: 'Voltar ao inicio',
                colour: Colors.transparent,
                fontColor: AppColors.white,
                onTap: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
