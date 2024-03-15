import 'package:course_app/constants/widgets/course_tile.dart';
import 'package:course_app/models/course_model.dart';
import 'package:flutter/material.dart';

class HomeScreenCourses extends StatelessWidget {
  const HomeScreenCourses({super.key, required this.courses});
  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount:courses.length,
        itemBuilder: (context, index) {
          return CourseTile(
              isPurchased: false,
              course: courses[index]);
        });
  }
}
