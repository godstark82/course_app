import 'package:course_app/models/quiz_model.dart';
import 'package:course_app/provider/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EnrollQuizScreen extends StatelessWidget {
  const EnrollQuizScreen({super.key, required this.quiz});
  final QuizModel quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 0, 111, 202),
            Color.fromARGB(255, 0, 142, 203),
            Color.fromARGB(255, 0, 177, 221)
          ])),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title:
              Text(quiz.quizName, style: const TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: context.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Enroll this Quiz to start the test',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.white)),
              const SizedBox(height: 25),
              FilledButton(
                  onPressed: () async {
                    await context
                        .read<QuizProvider>()
                        .enrollQuiz(UserQuizModel(
                            userRecords: [],
                            attemped: false,
                            lastScore: 0,
                            quiz: quiz,
                            time: DateTime.now()))
                        .whenComplete(() {
                      Get.back();
                    });
                  },
                  child: const Text('Entroll Quiz'))
            ],
          ),
        ),
      ),
    );
  }
}
