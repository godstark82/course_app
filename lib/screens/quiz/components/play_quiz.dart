import 'dart:developer';

import 'package:course_app/main.dart';
import 'package:course_app/models/quiz_model.dart';
import 'package:course_app/provider/quiz_provider.dart';
import 'package:course_app/screens/quiz/components/result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:radio_group_v2/utils/radio_group_decoration.dart';
import 'package:radio_group_v2/widgets/view_models/radio_group_controller.dart';
import 'package:radio_group_v2/widgets/views/radio_group.dart';
import 'package:velocity_x/velocity_x.dart';

class PlayQuizScreen extends StatefulWidget {
  const PlayQuizScreen({super.key, required this.userQuiz});
  final UserQuizModel userQuiz;
  @override
  State<PlayQuizScreen> createState() => _PlayQuizScreenState();
}

class _PlayQuizScreenState extends State<PlayQuizScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late List<int?> selectedOptions = [];
  bool loading = false;
  GlobalKey<NavigatorState> dialogeNavigator = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: widget.userQuiz.quiz.questions.length, vsync: this);
    selectedOptions =
        List.generate(widget.userQuiz.quiz.questions.length, (index) => null);
    if (kDebugMode) {
      print(selectedOptions);
    }
  }

  int calScore() {
    int currentScore = 0;
    for (int i = 0; i < selectedOptions.length; i++) {
      if (selectedOptions[i] ==
          widget.userQuiz.quiz.questions[i].correctAnswer) {
        currentScore++;
      }
    }
    log(currentScore.toString());
    return currentScore;
  }

  void confirmExitfn(BuildContext context) async {
    await Get.dialog(
        AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
              'Result will not be calculated if you go back without submit.'),
          actions: [
            TextButton(
                onPressed: () => Get.back(), child: const Text('Cancel')),
            TextButton(
                onPressed: () async {
                  navigatorKey.currentState?.pop();
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Get.back();
                  });
                },
                child: const Text('Confirm Leave'))
          ],
        ),
        navigatorKey: dialogeNavigator);
  }

  @override
  Widget build(BuildContext context) {
    calScore();
    return PopScope(
      canPop: false,
      onPopInvoked: (v) {
        confirmExitfn(context);
      },
      child: Container(
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
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    confirmExitfn(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white)),
              backgroundColor: Colors.transparent,
              title: Text(widget.userQuiz.quiz.quizName).text.white.make(),
            ),
            body: TabBarView(
              controller: tabController,
              children: widget.userQuiz.quiz.questions.map((question) {
                final index = widget.userQuiz.quiz.questions.indexOf(question);
                RadioGroupController radioGroupController =
                    RadioGroupController();
                int? selectedOption;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        "Q${index + 1}".text.green100.make(),
                        question.question.text.bold.white
                            .minFontSize(32)
                            .makeCentered(),
                        const SizedBox(height: 35),
                        RadioGroup(
                            values: question.options,
                            labelBuilder: (label) {
                              return Card(
                                margin: const EdgeInsets.all(10),
                                color: Colors.blue.withOpacity(0.1),
                                child: CupertinoListTile(
                                    padding: const EdgeInsets.all(8),
                                    title: Text(
                                      label,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                              );
                            },
                            decoration: const RadioGroupDecoration(
                              fillColor:
                                  MaterialStatePropertyAll(Colors.orange),
                              spacing: 15,
                            ),
                            onChanged: (newvalue) {
                              selectedOption =
                                  question.options.indexOf(newvalue) + 1;
                              selectedOptions[index] = selectedOption;
                            },
                            controller: radioGroupController),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            tabController.index == 0
                                ? const SizedBox()
                                : FilledButton(
                                    onPressed: () {
                                      tabController
                                          .animateTo(tabController.index - 1);
                                    },
                                    child: const Text('Back')),
                            tabController.index + 1 !=
                                    widget.userQuiz.quiz.questions.length
                                ? Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: FilledButton(
                                        onPressed: () {
                                          if (selectedOptions[index] != null) {
                                            tabController.animateTo(
                                                tabController.index + 1);
                                          }
                                        },
                                        child: const Text('Next')),
                                  )
                                : FilledButton(
                                    onPressed: () async {
                                      if (selectedOptions.contains(null) ==
                                          false) {
                                        loading = true;
                                        setState(() {});
                                        //
                                        // code to update the data on firestore'
                                        int score = calScore();
                                        UserQuizModel newUserQuizModel =
                                            UserQuizModel(
                                                attemped: true,
                                                lastScore: score,
                                                quiz: widget.userQuiz.quiz,
                                                userRecords: selectedOptions,
                                                time: DateTime.now());
                    
                                        await context
                                            .read<QuizProvider>()
                                            .editQuizToUserDoc(
                                                newUserQuizModel);
                                        loading = false;
                                        setState(() {});
                                        // navigate to other screen
                                        Get.off(() => QuizResultScreen(
                                            userQuiz: newUserQuizModel));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please Select atleast one option')));
                                      }
                                    },
                                    child: loading
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : const Text('SUBMIT')),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            )),
      ),
    );
  }
}
