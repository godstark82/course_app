import 'package:course_app/constants/widgets/course_tile.dart';
import 'package:course_app/provider/course_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenCourses extends StatelessWidget {
  const HomeScreenCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: context.read<CourseProvider>().courses.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  child: Text(
                    'All Courses ${context.read<CourseProvider>().courses.length}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                CourseTile(
                    course: context.read<CourseProvider>().courses[index])
              ],
            );
          } else {
            return CourseTile(
                course: context.read<CourseProvider>().courses[index]);
          }
        });
  }
}
