import 'package:course_app/models/quiz_model.dart';
import 'package:course_app/provider/quiz_provider.dart';
import 'package:course_app/provider/user_provider.dart';
import 'package:course_app/screens/quiz/components/enroll_quiz.dart';
import 'package:course_app/screens/quiz/components/play_quiz.dart';
import 'package:course_app/screens/quiz/components/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class QuizTile extends StatefulWidget {
  const QuizTile({super.key, required this.quiz});
  final QuizModel quiz;

  @override
  State<QuizTile> createState() => _QuizTileState();
}

class _QuizTileState extends State<QuizTile> {
  List<Color> bgColors = [
    Colors.blue.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.green.shade100
  ];

  @override
  Widget build(BuildContext context) {
    Color color = (bgColors..shuffle()).first;
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.swatch.shade300, width: 2)),
      child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          tileColor: color,
          onTap: () {
            if (context
                .read<UserProvider>()
                .checkQuizPurchased(context, widget.quiz)) {
              if (context
                      .read<UserProvider>()
                      .userQuizes
                      .firstWhere(
                          (element) => element.title == widget.quiz.title)
                      .isAttempted ==
                  true) {
                Get.to(() => QuizResultScreen(
                    userQuiz: context
                        .read<UserProvider>()
                        .userQuizes
                        .firstWhere(
                            (element) => element.title == widget.quiz.title)));
              } else {
                Get.to(() => PlayQuizScreen(userQuiz: widget.quiz));
              }
              // play
            } else {
              //enroll
              Get.to(() => EnrollQuizScreen(quiz: widget.quiz));
            }
          },
          // backgroundColor: (bgColors..shuffle()).first,
          leading: CircleAvatar(
            backgroundColor: color.swatch.shade400,
            child: Text(
                '${context.read<QuizProvider>().quizes.indexOf(widget.quiz) + 1}',
                style: const TextStyle(color: Colors.white)),
          ),
          trailing: context
                  .watch<UserProvider>()
                  .checkQuizPurchased(context, widget.quiz)
              ? Icon(Icons.play_circle)
              : const Icon(Icons.start, color: Colors.blueAccent),
          subtitle: Text(
            'Questions: ${widget.quiz.questions.length}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          title: Text(
            widget.quiz.title,
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1.2),
          )),
    );
  }
}
