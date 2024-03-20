import 'package:course_app/constants/utils/utils.dart';
import 'package:course_app/screens/study/pages/user_courses.dart';
import 'package:course_app/screens/study/pages/user_notes.dart';
import 'package:course_app/screens/study/pages/user_quizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Study Center'),
          centerTitle: true,
        ),
        body: Container(
          // margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => const UserCourses());
                },
                child: Container(
                    height: 150,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(LottieFiles.COURSE, height: 100),
                        const Text(
                          'Your Courses',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 20,
                        )
                      ],
                    )),
              ),
             InkWell(
                onTap: () {
                  Get.to(() => const UserQuizes());
                },
                child: Container(
                    height: 150,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(LottieFiles.QUIZ, height: 100),
                        const Text(
                          'Your Quizes',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 20,
                        )
                      ],
                    )),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const UserNotes());
                },
                child: Container(
                    height: 150,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(LottieFiles.QUIZ, height: 100),
                        const Text(
                          'Your Notes',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 20,
                        )
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
