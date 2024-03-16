// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future loadingDialog(BuildContext context) async {
  return await showAdaptiveDialog(
    barrierColor: Colors.white.withOpacity(.5),
    context: context,
    builder: (context) => Material(
      color: Colors.transparent,
      child: PopScope(
        canPop: false,
        child: Center(
          child: Container(
            height: 135,
            width: 135,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitSpinningLines(
                  color: Colors.indigo,
                  size: 55,
                ),
                Text("Loading..."),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class LottieFiles {
  static const String GRADIENT = 'assets/anim/gradient.json';
  static const String COURSE = 'assets/anim/course.json';
  static const String QUIZ = 'assets/anim/quiz.json';
  static const String RESULT = 'assets/anim/result.json';
}

class AssetImages {
  static const String ABOUT = 'assets/images/about.png';
  static const String CATEGORY = 'assets/images/category.png';
  static const String COURSE = 'assets/images/course.png';
  static const String QUIZ_1 = 'assets/images/quiz_1.png';
  static const String QUIZ_2 = 'assets/images/quiz_2.png';
  static const String STUDY = 'assets/images/study.png';
  static const String NOTEPEDIAX_BLACK = 'assets/images/notepediax_black.png';
  static const String NOTEPEDIAX_WHITE = 'assets/images/notepediax_white.png';

}

class GlobalKeys {
  static GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();
}
