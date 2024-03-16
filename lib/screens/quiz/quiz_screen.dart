import 'dart:developer';

import 'package:course_app/models/quiz_model.dart';
import 'package:course_app/provider/quiz_provider.dart';
import 'package:course_app/screens/home/components/filters.dart';
import 'package:course_app/screens/quiz/components/play_quiz.dart';
import 'package:course_app/screens/quiz/components/result_screen.dart';
import 'package:empty_widget/empty_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'components/enroll_quiz.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.isUserQuizes});
  final bool isUserQuizes;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuizModel> quizes = [];
  List<Color> bgColors = [
    Colors.blue.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.green.shade100
  ];
  UserQuizModel? userQuizModel(BuildContext context, QuizModel quiz) {
    if (isEnrolled(context, quiz)) {
      UserQuizModel userQuiz = context
          .read<QuizProvider>()
          .userQuiz
          .firstWhere((element) => element.quiz.quizName == quiz.quizName);
      return userQuiz;
    } else {
      return null;
    }
  }

  bool isEnrolled(BuildContext context, QuizModel quiz) {
    bool enrolled = false;
    for (int i = 0; i < context.read<QuizProvider>().userQuiz.length; i++) {
      if (context.read<QuizProvider>().userQuiz[i].quiz.quizName ==
          quiz.quizName) {
        enrolled = true;
      } else {
        enrolled = false;
      }
    }
    log('Enrolled: $enrolled');
    return enrolled;
  }

  void sortCoursesByDecreasedTime() {
    quizes.sort((a, b) => b.time.compareTo(a.time));
    setState(() {});
  }

  void sortCoursesByIncreasedTime() {
    quizes.sort((a, b) => a.time.compareTo(b.time));
    setState(() {});
  }

  @override
  void initState() {
    quizes = context.read<QuizProvider>().quizes;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isUserQuizes && context.watch<QuizProvider>().userQuiz.isEmpty) {
      return Center(
        child: EmptyWidget(
          image: null,
          packageImage: PackageImage.Image_3,
          title: 'No Quizes Found',
          subTitle: 'Try to add some quizes from HomeScreen',
        ),
      );
    } else {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: FilterView(
                    showHeader: false,
                    decreasingFn: sortCoursesByDecreasedTime,
                    increasingFn: sortCoursesByIncreasedTime)),
            SliverList.builder(
                itemCount: widget.isUserQuizes
                    ? context.watch<QuizProvider>().userQuiz.length
                    : context.watch<QuizProvider>().quizes.length,
                itemBuilder: (context, index) {
                  bool enrolled = isEnrolled(context, quizes[index]);
                  UserQuizModel? userQuiz =
                      userQuizModel(context, quizes[index]);
                  Color color = (bgColors..shuffle()).first;
                  return Container(
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: color.swatch.shade300, width: 2)),
                    child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: color,
                        onTap: () {
                          if (enrolled) {
                            if (userQuiz?.attemped == false) {
                              Get.to(() => PlayQuizScreen(userQuiz: userQuiz!));
                            } else {
                              Get.to(
                                  () => QuizResultScreen(userQuiz: userQuiz!));
                            }
                          } else {
                            Get.to(() => EnrollQuizScreen(quiz: quizes[index]));
                          }
                        },
                        // backgroundColor: (bgColors..shuffle()).first,
                        leading: CircleAvatar(
                          backgroundColor: color.swatch.shade400,
                          child: Text('${index + 1}',
                              style: const TextStyle(color: Colors.white)),
                        ),
                        trailing: enrolled
                            ? CircleAvatar(
                                backgroundColor: color.swatch.shade300,
                                child: const Icon(Icons.play_circle),
                              )
                            : const Icon(Icons.start, color: Colors.blueAccent),
                        subtitle: Text(
                          enrolled
                              ? 'Last Score: ${context.watch<QuizProvider>().userQuiz.firstWhere((element) => element.quiz.quizName == quizes[index].quizName).lastScore}/${userQuiz?.quiz.questions.length}'
                              : 'Questions: ${quizes[index].questions.length}',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        title: Text(
                          quizes[index].quizName,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2),
                        )),
                  );
                })
          ],
        ),
      );
    }
  }
}
