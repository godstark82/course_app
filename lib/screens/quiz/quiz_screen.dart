import 'package:course_app/models/quiz_model.dart';
import 'package:course_app/provider/quiz_provider.dart';
import 'package:course_app/provider/user_provider.dart';
import 'package:course_app/screens/home/components/filters.dart';
import 'package:course_app/screens/quiz/components/quiz_tile.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.isUserQuiz});
  final bool isUserQuiz;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuizModel> quizes = [];

  void sortCoursesByDecreasedTime() {
    quizes.sort((a, b) => a.time.compareTo(b.time));
    setState(() {});
  }

  void sortCoursesByIncreasedTime() {
    quizes.sort((a, b) => b.time.compareTo(a.time));
    setState(() {});
  }

  @override
  void initState() {
    if (widget.isUserQuiz) {
      quizes = context.read<UserProvider>().userQuizes;
    } else {
      quizes = context.read<QuizProvider>().quizes;
    }
  // print(context.read<UserProvider>().userQuizes.map((e) => e.toJson()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.read<QuizProvider>().quizes.isEmpty) {
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
                child: FilterViewHome(
                    showHeader: false,
                    decreasingFn: sortCoursesByDecreasedTime,
                    increasingFn: sortCoursesByIncreasedTime)),
            SliverList.builder(
                itemCount: quizes.length,
                itemBuilder: (context, index) {
                  return QuizTile(quiz: quizes[index]);
                })
          ],
        ),
      );
    }
  }
}
